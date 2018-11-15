# USAGE
# python motion_detector.py
# python motion_detector.py --video videos/example_01.mp4

# import the necessary packages
from imutils.video import VideoStream
from collections import deque as d
from enum import Enum
import numpy as np
import argparse
import datetime
import imutils
import cv2
import time
import os
import sys
import copy

# Working from PyCharm, so just making sure I'm actually running on the PYNQ
full_path = os.path.realpath(__file__)
print(full_path)

start = time.time()
total_time_f = 0

# add new heuristics here
class Heuristic(Enum):
    biggest     = 0
    last        = 1
    closestsize = 2
    closestpos  = 3
    composite   = 4

# and here
heuristicMap = {
    "biggest"     : Heuristic.biggest,
    "last"        : Heuristic.last,
    "closestsize" : Heuristic.closestsize,
    "closestpos"  : Heuristic.closestpos,
    "composite"   : Heuristic.composite,
}

# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-v", "--video", help="path to the video file")
ap.add_argument("-a", "--min-area", type=int, default=500, help="minimum area size")
ap.add_argument("--heuristic", type=str, default="biggest", help="which heuristic to use")
args = vars(ap.parse_args())

heuristic = heuristicMap[args["heuristic"]]
print(heuristic)

# vs = cv2.VideoCapture("/home/xilinx/Code/BRICOLEUR/DetectionAlgorithm/TestData/%d-img.png")
vs = cv2.VideoCapture(0)
vs.set(3,320)
vs.set(4,240)

oldBoundingBox = (0, 0, 0, 0)

def compare_bounding_boxes(b1, b2):
    """
    Returns true if b1 is bigger than b2, otherwise false
    """
    (x1, y1, w1, h1) = b1
    (x2, y2, w2, h2) = b2

    c1 = w1 + w1 + h1 + h1
    c2 = w2 + w2 + h2 + h2

    return c1 > c2

i = 0

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

