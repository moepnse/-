from c_windows_data_types cimport *
from c_winsock2 cimport SOCKADDR

cdef extern from "WS2tcpip.h":

    ctypedef int socklen_t

    INT getnameinfo(
        const SOCKADDR *    pSockaddr,
        socklen_t           SockaddrLength,
        PCHAR               pNodeBuffer,
        DWORD               NodeBufferSize,
        PCHAR               pServiceBuffer,
        DWORD               ServiceBufferSize,
        INT                 Flags
    ) nogil