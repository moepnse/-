cdef class BaseHandler:
    cdef:
        public bint _log_gen
        public bint _log_info
        public bint _log_warn
        public bint _log_err
        public bint _log_debug
    
        public object _url
