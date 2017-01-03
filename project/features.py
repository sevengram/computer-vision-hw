import os
import pickle
import sys

import cv2

nf = 256
task = sys.argv[1]
result = []
detector = cv2.xfeatures2d.SIFT_create(nfeatures=nf)

for filename in os.listdir(task):
    print(filename)
    img = cv2.imread('%s/%s' % (task, filename))

    height, width, channels = img.shape
    if width > 1024:
        img = cv2.resize(img, None, fx=1024.0 / width, fy=1024.0 / width, interpolation=cv2.INTER_CUBIC)

    # find the keypoints and descriptors with SIFT
    kp, des = detector.detectAndCompute(img, None)
    result.append({'name': filename, 'features': des, 'nf': len(des)})

with open('raw.pkl', 'wb') as output:
    pickle.dump(result, output)
