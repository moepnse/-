typedef Py_UNICODE WCHAR;
typedef const WCHAR* LPCWSTR;
typedef WCHAR* LPWSTR;
typedef LPWSTR LPTSTR;
typedef void* HWND;
typedef void* PVOID;
typedef void* LPVOID;
typedef const void *LPCVOID;
typedef void VOID;
typedef unsigned int ULONG_PTR;
typedef unsigned long ULONG;
typedef unsigned int UINT_PTR;
typedef long LONG_PTR;
typedef int errno_t;
typedef char* PSTR;
typedef char** LPSTR;
typedef unsigned char BYTE;
typedef BYTE *PBYTE; // Pointer to BYTE.
typedef UINT_PTR WPARAM;
typedef LONG_PTR LPARAM;
typedef wchar_t* PWSTR;
typedef const wchar_t* PCWSTR;
typedef char CHAR;
typedef CHAR *PCHAR;
typedef WCHAR *PWCHAR;
typedef WCHAR *LPWCH;
typedef const char *LPCTSTR;
typedef void *HANDLE;
typedef HANDLE *PHANDLE;
typedef HANDLE HICON;
typedef HANDLE HINSTANCE;
typedef HINSTANCE HMODULE;
typedef HANDLE SC_HANDLE;
typedef BYTE *LPBYTE;
typedef unsigned long DWORD;
typedef DWORD *PDWORD;
typedef DWORD *LPDWORD;
typedef DWORD NET_API_STATUS;
typedef unsigned short WORD;
typedef HANDLE HKEY;
typedef HKEY *PHKEY;
typedef long LONG;
typedef LONG *PLONG;
typedef ULONG *PULONG;
typedef unsigned long long ULONGLONG;
typedef ULONGLONG *PULONGLONG;
typedef unsigned char UINT8;
typedef unsigned short UINT16;
typedef unsigned int UINT32;
typedef unsigned int ULONG32;
typedef int INT;
typedef long long INT64;
typedef unsigned long long UINT64;
typedef unsigned long long ULONG64;
typedef unsigned char UCHAR;
typedef unsigned int UINT;
typedef UINT *PUINT;
typedef unsigned short USHORT;

DWORD MAX_PREFERRED_LENGTH = -1;
DWORD ERROR_SUCCESS = 0;
DWORD ERROR_MORE_DATA = 234;
DWORD ERROR_INVALID_PARAMETER;

// FIXME
DWORD STYPE_DISKTREE;
DWORD STYPE_PRINTQ;
DWORD STYPE_DEVICE;
DWORD STYPE_IPC;
DWORD STYPE_SPECIAL;
DWORD STYPE_TEMPORARY;

// FIXME
DWORD ACCESS_READ;
DWORD ACCESS_WRITE;
DWORD ACCESS_CREATE;
DWORD ACCESS_EXEC;
DWORD ACCESS_DELETE;
DWORD ACCESS_ATRIB;
DWORD ACCESS_PERM;
DWORD ACCESS_ALL;

//
// Reserved Key Handles.
//
HKEY HKEY_CLASSES_ROOT = 0x80000000;
HKEY HKEY_CURRENT_USER = 0x80000001;
HKEY HKEY_LOCAL_MACHINE = 0x80000002;
HKEY HKEY_USERS = 0x80000003;
HKEY HKEY_PERFORMANCE_DATA = 0x80000004;
HKEY HKEY_PERFORMANCE_TEXT = 0x80000050;
HKEY HKEY_PERFORMANCE_NLSTEXT = 0x80000060;
HKEY HKEY_CURRENT_CONFIG = 0x80000005;
HKEY HKEY_DYN_DATA = 0x80000006;

//
// Predefined Value Types.
//

DWORD REG_NONE                    = 0;    // No value type
DWORD REG_SZ                      = 1;    // Unicode nul terminated string
DWORD REG_EXPAND_SZ               = 2;    // Unicode nul terminated string
                                                // (with environment variable references)
DWORD REG_BINARY                  = 3;    // Free form binary
DWORD REG_DWORD                   = 4;    // 32-bit number
DWORD REG_DWORD_LITTLE_ENDIAN     = 4;    // 32-bit number =same as REG_DWORD
DWORD REG_DWORD_BIG_ENDIAN        = 5;    // 32-bit number
DWORD REG_LINK                    = 6;    // Symbolic Link =unicode
DWORD REG_MULTI_SZ                = 7;    // Multiple Unicode strings
DWORD REG_RESOURCE_LIST           = 8;    // Resource list in the resource map
DWORD REG_FULL_RESOURCE_DESCRIPTOR = 9;   // Resource list in the hardware description
DWORD REG_RESOURCE_REQUIREMENTS_LIST = 10;
DWORD REG_QWORD                   = 11;   // 64-bit number
DWORD REG_QWORD_LITTLE_ENDIAN     = 11;   // 64-bit number =same as REG_QWORD