# loop over the frames of the video
while True:

    # make a new frame to draw rectangles on for visualization purposes
    # drawing on the orignal frame altered results so we keep a spare one
    frame = vs.read()[1]
    # frame = imutils.resize(frame, width=320)
    debugframe = copy.deepcopy(frame)
    # if the frame could not be grabbed, then
    # we have reached the end of the video
    if frame is None:
        break

    start_cvt = time.time()
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (9,9), 0)

    if firstFrame is None:
        firstFrame = gray
        continue

    #compute the absolute difference between the current frame and the first frame
    frameDelta = cv2.absdiff(firstFrame, gray)
    thresh = cv2.threshold(frameDelta, 10, 255, cv2.THRESH_BINARY)[1]

    # Otsu thresholding yields nice visual results. Maybe not useful for our application
    # otsu = cv2.threshold(frameDelta,0,255,cv2.THRESH_BINARY+cv2.THRESH_OTSU)[1]

    # dilate the thresholded image to fill in holes, then find contours on thresholded image
    dilation_kernel = cv2.getStructuringElement(cv2.MORPH_CROSS, (3,3))
    thresh = cv2.erode(thresh, dilation_kernel, iterations=1)
    thresh = cv2.dilate(thresh, dilation_kernel,iterations=3)

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
        if cv2.contourArea(c) < args["min_area"]:
            continue

        (x, y, w, h) = cv2.boundingRect(c)
        cv2.rectangle(debugframe, (x, y), (x + w, y + h), (0, 0, 255), 2)

        if(heuristic in [ Heuristic.closestsize, Heuristic.composite]):
            epsilon.append(((w*h - oldsize),(x,y,w,h)))

        elif(heuristic == Heuristic.biggest):
            if(w*h > newBoundingBox[2]*newBoundingBox[3]):
                newBoundingBox = (x, y, w, h)

        elif(heuristic in [ Heuristic.closestpos, Heuristic.composite]):
            rectangles.append((x,y, w, h))

        else:
            newBoundingBox = (x, y, w, h)

    if(heuristic == Heuristic.closestsize):
        best = (10000,(0,0,0,0))
        for tuples in epsilon:
            # print(f"size: {(tuples[1][2] * tuples[1][3])} error: {abs(tuples[0])}")
            # print(f"best: {best}")
            if(abs(tuples[0]) < best[0]):
                best = (abs( tuples[0] ) ,tuples[1])

        # prettify this. holy shit, why does python let me
        oldsize   = best[1][2] * best[1][3]
        (x,y,w,h) = best[1][0], best[1][1], best[1][2], best[1][3],
        cv2.rectangle(debugframe, (x, y), (x + w, y + h), (0, 255, 0), 2)
        newBoundingBox = (x, y, w, h)

    if(heuristic == Heuristic.biggest):
        (x, y, w, h) = newBoundingBox
        cv2.rectangle(debugframe, (x, y), (x + w, y + h), (0, 255, 0), 2)

    if(heuristic == Heuristic.composite):
        # TODO:
        #implement a combination between closestpos and closestsize
        (x, y, w, h) = newBoundingBox # Placeholder statements
        cv2.rectangle(debugframe, (x, y), (x + w, y + h), (0, 255, 0), 2)

    if(heuristic == Heuristic.closestpos):
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

    print("=========")
    if compare_bounding_boxes(newBoundingBox, oldBoundingBox):
        framebuffer['incomingshort'].append(1)
        if(sum(framebuffer['incomingshort']) >= 3):
            framebuffer['incominglong'].append(1)
        print("current box bigger")
        framebuffer['frameBuffer'].append(2*newBoundingBox[2] + 2*newBoundingBox[3])
    else:
        framebuffer['incomingshort'].append(0)
        framebuffer['incominglong' ].append(0)
        framebuffer['frameBuffer'  ].append(2*newBoundingBox[2] + 2*newBoundingBox[3])
        print("current box smaller")

    # if(sum( framebuffer['incomingshort'] ) > ( BUFFERSIZESMALL/2 )):
    #    print("box definitely bigger")
    # else:
    #    print("box definitely smaller")
    # print(sum( framebuffer['incominglong'] ))
    # probability = [x for x in framebuffer['frameBuffer']]
    # print(probability)
    # print(framebuffer['incominglong'])

    totArea         = 0
    prob            = 0
    positivesamples = 0
    for i in range(BUFFERSIZELONG):
        totArea += framebuffer['frameBuffer'][i]
        if(framebuffer['incominglong'][i] == 1):
            prob += framebuffer['frameBuffer'][i]
            positivesamples += 1


    negativesamples = BUFFERSIZELONG - positivesamples

    print("total: %6d\tpositive: %2d"%(totArea,positivesamples))
    print("incom: %6d\tpnegative: %2d"%(prob,negativesamples))
    if(totArea != 0 and positivesamples > 3 and negativesamples < 20):
        prob /= totArea
    else:
        prob= 0

    print("%1.6f"%prob)

    if(sum(framebuffer['incominglong']) > ((2*BUFFERSIZELONG)/3)):
        print("i think we're colliding")
    else:
        print(23*" ")

    print(str(framebuffer['incomingshort']))
    print(str(framebuffer['incominglong']))
    print("=========")
    print(10*"\033[F")

    oldBoundingBox = newBoundingBox

    cv2.imshow('dilated',thresh)
    # cv2.imshow('pls',pls)
    cv2.imshow('delta', frameDelta)
    cv2.imshow('debugframe',debugframe)

    if( cv2.waitKey(1)&0xFF == 27):
        break
    firstFrame = gray

    i += 1

# cleanup the camera and close any open windows
cv2.destroyAllWindows()

print(framebuffer['incomingshort'])
print(str( sum(framebuffer['incomingshort']) )+"/" + str(BUFFERSIZESMALL))

end = time.time()
total_time = end - start

print("\nTotal time in <function> is = ", total_time_f * 1000, "ms")

print("\nTime = ", total_time * 1000)

print(vs.get(3))
print(vs.get(4))
