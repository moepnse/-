from c_windows_data_types cimport *

cdef extern from "ipifcons.h":
    ctypedef ULONG IFTYPE
   
cdef extern from "Guiddef.h":
    ctypedef struct _GUID:
        DWORD Data1
        WORD  Data2
        WORD  Data3
        BYTE  Data4[8]

    ctypedef _GUID GUID

cdef extern from "ifdef.h":

    ctypedef struct _NET_LUID_LH_STRUCT:    
        ULONG64     Reserved
        ULONG64     NetLuidIndex
        ULONG64     IfType                  # equal to IANA IF type
        
    ctypedef union _NET_LUID_LH:
        ULONG64     Value
        _NET_LUID_LH_STRUCT Info
    
    ctypedef _NET_LUID_LH NET_LUID_LH
    ctypedef _NET_LUID_LH *PNET_LUID_LH


    #
    # Need to make this visible on all platforms (for the purpose of IF_LUID).
    #
    ctypedef NET_LUID_LH NET_LUID
    ctypedef NET_LUID* PNET_LUID

    #
    # IF_LUID
    #
    # Define the locally unique datalink interface identifier type.
    # This type is persistable.
    #
    ctypedef NET_LUID IF_LUID
    ctypedef NET_LUID *PIF_LUID

    ctypedef ULONG NET_IFINDEX
    ctypedef ULONG *PNET_IFINDEX       # Interface Index (ifIndex)
    ctypedef UINT16 NET_IFTYPE
    ctypedef UINT16 *PNET_IFTYPE        # Interface Type (IANA ifType)

    #
    # OperStatus values from RFC 2863
    #
    ctypedef enum IF_OPER_STATUS:
        IfOperStatusUp = 1,
        IfOperStatusDown,
        IfOperStatusTesting,
        IfOperStatusUnknown,
        IfOperStatusDormant,
        IfOperStatusNotPresent,
        IfOperStatusLowerLayerDown

    ctypedef enum _NET_IF_CONNECTION_TYPE:
       NET_IF_CONNECTION_DEDICATED = 1,
       NET_IF_CONNECTION_PASSIVE = 2,
       NET_IF_CONNECTION_DEMAND = 3,
       NET_IF_CONNECTION_MAXIMUM = 4
    
    ctypedef _NET_IF_CONNECTION_TYPE NET_IF_CONNECTION_TYPE
    ctypedef _NET_IF_CONNECTION_TYPE*PNET_IF_CONNECTION_TYPE

    ctypedef enum TUNNEL_TYPE:
        TUNNEL_TYPE_NONE = 0,
        TUNNEL_TYPE_OTHER = 1,
        TUNNEL_TYPE_DIRECT = 2,
        TUNNEL_TYPE_6TO4 = 11,
        TUNNEL_TYPE_ISATAP = 13,
        TUNNEL_TYPE_TEREDO = 14
        
    ctypedef TUNNEL_TYPE *PTUNNEL_TYPE
    
    ctypedef UINT32 NET_IF_COMPARTMENT_ID
    ctypedef UINT32 *PNET_IF_COMPARTMENT_ID

    #
    # Define NetworkGUID type:
    
    ctypedef GUID NET_IF_NETWORK_GUID
    ctypedef GUID *PNET_IF_NETWORK_GUID
    
    ctypedef ULONG NET_IFINDEX
    ctypedef ULONG *PNET_IFINDEX       # Interface Index (ifIndex)
    ctypedef UINT16 NET_IFTYPE
    ctypedef ULONG *PNET_IFTYPE        # Interface Type (IANA ifType)

    #
    # IF_INDEX
    #
    # Define the interface index type.
    # This type is not persistable.
    # This must be unsigned (not an enum) to replace previous uses of
    # an index that used a DWORD type.
    #

    ctypedef NET_IFINDEX IF_INDEX
    ctypedef NET_IFINDEX *PIF_INDEX
    #define IFI_UNSPECIFIED NET_IFINDEX_UNSPECIFIED

    ctypedef ULONG32 NET_IF_OBJECT_ID
    ctypedef ULONG32 *PNET_IF_OBJECT_ID

    ctypedef enum _NET_IF_ADMIN_STATUS:   # ifAdminStatus
        NET_IF_ADMIN_STATUS_UP = 1,
        NET_IF_ADMIN_STATUS_DOWN = 2,
        NET_IF_ADMIN_STATUS_TESTING = 3
    
    ctypedef _NET_IF_ADMIN_STATUS NET_IF_ADMIN_STATUS
    ctypedef _NET_IF_ADMIN_STATUS *PNET_IF_ADMIN_STATUS

    ctypedef enum _NET_IF_OPER_STATUS:   # ifOperStatus
        NET_IF_OPER_STATUS_UP = 1,
        NET_IF_OPER_STATUS_DOWN = 2,
        NET_IF_OPER_STATUS_TESTING = 3,
        NET_IF_OPER_STATUS_UNKNOWN = 4,
        NET_IF_OPER_STATUS_DORMANT = 5,
        NET_IF_OPER_STATUS_NOT_PRESENT = 6,
        NET_IF_OPER_STATUS_LOWER_LAYER_DOWN = 7
    
    ctypedef _NET_IF_OPER_STATUS NET_IF_OPER_STATUS
    ctypedef _NET_IF_OPER_STATUS *PNET_IF_OPER_STATUS