#from libc.stdint cimport uint32_t, int64_t
from c_windows_data_types cimport *

cdef extern from "stdio.h":
    unsigned long BUFSIZ = 512

cdef extern from "time.h":
    ctypedef long time_t

IF UNAME_SYSNAME == "Windows":
    cdef extern from "Windows.h":
        pass

cdef extern from *:

    ctypedef DWORD ACCESS_MASK
    ctypedef ACCESS_MASK* PACCESS_MASK

    #
    # Error control type
    #
    DWORD SERVICE_ERROR_IGNORE           = 0x00000000
    DWORD SERVICE_ERROR_NORMAL           = 0x00000001
    DWORD SERVICE_ERROR_SEVERE           = 0x00000002
    DWORD SERVICE_ERROR_CRITICAL         = 0x00000003

    #
    # Start Type
    #
    DWORD SERVICE_BOOT_START             = 0x00000000
    DWORD SERVICE_SYSTEM_START           = 0x00000001
    DWORD SERVICE_AUTO_START             = 0x00000002
    DWORD SERVICE_DEMAND_START           = 0x00000003
    DWORD SERVICE_DISABLED               = 0x00000004

#cdef extern from "datacontainer.h":
    #ctypedef unsigned __int64 QWORD
    ctypedef unsigned long long QWORD

#cdef extern from "WinDef.h":
    ctypedef DWORD *PDWORD

#cdef extern from "WTypes.h":

    ctypedef long LONG
    ctypedef unsigned char UCHAR
    ctypedef short SHORT
    ctypedef unsigned short USHORT
    ctypedef DWORD ULONG
    ctypedef double DOUBLE
    ctypedef PVOID PSID

    ctypedef struct _ACL:
        UCHAR AclRevision
        UCHAR Sbz1
        USHORT AclSize
        USHORT AceCount
        USHORT Sbz2

    ctypedef _ACL ACL
    ctypedef ACL *PACL

    struct _SECURITY_ATTRIBUTES:
        DWORD nLength
        void *lpSecurityDescriptor
        bint bInheritHandle

    ctypedef _SECURITY_ATTRIBUTES SECURITY_ATTRIBUTES
    ctypedef _SECURITY_ATTRIBUTES *PSECURITY_ATTRIBUTES
    ctypedef _SECURITY_ATTRIBUTES *LPSECURITY_ATTRIBUTES

    ctypedef enum _SECURITY_IMPERSONATION_LEVEL:
        SecurityAnonymous,
        SecurityIdentification,
        SecurityImpersonation,
        SecurityDelegation

    ctypedef _SECURITY_IMPERSONATION_LEVEL SECURITY_IMPERSONATION_LEVEL
    ctypedef _SECURITY_IMPERSONATION_LEVEL* PSECURITY_IMPERSONATION_LEVE

    ctypedef struct _SID_IDENTIFIER_AUTHORITY:
        UCHAR Value[6]

    ctypedef _SID_IDENTIFIER_AUTHORITY SID_IDENTIFIER_AUTHORITY
    ctypedef _SID_IDENTIFIER_AUTHORITY* PSID_IDENTIFIER_AUTHORITY

    ctypedef struct _SID:
        BYTE Revision
        BYTE SubAuthorityCount
        SID_IDENTIFIER_AUTHORITY IdentifierAuthority
        ULONG SubAuthority[1]

    ctypedef _SID SID
    ctypedef _SID *PISID

    ctypedef struct _SID_AND_ATTRIBUTES:
        SID *Sid
        DWORD Attributes

    ctypedef _SID_AND_ATTRIBUTES SID_AND_ATTRIBUTES
    ctypedef _SID_AND_ATTRIBUTES *PSID_AND_ATTRIBUTES

IF UNAME_SYSNAME == "Windows":
    cdef extern from "WinUser.h":
        pass

cdef extern from *:
    DWORD MAX_STR_BLOCKREASON = 256

    BOOL __stdcall ShutdownBlockReasonCreate(
        HWND hWnd,
        LPCWSTR pwszReason) nogil

    BOOL __stdcall ShutdownBlockReasonQuery(
        HWND hWnd,
        LPWSTR pwszBuff,
        DWORD *pcchBuff) nogil

    BOOL __stdcall ShutdownBlockReasonDestroy(
        HWND hWnd)

