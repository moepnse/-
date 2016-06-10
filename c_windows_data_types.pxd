cdef extern:
#cdef extern from "BaseTsd.h":
#    pass

#cdef extern from "WinDef.h":
#    pass

#cdef extern from "WinNT.h":
    ctypedef Py_UNICODE WCHAR
    ctypedef const WCHAR* LPCWSTR
    ctypedef WCHAR* LPWSTR
    ctypedef LPWSTR LPTSTR
    ctypedef void* HWND
    ctypedef void* PVOID
    ctypedef void* LPVOID
    ctypedef const void *LPCVOID
    ctypedef void VOID
    #ctypedef unsigned short wchar_t
    ctypedef WCHAR wchar_t
    #ctypedef unsigned __int3264 ULONG_PTR
    ctypedef unsigned int ULONG_PTR
    ctypedef unsigned long ULONG
    ctypedef unsigned int UINT_PTR
    ctypedef long LONG_PTR
    ctypedef ULONG_PTR size_t
    ctypedef int errno_t
    ctypedef char* PSTR
    ctypedef char** LPSTR
    ctypedef bint BOOL
    ctypedef unsigned char BYTE
    ctypedef BYTE *PBYTE # Pointer to BYTE.
    ctypedef UINT_PTR WPARAM
    ctypedef LONG_PTR LPARAM
    ctypedef wchar_t* PWSTR
    ctypedef const wchar_t* PCWSTR
    ctypedef char CHAR
    ctypedef CHAR *PCHAR
    ctypedef WCHAR *PWCHAR
    ctypedef WCHAR *LPWCH
    ctypedef const char *LPCTSTR
    ctypedef void *HANDLE
    ctypedef HANDLE *PHANDLE
    ctypedef HANDLE HICON
    ctypedef HANDLE HINSTANCE
    ctypedef HINSTANCE HMODULE
    ctypedef HANDLE SC_HANDLE
    ctypedef BYTE *LPBYTE
    ctypedef unsigned long DWORD
    ctypedef DWORD *PDWORD
    ctypedef DWORD *LPDWORD
    ctypedef DWORD NET_API_STATUS
    ctypedef unsigned short WORD
    ctypedef HANDLE HKEY
    ctypedef HKEY *PHKEY
    ctypedef long LONG
    ctypedef LONG *PLONG
    ctypedef ULONG *PULONG
    ctypedef unsigned long long ULONGLONG
    ctypedef ULONGLONG *PULONGLONG
    ctypedef unsigned char UINT8
    ctypedef unsigned short UINT16
    ctypedef unsigned int UINT32
    ctypedef unsigned int ULONG32
    ctypedef int INT
    ctypedef long long INT64
    ctypedef unsigned long long UINT64
    ctypedef unsigned long long ULONG64
    ctypedef unsigned char UCHAR
    ctypedef unsigned int UINT
    ctypedef UINT *PUINT
    ctypedef unsigned short USHORT