
cdef handle_dependencies(package_id, action_list, package_list, package_lists=*)

cdef remove_depending_packages(package_id, action_list, package_list, package_lists)

cdef add_package_status(dict package_status_mapping, unicode package_id, bint success)

cdef bint check_dependencies(dict package_status_mapping, object package)

cdef bint check_if_package_is_needed(dict package_status_mapping, object package, object package_list, package_lists=*)