#cdef extern from "WinNT.h":

    #
    # Predefined Value Types.
    #

    DWORD REG_NONE                    = 0    # No value type
    DWORD REG_SZ                      = 1    # Unicode nul terminated string
    DWORD REG_EXPAND_SZ               = 2    # Unicode nul terminated string
                                                   # (with environment variable references)
    DWORD REG_BINARY                  = 3    # Free form binary
    DWORD REG_DWORD                   = 4    # 32-bit number
    DWORD REG_DWORD_LITTLE_ENDIAN     = 4    # 32-bit number =same as REG_DWORD
    DWORD REG_DWORD_BIG_ENDIAN        = 5    # 32-bit number
    DWORD REG_LINK                    = 6    # Symbolic Link =unicode
    DWORD REG_MULTI_SZ                = 7    # Multiple Unicode strings
    DWORD REG_RESOURCE_LIST           = 8    # Resource list in the resource map
    DWORD REG_FULL_RESOURCE_DESCRIPTOR = 9   # Resource list in the hardware description
    DWORD REG_RESOURCE_REQUIREMENTS_LIST = 10 
    DWORD REG_QWORD                   = 11   # 64-bit number
    DWORD REG_QWORD_LITTLE_ENDIAN     = 11   # 64-bit number =same as REG_QWORD

    ########################################################################
    ##                                                                    ##
    ##                             ACCESS TYPES                           ##
    ##                                                                    ##
    ########################################################################

    #
    # Registry Specific Access Rights.
    #

    DWORD KEY_QUERY_VALUE         = 0x0001
    DWORD KEY_SET_VALUE           = 0x0002
    DWORD KEY_CREATE_SUB_KEY      = 0x0004
    DWORD KEY_ENUMERATE_SUB_KEYS  = 0x0008
    DWORD KEY_NOTIFY              = 0x0010
    DWORD KEY_CREATE_LINK         = 0x0020
    DWORD KEY_WOW64_32KEY         = 0x0200
    DWORD KEY_WOW64_64KEY         = 0x0100
    DWORD KEY_WOW64_RES           = 0x0300
    DWORD KEY_READ                = 0x20019
    DWORD KEY_WRITE               = 0x20006
    DWORD KEY_ALL_ACCESS          = 0xF003F


    #
    #  The following are masks for the predefined standard access types
    #

    DWORD DELETE                           = 0x00010000L
    DWORD READ_CONTROL                     = 0x00020000L
    DWORD WRITE_DAC                        = 0x00040000L
    DWORD WRITE_OWNER                      = 0x00080000L
    DWORD SYNCHRONIZE                      = 0x00100000L

    DWORD STANDARD_RIGHTS_REQUIRED         = 0x000F0000L

    DWORD STANDARD_RIGHTS_READ             = READ_CONTROL
    DWORD STANDARD_RIGHTS_WRITE            = READ_CONTROL
    DWORD STANDARD_RIGHTS_EXECUTE          = READ_CONTROL

    DWORD STANDARD_RIGHTS_ALL              = 0x001F0000L

    DWORD SPECIFIC_RIGHTS_ALL              = 0x0000FFFFL

    #
    # AccessSystemAcl access type
    #

    DWORD ACCESS_SYSTEM_SECURITY           = 0x01000000L

    #
    # MaximumAllowed access type
    #

    DWORD MAXIMUM_ALLOWED                  = 0x02000000L

    #
    #  These are the generic rights.
    #

    DWORD GENERIC_READ                     = 0x80000000L
    DWORD GENERIC_WRITE                    = 0x40000000L
    DWORD GENERIC_EXECUTE                  = 0x20000000L
    DWORD GENERIC_ALL                      = 0x10000000L


    ##include <ctype.h>  
    DWORD ANYSIZE_ARRAY = 1

    ########################################################################
    ##                                                                    ##
    ##               NT Defined Privileges                                ##
    ##                                                                    ##
    ########################################################################

    LPCWSTR SE_CREATE_TOKEN_NAME              = <bytes>u"SeCreateTokenPrivilege"
    LPCWSTR SE_ASSIGNPRIMARYTOKEN_NAME        = <bytes>u"SeAssignPrimaryTokenPrivilege"
    LPCWSTR SE_LOCK_MEMORY_NAME               = <bytes>u"SeLockMemoryPrivilege"
    LPCWSTR SE_INCREASE_QUOTA_NAME            = <bytes>u"SeIncreaseQuotaPrivilege"
    LPCWSTR SE_UNSOLICITED_INPUT_NAME         = <bytes>u"SeUnsolicitedInputPrivilege"
    LPCWSTR SE_MACHINE_ACCOUNT_NAME           = <bytes>u"SeMachineAccountPrivilege"
    LPCWSTR SE_TCB_NAME                       = <bytes>u"SeTcbPrivilege"
    LPCWSTR SE_SECURITY_NAME                  = <bytes>u"SeSecurityPrivilege"
    LPCWSTR SE_TAKE_OWNERSHIP_NAME            = <bytes>u"SeTakeOwnershipPrivilege"
    LPCWSTR SE_LOAD_DRIVER_NAME               = <bytes>u"SeLoadDriverPrivilege"
    LPCWSTR SE_SYSTEM_PROFILE_NAME            = <bytes>u"SeSystemProfilePrivilege"
    LPCWSTR SE_SYSTEMTIME_NAME                = <bytes>u"SeSystemtimePrivilege"
    LPCWSTR SE_PROF_SINGLE_PROCESS_NAME       = <bytes>u"SeProfileSingleProcessPrivilege"
    LPCWSTR SE_INC_BASE_PRIORITY_NAME         = <bytes>u"SeIncreaseBasePriorityPrivilege"
    LPCWSTR SE_CREATE_PAGEFILE_NAME           = <bytes>u"SeCreatePagefilePrivilege"
    LPCWSTR SE_CREATE_PERMANENT_NAME          = <bytes>u"SeCreatePermanentPrivilege"
    LPCWSTR SE_BACKUP_NAME                    = <bytes>u"SeBackupPrivilege"
    LPCWSTR SE_RESTORE_NAME                   = <bytes>u"SeRestorePrivilege"
    LPCWSTR SE_SHUTDOWN_NAME                  = <bytes>u"SeShutdownPrivilege"
    LPCWSTR SE_DEBUG_NAME                     = <bytes>u"SeDebugPrivilege"
    LPCWSTR SE_AUDIT_NAME                     = <bytes>u"SeAuditPrivilege"
    LPCWSTR SE_SYSTEM_ENVIRONMENT_NAME        = <bytes>u"SeSystemEnvironmentPrivilege"
    LPCWSTR SE_CHANGE_NOTIFY_NAME             = <bytes>u"SeChangeNotifyPrivilege"
    LPCWSTR SE_REMOTE_SHUTDOWN_NAME           = <bytes>u"SeRemoteShutdownPrivilege"
    LPCWSTR SE_UNDOCK_NAME                    = <bytes>u"SeUndockPrivilege"
    LPCWSTR SE_SYNC_AGENT_NAME                = <bytes>u"SeSyncAgentPrivilege"
    LPCWSTR SE_ENABLE_DELEGATION_NAME         = <bytes>u"SeEnableDelegationPrivilege"
    LPCWSTR SE_MANAGE_VOLUME_NAME             = <bytes>u"SeManageVolumePrivilege"
    LPCWSTR SE_IMPERSONATE_NAME               = <bytes>u"SeImpersonatePrivilege"
    LPCWSTR SE_CREATE_GLOBAL_NAME             = <bytes>u"SeCreateGlobalPrivilege"
    LPCWSTR SE_TRUSTED_CREDMAN_ACCESS_NAME    = <bytes>u"SeTrustedCredManAccessPrivilege"
    LPCWSTR SE_RELABEL_NAME                   = <bytes>u"SeRelabelPrivilege"
    LPCWSTR SE_INC_WORKING_SET_NAME           = <bytes>u"SeIncreaseWorkingSetPrivilege"
    LPCWSTR SE_TIME_ZONE_NAME                 = <bytes>u"SeTimeZonePrivilege"
    LPCWSTR SE_CREATE_SYMBOLIC_LINK_NAME      = <bytes>u"SeCreateSymbolicLinkPrivilege"

    ctypedef struct _LUID:
        DWORD LowPart
        LONG HighPart

    ctypedef _LUID LUID
    ctypedef _LUID *PLUID

    ctypedef enum _SID_NAME_USE:
        SidTypeUser = 1,
        SidTypeGroup,
        SidTypeDomain,
        SidTypeAlias,
        SidTypeWellKnownGroup,
        SidTypeDeletedAccount,
        SidTypeInvalid,
        SidTypeUnknown,
        SidTypeComputer,
        SidTypeLabel

    ctypedef _SID_NAME_USE SID_NAME_USE
    ctypedef _SID_NAME_USE *PSID_NAME_USE

    ctypedef struct _SID_AND_ATTRIBUTES:
        PSID Sid
        DWORD Attributes

    ctypedef _SID_AND_ATTRIBUTES SID_AND_ATTRIBUTES
    ctypedef _SID_AND_ATTRIBUTES* PSID_AND_ATTRIBUTES;

    #ctypedef SID_AND_ATTRIBUTES SID_AND_ATTRIBUTES_ARRAY[ANYSIZE_ARRAY]
    ctypedef SID_AND_ATTRIBUTES SID_AND_ATTRIBUTES_ARRAY[1]
    ctypedef SID_AND_ATTRIBUTES_ARRAY *PSID_AND_ATTRIBUTES_ARRAY

    DWORD SID_HASH_SIZE = 32
    ctypedef ULONG_PTR SID_HASH_ENTRY
    ctypedef ULONG_PTR *PSID_HASH_ENTRY

    ctypedef struct _SID_AND_ATTRIBUTES_HASH:
        DWORD SidCount
        PSID_AND_ATTRIBUTES SidAttr
        #SID_HASH_ENTRY Hash[SID_HASH_SIZE]
        SID_HASH_ENTRY Hash[32]

    ctypedef _SID_AND_ATTRIBUTES_HASH SID_AND_ATTRIBUTES_HASH
    ctypedef _SID_AND_ATTRIBUTES_HASH *PSID_AND_ATTRIBUTES_HASH

    ########################################################################
    ##                                                                    ##
    ##               Privilege Related Data Structures                    ##
    ##                                                                    ##
    ########################################################################

    ##
    ## Privilege attributes
    ##

    DWORD SE_PRIVILEGE_ENABLED_BY_DEFAULT = 0x00000001L
    DWORD SE_PRIVILEGE_ENABLED            = 0x00000002L
    DWORD SE_PRIVILEGE_REMOVED            = 0X00000004L
    DWORD SE_PRIVILEGE_USED_FOR_ACCESS    = 0x80000000L


    ########################################################################
    ##                                                                    ##
    ##                        LUID_AND_ATTRIBUTES                         ##
    ##                                                                    ##
    ########################################################################
    ##
    ##

    ##include <pshpack4.h>

    ctypedef struct _LUID_AND_ATTRIBUTES:
        LUID Luid;
        DWORD Attributes;
    ctypedef _LUID_AND_ATTRIBUTES LUID_AND_ATTRIBUTES
    ctypedef _LUID_AND_ATTRIBUTES* PLUID_AND_ATTRIBUTES
    #ctypedef LUID_AND_ATTRIBUTES LUID_AND_ATTRIBUTES_ARRAY[ANYSIZE_ARRAY]
    ctypedef LUID_AND_ATTRIBUTES LUID_AND_ATTRIBUTES_ARRAY[1]
    ctypedef LUID_AND_ATTRIBUTES_ARRAY *PLUID_AND_ATTRIBUTES_ARRAY


    ####################################################################
    ##                                                                ##
    ##           Token Object Definitions                             ##
    ##                                                                ##
    ##                                                                ##
    ####################################################################


    #
    # Token Specific Access Rights.
    #

    DWORD TOKEN_ASSIGN_PRIMARY    =  0x0001
    DWORD TOKEN_DUPLICATE         =  0x0002
    DWORD TOKEN_IMPERSONATE       =  0x0004
    DWORD TOKEN_QUERY             =  0x0008
    DWORD TOKEN_QUERY_SOURCE      =  0x0010
    DWORD TOKEN_ADJUST_PRIVILEGES =  0x0020
    DWORD TOKEN_ADJUST_GROUPS     =  0x0040
    DWORD TOKEN_ADJUST_DEFAULT    =  0x0080
    DWORD TOKEN_ADJUST_SESSIONID  =  0x0100

    DWORD TOKEN_ALL_ACCESS_P
    DWORD TOKEN_ALL_ACCESS
    DWORD TOKEN_READ
    DWORD TOKEN_WRITE
    DWORD TOKEN_EXECUTE

    #
    # Token Types
    #

    ctypedef enum _TOKEN_TYPE:
        TokenPrimary = 1,
        TokenImpersonation

    ctypedef _TOKEN_TYPE TOKEN_TYPE
    ctypedef TOKEN_TYPE *PTOKEN_TYPE

    #
    # Token elevation values describe the relative strength of a given token.
    # A full token is a token with all groups and privileges to which the principal
    # is authorized.  A limited token is one with some groups or privileges removed.
    #

    ctypedef enum _TOKEN_ELEVATION_TYPE:
        TokenElevationTypeDefault = 1,
        TokenElevationTypeFull,
        TokenElevationTypeLimited,

    ctypedef _TOKEN_ELEVATION_TYPE TOKEN_ELEVATION_TYPE
    ctypedef _TOKEN_ELEVATION_TYPE *PTOKEN_ELEVATION_TYPE

    #
    # Token Information Classes.
    #

    ctypedef enum _TOKEN_INFORMATION_CLASS:
        TokenUser = 1,
        TokenGroups,
        TokenPrivileges,
        TokenOwner,
        TokenPrimaryGroup,
        TokenDefaultDacl,
        TokenSource,
        TokenType,
        TokenImpersonationLevel,
        TokenStatistics,
        TokenRestrictedSids,
        TokenSessionId,
        TokenGroupsAndPrivileges,
        TokenSessionReference,
        TokenSandBoxInert,
        TokenAuditPolicy,
        TokenOrigin,
        TokenElevationType,
        TokenLinkedToken,
        TokenElevation,
        TokenHasRestrictions,
        TokenAccessInformation,
        TokenVirtualizationAllowed,
        TokenVirtualizationEnabled,
        TokenIntegrityLevel,
        TokenUIAccess,
        TokenMandatoryPolicy,
        TokenLogonSid,
        MaxTokenInfoClass  # MaxTokenInfoClass should always be the last enum

    ctypedef _TOKEN_INFORMATION_CLASS TOKEN_INFORMATION_CLASS
    ctypedef _TOKEN_INFORMATION_CLASS *PTOKEN_INFORMATION_CLASS;

    #
    # Token information class structures
    #

    ctypedef struct _TOKEN_USER:
        SID_AND_ATTRIBUTES User

    ctypedef _TOKEN_USER TOKEN_USER
    ctypedef _TOKEN_USER *PTOKEN_USER;

    ctypedef struct _TOKEN_GROUPS:
        DWORD GroupCount
        #SID_AND_ATTRIBUTES Groups[ANYSIZE_ARRAY]
        SID_AND_ATTRIBUTES Groups[1]

    ctypedef _TOKEN_GROUPS TOKEN_GROUPS
    ctypedef _TOKEN_GROUPS  *PTOKEN_GROUPS;

    ctypedef struct _TOKEN_PRIVILEGES:
        DWORD PrivilegeCount
        #LUID_AND_ATTRIBUTES Privileges[ANYSIZE_ARRAY]
        LUID_AND_ATTRIBUTES Privileges[1]

    ctypedef _TOKEN_PRIVILEGES TOKEN_PRIVILEGES
    ctypedef _TOKEN_PRIVILEGES *PTOKEN_PRIVILEGES;

    ctypedef struct _TOKEN_OWNER:
        PSID Owner

    ctypedef _TOKEN_OWNER TOKEN_OWNER
    ctypedef _TOKEN_OWNER *PTOKEN_OWNER

    ctypedef struct _TOKEN_PRIMARY_GROUP:
        PSID PrimaryGroup

    ctypedef _TOKEN_PRIMARY_GROUP TOKEN_PRIMARY_GROUP
    ctypedef _TOKEN_PRIMARY_GROUP *PTOKEN_PRIMARY_GROUP

    ctypedef struct _TOKEN_DEFAULT_DACL:
        PACL DefaultDacl
    ctypedef _TOKEN_DEFAULT_DACL TOKEN_DEFAULT_DACL
    ctypedef _TOKEN_DEFAULT_DACL *PTOKEN_DEFAULT_DACL

    ctypedef struct _TOKEN_GROUPS_AND_PRIVILEGES:
        DWORD SidCount
        DWORD SidLength
        PSID_AND_ATTRIBUTES Sids
        DWORD RestrictedSidCount
        DWORD RestrictedSidLength
        PSID_AND_ATTRIBUTES RestrictedSids
        DWORD PrivilegeCount
        DWORD PrivilegeLength
        PLUID_AND_ATTRIBUTES Privileges
        LUID AuthenticationId

    ctypedef _TOKEN_GROUPS_AND_PRIVILEGES TOKEN_GROUPS_AND_PRIVILEGES
    ctypedef _TOKEN_GROUPS_AND_PRIVILEGES *PTOKEN_GROUPS_AND_PRIVILEGES

    ctypedef struct _TOKEN_LINKED_TOKEN:
        HANDLE LinkedToken

    ctypedef _TOKEN_LINKED_TOKEN TOKEN_LINKED_TOKEN
    ctypedef _TOKEN_LINKED_TOKEN *PTOKEN_LINKED_TOKEN

    ctypedef struct _TOKEN_ELEVATION:
        DWORD TokenIsElevated

    ctypedef _TOKEN_ELEVATION TOKEN_ELEVATION
    ctypedef _TOKEN_ELEVATION*PTOKEN_ELEVATION

    ctypedef struct _TOKEN_MANDATORY_LABEL:
        SID_AND_ATTRIBUTES Label

    ctypedef _TOKEN_MANDATORY_LABEL TOKEN_MANDATORY_LABEL
    ctypedef _TOKEN_MANDATORY_LABEL*PTOKEN_MANDATORY_LABEL

    DWORD TOKEN_MANDATORY_POLICY_OFF             = 0x0
    DWORD TOKEN_MANDATORY_POLICY_NO_WRITE_UP     = 0x1
    DWORD TOKEN_MANDATORY_POLICY_NEW_PROCESS_MIN = 0x2

    #DWORD TOKEN_MANDATORY_POLICY_VALID_MASK     = TOKEN_MANDATORY_POLICY_NO_WRITE_UP | TOKEN_MANDATORY_POLICY_NEW_PROCESS_MIN
    DWORD TOKEN_MANDATORY_POLICY_VALID_MASK

    ctypedef struct _TOKEN_MANDATORY_POLICY:
        DWORD Policy

    ctypedef _TOKEN_MANDATORY_POLICY TOKEN_MANDATORY_POLICY
    ctypedef _TOKEN_MANDATORY_POLICY *PTOKEN_MANDATORY_POLICY

    ctypedef struct _TOKEN_ACCESS_INFORMATION:
        PSID_AND_ATTRIBUTES_HASH SidHash
        PSID_AND_ATTRIBUTES_HASH RestrictedSidHash
        PTOKEN_PRIVILEGES Privileges
        LUID AuthenticationId
        TOKEN_TYPE TokenType
        SECURITY_IMPERSONATION_LEVEL ImpersonationLevel
        TOKEN_MANDATORY_POLICY MandatoryPolicy
        DWORD Flags

    ctypedef _TOKEN_ACCESS_INFORMATION TOKEN_ACCESS_INFORMATION
    ctypedef _TOKEN_ACCESS_INFORMATION*PTOKEN_ACCESS_INFORMATION

    DWORD PROCESS_TERMINATE                  = 0x0001  
    DWORD PROCESS_CREATE_THREAD              = 0x0002  
    DWORD PROCESS_SET_SESSIONID              = 0x0004  
    DWORD PROCESS_VM_OPERATION               = 0x0008  
    DWORD PROCESS_VM_READ                    = 0x0010  
    DWORD PROCESS_VM_WRITE                   = 0x0020  
    DWORD PROCESS_DUP_HANDLE                 = 0x0040  
    DWORD PROCESS_CREATE_PROCESS             = 0x0080  
    DWORD PROCESS_SET_QUOTA                  = 0x0100  
    DWORD PROCESS_SET_INFORMATION            = 0x0200  
    DWORD PROCESS_QUERY_INFORMATION          = 0x0400  
    DWORD PROCESS_SUSPEND_RESUME             = 0x0800  
    DWORD PROCESS_QUERY_LIMITED_INFORMATION  = 0x1000  
    DWORD PROCESS_ALL_ACCESS

    #
    # Token Specific Access Rights.
    #

    DWORD TOKEN_ASSIGN_PRIMARY    = 0x0001
    DWORD TOKEN_DUPLICATE         = 0x0002
    DWORD TOKEN_IMPERSONATE       = 0x0004
    DWORD TOKEN_QUERY             = 0x0008
    DWORD TOKEN_QUERY_SOURCE      = 0x0010
    DWORD TOKEN_ADJUST_PRIVILEGES = 0x0020
    DWORD TOKEN_ADJUST_GROUPS     = 0x0040
    DWORD TOKEN_ADJUST_DEFAULT    = 0x0080
    DWORD TOKEN_ADJUST_SESSIONID  = 0x0100

    #DWORD TOKEN_ALL_ACCESS_P = STANDARD_RIGHTS_REQUIRED | TOKEN_ASSIGN_PRIMARY | TOKEN_DUPLICATE | TOKEN_IMPERSONATE | TOKEN_QUERY | TOKEN_QUERY_SOURCE | TOKEN_ADJUST_PRIVILEGES | TOKEN_ADJUST_GROUPS | TOKEN_ADJUST_DEFAULT

