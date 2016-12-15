

cdef object _get_package(package_id, package_list, package_lists):
    cdef:
        object _package_list
    if package_id in package_list:
        return package_list[package_id]

    for _package_list in package_lists:
        if package_id in _package_list:
            return _package_list[package_id]
    return None


cdef __handle_dependencies(_package_list, package_id, action_list, package_list, package_lists):
    cdef:
        object package
        dict dependency
        unicode dep_package_id
    if package_id in _package_list:
        package = _get_package(package_id, package_list, package_lists)
        for dependency in package.dependencies:
            if not "package_id" in dependency:
                #self._log.log_err(u"Error: package_id attribute is missing in dependency!")
                continue
            if not "installed" in dependency:
                #self._log.log_err(u"Error: installed attribute is missing in dependency!")
                continue
            dep_package_id = dependency["package_id"]

            if dependency['installed'] == False:
                dep_action = u"uninstall"
            elif dependency['installed'] == True:
                dep_action = u"install"
            #for action in action_list:
                #if action['package_id'] == dep_package_id and action['action'] == dep_action:
                    #pass
            if dep_action == u"install":
                handle_dependencies(dep_package_id, action_list, package_list, package_lists)
            _remove_packages_with_conflicting_dependencies(dep_package_id, dep_action, action_list, package_list, package_lists)
            action_list.append({'package_list': _package_list, "package_id": dep_package_id, "action": dep_action})


cdef handle_dependencies(package_id, action_list, package_list, package_lists):
    """
    action_list = {
        [
            {   package_id:"winrar",
                action: "install",
            }
        ]
    }
    """
    cdef:
        object _package_list
    __handle_dependencies(package_list, package_id, action_list, package_list, package_lists)
    for _package_list in package_lists:
        __handle_dependencies(_package_list, package_id, action_list, package_list, package_lists)


cdef _remove_packages_with_conflicting_dependencies(unicode package_id, unicode action, action_list, package_list, package_lists):
    cdef:
        dict dict_package
        object package
        dict dependency
        int index
        dict a_entry
    for dict_package in action_list:
        package = _get_package(dict_package['package_id'], package_list, package_lists)
        for dependency in package.dependencies:
            if package_id == dependency['package_id'] and dependency["installed"] == {u"install": False, u"uninstall": True}[action]:
                for index in range(0, len(action_list)):
                    a_entry = action_list[index]
                    if a_entry["package_id"] == dependency["package_id"] and a_entry["action"]  == {True: u"install", False: u"uninstall"}[dependency["installed"]]:
                        del action_list[index]
                        index = index -1
