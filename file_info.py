import sys
import os

from libs.win.file_info import FileInfo

if len(sys.argv) > 1:
    path = unicode(sys.argv[1])
    if not os.path.exists(path):
        print "%s does not exist!" % path
        sys.exit(1)
    if not os.path.isfile(path):
        print "%s is not a file!" % path
    fi = FileInfo(path)
    print "file informations of %s:" % path
    for key in fi:
        print "%s: %s" % (key, fi[key])