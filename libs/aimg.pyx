# -*- coding: utf-8 -*-

# standard library imports
import struct

# third party imports

# application/library imports


class EOF(Exception):

    def __init__(self, path):
        self._path = path

    def __str__(self):
        return repr(self._path)


class AnimatedImgFrame:

    def __init__(self, duration, img_type, img):
        self._duration = duration
        self._img_type = img_type
        self._img = img

    @property
    def duration(self):
        return self._duration

    @property
    def img_type(self):
        return self._img_type

    @property
    def img(self):
        return self._img


class AnimatedImg:

    def __init__(self, path, log):
        self._path = path
        self._fh = open(path, 'rb')
        self._frames = []
        self._index = 0
        self._log = log
        try:
            while 1:
                self._frames.append(self._get_next_frame())
        except EOF as err:
            pass
        self._frame_count = len(self._frames)

    def _get_frame_information(self):
        data = self._fh.read(12)
        if not data:
            raise EOF(self._path)
        # NEED FIX!
        #self._log.log_debug(u"img_data: %s" % data)
        return struct.unpack('IBI', data)

    def _get_image(self, img_size):
        data = self._fh.read(img_size)
        return struct.unpack('%ds' % img_size, data)[0]

    def _get_next_frame(self):
        duration, img_type, img_size = self._get_frame_information()
        img = self._get_image(img_size)
        return AnimatedImgFrame(duration, img_type, img)

    def get_next_frame(self):
        if self._index == self._frame_count:
            self._index = 0
        frame = self._frames[self._index]
        self._index += 1
        return frame

    def next(self):
        return self._frames.next()

    def __iter__(self):
        return self._frames.__iter__()

    def __len__(self):
        return self._frames.__len__()

    def __getitem__(self, key):
        return self._frames[key]