#cdef extern from "WinCon.h":
    DWORD CTRL_C_EVENT        = 0
    DWORD CTRL_BREAK_EVENT    = 1
    DWORD CTRL_CLOSE_EVENT    = 2
    # 3 is reserved!
    # 4 is reserved!
    DWORD CTRL_LOGOFF_EVENT   = 5
    DWORD CTRL_SHUTDOWN_EVENT = 6

#cdef extern from "WinBase.h":

    DWORD STD_INPUT_HANDLE    = <DWORD>-10
    DWORD STD_OUTPUT_HANDLE   = <DWORD>-11
    DWORD STD_ERROR_HANDLE    = <DWORD>-12

    ctypedef struct OVERLAPPED_UNION_STRUCT:
        DWORD Offset
        DWORD OffsetHigh

    ctypedef union OVERLAPPED_UNION:
        OVERLAPPED_UNION_STRUCT overlapped_union_struct
        PVOID Pointer

    ctypedef struct _OVERLAPPED:
        ULONG_PTR Internal
        ULONG_PTR InternalHigh
        OVERLAPPED_UNION overlapped_union
        HANDLE hEvent

    ctypedef _OVERLAPPED OVERLAPPED
    ctypedef _OVERLAPPED *LPOVERLAPPED;

    BOOL __stdcall SetEvent(
        HANDLE hEvent
    ) nogil

    BOOL __stdcall ResetEvent(
        HANDLE hEvent
    ) nogil

    BOOL __stdcall PulseEvent(
        HANDLE hEvent
    ) nogil

    HANDLE __stdcall CreateEventW(
        LPSECURITY_ATTRIBUTES lpEventAttributes,
        BOOL bManualReset,
        BOOL bInitialState,
        LPCWSTR lpName
    ) nogil

    BOOL __stdcall DuplicateTokenEx(
        HANDLE hExistingToken,
        DWORD dwDesiredAccess,
        LPSECURITY_ATTRIBUTES lpTokenAttributes,
        SECURITY_IMPERSONATION_LEVEL ImpersonationLevel,
        TOKEN_TYPE TokenType,
        PHANDLE phNewToken) nogil

    BOOL __stdcall LookupPrivilegeValueW(
        LPCWSTR lpSystemName,
        LPCWSTR lpName,
        PLUID   lpLuid
    ) nogil

    BOOL __stdcall OpenProcessToken (
        HANDLE ProcessHandle,
        DWORD DesiredAccess,
        PHANDLE TokenHandle
    ) nogil

    HANDLE __stdcall OpenProcess(
        DWORD dwDesiredAccess,
        BOOL bInheritHandle,
        DWORD dwProcessId
    ) nogil

    HANDLE __stdcall GetCurrentProcess() nogil

    BOOL __stdcall GetTokenInformation (
        HANDLE TokenHandle,
        TOKEN_INFORMATION_CLASS TokenInformationClass,
        LPVOID TokenInformation,
        DWORD TokenInformationLength,
        PDWORD ReturnLength
    ) nogil

    BOOL __stdcall SetTokenInformation (
        HANDLE TokenHandle,
        TOKEN_INFORMATION_CLASS TokenInformationClass,
        LPVOID TokenInformation,
        DWORD TokenInformationLength
    ) nogil


    BOOL __stdcall AdjustTokenPrivileges (
        HANDLE TokenHandle,
        BOOL DisableAllPrivileges,
        PTOKEN_PRIVILEGES NewState,
        DWORD BufferLength,
        PTOKEN_PRIVILEGES PreviousState,
        PDWORD ReturnLength
    ) nogil

    BOOL __stdcall ReportEventW (
        HANDLE     hEventLog,
        WORD       wType,
        WORD       wCategory,
        DWORD      dwEventID,
        PSID       lpUserSid,
        WORD       wNumStrings,
        DWORD      dwDataSize,
        LPCWSTR *lpStrings,
        LPVOID lpRawData
    ) nogil

    BOOL __stdcall GetComputerNameW (
        LPWSTR lpBuffer,
        LPDWORD nSize
    ) nogil

    DWORD MAX_COMPUTERNAME_LENGTH = 31

    ctypedef enum _COMPUTER_NAME_FORMAT:
        ComputerNameNetBIOS,
        ComputerNameDnsHostname,
        ComputerNameDnsDomain,
        ComputerNameDnsFullyQualified,
        ComputerNamePhysicalNetBIOS,
        ComputerNamePhysicalDnsHostname,
        ComputerNamePhysicalDnsDomain,
        ComputerNamePhysicalDnsFullyQualified,
        ComputerNameMax

    ctypedef _COMPUTER_NAME_FORMAT COMPUTER_NAME_FORMAT

    #BOOL __stdcall GetComputerNameExW (
    #    COMPUTER_NAME_FORMAT NameType,
    #    LPWSTR lpBuffer,
    #    LPDWORD nSize
    #) nogil

    BOOL __stdcall GetComputerNameExW (
        DWORD NameType,
        LPWSTR lpBuffer,
        LPDWORD nSize
    ) nogil

    BOOL __stdcall GetComputerNameExA (
        COMPUTER_NAME_FORMAT NameType,
        LPSTR lpBuffer,
        LPDWORD nSize
    ) nogil

    HANDLE __stdcall GetStdHandle(
        DWORD nStdHandle
    ) nogil


