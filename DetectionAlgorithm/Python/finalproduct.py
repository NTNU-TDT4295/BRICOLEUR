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
import math

min_area = 500
videopath = "../TestData/eirik2.mov"

vs = cv2.VideoCapture(videopath)
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


def printProbabilityInBinary(prob):
    # print("%1.6f"%(prob*100))
    numbits = 3
    possibleRepresentationOfAllTheBits = math.pow(2, numbits)
    step = 100/possibleRepresentationOfAllTheBits

    for i in range(0, 8):
        if inRange(prob, i * step, (i + 1) * step):
            byteString = '{0:03b}'.format(i)
            print(byteString)

            writeToGPIO(0, byteString[0])
            writeToGPIO(1, byteString[1])
            writeToGPIO(2, byteString[2])

            break

def writeToGPIO(gpio_number, value):
    print(gpio_number, value)
    #gpio_write[gpio_number] = value
    pass

def inRange(number, a, b):
    if number >= a and number < b:
        return True
    else:
        return False


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


    frame = vs.read()[1]
    debugframe = copy.deepcopy(frame)

    if frame is None:
        break
    frame = imutils.resize(frame, width=320)

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (9,9), 0)

    if firstFrame is None:
        firstFrame = gray
        continue

    #compute the absolute difference between the current frame and the first frame
    frameDelta = cv2.absdiff(firstFrame, gray)
    thresh = cv2.threshold(frameDelta, 10, 255, cv2.THRESH_BINARY)[1]

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
        if cv2.contourArea(c) < min_area:
            continue

        (x, y, w, h) = cv2.boundingRect(c)
        cv2.rectangle(debugframe, (x, y), (x + w, y + h), (0, 0, 255), 2)


        newBoundingBox = (x, y, w, h)


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

    # print("%1.6f"%prob)
    printProbabilityInBinary(prob * 100)

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


print(vs.get(3))
print(vs.get(4))