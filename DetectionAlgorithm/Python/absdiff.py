import cv2

frame = cv2.imread("bie.png")
frame = cv2.resize(frame, dsize=(320, 240))
frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

frame2 = cv2.imread("bie2.png")
frame2 = cv2.resize(frame2, dsize=(320,240))
frame2 = cv2.cvtColor(frame2, cv2.COLOR_BGR2GRAY)

framedelta = cv2.absdiff(frame, frame2)

thresh = cv2.threshold(framedelta, 10, 255, cv2.THRESH_BINARY)[1]

cv2.imwrite("test.png", thresh)