#cdef extern from "IntSafe.h":

    DWORD __stdcall GetLastError() nogil

    void __stdcall SetLastError(
        DWORD dwErrCode
    ) nogil

    DWORD MAX_PATH
    DWORD DELETE

#cdef extern from "WinReg.h":
    BOOL __stdcall InitiateSystemShutdownW(
        LPWSTR lpMachineName,
        LPWSTR lpMessage,
        DWORD dwTimeout,
        BOOL bForceAppsClosed,
        BOOL bRebootAfterShutdown
    ) nogil

    BOOL __stdcall AbortSystemShutdownW(
        LPWSTR lpMachineName
    ) nogil


IF UNAME_SYSNAME == "Windows":
    cdef extern from "WinSvc.h":
        pass

cdef extern from *:
    enum _SC_STATUS_TYPE:
        SC_STATUS_PROCESS_INFO  = 0

    ctypedef _SC_STATUS_TYPE SC_STATUS_TYPE

    struct _SERVICE_STATUS:
        DWORD   dwServiceType
        DWORD   dwCurrentState
        DWORD   dwControlsAccepted
        DWORD   dwWin32ExitCode
        DWORD   dwServiceSpecificExitCode
        DWORD   dwCheckPoint
        DWORD   dwWaitHint

    ctypedef _SERVICE_STATUS SERVICE_STATUS
    ctypedef _SERVICE_STATUS *LPSERVICE_STATUS
    ctypedef _SERVICE_STATUS *SERVICE_STATUS_HANDLE
    ctypedef void (*LPSERVICE_MAIN_FUNCTIONW)(DWORD,LPWSTR)

    struct _SERVICE_TABLE_ENTRYW:
        LPWSTR lpServiceName
        LPSERVICE_MAIN_FUNCTIONW lpServiceProc

    ctypedef _SERVICE_TABLE_ENTRYW SERVICE_TABLE_ENTRYW
    ctypedef _SERVICE_TABLE_ENTRYW *LPSERVICE_TABLE_ENTRYW

    ctypedef SERVICE_TABLE_ENTRYW SERVICE_TABLE_ENTRY
    ctypedef LPSERVICE_TABLE_ENTRYW LPSERVICE_TABLE_ENTRY

    DWORD SERVICE_START_PENDING 
    DWORD SERVICE_ACCEPT_STOP
    DWORD SERVICE_ACCEPT_SHUTDOWN

    # Controls

    DWORD SERVICE_CONTROL_STOP
    DWORD SERVICE_CONTROL_PAUSE
    DWORD SERVICE_CONTROL_CONTINUE
    DWORD SERVICE_CONTROL_INTERROGATE
    DWORD SERVICE_CONTROL_SHUTDOWN
    DWORD SERVICE_CONTROL_PARAMCHANGE
    DWORD SERVICE_CONTROL_NETBINDADD
    DWORD SERVICE_CONTROL_NETBINDREMOVE
    DWORD SERVICE_CONTROL_NETBINDENABLE
    DWORD SERVICE_CONTROL_NETBINDDISABLE
    DWORD SERVICE_CONTROL_DEVICEEVENT
    DWORD SERVICE_CONTROL_HARDWAREPROFILECHANGE
    DWORD SERVICE_CONTROL_POWEREVENT
    DWORD SERVICE_CONTROL_SESSIONCHANGE
    DWORD SERVICE_CONTROL_PRESHUTDOWN    

    # Service State -- for CurrentState

    DWORD SERVICE_STOPPED
    DWORD SERVICE_START_PENDING
    DWORD SERVICE_STOP_PENDING
    DWORD SERVICE_RUNNING
    DWORD SERVICE_CONTINUE_PENDING
    DWORD SERVICE_PAUSE_PENDING
    DWORD SERVICE_PAUSED

    #
    # Controls Accepted  (Bit Mask)
    #
    DWORD SERVICE_ACCEPT_STOP                    = 0x00000001
    DWORD SERVICE_ACCEPT_PAUSE_CONTINUE          = 0x00000002
    DWORD SERVICE_ACCEPT_SHUTDOWN                = 0x00000004
    DWORD SERVICE_ACCEPT_PARAMCHANGE             = 0x00000008
    DWORD SERVICE_ACCEPT_NETBINDCHANGE           = 0x00000010
    DWORD SERVICE_ACCEPT_HARDWAREPROFILECHANGE   = 0x00000020
    DWORD SERVICE_ACCEPT_POWEREVENT              = 0x00000040
    DWORD SERVICE_ACCEPT_SESSIONCHANGE           = 0x00000080
    DWORD SERVICE_ACCEPT_PRESHUTDOWN             = 0x00000100

    #
    # Service Control Manager object specific access types
    #
    DWORD SC_MANAGER_CONNECT             = 0x0001
    DWORD SC_MANAGER_CREATE_SERVICE      = 0x0002
    DWORD SC_MANAGER_ENUMERATE_SERVICE   = 0x0004
    DWORD SC_MANAGER_LOCK                = 0x0008
    DWORD SC_MANAGER_QUERY_LOCK_STATUS   = 0x0010
    DWORD SC_MANAGER_MODIFY_BOOT_CONFIG  = 0x0020

    #WINAPI = __stdcall
    #StartServiceCtrlDispatcher = StartServiceCtrlDispatcherW

    ctypedef void VOID
    ctypedef void (*LPHANDLER_FUNCTION)(DWORD dwControl)

    #BOOL StartServiceCtrlDispatcherW(SERVICE_TABLE_ENTRYW *lpServiceStartTable)
    #BOOL SetServiceStatus(SERVICE_STATUS_HANDLE hServiceStatus, LPSERVICE_STATUS lpServiceStatus)
    bint StartServiceCtrlDispatcherW(SERVICE_TABLE_ENTRYW *lpServiceStartTable) nogil
    bint SetServiceStatus(SERVICE_STATUS_HANDLE hServiceStatus, LPSERVICE_STATUS lpServiceStatus) nogil
    SERVICE_STATUS_HANDLE RegisterServiceCtrlHandlerW(LPCWSTR lpServiceName, LPHANDLER_FUNCTION lpHandlerProc) nogil

    DWORD SERVICE_QUERY_CONFIG           = 0x0001
    DWORD SERVICE_CHANGE_CONFIG          = 0x0002
    DWORD SERVICE_QUERY_STATUS           = 0x0004
    DWORD SERVICE_ENUMERATE_DEPENDENTS   = 0x0008
    DWORD SERVICE_START                  = 0x0010
    DWORD SERVICE_STOP                   = 0x0020
    DWORD SERVICE_PAUSE_CONTINUE         = 0x0040
    DWORD SERVICE_INTERROGATE            = 0x0080
    DWORD SERVICE_USER_DEFINED_CONTROL   = 0x0100

    BOOL __stdcall CloseServiceHandle(
        SC_HANDLE   hSCObject
    ) nogil

    BOOL __stdcall ControlService(
        SC_HANDLE           hService,
        DWORD               dwControl,
        LPSERVICE_STATUS    lpServiceStatus
    ) nogil

    BOOL __stdcall QueryServiceStatus(
        SC_HANDLE           hService,
        LPSERVICE_STATUS    lpServiceStatus
    ) nogil

    BOOL __stdcall QueryServiceStatusEx(
        SC_HANDLE           hService,
        SC_STATUS_TYPE      InfoLevel,
        LPBYTE              lpBuffer,
        DWORD               cbBufSize,
        LPDWORD             pcbBytesNeeded
    ) nogil

    SC_HANDLE __stdcall OpenServiceW(
        SC_HANDLE           hSCManager,
        LPCWSTR             lpServiceName,
        DWORD               dwDesiredAccess
    ) nogil

    BOOL __stdcall DeleteService(
        SC_HANDLE   hService
    ) nogil

    SC_HANDLE __stdcall OpenSCManagerW(
        LPCWSTR lpMachineName,
        LPCWSTR lpDatabaseName,
        DWORD dwDesiredAccess
    ) nogil

    SC_HANDLE __stdcall CreateServiceW(
        SC_HANDLE   hSCManager,
        LPCWSTR     lpServiceName,
        LPCWSTR     lpDisplayName,
        DWORD       dwDesiredAccess,
        DWORD       dwServiceType,
        DWORD       dwStartType,
        DWORD       dwErrorControl,
        LPCWSTR     lpBinaryPathName,
        LPCWSTR     lpLoadOrderGroup,
        LPDWORD     lpdwTagId,
        LPCWSTR     lpDependencies,
        LPCWSTR     lpServiceStartName,
        LPCWSTR     lpPassword
    ) nogil

