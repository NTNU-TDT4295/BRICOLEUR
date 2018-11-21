#!/usr/bin/python3.6

import os
import sys
import time
import threading
import queue

from pynq import Overlay, Xlnk
import numpy as np

OUTPUT_BUFFER_COUNT = 8
FRAME_COUNT = 1230219302193
min_area = 250

video = sys.stdin.detach()
video_out = open("debugframes.raw", "wb")

ov = Overlay("/home/xilinx/pipeline-150.bit")
mcu_communication_channel = ov.axi_gpio_0.channel1[0:3]

xlnk = Xlnk()
input_buffers = [xlnk.cma_array(shape=(240,320), dtype=np.uint8) for _ in range(2)]
output_buffers = [xlnk.cma_array(shape=(238,318), dtype=np.uint32) for _ in range(8)]

push_queue = queue.Queue(OUTPUT_BUFFER_COUNT)
return_queue = queue.Queue(OUTPUT_BUFFER_COUNT)

for buffer in output_buffers:
    return_queue.put(buffer)

class push_thread(threading.Thread):
    def __init__(self, stream):
        threading.Thread.__init__(self)
        self.stream = stream
        self.current_input_buffer_index = 0
    def run(self):
        # Grab a recv buffer 
        output_buffer = return_queue.get()

        # Read a frame into input buffer
        self.stream.readinto(input_buffers[self.current_input_buffer_index].data)
        for frame in range(FRAME_COUNT):
            # Grab next recv buffer
            output_buffer = return_queue.get()

            ov.axi_dma_0.sendchannel.transfer(input_buffers[self.current_input_buffer_index])
            ov.axi_dma_0.recvchannel.transfer(output_buffer)

            # Read frame into next input buffer while accelerator works
            if frame < FRAME_COUNT:
                self.current_input_buffer_index = (self.current_input_buffer_index + 1) % 2
                video.readinto(input_buffers[self.current_input_buffer_index].data)

            # Wait for accelerator to finish
            ov.axi_dma_0.recvchannel.wait()

            # Enqueue the finished buffer
            push_queue.put(output_buffer)

        print("Push thread ending")

push = push_thread(video)
push.start()

from collections import deque as d
import imutils
import cv2
import copy
import math

def compare_bounding_boxes(b1, b2):
    """
    Returns true if b1 is bigger than b2, otherwise false
    """
    (x1, y1, w1, h1) = b1
    (x2, y2, w2, h2) = b2

    c1 = w1 + w1 + h1 + h1
    c2 = w2 + w2 + h2 + h2

    return c1 > c2

oldBoundingBox = (0, 0, 0, 0)

oldsize = -1
oldpos = (-1,-1,-1,-1)
x,y,w,h = 0,0,0,0

# initialize the first frame in the video stream
firstFrame = None

# Dictionary containing a circular framebuffer and a circular list containing 1 if the frame at the
# same index showed something incoming or 0 if the frame at the same index didn't show something
# incoming
BUFFERSIZESMALL = 5
BUFFERSIZELONG  = 25
framebuffer = {
        # frameBuffer contains area of rectangles
        'frameBuffer'  : d(maxlen = BUFFERSIZELONG, iterable = [0 for x in range(BUFFERSIZELONG) ]),
        'incomingshort': d(maxlen = BUFFERSIZESMALL,iterable = [0 for x in range(BUFFERSIZESMALL)]),
        'incominglong' : d(maxlen = BUFFERSIZELONG, iterable = [0 for x in range(BUFFERSIZELONG) ])
        }

