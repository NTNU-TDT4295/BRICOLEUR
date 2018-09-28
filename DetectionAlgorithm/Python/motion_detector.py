# USAGE
# python motion_detector.py
# python motion_detector.py --video videos/example_01.mp4

# import the necessary packages
from imutils.video import VideoStream
import argparse
import datetime
import imutils
import time
import cv2
import time

entire_file = time.time()
parsing = time.time()
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-v", "--video", help="path to the video file")
ap.add_argument("-a", "--min-area", type=int, default=500, help="minimum area size")
args = vars(ap.parse_args())
end_parsing = time.time()
print("parsing = ", (end_parsing - parsing)*1000)
# if the video argument is None, then we are reading from webcam
#if args.get("video", None) is None:
#    vs = VideoStream(src=0).start()
#    time.sleep(2.0)

# otherwise, we are reading from a video file
#else:
#    vs = cv2.VideoCapture(args["video"])
get_images = time.time()
vs = cv2.VideoCapture("../TestData/img%d.png")
# vs = cv2.VideoCapture("/home/xilinx/Code/BRICOLEUR/DetectionAlgorithm/TestData/IMG_%04d.jpg")
fin_get_images = time.time()

print("fetching images = ", (fin_get_images - get_images)*1000)

# initialize the first frame in the video stream
firstFrame = None

oldBoundingBox = (0, 0, 0, 0)

def compareBoundingBoxes(b1, b2):
    """
    Returns true if b1 is bigger than b2, otherwise false
    """
    (x1, y1, w1, h1) = b1
    (x2, y2, w2, h2) = b2

    c1 = w1 + w1 + h1 + h1
    c2 = w2 + w2 + h2 + h2

    print("new = ", c1, "old = ", c2, "new > old = ", c1 > c2)

    return c1 > c2
startAll = time.time()
i = 0
# loop over the frames of the video
while True:
    start = time.time()
    # grab the current frame and initialize the occupied/unoccupied
    # text
    frame = vs.read()[1]
    #frame = frame if args.get("video", None) is None else frame[1]
    # text = "Unoccupied"
    # if the frame could not be grabbed, then we have reached the end
    # of the vide
    if frame is None:
        break
    # resize the frame, convert it to grayscale, and blur it
    #frame = imutils.resize(frame, width=500)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (21, 21), 0)

    # if the first frame is None, initialize it
    if firstFrame is None:
        firstFrame = gray
        continue
    # compute the absolute difference between the current frame and
    # first frame
    frameDelta = cv2.absdiff(firstFrame, gray)
    thresh = cv2.threshold(frameDelta, 25, 255, cv2.THRESH_BINARY)[1]

    # dilate the thresholded image to fill in holes, then find contours
    # on thresholded image
    thresh = cv2.dilate(thresh, None, iterations=2)
    cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL,
                            cv2.CHAIN_APPROX_SIMPLE)
    cnts = cnts[0] if imutils.is_cv2() else cnts[1]
    newBoundingBox = (0, 0, 0, 0)
    # loop over the contours
    for c in cnts:
        # if the contour is too small, ignore it
        if cv2.contourArea(c) < args["min_area"]:
            continue

        # compute the bounding box for the contour, draw it on the frame,
        # and update the text
        (x, y, w, h) = cv2.boundingRect(c)
        if(w*h > newBoundingBox[2]*newBoundingBox[3]):
            newBoundingBox = (x, y, w, h)
        else:
            print("smaller")

        #if compareBoundingBoxes((x, y, w, h), oldBoundingBox):
        #    print("Appraching objec")

        #oldBoundingBox = (x, y, w, h)
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        # text = "Occupied"

    if compareBoundingBoxes(newBoundingBox, oldBoundingBox):
        print("Approaching")
    else:
        print("Going away")

    oldBoundingBox = newBoundingBox



    # draw the text and timestamp on the frame
    #cv2.putText(frame, "Room Status: {}".format(text), (10, 20),
    #            cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
    #cv2.putText(frame, datetime.datetime.now().strftime("%A %d %B %Y %I:%M:%S%p"),
    #            (10, frame.shape[0] - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.35, (0, 0, 255), 1)

    # show the frame and record if the user presses a key
    cv2.imwrite(format("./Output/tracked%d.png"%i), frame)
    i+=1
    end = time.time()
    print("time for one image = ", (end - start)*1000)
    #cv2.imwrite("Thresh", thresh)
    #cv2.imwrite("Frame Delta", frameDelta)
    # key = cv2.waitKey(1) & 0xFF

    # if the `q` key is pressed, break from the lop
    # if key == ord("q"):
        # break

stopAll = time.time()
print("everything but video in = ", (stopAll - startAll)*1000)
# cleanup the camera and close any open windows
#vs.stop() if args.get("video", None) is None else vs.release()
cv2.destroyAllWindows()
end_entire_file = time.time()
print("entire file = ", ( end_entire_file - entire_file )*1000)
