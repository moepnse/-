from c_windows_data_types cimport HANDLE, ULONG

cdef:
    struct WinSession:
        HANDLE h_token
        ULONG dw_session_id

    enum run_on:
        ON_START = 0
        ON_SHUTDOWN = 1
        REPEATEDLY = 2
        
    enum display_target:
        CURRENT_USER = 0
        WINLOGON = 1