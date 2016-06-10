cdef class FileInfo:

    cdef:
        unicode _path
        dict _file_info
        
    cdef _get_file_info(self)