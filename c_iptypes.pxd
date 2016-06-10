from c_windows_data_types cimport *

from c_nldef cimport *
from c_ifdef cimport *
from c_winsock2 cimport SOCKET_ADDRESS
 
cdef extern from "time.h":
    ctypedef long time_t
    
cdef extern from "iptypes.h":
    # Definitions and structures used by getnetworkparams and getadaptersinfo apis

    DWORD MAX_ADAPTER_DESCRIPTION_LENGTH  = 128 # arb.
    DWORD MAX_ADAPTER_NAME_LENGTH         = 256 # arb.
    DWORD MAX_ADAPTER_ADDRESS_LENGTH      = 8   # arb.
    DWORD DEFAULT_MINIMUM_ENTITIES        = 32  # arb.
    DWORD MAX_HOSTNAME_LEN                = 128 # arb.
    DWORD MAX_DOMAIN_NAME_LEN             = 128 # arb.
    DWORD MAX_SCOPE_ID_LEN                = 256 # arb.
    DWORD MAX_DHCPV6_DUID_LENGTH          = 130 # RFC 3315.

    #
    # types
    #

    # Node Type

    DWORD BROADCAST_NODETYPE              = 1
    DWORD PEER_TO_PEER_NODETYPE           = 2
    DWORD MIXED_NODETYPE                  = 4
    DWORD HYBRID_NODETYPE                 = 8

    #
    # IP_ADDRESS_STRING - store an IP address as a dotted decimal string
    #

    ctypedef struct IP_ADDRESS_STRING:
        char String[4 * 4]
    
    ctypedef IP_ADDRESS_STRING *PIP_ADDRESS_STRING
    ctypedef IP_ADDRESS_STRING IP_MASK_STRING
    ctypedef IP_ADDRESS_STRING *PIP_MASK_STRING

    #
    # IP_ADDR_STRING - store an IP address with its corresponding subnet mask,
    # both as dotted decimal strings
    #

    ctypedef struct _IP_ADDR_STRING:
        _IP_ADDR_STRING* Next
        IP_ADDRESS_STRING IpAddress
        IP_MASK_STRING IpMask
        DWORD Context
        
    ctypedef _IP_ADDR_STRING IP_ADDR_STRING
    ctypedef _IP_ADDR_STRING *PIP_ADDR_STRING

    #
    # ADAPTER_INFO - per-adapter information. All IP addresses are stored as
    # strings
    #

    struct _IP_ADAPTER_INFO
    
    struct _IP_ADAPTER_INFO:
        _IP_ADAPTER_INFO* Next
        DWORD ComboIndex
        #char AdapterName[MAX_ADAPTER_NAME_LENGTH + 4]
        #char Description[MAX_ADAPTER_DESCRIPTION_LENGTH + 4]
        char AdapterName[256 + 4]
        char Description[256 + 4]
        UINT AddressLength
        #BYTE Address[MAX_ADAPTER_ADDRESS_LENGTH]
        BYTE Address[256]
        DWORD Index
        UINT Type
        UINT DhcpEnabled
        PIP_ADDR_STRING CurrentIpAddress
        IP_ADDR_STRING IpAddressList
        IP_ADDR_STRING GatewayList
        IP_ADDR_STRING DhcpServer
        BOOL HaveWins
        IP_ADDR_STRING PrimaryWinsServer
        IP_ADDR_STRING SecondaryWinsServer
        time_t LeaseObtained
        time_t LeaseExpires
        
    ctypedef _IP_ADAPTER_INFO IP_ADAPTER_INFO
    ctypedef _IP_ADAPTER_INFO *PIP_ADAPTER_INFO

    #ifdef _WINSOCK2API_

    #
    # The following types require Winsock2.
    #

    ctypedef NL_PREFIX_ORIGIN IP_PREFIX_ORIGIN
    ctypedef NL_SUFFIX_ORIGIN IP_SUFFIX_ORIGIN
    ctypedef NL_DAD_STATE IP_DAD_STATE
    
    ctypedef struct _IP_ADAPTER_UNICAST_ADDRESS_LH_UNION_STRUCT:
        ULONG Length
        DWORD Flags
    
    ctypedef union _IP_ADAPTER_UNICAST_ADDRESS_LH_UNION:
        ULONGLONG Alignment
        _IP_ADAPTER_UNICAST_ADDRESS_LH_UNION_STRUCT aaa
        
    struct _IP_ADAPTER_UNICAST_ADDRESS_LH
        
    struct _IP_ADAPTER_UNICAST_ADDRESS_LH:
        _IP_ADAPTER_UNICAST_ADDRESS_LH_UNION aaa

        _IP_ADAPTER_UNICAST_ADDRESS_LH *Next
        SOCKET_ADDRESS Address

        IP_PREFIX_ORIGIN PrefixOrigin
        IP_SUFFIX_ORIGIN SuffixOrigin
        IP_DAD_STATE DadState

        ULONG ValidLifetime
        ULONG PreferredLifetime
        ULONG LeaseLifetime
        UINT8 OnLinkPrefixLength
    
    ctypedef _IP_ADAPTER_UNICAST_ADDRESS_LH IP_ADAPTER_UNICAST_ADDRESS_LH
    ctypedef _IP_ADAPTER_UNICAST_ADDRESS_LH *PIP_ADAPTER_UNICAST_ADDRESS_LH

    ctypedef struct _IP_ADAPTER_UNICAST_ADDRESS_XP_UNION_STRUCT:
        ULONG Length
        DWORD Flags

    ctypedef union _IP_ADAPTER_UNICAST_ADDRESS_XP_UNION:
        ULONGLONG Alignment
        _IP_ADAPTER_UNICAST_ADDRESS_XP_UNION_STRUCT aaa
    
    struct _IP_ADAPTER_UNICAST_ADDRESS_XP
    
    struct _IP_ADAPTER_UNICAST_ADDRESS_XP:
        _IP_ADAPTER_UNICAST_ADDRESS_XP_UNION aaa
        _IP_ADAPTER_UNICAST_ADDRESS_XP *Next
        SOCKET_ADDRESS Address

        IP_PREFIX_ORIGIN PrefixOrigin
        IP_SUFFIX_ORIGIN SuffixOrigin
        IP_DAD_STATE DadState

        ULONG ValidLifetime
        ULONG PreferredLifetime
        ULONG LeaseLifetime
        
    ctypedef _IP_ADAPTER_UNICAST_ADDRESS_XP IP_ADAPTER_UNICAST_ADDRESS_XP
    ctypedef _IP_ADAPTER_UNICAST_ADDRESS_XP *PIP_ADAPTER_UNICAST_ADDRESS_XP

    #if (NTDDI_VERSION >= NTDDI_LONGHORN)
    #typedef  IP_ADAPTER_UNICAST_ADDRESS_LH IP_ADAPTER_UNICAST_ADDRESS;
    #typedef  IP_ADAPTER_UNICAST_ADDRESS_LH *PIP_ADAPTER_UNICAST_ADDRESS;
    #elif (NTDDI_VERSION >= NTDDI_WINXP)
    #typedef  IP_ADAPTER_UNICAST_ADDRESS_XP IP_ADAPTER_UNICAST_ADDRESS;
    #typedef  IP_ADAPTER_UNICAST_ADDRESS_XP *PIP_ADAPTER_UNICAST_ADDRESS;
    #endif

    #
    # Bit values of IP_ADAPTER_UNICAST_ADDRESS Flags field.
    #
    DWORD IP_ADAPTER_ADDRESS_DNS_ELIGIBLE = 0x01
    DWORD IP_ADAPTER_ADDRESS_TRANSIENT    = 0x02

    ctypedef struct _IP_ADAPTER_ANYCAST_ADDRESS_XP_UNION_STRUCT:
        ULONG Length
        DWORD Flags

    ctypedef union _IP_ADAPTER_ANYCAST_ADDRESS_XP_UNION:
        ULONGLONG Alignment
        _IP_ADAPTER_ANYCAST_ADDRESS_XP_UNION_STRUCT aaa
        
    struct _IP_ADAPTER_ANYCAST_ADDRESS_XP
        
    struct _IP_ADAPTER_ANYCAST_ADDRESS_XP:
        _IP_ADAPTER_ANYCAST_ADDRESS_XP_UNION aaa
        _IP_ADAPTER_ANYCAST_ADDRESS_XP *Next
        SOCKET_ADDRESS Address
    
    ctypedef _IP_ADAPTER_ANYCAST_ADDRESS_XP IP_ADAPTER_ANYCAST_ADDRESS_XP
    ctypedef _IP_ADAPTER_ANYCAST_ADDRESS_XP *PIP_ADAPTER_ANYCAST_ADDRESS_XP
    
    #if (NTDDI_VERSION >= NTDDI_WINXP)
    #ctypedef IP_ADAPTER_ANYCAST_ADDRESS_XP IP_ADAPTER_ANYCAST_ADDRESS;
    #ctypedef IP_ADAPTER_ANYCAST_ADDRESS_XP *PIP_ADAPTER_ANYCAST_ADDRESS;
    #endif

    ctypedef struct _IP_ADAPTER_MULTICAST_ADDRESS_XP_UNION_STRUCT:
        ULONG Length
        DWORD Flags
        
    ctypedef union _IP_ADAPTER_MULTICAST_ADDRESS_XP_UNION:
        ULONGLONG Alignment
        _IP_ADAPTER_MULTICAST_ADDRESS_XP_UNION_STRUCT aaa
       
    struct _IP_ADAPTER_MULTICAST_ADDRESS_XP
       
    struct _IP_ADAPTER_MULTICAST_ADDRESS_XP:
        _IP_ADAPTER_MULTICAST_ADDRESS_XP_UNION aaa
        _IP_ADAPTER_MULTICAST_ADDRESS_XP *Next
        SOCKET_ADDRESS Address
    
    ctypedef _IP_ADAPTER_MULTICAST_ADDRESS_XP IP_ADAPTER_MULTICAST_ADDRESS_XP
    ctypedef _IP_ADAPTER_MULTICAST_ADDRESS_XP *PIP_ADAPTER_MULTICAST_ADDRESS_XP
    
    #if (NTDDI_VERSION >= NTDDI_WINXP)
    #typedef IP_ADAPTER_MULTICAST_ADDRESS_XP IP_ADAPTER_MULTICAST_ADDRESS;
    #typedef IP_ADAPTER_MULTICAST_ADDRESS_XP *PIP_ADAPTER_MULTICAST_ADDRESS;
    #endif

    ctypedef struct _IP_ADAPTER_DNS_SERVER_ADDRESS_XP_UNION_STRUCT:
        ULONG Length
        DWORD Reserved
    
    ctypedef union _IP_ADAPTER_DNS_SERVER_ADDRESS_XP_UNION:
        ULONGLONG Alignment
        _IP_ADAPTER_DNS_SERVER_ADDRESS_XP_UNION_STRUCT aaa
        
    struct _IP_ADAPTER_DNS_SERVER_ADDRESS_XP
        
    struct _IP_ADAPTER_DNS_SERVER_ADDRESS_XP:
        _IP_ADAPTER_DNS_SERVER_ADDRESS_XP_UNION aaa
        _IP_ADAPTER_DNS_SERVER_ADDRESS_XP *Next;
        SOCKET_ADDRESS Address
        
    ctypedef _IP_ADAPTER_DNS_SERVER_ADDRESS_XP IP_ADAPTER_DNS_SERVER_ADDRESS_XP
    ctypedef _IP_ADAPTER_DNS_SERVER_ADDRESS_XP *PIP_ADAPTER_DNS_SERVER_ADDRESS_XP
    
    #if (NTDDI_VERSION >= NTDDI_WINXP)
    #typedef IP_ADAPTER_DNS_SERVER_ADDRESS_XP IP_ADAPTER_DNS_SERVER_ADDRESS;
    #typedef IP_ADAPTER_DNS_SERVER_ADDRESS_XP *PIP_ADAPTER_DNS_SERVER_ADDRESS;
    #endif

    ctypedef struct _IP_ADAPTER_WINS_SERVER_ADDRESS_LH_STRUCT:
        ULONG Length
        DWORD Reserved
        
    ctypedef union _IP_ADAPTER_WINS_SERVER_ADDRESS_LH_UNION:
        ULONGLONG Alignment
        _IP_ADAPTER_WINS_SERVER_ADDRESS_LH_STRUCT aaa
        
    struct _IP_ADAPTER_WINS_SERVER_ADDRESS_LH
        
    struct _IP_ADAPTER_WINS_SERVER_ADDRESS_LH:
        _IP_ADAPTER_WINS_SERVER_ADDRESS_LH_UNION aaa
        _IP_ADAPTER_WINS_SERVER_ADDRESS_LH *Next
        SOCKET_ADDRESS Address
        
    ctypedef _IP_ADAPTER_WINS_SERVER_ADDRESS_LH IP_ADAPTER_WINS_SERVER_ADDRESS_LH
    ctypedef _IP_ADAPTER_WINS_SERVER_ADDRESS_LH *PIP_ADAPTER_WINS_SERVER_ADDRESS_LH
    
    #if (NTDDI_VERSION >= NTDDI_LONGHORN)
    #typedef IP_ADAPTER_WINS_SERVER_ADDRESS_LH IP_ADAPTER_WINS_SERVER_ADDRESS;
    #typedef IP_ADAPTER_WINS_SERVER_ADDRESS_LH *PIP_ADAPTER_WINS_SERVER_ADDRESS;
    #endif

    ctypedef struct _IP_ADAPTER_GATEWAY_ADDRESS_LH_UNION_STRUCT:
        ULONG Length
        DWORD Reserved

    ctypedef union _IP_ADAPTER_GATEWAY_ADDRESS_LH_UNION:
            ULONGLONG Alignment
            _IP_ADAPTER_GATEWAY_ADDRESS_LH_UNION_STRUCT aaa

    struct _IP_ADAPTER_GATEWAY_ADDRESS_LH
            
    struct _IP_ADAPTER_GATEWAY_ADDRESS_LH:
        _IP_ADAPTER_GATEWAY_ADDRESS_LH_UNION aaa
        _IP_ADAPTER_GATEWAY_ADDRESS_LH *Next
        SOCKET_ADDRESS Address
        
    ctypedef _IP_ADAPTER_GATEWAY_ADDRESS_LH IP_ADAPTER_GATEWAY_ADDRESS_LH
    ctypedef _IP_ADAPTER_GATEWAY_ADDRESS_LH *PIP_ADAPTER_GATEWAY_ADDRESS_LH
    
    #if (NTDDI_VERSION >= NTDDI_LONGHORN)
    #typedef IP_ADAPTER_GATEWAY_ADDRESS_LH IP_ADAPTER_GATEWAY_ADDRESS;
    #typedef IP_ADAPTER_GATEWAY_ADDRESS_LH *PIP_ADAPTER_GATEWAY_ADDRESS;
    #endif

    ctypedef union _IP_ADAPTER_PREFIX_XP_UNION_STRUCT:
        ULONG Length
        DWORD Flags
    
    ctypedef union _IP_ADAPTER_PREFIX_XP_UNION:
        ULONGLONG Alignment
        _IP_ADAPTER_PREFIX_XP_UNION_STRUCT aaa
        
    struct _IP_ADAPTER_PREFIX_XP
        
    struct _IP_ADAPTER_PREFIX_XP:
        _IP_ADAPTER_PREFIX_XP_UNION aaa
        _IP_ADAPTER_PREFIX_XP *Next
        SOCKET_ADDRESS Address
        ULONG PrefixLength
    
    ctypedef _IP_ADAPTER_PREFIX_XP IP_ADAPTER_PREFIX_XP
    ctypedef _IP_ADAPTER_PREFIX_XP *PIP_ADAPTER_PREFIX_XP
    
    #if (NTDDI_VERSION >= NTDDI_WINXP)
    #typedef IP_ADAPTER_PREFIX_XP IP_ADAPTER_PREFIX;
    #typedef IP_ADAPTER_PREFIX_XP *PIP_ADAPTER_PREFIX;
    #endif

    #
    # Bit values of IP_ADAPTER_ADDRESSES Flags field.
    #
    DWORD IP_ADAPTER_DDNS_ENABLED               = 0x00000001
    DWORD IP_ADAPTER_REGISTER_ADAPTER_SUFFIX    = 0x00000002
    DWORD IP_ADAPTER_DHCP_ENABLED               = 0x00000004
    DWORD IP_ADAPTER_RECEIVE_ONLY               = 0x00000008
    DWORD IP_ADAPTER_NO_MULTICAST               = 0x00000010
    DWORD IP_ADAPTER_IPV6_OTHER_STATEFUL_CONFIG = 0x00000020
    DWORD IP_ADAPTER_NETBIOS_OVER_TCPIP_ENABLED = 0x00000040
    DWORD IP_ADAPTER_IPV4_ENABLED               = 0x00000080
    DWORD IP_ADAPTER_IPV6_ENABLED               = 0x00000100

    ctypedef union _IP_ADAPTER_ADDRESSES_LH_UNION_STRUCT:
        ULONG Length
        IF_INDEX IfIndex
        
    ctypedef union _IP_ADAPTER_ADDRESSES_LH_UNION:
        ULONGLONG Alignment
        _IP_ADAPTER_ADDRESSES_LH_UNION_STRUCT aaa
        
    ctypedef struct _IP_ADAPTER_ADDRESSES_LH_UNION2_STRUCT:
        ULONG DdnsEnabled
        ULONG RegisterAdapterSuffix
        ULONG Dhcpv4Enabled
        ULONG ReceiveOnly
        ULONG NoMulticast
        ULONG Ipv6OtherStatefulConfig
        ULONG NetbiosOverTcpipEnabled
        ULONG Ipv4Enabled
        ULONG Ipv6Enabled
        ULONG Ipv6ManagedAddressConfigurationSupported

    ctypedef union _IP_ADAPTER_ADDRESSES_LH_UNION2:
        ULONG Flags
        _IP_ADAPTER_ADDRESSES_LH_UNION2_STRUCT aaa
        
    struct _IP_ADAPTER_ADDRESSES_LH
        
    struct _IP_ADAPTER_ADDRESSES_LH:
        _IP_ADAPTER_ADDRESSES_LH_UNION aaa
        _IP_ADAPTER_ADDRESSES_LH *Next
        PCHAR AdapterName
        PIP_ADAPTER_UNICAST_ADDRESS_LH FirstUnicastAddress
        PIP_ADAPTER_ANYCAST_ADDRESS_XP FirstAnycastAddress
        PIP_ADAPTER_MULTICAST_ADDRESS_XP FirstMulticastAddress
        PIP_ADAPTER_DNS_SERVER_ADDRESS_XP FirstDnsServerAddress
        PWCHAR DnsSuffix
        PWCHAR Description
        PWCHAR FriendlyName
        #BYTE PhysicalAddress[MAX_ADAPTER_ADDRESS_LENGTH]
        BYTE PhysicalAddress[8]
        ULONG PhysicalAddressLength
        _IP_ADAPTER_ADDRESSES_LH_UNION2 bbb
        ULONG Mtu
        IFTYPE IfType
        IF_OPER_STATUS OperStatus
        IF_INDEX Ipv6IfIndex
        ULONG ZoneIndices[16]
        PIP_ADAPTER_PREFIX_XP FirstPrefix

        ULONG64 TransmitLinkSpeed;
        ULONG64 ReceiveLinkSpeed;
        PIP_ADAPTER_WINS_SERVER_ADDRESS_LH FirstWinsServerAddress
        PIP_ADAPTER_GATEWAY_ADDRESS_LH FirstGatewayAddress
        ULONG Ipv4Metric
        ULONG Ipv6Metric
        IF_LUID Luid
        SOCKET_ADDRESS Dhcpv4Server
        NET_IF_COMPARTMENT_ID CompartmentId
        NET_IF_NETWORK_GUID NetworkGuid
        NET_IF_CONNECTION_TYPE ConnectionType
        TUNNEL_TYPE TunnelType
        #
        # DHCP v6 Info.
        #
        SOCKET_ADDRESS Dhcpv6Server
        #BYTE Dhcpv6ClientDuid[MAX_DHCPV6_DUID_LENGTH]
        BYTE Dhcpv6ClientDuid[130]
        ULONG Dhcpv6ClientDuidLength
        ULONG Dhcpv6Iaid
    
    ctypedef _IP_ADAPTER_ADDRESSES_LH IP_ADAPTER_ADDRESSES_LH
    ctypedef _IP_ADAPTER_ADDRESSES_LH *PIP_ADAPTER_ADDRESSES_LH

    ctypedef struct _IP_ADAPTER_ADDRESSES_XP_UNION_STRUCT:
        ULONG Length
        DWORD IfIndex
    
    ctypedef union _IP_ADAPTER_ADDRESSES_XP_UNION:
        ULONGLONG Alignment;
        _IP_ADAPTER_ADDRESSES_XP_UNION_STRUCT aaa

    struct _IP_ADAPTER_ADDRESSES_XP
        
    struct _IP_ADAPTER_ADDRESSES_XP:
        _IP_ADAPTER_ADDRESSES_XP_UNION aaa
        _IP_ADAPTER_ADDRESSES_XP *Next
        PCHAR AdapterName
        PIP_ADAPTER_UNICAST_ADDRESS_XP FirstUnicastAddress
        PIP_ADAPTER_ANYCAST_ADDRESS_XP FirstAnycastAddress
        PIP_ADAPTER_MULTICAST_ADDRESS_XP FirstMulticastAddress
        PIP_ADAPTER_DNS_SERVER_ADDRESS_XP FirstDnsServerAddress
        PWCHAR DnsSuffix
        PWCHAR Description
        PWCHAR FriendlyName
        #BYTE PhysicalAddress[MAX_ADAPTER_ADDRESS_LENGTH]
        BYTE PhysicalAddress[8]
        DWORD PhysicalAddressLength
        DWORD Flags
        DWORD Mtu
        DWORD IfType
        IF_OPER_STATUS OperStatus
        DWORD Ipv6IfIndex
        DWORD ZoneIndices[16]
        PIP_ADAPTER_PREFIX_XP FirstPrefix
    
    ctypedef _IP_ADAPTER_ADDRESSES_XP IP_ADAPTER_ADDRESSES_XP
    ctypedef _IP_ADAPTER_ADDRESSES_XP *PIP_ADAPTER_ADDRESSES_XP

    #if (NTDDI_VERSION >= NTDDI_LONGHORN)
    #typedef  IP_ADAPTER_ADDRESSES_LH IP_ADAPTER_ADDRESSES;
    #typedef  IP_ADAPTER_ADDRESSES_LH *PIP_ADAPTER_ADDRESSES;
    #elif (NTDDI_VERSION >= NTDDI_WINXP)
    #typedef  IP_ADAPTER_ADDRESSES_XP IP_ADAPTER_ADDRESSES;
    #typedef  IP_ADAPTER_ADDRESSES_XP *PIP_ADAPTER_ADDRESSES;
    #else
    #
    # For platforms other platforms that are including
    # the file but not using the types.
    #
    #typedef  IP_ADAPTER_ADDRESSES_XP IP_ADAPTER_ADDRESSES;
    #typedef  IP_ADAPTER_ADDRESSES_XP *PIP_ADAPTER_ADDRESSES;
    #endif

    ctypedef IP_ADAPTER_ADDRESSES_XP IP_ADAPTER_ADDRESSES
    ctypedef IP_ADAPTER_ADDRESSES_XP *PIP_ADAPTER_ADDRESSES
    
    #
    # Flags used as argument to GetAdaptersAddresses().
    # "SKIP" flags are added when the default is to include the information.
    # "INCLUDE" flags are added when the default is to skip the information.
    #
    DWORD GAA_FLAG_SKIP_UNICAST                   = 0x0001
    DWORD GAA_FLAG_SKIP_ANYCAST                   = 0x0002
    DWORD GAA_FLAG_SKIP_MULTICAST                 = 0x0004
    DWORD GAA_FLAG_SKIP_DNS_SERVER                = 0x0008
    DWORD GAA_FLAG_INCLUDE_PREFIX                 = 0x0010
    DWORD GAA_FLAG_SKIP_FRIENDLY_NAME             = 0x0020
    DWORD GAA_FLAG_INCLUDE_WINS_INFO              = 0x0040
    DWORD GAA_FLAG_INCLUDE_GATEWAYS               = 0x0080
    DWORD GAA_FLAG_INCLUDE_ALL_INTERFACES         = 0x0100
    DWORD GAA_FLAG_INCLUDE_ALL_COMPARTMENTS       = 0x0200
    DWORD GAA_FLAG_INCLUDE_TUNNEL_BINDINGORDER    = 0x0400

    #endif /* _WINSOCK2API_ */

    #
    # IP_PER_ADAPTER_INFO - per-adapter IP information such as DNS server list.
    #

    ctypedef struct _IP_PER_ADAPTER_INFO_W2KSP1:
        UINT AutoconfigEnabled
        UINT AutoconfigActive
        PIP_ADDR_STRING CurrentDnsServer
        IP_ADDR_STRING DnsServerList
    ctypedef _IP_PER_ADAPTER_INFO_W2KSP1 IP_PER_ADAPTER_INFO_W2KSP1
    ctypedef _IP_PER_ADAPTER_INFO_W2KSP1 *PIP_PER_ADAPTER_INFO_W2KSP1
    
    #if (NTDDI_VERSION >= NTDDI_WIN2KSP1)
    #typedef  IP_PER_ADAPTER_INFO_W2KSP1 IP_PER_ADAPTER_INFO;
    #typedef  IP_PER_ADAPTER_INFO_W2KSP1 *PIP_PER_ADAPTER_INFO;
    #endif


    #
    # FIXED_INFO - the set of IP-related information which does not depend on DHCP
    #

    ctypedef struct FIXED_INFO_W2KSP1:
        #char HostName[MAX_HOSTNAME_LEN + 4]
        #char DomainName[MAX_DOMAIN_NAME_LEN + 4]
        char HostName[128 + 4]
        char DomainName[128 + 4]
        PIP_ADDR_STRING CurrentDnsServer
        IP_ADDR_STRING DnsServerList
        UINT NodeType
        #char ScopeId[MAX_SCOPE_ID_LEN + 4]
        char ScopeId[128 + 4]
        UINT EnableRouting
        UINT EnableProxy
        UINT EnableDns
    ctypedef FIXED_INFO_W2KSP1 *PFIXED_INFO_W2KSP1
    #if (NTDDI_VERSION >= NTDDI_WIN2KSP1)
    #typedef  FIXED_INFO_W2KSP1 FIXED_INFO;
    #typedef  FIXED_INFO_W2KSP1 *PFIXED_INFO;
    #endif


    #ifndef IP_INTERFACE_NAME_INFO_DEFINED
    DWORD IP_INTERFACE_NAME_INFO_DEFINED

    ctypedef struct ip_interface_name_info_w2ksp1:
        ULONG           Index      # Interface Index
        ULONG           MediaType  # Interface Types - see ipifcons.h
        UCHAR           ConnectionType
        UCHAR           AccessType
        GUID            DeviceGuid # Device GUID is the guid of the device
                                    # that IP exposes
        GUID            InterfaceGuid # Interface GUID, if not GUID_NULL is the
                                    # GUID for the interface mapped to the device.
    
    ctypedef ip_interface_name_info_w2ksp1 IP_INTERFACE_NAME_INFO_W2KSP1
    ctypedef ip_interface_name_info_w2ksp1 *PIP_INTERFACE_NAME_INFO_W2KSP1

    #if (NTDDI_VERSION >= NTDDI_WIN2KSP1)
    #typedef IP_INTERFACE_NAME_INFO_W2KSP1 IP_INTERFACE_NAME_INFO;
    #typedef IP_INTERFACE_NAME_INFO_W2KSP1 *PIP_INTERFACE_NAME_INFO;