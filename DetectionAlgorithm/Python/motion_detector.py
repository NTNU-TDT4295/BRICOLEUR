# USAGE
# python motion_detector.py
# python motion_detector.py --video videos/example_01.mp4

# import the necessary packages
from imutils.video import VideoStream
import argparse
import datetime
import imutils
import cv2
import time
import os
import sys

# Working from PyCharm, so just making sure I'm actually running on the PYNQ
full_path = os.path.realpath(__file__)
print(full_path)

start = time.time()
total_time_f = 0

# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-v", "--video", help="path to the video file")
ap.add_argument("-a", "--min-area", type=int, default=500, help="minimum area size")
args = vars(ap.parse_args())

vs = cv2.VideoCapture("/home/xilinx/Code/BRICOLEUR/DetectionAlgorithm/TestData/%d-img.png")

# initialize the first frame in the video stream
firstFrame = None

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

# loop over the frames of the video
while True:
    # Print the currently processed image in a nice way (replaces the previous print)
    sys.stdout.write("\rProcessing image {}".format(i))
    sys.stdout.flush()

    # grab the current frame and initialize the occupied/unoccupied text
    # start_r = time.time()
    frame = vs.read()[1]
    # end_r = time.time()

    # total_time_f += end_r - start_r

    # if the frame could not be grabbed, then we have reached the end
    # of the vide
    if frame is None:
        break

    # resize the frame, convert it to grayscale, and blur it
    # start_cvt = time.time()
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

    # compute the absolute difference between the current frame and first frame
    frameDelta = cv2.absdiff(firstFrame, gray)
    thresh = cv2.threshold(frameDelta, 25, 255, cv2.THRESH_BINARY)[1]

    # dilate the thresholded image to fill in holes, then find contours on thresholded image
    # start_d = time.time()
    thresh = cv2.dilate(thresh, None, iterations=2)
    # end_d = time.time()
    # total_time_f += end_d - start_d

    start_fc = time.time()
    cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    end_fc = time.time()
    total_time_f += end_fc - start_fc

    cnts = cnts[0] if imutils.is_cv2() else cnts[1]

    # Use this to keep track of the previous bounding box
    newBoundingBox = (0, 0, 0, 0)

    # loop over the contours
    for c in cnts:
        # if the contour is too small, ignore it
        if cv2.contourArea(c) < args["min_area"]:
            continue

        # compute the bounding box for the contour, draw it on the frame, and update the text
        (x, y, w, h) = cv2.boundingRect(c)

        if w * h > newBoundingBox[2] * newBoundingBox[3]:
            newBoundingBox = (x, y, w, h)
        else:
            pass

        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)

    if compare_bounding_boxes(newBoundingBox, oldBoundingBox):
        pass
    else:
        pass

    oldBoundingBox = newBoundingBox

    i += 1

# cleanup the camera and close any open windows
cv2.destroyAllWindows()

end = time.time()
total_time = end - start

print("\nTotal time in <function> is = ", total_time_f * 1000, "ms")

print("\nTime = ", total_time * 1000)