#cdef extern from "ntconfig.h":   
    DWORD SERVICE_WIN32_OWN_PROCESS
    DWORD SERVICE_WIN32_SHARE_PROCESS
    DWORD SERVICE_INTERACTIVE_PROCESS
    DWORD SERVICE_TYPE_ALL
    DWORD SERVICE_WIN32

    HANDLE __stdcall CreateNamedPipeW(
        LPCWSTR lpName,
        DWORD dwOpenMode,
        DWORD dwPipeMode,
        DWORD nMaxInstances,
        DWORD nOutBufferSize,
        DWORD nInBufferSize,
        DWORD nDefaultTimeOut,
        LPSECURITY_ATTRIBUTES lpSecurityAttributes
    ) nogil

    ctypedef unsigned int ULONG_PTR


    # https:#www.mail-archive.com/cython-dev@codespeak.net/msg05746.html
    # http:#stackoverflow.com/questions/12452210/cython-nesting-a-union-within-a-struct
    struct _OVERLAPPED_INNER_UNION_INNER_STRUCT:
        DWORD Offset
        DWORD OffsetHigh

    union _OVERLAPPED_INNER_UNION:
        _OVERLAPPED_INNER_UNION_INNER_STRUCT data
        PVOID Pointer

    struct _OVERLAPPED:
        ULONG_PTR Internal
        ULONG_PTR InternalHigh
        _OVERLAPPED_INNER_UNION data
        HANDLE hEvent

    ctypedef _OVERLAPPED OVERLAPPED
    ctypedef _OVERLAPPED *LPOVERLAPPED
    ctypedef DWORD *LPDWORD

    bint __stdcall ConnectNamedPipe(
        HANDLE hNamedPipe,
        LPOVERLAPPED lpOverlapped
    ) nogil

    bint __stdcall DisconnectNamedPipe(
        HANDLE hNamedPipe
    ) nogil

    bint __stdcall WriteFile(
        HANDLE hFile,
        LPCVOID lpBuffer,
        DWORD nNumberOfBytesToWrite,
        LPDWORD lpNumberOfBytesWritten,
        LPOVERLAPPED lpOverlapped
    ) nogil

    bint __stdcall ReadFile(
        HANDLE hFile,
        LPVOID lpBuffer,
        DWORD nNumberOfBytesToRead,
        LPDWORD lpNumberOfBytesRead,
        LPOVERLAPPED lpOverlapped
    ) nogil

    HANDLE __stdcall CreateFileW(
        LPCWSTR lpFileName,
        DWORD dwDesiredAccess,
        DWORD dwShareMode,
        LPSECURITY_ATTRIBUTES lpSecurityAttributes,
        DWORD dwCreationDisposition,
        DWORD dwFlagsAndAttributes,
        HANDLE hTemplateFile
    ) nogil

    bint __stdcall CloseHandle(
        HANDLE hObject
    ) nogil

    DWORD PIPE_ACCESS_DUPLEX
    DWORD PIPE_TYPE_MESSAGE
    DWORD PIPE_TYPE_BYTE
    DWORD PIPE_READMODE_MESSAGE
    DWORD PIPE_WAIT
    DWORD PIPE_ACCESS_OUTBOUND

    DWORD GENERIC_READ
    DWORD GENERIC_WRITE
    DWORD OPEN_EXISTING

    HANDLE INVALID_HANDLE_VALUE

    DWORD __stdcall WaitForSingleObject(
        HANDLE hHandle,
        DWORD dwMilliseconds
    ) nogil

    DWORD WAIT_ABANDONED
    DWORD WAIT_OBJECT_0
    DWORD WAIT_TIMEOUT
    DWORD WAIT_FAILED

    ctypedef unsigned int UINT
    ctypedef UINT* PUINT
    ctypedef const char* LPCSTR
    ctypedef unsigned char BYTE
    ctypedef BYTE *PBYTE
    ctypedef BYTE *LPBYTE
    ctypedef PBYTE LPBYTE
    ctypedef unsigned short WORD
    ctypedef LPWSTR LPTST
    ctypedef LPWSTR LPTSTR

    UINT __stdcall WinExec(
            LPCSTR lpCmdLine,
            UINT uCmdShow
    ) nogil

    ctypedef struct _NETRESOURCEW:
        DWORD    dwScope
        DWORD    dwType
        DWORD    dwDisplayType
        DWORD    dwUsage
        LPWSTR   lpLocalName
        LPWSTR   lpRemoteName
        LPWSTR   lpComment
        LPWSTR   lpProvider

    ctypedef _NETRESOURCEW NETRESOURCEW
    ctypedef _NETRESOURCEW *LPNETRESOURCEW

    ctypedef NETRESOURCEW NETRESOURCE
    ctypedef LPNETRESOURCEW *LPNETRESOURCE

    DWORD  WNetAddConnection2(
        LPNETRESOURCE lpNetResource,
        LPCTSTR lpPassword,
        LPCTSTR lpUsername,
        DWORD dwFlags
    ) nogil

    DWORD __stdcall WNetAddConnection2W(
        LPNETRESOURCEW lpNetResource,
        LPCWSTR       lpPassword,
        LPCWSTR       lpUserName,
        DWORD          dwFlags
    ) nogil

    DWORD __stdcall WNetCancelConnection2(
        LPCTSTR lpName,
        DWORD dwFlags,
        bint fForce
    ) nogil

    DWORD __stdcall WNetCancelConnection2W(
        LPCWSTR lpName,
        DWORD    dwFlags,
        bint     fForce
    ) nogil

    DWORD MAX_PREFERRED_LENGTH = -1
    DWORD ERROR_SUCCESS = 0
    DWORD ERROR_MORE_DATA = 234
    DWORD ERROR_INVALID_PARAMETER

    ctypedef PVOID PSECURITY_DESCRIPTOR
    ctypedef DWORD NET_API_STATUS

    struct _SHARE_INFO_0:
        LPWSTR shi0_netname

    ctypedef _SHARE_INFO_0 SHARE_INFO_0
    ctypedef _SHARE_INFO_0 *PSHARE_INFO_0
    ctypedef _SHARE_INFO_0 *LPSHARE_INFO_0

    struct _SHARE_INFO_1:
        LPWSTR shi1_netname
        DWORD  shi1_type
        LPWSTR shi1_remark

    ctypedef _SHARE_INFO_1 SHARE_INFO_1
    ctypedef _SHARE_INFO_1 *PSHARE_INFO_1
    ctypedef _SHARE_INFO_1 *LPSHARE_INFO_1

    struct _SHARE_INFO_2:
        LPWSTR shi2_netname
        DWORD  shi2_type
        LPWSTR shi2_remark
        DWORD  shi2_permissions
        DWORD  shi2_max_uses
        DWORD  shi2_current_uses
        LPWSTR shi2_path
        LPWSTR shi2_passwd

    ctypedef _SHARE_INFO_2 SHARE_INFO_2
    ctypedef _SHARE_INFO_2 *PSHARE_INFO_2
    ctypedef _SHARE_INFO_2 *LPSHARE_INFO_2

    struct _SHARE_INFO_501:
        LPWSTR shi501_netname
        DWORD  shi501_type
        LPWSTR shi501_remark
        DWORD  shi501_flags

    ctypedef _SHARE_INFO_501 SHARE_INFO_501
    ctypedef _SHARE_INFO_501 *PSHARE_INFO_501
    ctypedef _SHARE_INFO_501 *LPSHARE_INFO_501

    struct _SHARE_INFO_502:
        LPWSTR               shi502_netname
        DWORD                shi502_type
        LPWSTR               shi502_remark
        DWORD                shi502_permissions
        DWORD                shi502_max_uses
        DWORD                shi502_current_uses
        LPWSTR               shi502_path
        LPWSTR               shi502_passwd
        DWORD                shi502_reserved
        PSECURITY_DESCRIPTOR shi502_security_descriptor

    ctypedef _SHARE_INFO_502 SHARE_INFO_502
    ctypedef _SHARE_INFO_502 *PSHARE_INFO_502
    ctypedef _SHARE_INFO_502 *LPSHARE_INFO_502

    DWORD STYPE_DISKTREE
    DWORD STYPE_PRINTQ
    DWORD STYPE_DEVICE
    DWORD STYPE_IPC
    DWORD STYPE_SPECIAL
    DWORD STYPE_TEMPORARY

    DWORD ACCESS_READ
    DWORD ACCESS_WRITE
    DWORD ACCESS_CREATE
    DWORD ACCESS_EXEC
    DWORD ACCESS_DELETE
    DWORD ACCESS_ATRIB
    DWORD ACCESS_PERM
    DWORD ACCESS_ALL 

    NET_API_STATUS __stdcall NetShareEnum(
        LPWSTR servername,
        DWORD level,
        LPBYTE *bufptr,
        DWORD prefmaxlen,
        LPDWORD entriesread,
        LPDWORD totalentries,
        LPDWORD resume_handle
    ) nogil

    NET_API_STATUS __stdcall NetApiBufferFree(
        LPVOID Buffer
    ) nogil

    DWORD RESOURCETYPE_DISK
    DWORD CONNECT_TEMPORARY

    DWORD ERROR_BAD_PROFILE
    DWORD ERROR_CANNOT_OPEN_PROFILE
    DWORD ERROR_DEVICE_IN_USE
    DWORD ERROR_EXTENDED_ERROR
    DWORD ERROR_NOT_CONNECTED
    DWORD ERROR_OPEN_FILES

    struct _SECURITY_ATTRIBUTES:
        DWORD nLength
        LPVOID lpSecurityDescriptor
        bint bInheritHandle

    ctypedef _SECURITY_ATTRIBUTES SECURITY_ATTRIBUTES
    ctypedef _SECURITY_ATTRIBUTES *PSECURITY_ATTRIBUTES
    ctypedef _SECURITY_ATTRIBUTES *LPSECURITY_ATTRIBUTES

    ctypedef struct _STARTUPINFOW:
        DWORD   cb
        LPWSTR  lpReserved
        LPWSTR  lpDesktop
        LPWSTR  lpTitle
        DWORD   dwX
        DWORD   dwY
        DWORD   dwXSize
        DWORD   dwYSize
        DWORD   dwXCountChars
        DWORD   dwYCountChars
        DWORD   dwFillAttribute
        DWORD   dwFlags
        WORD    wShowWindow
        WORD    cbReserved2
        LPBYTE  lpReserved2
        HANDLE  hStdInput
        HANDLE  hStdOutput
        HANDLE  hStdError

    ctypedef _STARTUPINFOW STARTUPINFOW
    ctypedef _STARTUPINFOW *LPSTARTUPINFOW

    struct _STARTUPINFO:
        DWORD  cb
        LPTSTR lpReserved
        LPTSTR lpDesktop
        LPTSTR lpTitle
        DWORD  dwX
        DWORD  dwY
        DWORD  dwXSize
        DWORD  dwYSize
        DWORD  dwXCountChars
        DWORD  dwYCountChars
        DWORD  dwFillAttribute
        DWORD  dwFlags
        WORD   wShowWindow
        WORD   cbReserved2
        LPBYTE lpReserved2
        HANDLE hStdInput
        HANDLE hStdOutput
        HANDLE hStdError

    ctypedef _STARTUPINFO STARTUPINFO
    ctypedef _STARTUPINFO *LPSTARTUPINFO

    struct _PROCESS_INFORMATION:
        HANDLE hProcess
        HANDLE hThread
        DWORD  dwProcessId
        DWORD  dwThreadId

    ctypedef _PROCESS_INFORMATION PROCESS_INFORMATION
    ctypedef _PROCESS_INFORMATION *LPPROCESS_INFORMATION

    bint __stdcall CreateProcess(
        LPCTSTR lpApplicationName,
        LPTSTR lpCommandLine,
        LPSECURITY_ATTRIBUTES lpProcessAttributes,
        LPSECURITY_ATTRIBUTES lpThreadAttributes,
        bint bInheritHandles,
        DWORD dwCreationFlags,
        LPVOID lpEnvironment,
        LPCTSTR lpCurrentDirectory,
        LPSTARTUPINFO lpStartupInfo,
        LPPROCESS_INFORMATION lpProcessInformation
    ) nogil

    bint __stdcall CreateProcessW(
        LPCWSTR lpApplicationName,
        LPWSTR lpCommandLine,
        LPSECURITY_ATTRIBUTES lpProcessAttributes,
        LPSECURITY_ATTRIBUTES lpThreadAttributes,
        bint bInheritHandles,
        DWORD dwCreationFlags,
        LPVOID lpEnvironment,
        LPCWSTR lpCurrentDirectory,
        LPSTARTUPINFOW lpStartupInfo,
        LPPROCESS_INFORMATION lpProcessInformation
    ) nogil

    BOOL __stdcall CreateProcessAsUserW (
        HANDLE hToken,
        LPCWSTR lpApplicationName,
        LPWSTR lpCommandLine,
        LPSECURITY_ATTRIBUTES lpProcessAttributes,
        LPSECURITY_ATTRIBUTES lpThreadAttributes,
        BOOL bInheritHandles,
        DWORD dwCreationFlags,
        LPVOID lpEnvironment,
        LPCWSTR lpCurrentDirectory,
        LPSTARTUPINFOW lpStartupInfo,
        LPPROCESS_INFORMATION lpProcessInformation
    ) nogil

    DWORD STARTF_USESTDHANDLES = 0x00000100
    DWORD STARTF_USESHOWWINDOW
    DWORD SW_HIDE
    DWORD CREATE_NEW_CONSOLE = 0x00000010
    DWORD CREATE_UNICODE_ENVIRONMENT = 0x00000400

    bint __stdcall GetExitCodeProcess(
        HANDLE hProcess,
        LPDWORD lpExitCode
    ) nogil

    DWORD INFINITE

    bint __stdcall DeregisterEventSource(
        HANDLE hEventLog
    ) nogil

    HANDLE __stdcall RegisterEventSource(
        LPCTSTR lpUNCServerName,
        LPCTSTR lpSourceName
    ) nogil

    bint __stdcall ReportEvent(
        HANDLE hEventLog,
        WORD wType,
        WORD wCategory,
        DWORD dwEventID,
        PSID lpUserSid,
        WORD wNumStrings,
        DWORD dwDataSize,
        LPCTSTR *lpStrings,
        LPVOID lpRawData
    ) nogil

    DWORD EVENTLOG_SUCCESS
    DWORD EVENTLOG_AUDIT_FAILURE
    DWORD EVENTLOG_AUDIT_SUCCESS
    DWORD EVENTLOG_ERROR_TYPE
    DWORD EVENTLOG_INFORMATION_TYPE
    DWORD EVENTLOG_WARNING_TYPE

    bint __stdcall CopyFileW(
        LPCWSTR lpExistingFileName,
        LPCWSTR lpNewFileName,
        bint bFailIfExists
    ) nogil

    size_t strlen(
       const char *str
    )
    size_t wcslen(
       const wchar_t *str 
    )
    size_t _mbslen(
       const unsigned char *str 
    )
    #size_t _mbslen_l(
    #   const unsigned char *str,
    #   _locale_t locale
    #)
    size_t _mbstrlen(
       const char *str
    )
    #size_t _mbstrlen_l(
    #   const char *str,
    #   _locale_t locale
    #)
    char *strcpy(
       char *strDestination,
       const char *strSource 
    )
    wchar_t *wcscpy(
       wchar_t *strDestination,
       const wchar_t *strSource 
    )
    unsigned char *_mbscpy(
       unsigned char *strDestination,
       const unsigned char *strSource 
    )
    errno_t strcpy_s(
       char *strDestination,
       size_t numberOfElements,
       const char *strSource 
    )
    errno_t wcscpy_s(
       wchar_t *strDestination,
       size_t numberOfElements,
       const wchar_t *strSource 
    )
    errno_t _mbscpy_s(
       unsigned char *strDestination,
       size_t numberOfElements,
       const unsigned char *strSource 
    )

    #ctypedef DWORD (*PTHREAD_START_ROUTINE)(
    #    LPVOID lpThreadParameter
    #)
    #ctypedef PTHREAD_START_ROUTINE LPTHREAD_START_ROUTINE

    #HANDLE CreateThread:
    #    LPSECURITY_ATTRIBUTES lpThreadAttributes,
    #    SIZE_T dwStackSize,
    #    LPTHREAD_START_ROUTINE lpStartAddress,
    #    LPVOID lpParameter,
    #    DWORD dwCreationFlags,
    #    LPDWORD lpThreadId

    PVOID SecureZeroMemory(
        PVOID ptr,
        size_t cnt
    )

    VOID __stdcall Sleep(
        DWORD dwMilliseconds
    ) nogil

    struct tagVS_FIXEDFILEINFO:
        DWORD dwSignature
        DWORD dwStrucVersion
        DWORD dwFileVersionMS
        DWORD dwFileVersionLS
        DWORD dwProductVersionMS
        DWORD dwProductVersionLS
        DWORD dwFileFlagsMask
        DWORD dwFileFlags
        DWORD dwFileOS
        DWORD dwFileType
        DWORD dwFileSubtype
        DWORD dwFileDateMS
        DWORD dwFileDateLS

    ctypedef tagVS_FIXEDFILEINFO VS_FIXEDFILEINFO

    BOOL __stdcall GetFileVersionInfo(
        LPCTSTR lptstrFilename,
        DWORD dwHandle,
        DWORD dwLen,
        LPVOID lpData
    ) nogil

    BOOL __stdcall GetFileVersionInfoW(
        LPCWSTR lptstrFilename, 
        DWORD dwHandle,
        DWORD dwLen,
        LPVOID lpData
        ) nogil

    BOOL __stdcall VerQueryValue(
        LPCVOID pBlock,
        LPCTSTR lpSubBlock,
        LPVOID *lplpBuffer,
        PUINT puLen
    ) nogil

    BOOL __stdcall VerQueryValueW(
        LPCVOID pBlock,
        LPCWSTR lpSubBlock,
        LPVOID * lplpBuffer,
        PUINT puLen
    ) nogil

    DWORD __stdcall GetFileVersionInfoSize(
        LPCTSTR lptstrFilename,
        LPDWORD lpdwHandle
    ) nogil

    DWORD __stdcall GetFileVersionInfoSizeW(
        LPCWSTR lptstrFilename,
        LPDWORD lpdwHandle
    ) nogil

    WORD MAKEWORD(
        BYTE bLow,
        BYTE bHigh
    ) nogil

    DWORD MAKELONG(
       WORD wLow,
       WORD wHigh
    ) nogil

    WORD HIWORD(
        DWORD dwValue
    ) nogil

    WORD LOWORD(
        DWORD dwValue
    ) nogil

    BYTE LOBYTE(
       WORD wValue
    )

    BYTE HIBYTE(
       WORD wValue
    )

    DWORD __stdcall GetVersion() nogil

    #ctypedef BOOL (CALLBACK* NAMEENUMPROCW)(LPWSTR, LPARAM)
    #ctypedef NAMEENUMPROCW   WINSTAENUMPROCW

    #BOOL __stdcall EnumWindowStationsW(
    #    WINSTAENUMPROCW lpEnumFunc,
    #    LPARAM lParam
    #) nogil

    BOOL __stdcall DuplicateTokenEx(
        HANDLE hExistingToken,
        DWORD dwDesiredAccess,
        LPSECURITY_ATTRIBUTES lpTokenAttributes,
        SECURITY_IMPERSONATION_LEVEL ImpersonationLevel,
        TOKEN_TYPE TokenType,
        PHANDLE phNewToken
    ) nogil

    DWORD TOKEN_ASSIGN_PRIMARY = 0x0001
    DWORD TOKEN_DUPLICATE = 0x0002
    DWORD TOKEN_IMPERSONATE = 0x0004
    DWORD TOKEN_QUERY = 0x0008
    DWORD TOKEN_QUERY_SOURCE = 0x0010
    DWORD TOKEN_ADJUST_PRIVILEGES = 0x0020
    DWORD TOKEN_ADJUST_GROUPS = 0x0040
    DWORD TOKEN_ADJUST_DEFAULT = 0x0080
    DWORD TOKEN_ADJUST_SESSIONID = 0x0100
    DWORD TOKEN_ALL_ACCESS

    DWORD __stdcall GetModuleFileNameW(
        HMODULE hModule,
        LPWCH lpFilename,
        DWORD nSize
    ) nogil

