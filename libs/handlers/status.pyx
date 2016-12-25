"""
cdef:
    unsigned char INSTALLING = 0
    unsigned char UPGRADING = 1
    unsigned char REMOVING = 2
    unsigned char INSTALLED = 3
    unsigned char UPGRADED = 4
    unsigned char REMOVED = 5
    unsigned char FAILED = 6
    unsigned char UNKNOWN = 7

    unsigned char SEND_STATUS = 1
    unsigned char SEND_INFO = 2

    unsigned char SEND_INFO_SUCCESS = 0
    unsigned char SEND_INFO_ERROR = 1
"""

INSTALLING = 1
UPGRADING = 2
REMOVING = 3
INSTALLED = 4
UPGRADED = 5
REMOVED = 6
FAILED = 7
UNKNOWN = 8

SEND_STATUS = 1
SEND_INFO = 2
SEND_DONE = 3

SEND_INFO_SUCCESS = 1
SEND_INFO_WARN = 2
SEND_INFO_ERROR = 3