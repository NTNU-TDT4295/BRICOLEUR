import cv2
import numpy as np
from imutils.video import VideoStream
import imutils
from enum import Enum


class Heuristic(Enum):
    biggestInArea = 0
    last = 1
    closestInArea = 2


# initialize the first frame in the video stream
text = "Incoming: false"
firstFrame = None
frameCounter = 0
min_area = 500
frame_source = 1
vs = VideoStream(src=0).start()
heuristic = Heuristic.biggestInArea
oldBoundingBox = (0, 0, 0, 0)
old = -1
x, y, w, h = 0, 0, 0, 0


def getFrameFromTextFile(count):
    global frameCounter

    # Basicly needs to change these lines to read from the image buffer
    file = open(str(count) + ".txt", "r")
    buffer = file.read().split(" ")

    imageBuffer = []
    for i in range(0, len(buffer)):
        imageBuffer.append(np.uint8(buffer[i]))

    frame = np.ndarray((720, 1080), dtype=np.uint8, buffer=np.array(imageBuffer))
    frameCounter = count + 1
    return frame


def getFrameFromDMABuffer():
    readyBuffer = []
    preprocessedImageBuffer = []

    # Simply polling the ready buffer untill a valid image is in the buffer containing the preprocessed images
    while True:
        if (readyBuffer[0] == 1):
            return np.ndarray((240, 320), dtype=np.uint8, buffer=np.array(preprocessedImageBuffer))
        else:
            continue


def getFrameFromWebCam():
    frame = vs.read()
    frame = imutils.resize(frame, width=320)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    gaussed = cv2.GaussianBlur(gray, (21, 21), 0)
    return gaussed


def getFrame():
    if frame_source == 0:
        return getFrameFromTextFile(frameCounter)
    elif frame_source == 1:
        return getFrameFromWebCam()
    elif frame_source == 2:
        return getFrameFromDMABuffer()


firstFrame = getFrame()

while True:

    frame = getFrame()
    debugFrame = frame

    frameDelta = cv2.absdiff(firstFrame, frame)
    thresh = cv2.threshold(frameDelta, 25, 255, cv2.THRESH_BINARY)[1]
    dilated = cv2.dilate(thresh, None, iterations=2)
    contours = cv2.findContours(dilated.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    contours = contours[0] if imutils.is_cv2() else contours[1]

    # store error values to find the best match later
    epsilon = []

    # Use this to keep track of the previous bounding box
    newBoundingBox = (0, 0, 0, 0)

    for contour in contours:
        if cv2.contourArea(contour) < min_area:
            continue

        # compute the bounding box for the contour, draw it on the frame,
        (x, y, w, h) = cv2.boundingRect(contour)
        cv2.rectangle(debugFrame, (x, y), (x + w, y + h), (0, 255, 0), 2)

        # Here we are choosing which heuristic to use for selecting the new contour.
        if heuristic == Heuristic.closestInArea:
            epsilon.append(((w * h - old), (x, y, w, h)))

        elif heuristic == Heuristic.biggestInArea:
            if w * h > newBoundingBox[2] * newBoundingBox[3]:
                newBoundingBox = (x, y, w, h)

        else:
            newBoundingBox = (x, y, w, h)

    if heuristic == Heuristic.closestInArea:
        best = (10000, (0, 0, 0, 0))
        for tuples in epsilon:
            print(f"size: {(tuples[1][2] * tuples[1][3])} error: {abs(tuples[0])}")
            print(f"best: {best}")
            if (abs(tuples[0]) < best[0]):
                best = (abs(tuples[0]), tuples[1])

        # prettify this. holy shit, why does python let me
        old = best[1][2] * best[1][3]
        (x, y, w, h) = best[1][0], best[1][1], best[1][2], best[1][3],
        cv2.rectangle(debugFrame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        newBoundingBox = (x, y, w, h)

    if heuristic == Heuristic.biggestInArea:
        (x, y, w, h) = newBoundingBox
        cv2.rectangle(debugFrame, (x, y), (x + w, y + h), (0, 255, 0), 2)


    if newBoundingBox[2] * newBoundingBox[3] > oldBoundingBox[2] * oldBoundingBox[3]:
        print("incoming")
        text = "Incoming: true"
    else:
        print("not incoming")
        text = "Incoming: false"

    oldBoundingBox = newBoundingBox


    cv2.putText(debugFrame, "Object status: {}".format(text), (10, 20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)

    #firstFrame = frame


    cv2.imshow("debugframe", debugFrame)
    cv2.imshow("BRICOLEUR", frame)
    key = cv2.waitKey(1) & 0xFF