IF UNAME_SYSNAME == "Windows":
    cdef extern from "Winnetwk.h":
        pass

    cdef extern from "Winsvc.h":
        pass

    cdef extern from "Lm.h":
        pass


    cdef extern from "Userenv.h":
        pass


cdef extern from *:
    BOOL __stdcall CreateEnvironmentBlock(
        LPVOID *lpEnvironment,
        HANDLE  hToken,
        BOOL    bInherit
    ) nogil

    BOOL __stdcall DestroyEnvironmentBlock(
        LPVOID  lpEnvironment
    ) nogil

    BOOL __stdcall GetProfilesDirectoryW(
        LPWSTR lpProfilesDir,
        LPDWORD lpcchSize
    ) nogil

    BOOL __stdcall GetUserProfileDirectoryW(
        HANDLE  hToken,
        LPWSTR lpProfileDir,
        LPDWORD lpcchSize
    ) nogil

IF UNAME_SYSNAME == "Windows":
    cdef extern from "Wtsapi32.h":
        pass

cdef extern from *:
    enum _WTS_CONNECTSTATE_CLASS:
        WTSActive,              # User logged on to WinStation
        WTSConnected,           # WinStation connected to client
        WTSConnectQuery,        # In the process of connecting to client
        WTSShadow,              # Shadowing another WinStation
        WTSDisconnected,        # WinStation logged on without client
        WTSIdle,                # Waiting for client to connect
        WTSListen,              # WinStation is listening for connection
        WTSReset,               # WinStation is being reset
        WTSDown,                # WinStation is down due to error
        WTSInit,                # WinStation in initialization

    ctypedef _WTS_CONNECTSTATE_CLASS WTS_CONNECTSTATE_CLASS

    enum _WTS_INFO_CLASS:
        WTSInitialProgram,
        WTSApplicationName,
        WTSWorkingDirectory,
        WTSOEMId,
        WTSSessionId,
        WTSUserName,
        WTSWinStationName,
        WTSDomainName,
        WTSConnectState,
        WTSClientBuildNumber,
        WTSClientName,
        WTSClientDirectory,
        WTSClientProductId,
        WTSClientHardwareId,
        WTSClientAddress,
        WTSClientDisplay,
        WTSClientProtocolType,
        WTSIdleTime,
        WTSLogonTime,  
        WTSIncomingBytes,
        WTSOutgoingBytes,
        WTSIncomingFrames,
        WTSOutgoingFrames

    ctypedef _WTS_INFO_CLASS WTS_INFO_CLASS

    BOOL WTSQueryUserToken(
        ULONG   SessionId,
        PHANDLE phToken
    ) nogil

    DWORD __stdcall WTSGetActiveConsoleSessionId() nogil

    struct _WTS_SESSION_INFOW:
        DWORD SessionId                 # session id
        LPWSTR pWinStationName          # name of WinStation this session is connected to
        WTS_CONNECTSTATE_CLASS State    # connection state (see enum)

    ctypedef _WTS_SESSION_INFOW WTS_SESSION_INFOW
    ctypedef _WTS_SESSION_INFOW* PWTS_SESSION_INFOW

    BOOL __stdcall WTSEnumerateSessionsW(
        HANDLE hServer,
        DWORD Reserved,
        DWORD Version,
        PWTS_SESSION_INFOW * ppSessionInfo,
        DWORD * pCount
    ) nogil

    BOOL __stdcall WTSQuerySessionInformationW(
        HANDLE hServer,
        DWORD SessionId,
        WTS_INFO_CLASS WTSInfoClass,
        LPWSTR * ppBuffer,
        DWORD * pBytesReturned
    ) nogil

    VOID __stdcall WTSFreeMemory(PVOID pMemory) nogil

    HANDLE WTS_CURRENT_SERVER_HANDLE = NULL

