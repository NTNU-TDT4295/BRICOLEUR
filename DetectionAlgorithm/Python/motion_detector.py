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

# and here
heuristicMap = {
    "biggest"     : Heuristic.biggest,
    "last"        : Heuristic.last,
    "closestsize" : Heuristic.closestsize,
    "closestpos"  : Heuristic.closestpos,
}

# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-v", "--video", help="path to the video file")
ap.add_argument("-a", "--min-area", type=int, default=500, help="minimum area size")
ap.add_argument("--heuristic", type=str, default="biggest", help="which heuristic to use")
args = vars(ap.parse_args())

print(args["heuristic"])
heuristic = heuristicMap[args["heuristic"]]
print(heuristic)

# vs = cv2.VideoCapture("/home/xilinx/Code/BRICOLEUR/DetectionAlgorithm/TestData/%d-img.png")
vs = cv2.VideoCapture(0)

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

old = -1
oldpos = (-1,-1)
x,y,w,h = 0,0,0,0

# initialize the first frame in the video stream
firstFrame = None

# store the positions of the rectangles in the two last frames
positions = d(maxlen=2)

# Dictionary containing a circular framebuffer and a circular list containing 1 if the frame at the
# same index showed something incoming or 0 if the frame at the same index didn't show something
# incoming
BUFFERSIZE = 5
framebuffer = {
        'frameBuffer': d(maxlen=BUFFERSIZE),
        'incoming': d(maxlen=BUFFERSIZE)
        }

# loop over the frames of the video
while True:
    # Print the currently processed image in a nice way (replaces the previous print)
    # sys.stdout.write("\rProcessing image {}".format(i))
    # sys.stdout.flush()

    # grab the current frame and initialize the occupied/unoccupied text
    # start_r = time.time()

    # make a new frame to draw rectangles on for visualization purposes
    # drawing on the orignal frame altered results so we keep a spare one
    frame = vs.read()[1]
    frame = imutils.resize(frame, width=320)
    debugframe = copy.deepcopy(frame)
    # end_r = time.time()

    # total_time_f += end_r - start_r

    # if the frame could not be grabbed, then we have reached the end
    # of the vide
    if frame is None:
        break

    start_cvt = time.time()
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    # end_cvt = time.time()

    # total_time_f += (end_cvt - start_cvt)

    # start_gb = time.time()

    gray = cv2.GaussianBlur(gray, (21, 21), 0)
    # end_gb = time.time()
    # total_time_f += end_gb - start_gb

    # if the first frame is None, initialize it
    if firstFrame is None:
        firstFrame = gray
        continue

    #compute the absolute difference between the current frame and the first frame
    frameDelta = cv2.absdiff(firstFrame, gray)
    thresh = cv2.threshold(frameDelta, 5, 255, cv2.THRESH_BINARY)[1]

    # Otsu thresholding yields nice results.
    # thresh = cv2.threshold(frameDelta,0,255,cv2.THRESH_BINARY+cv2.THRESH_OTSU)[1]

    # dilate the thresholded image to fill in holes, then find contours on thresholded image
    # start_d = time.time()
    thresh = cv2.dilate(thresh,None, iterations=2)

    # end_d = time.time()
    # total_time_f += end_d - start_d

    start_fc = time.time()
    cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    end_fc = time.time()
    total_time_f += end_fc - start_fc

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

        if(heuristic == Heuristic.closestsize):
            epsilon.append( ( (w*h - old),(x,y,w,h) ) )

        elif(heuristic == Heuristic.biggest):
            if(w*h > newBoundingBox[2]*newBoundingBox[3]):
                newBoundingBox = (x, y, w, h)

        elif(heuristic == Heuristic.closestpos):
            rectangles.append((x,y, w, h))

        else:
            newBoundingBox = (x, y, w, h)

    if(heuristic == Heuristic.closestsize):
        best = (10000,(0,0,0,0))
        for tuples in epsilon:
            print(f"size: {(tuples[1][2] * tuples[1][3])} error: {abs(tuples[0])}")
            print(f"best: {best}")
            if(abs(tuples[0]) < best[0]):
                best = (abs( tuples[0] ) ,tuples[1])

        # prettify this. holy shit, why does python let me
        old       = best[1][2] * best[1][3]
        (x,y,w,h) = best[1][0],best[1][1],best[1][2],best[1][3],
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        newBoundingBox = (x, y, w, h)

    if(heuristic == Heuristic.biggest):
        (x, y, w, h) = newBoundingBox
        cv2.rectangle(debugframe, (x, y), (x + w, y + h), (0, 255, 0), 2)

    if(heuristic == Heuristic.closestpos):
        positions.append(rectangles)
        best = (0,0,0,0)

        if len(positions) == 2:
            oldpos = positions[0]
            newpos = positions[1]

            bestError = 9999
            bestRectangle = None
            for coordinateOld in oldpos:
                for coordinateNew in newpos:
                    deltaX = abs(coordinateOld[0] - coordinateNew[0])
                    deltaY = abs(coordinateOld[1] - coordinateNew[1])
                    error = deltaX + deltaY

                    if error < bestError:
                        bestError = error
                        x, y, w, h = coordinateNew[0], coordinateNew[1], coordinateNew[2], coordinateNew[3]
                        newBoundingBox = (coordinateNew[0], coordinateNew[1], coordinateNew[2], coordinateNew[3])
                        best = (x,y,w,h)
                        cv2.rectangle(debugframe, (x, y), (x + w, y + h), (0, 0, 255), 2)

            (x,y,w,h) = best
            cv2.rectangle(debugframe, (x, y), (x + w, y + h), (0, 255, 0), 2)



    if compare_bounding_boxes(newBoundingBox, oldBoundingBox):
        framebuffer['incoming'].append(1)
        # print("box bigger")
    else:
        framebuffer['incoming'].append(0)
        # print("box smaller")

    if(sum( framebuffer['incoming'] ) > ( BUFFERSIZE/2 )):
       print("box definitely bigger")
    else:
       print("box definitely smaller")

    oldBoundingBox = newBoundingBox

    cv2.imshow('thresh',thresh)
    cv2.imshow('debugframe',debugframe)
    if( cv2.waitKey(1)&0xFF == 27):
        break
    firstFrame = gray
    framebuffer['frameBuffer'].append(frame)
    i += 1
    # print(frameBuffer)
    # cv2.imwrite(format("../Output/tracked%d.png"%i), frame)

# cleanup the camera and close any open windows
cv2.destroyAllWindows()

print(framebuffer['incoming'])
print(str( sum(framebuffer['incoming']) )+"/" + str(BUFFERSIZE))

end = time.time()
total_time = end - start

print("\nTotal time in <function> is = ", total_time_f * 1000, "ms")

print("\nTime = ", total_time * 1000)
