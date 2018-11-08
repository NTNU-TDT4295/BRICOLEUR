import cv2
import numpy as np

file = open("imagebuffer.txt", "r")

buffer = file.read().split(" ")
newBuf = []
for i in range(0, len(buffer)):
    newBuf.append(np.uint8(buffer[i]))

frame = np.ndarray((720, 1080), dtype=np.uint8, buffer=np.array(newBuf))
cv2.imshow("est", frame)
cv2.waitKey(0)