#cdef extern from "VersionHelpers.h":
#    BOOL IsWindowsVistaOrGreater()

cdef extern from "wchar.h":
    int _wcsicmp(
       const wchar_t *string1,
       const wchar_t *string2 
    ) nogil

IF UNAME_SYSNAME == "Windows":
    cdef extern from "Psapi.h":
        pass

cdef extern from *:
    BOOL __stdcall EnumProcesses (
        DWORD * lpidProcess,
        DWORD cb,
        LPDWORD lpcbNeeded
    ) nogil

    BOOL __stdcall EnumProcessModules(
        HANDLE hProcess,
        HMODULE *lphModule,
        DWORD cb,
        LPDWORD lpcbNeeded
    ) nogil

    DWORD __stdcall GetModuleBaseNameW(
        HANDLE hProcess,
        HMODULE hModule,
        LPWSTR lpBaseName,
        DWORD nSize
    ) nogil

IF UNAME_SYSNAME == "Windows":
    cdef extern from "Guiddef.h":
        pass

cdef extern from *:
    ctypedef struct _GUID:
        DWORD Data1
        WORD  Data2
        WORD  Data3
        BYTE  Data4[8]

    ctypedef _GUID GUID

IF UNAME_SYSNAME == "Windows":
    cdef extern from "DSRole.h":
        pass

cdef extern from *:
    #
    # Domain information
    #
    ctypedef enum _DSROLE_MACHINE_ROLE:
        DsRole_RoleStandaloneWorkstation,
        DsRole_RoleMemberWorkstation,
        DsRole_RoleStandaloneServer,
        DsRole_RoleMemberServer,
        DsRole_RoleBackupDomainController,
        DsRole_RolePrimaryDomainController

    ctypedef _DSROLE_MACHINE_ROLE DSROLE_MACHINE_ROLE

    #
    # Previous server state
    #
    ctypedef enum _DSROLE_SERVER_STATE:
        DsRoleServerUnknown = 0,
        DsRoleServerPrimary,
        DsRoleServerBackup

    ctypedef _DSROLE_SERVER_STATE DSROLE_SERVER_STATE
    ctypedef _DSROLE_SERVER_STATE *PDSROLE_SERVER_STATE

    ctypedef enum _DSROLE_PRIMARY_DOMAIN_INFO_LEVEL:
        DsRolePrimaryDomainInfoBasic = 1,
        DsRoleUpgradeStatus,
        DsRoleOperationState

    ctypedef _DSROLE_PRIMARY_DOMAIN_INFO_LEVEL DSROLE_PRIMARY_DOMAIN_INFO_LEVEL

    #
    # Flags to be used with the PRIMARY_DOMAIN_INFO_LEVEL structures below
    #
    DWORD DSROLE_PRIMARY_DS_RUNNING           = 0x00000001
    DWORD DSROLE_PRIMARY_DS_MIXED_MODE        = 0x00000002
    DWORD DSROLE_UPGRADE_IN_PROGRESS          = 0x00000004
    DWORD DSROLE_PRIMARY_DS_READONLY          = 0x00000008
    DWORD DSROLE_PRIMARY_DOMAIN_GUID_PRESENT  = 0x01000000

    #
    # Structure that correspond to the DSROLE_PRIMARY_DOMAIN_INFO_LEVEL
    #
    ctypedef struct _DSROLE_PRIMARY_DOMAIN_INFO_BASIC:
        DSROLE_MACHINE_ROLE MachineRole
        ULONG Flags
        LPWSTR DomainNameFlat
        LPWSTR DomainNameDns
        LPWSTR DomainForestName
        GUID DomainGuid

    ctypedef _DSROLE_PRIMARY_DOMAIN_INFO_BASIC DSROLE_PRIMARY_DOMAIN_INFO_BASIC
    ctypedef _DSROLE_PRIMARY_DOMAIN_INFO_BASIC *PDSROLE_PRIMARY_DOMAIN_INFO_BASIC

    ctypedef struct _DSROLE_UPGRADE_STATUS_INFO:
        ULONG OperationState
        DSROLE_SERVER_STATE PreviousServerState

    ctypedef _DSROLE_UPGRADE_STATUS_INFO DSROLE_UPGRADE_STATUS_INFO
    ctypedef _DSROLE_UPGRADE_STATUS_INFO *PDSROLE_UPGRADE_STATUS_INFO

    ctypedef enum _DSROLE_OPERATION_STATE:
        DsRoleOperationIdle = 0,
        DsRoleOperationActive,
        DsRoleOperationNeedReboot

    ctypedef _DSROLE_OPERATION_STATE DSROLE_OPERATION_STATE

    ctypedef struct _DSROLE_OPERATION_STATE_INFO:
        DSROLE_OPERATION_STATE OperationState

    ctypedef _DSROLE_OPERATION_STATE_INFO DSROLE_OPERATION_STATE_INFO
    ctypedef _DSROLE_OPERATION_STATE_INFO *PDSROLE_OPERATION_STATE_INFO

    DWORD __stdcall DsRoleGetPrimaryDomainInformation(
        LPCWSTR lpServer,
        DSROLE_PRIMARY_DOMAIN_INFO_LEVEL InfoLevel,
        PBYTE *Buffer 
    ) nogil

    VOID __stdcall DsRoleFreeMemory(
        PVOID    Buffer
     ) nogil


IF UNAME_SYSNAME == "Windows":
    cdef extern from "LMJoin.h":
        pass

cdef extern from *:
    #
    # Types of name that can be validated
    #
    ctypedef enum  _NETSETUP_NAME_TYPE:
        NetSetupUnknown = 0,
        NetSetupMachine,
        NetSetupWorkgroup,
        NetSetupDomain,
        NetSetupNonExistentDomain,
    #if(_WIN32_WINNT >= 0x0500)
        NetSetupDnsMachine
    #endif


    ctypedef  _NETSETUP_NAME_TYPE NETSETUP_NAME_TYPE
    ctypedef  _NETSETUP_NAME_TYPE *PNETSETUP_NAME_TYPE


    #
    # Status of a workstation
    #
    ctypedef enum _NETSETUP_JOIN_STATUS:

        NetSetupUnknownStatus = 0,
        NetSetupUnjoined,
        NetSetupWorkgroupName,
        NetSetupDomainName

    ctypedef _NETSETUP_JOIN_STATUS NETSETUP_JOIN_STATUS
    ctypedef _NETSETUP_JOIN_STATUS *PNETSETUP_JOIN_STATUS

    #
    # Flags to determine the behavior of the join/unjoin APIs
    #
    DWORD NETSETUP_JOIN_DOMAIN    = 0x00000001      # If not present, workgroup is joined
    DWORD NETSETUP_ACCT_CREATE    = 0x00000002      # Do the server side account creation/rename
    DWORD NETSETUP_ACCT_DELETE    = 0x00000004      # Delete the account when a domain is left
    DWORD NETSETUP_WIN9X_UPGRADE  = 0x00000010      # Invoked during upgrade of Windows 9x to
                                                    # Windows NT
    DWORD NETSETUP_DOMAIN_JOIN_IF_JOINED  = 0x00000020  # Allow the client to join a new domain
                                                    # even if it is already joined to a domain
    DWORD NETSETUP_JOIN_UNSECURE  = 0x00000040      # Performs an unsecure join
    DWORD NETSETUP_MACHINE_PWD_PASSED = 0x00000080  # Indicates that the machine (not user) password
                                                    #  is passed. Valid only for unsecure joins
    DWORD NETSETUP_DEFER_SPN_SET  = 0x00000100      # Specifies that writting SPN and DnsHostName
                                                    #  attributes on the computer object should be
                                                    #  defered until rename that will follow join

    DWORD NETSETUP_JOIN_DC_ACCOUNT    = 0x00000200  # Allow join if existing account is a DC
    DWORD NETSETUP_JOIN_WITH_NEW_NAME = 0x00000400  # Check for computer name change

    DWORD NETSETUP_INSTALL_INVOCATION = 0x00040000  # The APIs were invoked during install

    DWORD NETSETUP_IGNORE_UNSUPPORTED_FLAGS  = 0x10000000  # If this bit is set, unrecognized flags
                                                           #  will be ignored by the NetJoin API and
                                                           #  the API will behave as if the flags
                                                           #  were not set.

    DWORD NETSETUP_VALID_UNJOIN_FLAGS #(NETSETUP_ACCT_DELETE | NETSETUP_IGNORE_UNSUPPORTED_FLAGS)

    #
    # 0x80000000 is reserved for internal use only
    #

    #
    # Joins a machine to the domain.
    #
    # ctypedef DWORD NET_API_STATUS
    NET_API_STATUS __stdcall NetJoinDomain(
        LPCWSTR lpServer,
        LPCWSTR lpDomain,
        LPCWSTR lpAccountOU,
        LPCWSTR lpAccount,
        LPCWSTR lpPassword,
        DWORD   fJoinOptions
        ) nogil

    NET_API_STATUS __stdcall NetUnjoinDomain(
        LPCWSTR lpServer,
        LPCWSTR lpAccount,
        LPCWSTR lpPassword,
        DWORD   fUnjoinOptions
        ) nogil

    NET_API_STATUS __stdcall NetRenameMachineInDomain(
        LPCWSTR lpServer,
        LPCWSTR lpNewMachineName,
        LPCWSTR lpAccount,
        LPCWSTR lpPassword,
        DWORD   fRenameOptions
        ) nogil


    #
    # Determine the validity of a name
    #
    NET_API_STATUS __stdcall NetValidateName(
        LPCWSTR             lpServer,
        LPCWSTR             lpName,
        LPCWSTR             lpAccount,
        LPCWSTR             lpPassword,
        NETSETUP_NAME_TYPE  NameType
        ) nogil

    #
    # Determines whether a workstation is joined to a domain or not
    #
    NET_API_STATUS __stdcall NetGetJoinInformation(
        LPCWSTR                lpServer,
        LPWSTR                *lpNameBuffer,
        PNETSETUP_JOIN_STATUS  BufferType
        ) nogil


    #
    # Determines the list of OUs that the client can create a machine account in
    #
    NET_API_STATUS __stdcall NetGetJoinableOUs(
        LPCWSTR     lpServer,
        LPCWSTR     lpDomain,
        LPCWSTR     lpAccount,
        LPCWSTR     lpPassword,
        DWORD      *OUCount,
        LPWSTR    **OUs
        ) nogil

    #
    # Computer rename preparation APIs
    #

    DWORD NET_IGNORE_UNSUPPORTED_FLAGS  = 0x01

    NET_API_STATUS __stdcall NetAddAlternateComputerName(
        LPCWSTR Server,
        LPCWSTR AlternateName,
        LPCWSTR DomainAccount,
        LPCWSTR DomainAccountPassword,
        ULONG Reserved
        ) nogil

    NET_API_STATUS __stdcall NetRemoveAlternateComputerName(
        LPCWSTR Server,
        LPCWSTR AlternateName,
        LPCWSTR DomainAccount,
        LPCWSTR DomainAccountPassword,
        ULONG Reserved
        ) nogil

    NET_API_STATUS __stdcall NetSetPrimaryComputerName(
        LPCWSTR Server,
        LPCWSTR PrimaryName,
        LPCWSTR DomainAccount,
        LPCWSTR DomainAccountPassword,
        ULONG Reserved
        ) nogil

    #
    # The following enumeration must be kept
    # in sync with COMPUTER_NAME_TYPE defined
    # in winbase.h
    #

    ctypedef enum _NET_COMPUTER_NAME_TYPE:
        NetPrimaryComputerName,
        NetAlternateComputerNames,
        NetAllComputerNames,
        NetComputerNameTypeMax
    ctypedef _NET_COMPUTER_NAME_TYPE NET_COMPUTER_NAME_TYPE
    ctypedef _NET_COMPUTER_NAME_TYPE *PNET_COMPUTER_NAME_TYPE;

    #if (_MSC_VER >= 800) || defined(_STDCALL_SUPPORTED)
        #define NET_API_FUNCTION    __stdcall
    #else
        #define NET_API_FUNCTION
    #endif

    NET_API_STATUS __stdcall NetEnumerateComputerNames(
        LPCWSTR Server,
        NET_COMPUTER_NAME_TYPE NameType,
        ULONG Reserved,
        PDWORD EntryCount,
        LPWSTR **ComputerNames
    ) nogil       

