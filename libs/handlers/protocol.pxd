from c_windows_data_types cimport DWORD, HANDLE

cdef class BaseHandler:
    cdef:
        public object _url_prefix
        public object _log
        public object _status_handler
        public object _url
        public object _username
        public object _password
        public bint __log_info
        public bint __log_warn
        public bint __log_err
        public bint __log_debug
        public object _plugin_name
        
        unsigned long _execute(self, unicode cmd)
        unsigned long _execute_as_user(self, unicode cmd)
        HANDLE _get_current_user_token(self)