prev_time = time.time()
# loop over the frames of the video
for frame_number in range(FRAME_COUNT):
    new_time = time.time()
    print("Grabbing frame {} / {}".format(frame_number, FRAME_COUNT))
    print("{}ms ({}fps)".format(new_time - prev_time, 1/(new_time - prev_time)))
    prev_time = new_time
    frame = push_queue.get()
    gray = frame.astype(np.uint8)
    return_queue.put(frame)
    debugframe = copy.deepcopy(gray)

    # gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    # gray = cv2.GaussianBlur(gray, (9,9), 0)

    if firstFrame is None:
        firstFrame = gray
        continue

    #compute the absolute difference between the current frame and the first frame
    frameDelta = cv2.absdiff(firstFrame, gray)
    firstFrame = gray
    
    thresh = cv2.threshold(frameDelta, 10, 255, cv2.THRESH_BINARY)[1]

    dilation_kernel = cv2.getStructuringElement(cv2.MORPH_CROSS, (3,3))

    # dilate the thresholded image to fill in holes, then find contours on thresholded image
    thresh = cv2.erode(thresh, dilation_kernel, iterations=1)
    thresh = cv2.dilate(thresh, dilation_kernel, iterations=1)

    cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = cnts[0] if imutils.is_cv2() else cnts[1]

    # store error values to find the best match later
    epsilon = []
    # Use this to keep track of the previous bounding box
    newBoundingBox = (0, 0, 0, 0)
    rectangles = []

    # loop over the contours
    for c in cnts:
        # if the contour is too small, ignore it
        if cv2.contourArea(c) < min_area:
            continue
        x, y, w, h = cv2.boundingRect(c)
        cv2.rectangle(debugframe, (x, y), (x + w, y + h), (0, 0, 255), 2)

        newBoundingBox = (x, y, w, h)
        
        rectangles.append((x,y, w, h))



    best = (0,0,0,0)

    if len(rectangles) >= 2:
        bestError = 9999
        bestRectangle = None
        for coordinateNew in rectangles:
            # Normalizing, so we compare the center point of the box
            # this ignores size differences (which can cause the
            # interpretation of position to be skewed)
            deltaX = abs((oldpos[0]+oldpos[2]/2) - (coordinateNew[0] + coordinateNew[2]/2))
            deltaY = abs((oldpos[1]+oldpos[3]/2) - (coordinateNew[1] + coordinateNew[3]/2))
            error = deltaX + deltaY

            if error < bestError:
                bestError = error
                x, y, w, h = coordinateNew[0], coordinateNew[1], coordinateNew[2], coordinateNew[3]
                newBoundingBox = (coordinateNew[0], coordinateNew[1], coordinateNew[2], coordinateNew[3])
                best = (x,y,w,h)

        (x,y,w,h) = best
        oldpos = best
        cv2.rectangle(debugframe, (x, y), (x + w, y + h), (0, 255, 0), 2)
    elif len(rectangles) == 1:
        newBoundingBox = (rectangles[0][0], rectangles[0][1], rectangles[0][2], rectangles[0][3])
        x, y, w, h = rectangles[0][0], rectangles[0][1], rectangles[0][2], rectangles[0][3]
        cv2.rectangle(debugframe, (x, y), (x + w, y + h), (0, 255, 0), 2)
        best = (x,y,w,h)
        oldpos = newBoundingBox
    else:
        oldpos = oldpos


    if compare_bounding_boxes(newBoundingBox, oldBoundingBox):
        framebuffer['incomingshort'].append(1)
        if(sum(framebuffer['incomingshort']) >= 3):
            framebuffer['incominglong'].append(1)
        framebuffer['frameBuffer'].append(2*newBoundingBox[2] + 2*newBoundingBox[3])
    else:
        framebuffer['incomingshort'].append(0)
        framebuffer['incominglong' ].append(0)
        framebuffer['frameBuffer'  ].append(2*newBoundingBox[2] + 2*newBoundingBox[3])

    totArea         = 0
    prob            = 0
    positivesamples = 0
    for i in range(BUFFERSIZELONG):
        totArea += framebuffer['frameBuffer'][i]
        if(framebuffer['incominglong'][i] == 1):
            prob += framebuffer['frameBuffer'][i]
            positivesamples += 1


    negativesamples = BUFFERSIZELONG - positivesamples


    if(totArea != 0 and positivesamples > 3 and negativesamples < 20):
        prob /= totArea
    else:
        prob= 0

    mcu_communication_channel.write(int(min(prob * 8, 7)))
    print("Probability: {}%".format(prob * 100))

    oldBoundingBox = newBoundingBox
    video_out.write(debugframe.tobytes())
    continue

print("Closing buffers")
for buffer in input_buffers:
    buffer.close()
for buffer in output_buffers:
    buffer.close()

print("Closing files")
video.close()
video_out.close()

print("Closed files")