IF UNAME_SYSNAME == "Windows":
    cdef extern from "WinReg.h":
        pass

cdef extern from *:
    ctypedef LONG LSTATUS

    #
    # Flags for RegLoadAppKey
    #
    DWORD REG_PROCESS_APPKEY = 0x00000001

    #
    # Flags for RegLoadMUIString
    #
    DWORD REG_MUI_STRING_TRUNCATE = 0x00000001

    #
    # Requested Key access mask type.
    #

    ctypedef ACCESS_MASK REGSAM

    #
    # Reserved Key Handles.
    #
    HKEY HKEY_CLASSES_ROOT = 0x80000000
    HKEY HKEY_CURRENT_USER = 0x80000001
    HKEY HKEY_LOCAL_MACHINE = 0x80000002
    HKEY HKEY_USERS = 0x80000003
    HKEY HKEY_PERFORMANCE_DATA = 0x80000004
    HKEY HKEY_PERFORMANCE_TEXT = 0x80000050
    HKEY HKEY_PERFORMANCE_NLSTEXT = 0x80000060
    HKEY HKEY_CURRENT_CONFIG = 0x80000005
    HKEY HKEY_DYN_DATA = 0x80000006

    #
    # RegConnectRegistryEx supported flags
    #
    HKEY REG_SECURE_CONNECTION = 1

    HKEY PROVIDER_KEEPS_VALUE_LENGTH = 0x1

    LSTATUS __stdcall RegOpenKeyExW (
        HKEY hKey,
        LPCWSTR lpSubKey,
        DWORD ulOptions,
        REGSAM samDesired,
        PHKEY phkResult
    ) nogil

    LSTATUS __stdcall RegCloseKey (
        HKEY hKey
    ) nogil

    LSTATUS __stdcall RegCreateKeyW (
        HKEY hKey,
        LPCWSTR lpSubKey,
        PHKEY phkResult
    ) nogil

    LSTATUS __stdcall RegCreateKeyExW (
        HKEY hKey,
        LPCWSTR lpSubKey,
        DWORD Reserved,
        LPWSTR lpClass,
        DWORD dwOptions,
        REGSAM samDesired,
        const LPSECURITY_ATTRIBUTES lpSecurityAttributes,
        PHKEY phkResult,
        LPDWORD lpdwDisposition
    ) nogil

    LSTATUS __stdcall RegDeleteKeyW (
        HKEY hKey,
        LPCWSTR lpSubKey
    ) nogil

    LSTATUS __stdcall RegDeleteKeyExW (
        HKEY hKey,
        LPCWSTR lpSubKey,
        REGSAM samDesired,
        DWORD Reserved
    ) nogil

    LSTATUS __stdcall RegDeleteValueW (
        HKEY hKey,
        LPCWSTR lpValueName
    ) nogil

    LSTATUS __stdcall RegQueryValueW (
        HKEY hKey,
        LPCWSTR lpSubKey,
        LPWSTR lpData,
        PLONG lpcbData
    ) nogil

    LSTATUS __stdcall RegQueryValueExW (
        HKEY hKey,
        LPCWSTR lpValueName,
        LPDWORD lpReserved,
        LPDWORD lpType,
        LPBYTE lpData,
        LPDWORD lpcbData
    ) nogil

    LSTATUS __stdcall RegReplaceKeyW (
        HKEY hKey,
        LPCWSTR lpSubKey,
        LPCWSTR lpNewFile,
        LPCWSTR lpOldFile
    ) nogil

    LSTATUS __stdcall RegRestoreKeyW (
        HKEY hKey,
        LPCWSTR lpFile,
        DWORD dwFlags
    ) nogil

    LSTATUS __stdcall RegSaveKeyW (
        HKEY hKey,
        LPCWSTR lpFile,
        const LPSECURITY_ATTRIBUTES lpSecurityAttributes
    ) nogil

    LSTATUS __stdcall RegSetValueW (
        HKEY hKey,
        LPCWSTR lpSubKey,
        DWORD dwType,
        LPCWSTR lpData,
        DWORD cbData
    ) nogil

    LSTATUS __stdcall RegSetValueExW (
        HKEY hKey,
        LPCWSTR lpValueName,
        DWORD Reserved,
        DWORD dwType,
        const BYTE* lpData,
        DWORD cbData
    ) nogil

    LSTATUS __stdcall RegDeleteKeyValueW (
       HKEY     hKey,
       LPCWSTR lpSubKey,
       LPCWSTR lpValueName
    ) nogil

    LSTATUS __stdcall RegSetKeyValueW (
        HKEY     hKey,
        LPCWSTR  lpSubKey,
        LPCWSTR  lpValueName,
        DWORD    dwType,
        LPCVOID  lpData,
        DWORD    cbData
    ) nogil

    LSTATUS __stdcall RegDeleteTreeW (
        HKEY     hKey,
        LPCWSTR  lpSubKey
    ) nogil

    LSTATUS __stdcall RegCopyTreeW (
        HKEY     hKeySrc,
        LPCWSTR  lpSubKey,
        HKEY     hKeyDest
    ) nogil

    LSTATUS __stdcall RegGetValueW (
        HKEY    hkey,
        LPCWSTR  lpSubKey,
        LPCWSTR  lpValue,
        DWORD    dwFlags,
        LPDWORD pdwType,
        PVOID   pvData,
        LPDWORD pcbData
    ) nogil

    LSTATUS __stdcall RegSaveKeyExW (
        HKEY hKey,
        LPCWSTR lpFile,
        const LPSECURITY_ATTRIBUTES lpSecurityAttributes,
        DWORD Flags
    ) nogil


IF UNAME_SYSNAME == "Windows":
    cdef extern from "WinCon.h":
        pass

cdef extern from *:
    #
    # Attributes flags:
    #

    WORD FOREGROUND_BLUE      = 0x0001 # text color contains blue.
    WORD FOREGROUND_GREEN     = 0x0002 # text color contains green.
    WORD FOREGROUND_RED       = 0x0004 # text color contains red.
    WORD FOREGROUND_INTENSITY = 0x0008 # text color is intensified.
    WORD BACKGROUND_BLUE      = 0x0010 # background color contains blue.
    WORD BACKGROUND_GREEN     = 0x0020 # background color contains green.
    WORD BACKGROUND_RED       = 0x0040 # background color contains red.
    WORD BACKGROUND_INTENSITY = 0x0080 # background color is intensified.
    WORD COMMON_LVB_LEADING_BYTE    = 0x0100 # Leading Byte of DBCS
    WORD COMMON_LVB_TRAILING_BYTE   = 0x0200 # Trailing Byte of DBCS
    WORD COMMON_LVB_GRID_HORIZONTAL = 0x0400 # DBCS: Grid attribute: top horizontal.
    WORD COMMON_LVB_GRID_LVERTICAL  = 0x0800 # DBCS: Grid attribute: left vertical.
    WORD COMMON_LVB_GRID_RVERTICAL  = 0x1000 # DBCS: Grid attribute: right vertical.
    WORD COMMON_LVB_REVERSE_VIDEO   = 0x4000 # DBCS: Reverse fore/back ground attribute.
    WORD COMMON_LVB_UNDERSCORE      = 0x8000 # DBCS: Underscore.

    WORD COMMON_LVB_SBCSDBCS        = 0x0300 # SBCS or DBCS flag.

    BOOL __stdcall SetConsoleTextAttribute(
        HANDLE hConsoleOutput,
        WORD wAttributes
    ) nogil