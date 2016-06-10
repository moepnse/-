# -*- coding: utf-8 -*-

# standard library imports
import os
import sys
import struct

# third party imports

# application/library imports


def create_frame(path):
    img = open(path, 'rb').read()
    img_size = len(img)
    #print img_size
    duration = 1000
    return struct.pack('IBI%ds' % img_size, duration, 0, img_size, img)

imgs = ['w1.png', 'w2.png', 'w3.png']

data = b''
for img in imgs:
    data += create_frame(os.path.join(r'imgs\icons\16x16', img))

fh = open('img.aimg', 'wb')
fh.write(data)
fh.close()