from c_windows_data_types cimport *

cdef extern from "time.h":
    ctypedef long time_t

cdef extern from "winsock2.h": 
#cdef extern from "Ws2tcpip.h": 

    # Flags for getnameinfo()

    DWORD NI_NOFQDN       = 0x01  # Only return nodename portion for local hosts 
    DWORD NI_NUMERICHOST  = 0x02  # Return numeric form of the host's address 
    DWORD NI_NAMEREQD     = 0x04  # Error if the host's name not in DNS 
    DWORD NI_NUMERICSERV  = 0x08  # Return numeric form of the service (port #) 
    DWORD NI_DGRAM        = 0x10  # Service is a datagram service 

#cdef extern from "ws2def.h":

    ctypedef USHORT ADDRESS_FAMILY

    #
    # Although AF_UNSPEC is defined for backwards compatibility, using
    # AF_UNSPEC for the "af" parameter when creating a socket is STRONGLY
    # DISCOURAGED.  The interpretation of the "protocol" parameter
    # depends on the actual address family chosen.  As environments grow
    # to include more and more address families that use overlapping
    # protocol values there is more and more chance of choosing an
    # undesired address family when AF_UNSPEC is used.
    #
    DWORD AF_UNSPEC       = 0               # unspecified
    DWORD AF_UNIX         = 1               # local to host (pipes, portals)
    DWORD AF_INET         = 2               # internetwork: UDP, TCP, etc.
    DWORD AF_IMPLINK      = 3               # arpanet imp addresses
    DWORD AF_PUP          = 4               # pup protocols: e.g. BSP
    DWORD AF_CHAOS        = 5               # mit CHAOS protocols
    DWORD AF_NS           = 6               # XEROX NS protocols
    DWORD AF_IPX          = AF_NS           # IPX protocols: IPX, SPX, etc.
    DWORD AF_ISO          = 7               # ISO protocols
    DWORD AF_OSI          = AF_ISO          # OSI is ISO
    DWORD AF_ECMA         = 8               # european computer manufacturers
    DWORD AF_DATAKIT      = 9               # datakit protocols
    DWORD AF_CCITT        = 10              # CCITT protocols, X.25 etc
    DWORD AF_SNA          = 11              # IBM SNA
    DWORD AF_DECnet       = 12              # DECnet
    DWORD AF_DLI          = 13              # Direct data link interface
    DWORD AF_LAT          = 14              # LAT
    DWORD AF_HYLINK       = 15              # NSC Hyperchannel
    DWORD AF_APPLETALK    = 16              # AppleTalk
    DWORD AF_NETBIOS      = 17              # NetBios-style addresses
    DWORD AF_VOICEVIEW    = 18              # VoiceView
    DWORD AF_FIREFOX      = 19              # Protocols from Firefox
    DWORD AF_UNKNOWN1     = 20              # Somebody is using this!
    DWORD AF_BAN          = 21              # Banyan
    DWORD AF_ATM          = 22              # Native ATM Services
    DWORD AF_INET6        = 23              # Internetwork Version 6
    DWORD AF_CLUSTER      = 24              # Microsoft Wolfpack
    DWORD AF_12844        = 25              # IEEE 1284.4 WG AF
    DWORD AF_IRDA         = 26              # IrDA
    DWORD AF_NETDES       = 28              # Network Designers OSI & gateway

    #
    # Structure used to store most addresses.
    #
    ctypedef struct sockaddr:
        ADDRESS_FAMILY sa_family           # Address family.
        CHAR sa_data[14]                   # Up to 14 bytes of direct address.

    ctypedef sockaddr SOCKADDR
    ctypedef sockaddr *PSOCKADDR
    ctypedef sockaddr *LPSOCKADDR

    #
    # SockAddr Information
    #
    ctypedef struct _SOCKET_ADDRESS:
        LPSOCKADDR lpSockaddr
        INT iSockaddrLength

    ctypedef _SOCKET_ADDRESS SOCKET_ADDRESS
    ctypedef _SOCKET_ADDRESS *PSOCKET_ADDRESS
    ctypedef _SOCKET_ADDRESS *LPSOCKET_ADDRESS

    DWORD WSADESCRIPTION_LEN      = 256
    DWORD WSASYS_STATUS_LEN       = 128

    ctypedef struct WSAData:
        WORD                    wVersion
        WORD                    wHighVersion
    #ifdef _WIN64
    IF UNAME_MACHINE == "AMD64":    
        unsigned short          iMaxSockets
        unsigned short          iMaxUdpDg
        char*                   lpVendorInfo
        #char                    szDescription[WSADESCRIPTION_LEN+1]
        #char                    szSystemStatus[WSASYS_STATUS_LEN+1]
        char                    szDescription[256+1]
        char                    szSystemStatus[128+1]
    #else
    ELSE:
        #char                    szDescription[WSADESCRIPTION_LEN+1]
        #char                    szSystemStatus[WSASYS_STATUS_LEN+1]
        char                    szDescription[256+1]
        char                    szSystemStatus[128+1]
        unsigned short          iMaxSockets
        unsigned short          iMaxUdpDg
        char*                   lpVendorInfo
    #endif
    ctypedef WSAData WSADATA
    ctypedef WSADATA* LPWSADATA

    int WSAStartup(
        WORD wVersionRequested,
        LPWSADATA lpWSAData
    ) nogil

    int WSACleanup() nogil