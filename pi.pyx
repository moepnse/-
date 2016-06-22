# -*- coding: utf-8 -*-

__author__ = 'Richard Lamboj'
__copyright__ = 'Copyright 2013, Unicom'
__credits__ = ['Richard Lamboj']
__license__ = 'Proprietary'
__version__ = '0.2'
__maintainer__ = 'Richard Lamboj'
__email__ = 'rlamboj@unicom.ws'
__status__ = 'Development'


# standard library imports
import sys
import platform
import traceback

# third party imports

# application/library imports
from package_installer import get_application_path, settings_factory, install_list_factory, installed_list_factory, package_list_factory, package_lists_factory, host_list_factory, connection_list_factory, log_list_factory, Log, get_ph_plugins, get_log_plugins, get_settings_config_path
import libs


# standard library cimports


# third party cimports

# application/library imports
from c_windows_data_types cimport DWORD, WORD, HANDLE
from c_windows cimport SetConsoleTextAttribute, GetStdHandle, STD_OUTPUT_HANDLE, STD_ERROR_HANDLE, FOREGROUND_BLUE, FOREGROUND_GREEN, FOREGROUND_RED, FOREGROUND_INTENSITY, BACKGROUND_BLUE, BACKGROUND_GREEN, BACKGROUND_RED, BACKGROUND_INTENSITY
from libs.handlers.config cimport StatusHandler as BaseStatusHandler, STATUS_SOURCE, ss__cmd, ss__connection_handler, ss__protocol, STATUS_TYPES, st__info, st__success, st__warn, st__error
from libs.handlers.config import ChecksumViolation
from libs.handlers.protocol import FileNotFound, ConnectionError, AuthenticationError
from libs.win.software cimport SoftwareList


INSTALL = "install"
UPGRADE = "upgrade"
REMOVE = "remove"
UNINSTALL = "uninstall"
SEARCH = "search"
INFO = "info"
LIST = "list"
LIST_SOFTWARE = "list_software"
SHOW_INSTALLED = "show_installed"

#INSTALLED = {True: "installiert", False: "nicht installiert"}
INSTALLED = {True: "Yes", False: "No"}


cdef class Out:
    cdef:
        object _fh
        WORD _color
        HANDLE _h_stdout
        WORD _default_attr

    def __init__(self, DWORD std_handle, WORD color):
        self._color = color
        if std_handle == STD_OUTPUT_HANDLE:
            self._fh = sys.stdout
        else:
            self._fh = sys.stderr
        _h_stdout = GetStdHandle(std_handle)
        # This is our default color so that after the we change the text
        # we can change it back to the default dos console color
        self._default_attr = FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY

    def _encode_msg(self, unicode msg):
        # CP850 Encoding is important for Text Output in the Windows Console
        return msg.encode("CP850", errors='replace')

    def write(self, msg):
        SetConsoleTextAttribute(self._h_stdout, self._color)
        if isinstance(msg, unicode):
            msg = self._encode_msg(msg)
        self._fh.write(msg)
        SetConsoleTextAttribute(self._h_stdout, self._default_attr)

    def flush(self):
        self._fh.flush()

    def close(self):
        self._fh.close()


class StatusHandler(BaseStatusHandler):
    def set_status(self, int source_id, int status_type, unicode status_source_name, int status_id, unicode description):
        cdef:
            WORD attr,
            # This is our default color so that after the we change the text
            # we can change it back to the default dos console color
            WORD default_attr = FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY,
            # This is our handle to our output device (monitor)
            # But before we use the output_handle we need to initialize it,
            # so we get the standard handle and set it to the standard output 
            # handled device
            HANDLE h_stdout = GetStdHandle(STD_OUTPUT_HANDLE)
        if status_type == st__info:
            attr = FOREGROUND_BLUE | BACKGROUND_BLUE | BACKGROUND_GREEN | BACKGROUND_RED
        elif status_type == st__success:
            attr = FOREGROUND_GREEN
        elif status_type == st__warn:
            attr = FOREGROUND_GREEN | FOREGROUND_RED
        elif status_type == st__error:
            attr = FOREGROUND_RED

        SetConsoleTextAttribute(h_stdout, attr)
        print self._encode_msg(description)
        SetConsoleTextAttribute(h_stdout, default_attr)
        return BaseStatusHandler.set_status(self, source_id, status_type, status_source_name, status_id, description)

    def _encode_msg(self, unicode msg):
        # CP850 Encoding is important for Text Output in the Windows Console
        return msg.encode("CP850", errors='replace')

    def update_status(self, int old_status_id, int status_type, int status_id, unicode description):
        pass


try:
    status_hanlder = StatusHandler()
    stderr = Out(STD_ERROR_HANDLE, FOREGROUND_RED)
    stdout = Out(STD_OUTPUT_HANDLE, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY)
    try:
        settings = settings_factory(get_settings_config_path('pi_settings.path'))
    except IOError as e:
        if e.errno == 2:
            print >>stderr, "[SettingsPath] File not found: %s" % e.filename
            sys.exit(1)
    plugins = get_ph_plugins()
    log_plugins = get_log_plugins()
    try:
        log_targets = log_list_factory(settings.log_list, log_plugins)
    except IOError as e:
        if e.errno == 2:
            print >>stderr, "[LogList] File not found: %s" % e.filename
            sys.exit(1)
    log = Log(log_targets)
    try:
        connection_list = connection_list_factory(settings.connection_list, plugins, log, status_hanlder)
    except IOError as e:
        if e.errno == 2:
            print >>stderr, "[ConnectionList] File not found: %s" % e.filename
            sys.exit(1)
    try:
        installed_list = installed_list_factory(settings.installed_list, log)
    except IOError as e:
        if e.errno == 2:
            print >>stderr, "[InstalledList] File not found: %s" % e.filename
            sys.exit(1)
    try:
        package_list = package_list_factory(settings.package_list, connection_list, installed_list, log, status_hanlder)
    except IOError as e:
        if e.errno == 2:
            print >>stderr, "[PackageList] File not found: %s" % e.filename
            sys.exit(1)
    try:
        package_lists = package_lists_factory(settings.package_lists, connection_list, installed_list, log, status_hanlder)
    except IOError as e:
        if e.errno == 2:
            print >>stderr, "[PackageList] File not found: %s" % e.filename
            sys.exit(1)
    if settings.target_source == 'install_list':
        try:
            install_list = install_list_factory(settings.install_list, connection_list, log)
        except IOError as e:
            if e.errno == 2:
                print >>stderr, "[InstallList] File not found: %s" % e.filename
                sys.exit(1)
    else:
        try:
            host_list = host_list_factory(settings.host_list, log)
        except IOError as e:
            if e.errno == 2:
                print >>stderr, "[HostList] File not found: %s" % e.filename
                sys.exit(1)
except Exception as e:
    print "Please send this Error-report to support@unicom.ws. Error: %s" % e
    traceback.print_exc()
    sys.exit(1)


cdef main():

    #install_list = install_list_factory(settings.install_list)

    print "settings path: %s" % settings.path
    if len(sys.argv) == 1:
        print __version__
        return True
    action = sys.argv[1]

    if action == INSTALL:
        install(sys.argv[2:])
    elif action == UPGRADE:
        upgrade(sys.argv[2:])
    elif action == REMOVE:
        uninstall(sys.argv[2:])
    elif action == UNINSTALL:
        uninstall(sys.argv[2:])
    elif action == SEARCH:
        search(sys.argv[2:])
    elif action == INFO:
        info(sys.argv[2:])
    elif action == LIST:
        list_packages()
    elif action == LIST_SOFTWARE:
        list_software()
    elif action == SHOW_INSTALLED:
        show_installed()
    elif action == "show_packages_in_installed_list":
        show_packages_in_installed_list()
    elif action == "rebuild_installed_list":
        rebuild_installed_list()
    elif action == "help":
        show_help_text()
    else:
        print "Unknown action %s" % action
        show_help_text()
    return True


def show_help_text():
        print """install package_id [package_id2] ... \tinstall packages
upgrade package_id [package_id2]  ... \tupgrade packages
uninstall package_id [package_id2] ... \tuninstall packages
search keyword [keyword2] ... \t\tsearch packages
info package_id [package_id2] ... \tshow package information
list \t\t\t\t\tlist available packages
show_installed \t\t\t\tshow installed packages
rebuild_installed_list \t\t\trebuild the installed list database
        """

"""
class PI(object):
    def __init__(self):
        self._settings = settings_factory()
        self._package_list = package_list_factory(settings.package_list, RETURN_ID)

    def info(packages=[]):

        for package_id in packages:

            package = self._package_list._get_package_by_id(package_id)

            print "ID:", package_id
            print "Name:", package.name
            print "Befehl:", package.cmd
            #print "%s ist %s" % (package_id, INSTALLED[package.installed])
            print "Installiert:", INSTALLED[package.installed]

    def search(packages=[]):

        for package_id in packages:

            if package_id in self._package_list:
                print "Paket %s wurde gefunden!" % package_id
            else:
                print "Paket %s wurde nicht gefunden!" % package_id

    def install(packages=[]):

        for package_id in packages:
            print "ID", package_id
            if package_id in self._package_list:
                #print "Paket wird installiert"
                self._package_list.install(package_id)
            else:
                print "Paket wurde nicht gefunden!"
"""

"""
def _get_package_source():
    # since version 0.2
    if settings.target_source == 'host_list':
        for hostname in host_list:
            host = host_list[hostname]
            for package in host.get_packages(['install']):
                package_id = package['package_id']
                if package_id in package_list:
                    package_list.install(package_id)
                else:
                    print >>sys.stdout, "Could not found package %s!" % package_id
    # since version 0.1
    elif settings.target_source == 'install_list':
        for package_id in packages:
            if package_id in package_list and package_id in install_list:
                #print "Paket wird installiert"
                package_list.install(package_id)
            else:
                print >>sys.stdout, "Could not found package %s!" % package_id
"""

def _get_packages(self):
    self._log.log_info(u"[host_status] [%d] Target Source: %s" % (libs.common.get_current_line_nr(), settings.target_source))
    # since version 0.2
    if self._settings.target_source == 'host_list':
        install_list = self._host.get_packages()
    # since version 0.1
    elif self._settings.target_source == 'install_list':
        install_list = self._install_list

    packages = []
    for package in install_list:
        package_id = package['package_id']
        action = package['action']
        if package_id in package_list:
            package = package_list._get_package_by_id(package_id)
            yield (package_id, action, package)


#def _get_package(package_id):
    #for package_informations in _get_packages():
        #package_id, action,  =


cdef _list_packages(package_list):
    cdef:
        object package_id
        object package
        object version
        object rev
        object date
        object out
    """
    local_hostname = platform.node()
    for hostname in host_list:
        host = host_list[hostname]
        if host == local_hostname:
            break
    packages = host.get_packages()
    for package in packages:
        package_id = package['package_id']
        action = package['action']
        print action, package_id
    """
    for package_id, package in package_list.iteritems():
        if package_id in installed_list:
            version, rev, date = installed_list[package_id]
            out = "%s (%s) [I: %s (%s) | U: %s (%s)]:\n\t%s" % (package_id, package.name, package.installed, version, package.upgrade_available, package.version, package.description)
        else:
            out = "%s %s %s [I: %s | U: %s]\n%s\n" % (package.package_id, package.name, package.version, package.installed, package.upgrade_available, package.description)
        print out


cdef list_packages():
    cdef:
        object package_id
        object _package_list

    print "list packages..."
    if settings.target_source == 'install_list':
        for package_id in install_list:
            print package_id
    else:
        _list_packages(package_list)
        for _package_list in package_lists:
            _list_packages(_package_list)


cdef list_software():
    cdef:
        object product
        SoftwareList software_list

    print "list software..."
    software_list = SoftwareList()
    for key in software_list:
        product = software_list[key]
        print >>stdout, u"%s %s %s %s %s"% (product.display_name, product.display_version, product.version_major, product.version_minor, product.version)


cdef bint _info(package_list, package_id):
    cdef:
        bint found = False
    if package_id in package_list:
        package = package_list[package_id]
        print >>stdout, "ID: %s\r\nName: %s\r\nInstall Cmds: %s\r\nUpgrade Cmds: %s\r\nUinstall Cmds: %s\r\nInstalled: %s" % (package_id, package.name, repr(package.install_cmds), repr(package.upgrade_cmds), repr(package.uninstall_cmds), INSTALLED[package.installed])
    return found


cdef info(packages=[]):
    cdef:
        object package_id
        object package
        list install_cmds
        bint found

    for package_id in packages:
        found = _info(package_id, package_list)
        for _package_list in package_lists:
            found = _info(package_id, _package_list)
        if not found:
            print >>stdout, "Package %s could not be found!" % package_id


cdef __handle_dependencies(package_list, package_id, action_list):
    cdef:
        object package
        dict dependency
        unicode dep_package_id
    if package_id in package_list:
        package = _get_package(package_id)
        for dependency in package.dependencies:
            if not "package_id" in dependency:
                #self._log.log_err(u"Error: package_id attribute is missing in dependency!")
                continue
            if not "installed" in dependency:
                #self._log.log_err(u"Error: installed attribute is missing in dependency!")
                continue
            dep_package_id = dependency["package_id"]
            _handle_dependencies(dep_package_id, action_list)
            if dependency['installed'] == False:
                dep_action = u"uninstall"
            elif dependency['installed'] == True:
                dep_action = u"install"
            _remove_packages_with_conflicting_dependencies(dep_package_id, dep_action, action_list)
            action_list.append({"package_id": dep_package_id, "action": dep_action})


cdef _handle_dependencies(package_id, action_list):
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
    __handle_dependencies(package_list, package_id, action_list)
    for _package_list in package_lists:
        __handle_dependencies(_package_list, package_id, action_list)


cdef _remove_packages_with_conflicting_dependencies(unicode package_id, unicode action, action_list):
    cdef:
        dict dict_package
        object package
        dict dependency
        int index
        dict a_entry
    for dict_package in action_list:
        package = _get_package(dict_package['package_id'])
        for dependency in package.dependencies:
            if package_id == dependency['package_id'] and dependency["installed"] == {u"install": False, u"uninstall": True}[action]:
                for index in range(0, len(action_list)):
                    a_entry = action_list[index]
                    if a_entry["package_id"] == dependency["package_id"] and a_entry["action"]  == {True: u"install", False: u"uninstall"}[dependency["installed"]]:
                        del action_list[index]
                        index = index -1


cdef search(search_patterns=[]):
    cdef:
        object package_id
        object package
        dict packages_found = {}
        unicode search_pattern
        object version
        object rev
        object date
        object out
    for search_pattern in search_patterns:
        for package_id, package in package_list.items():
            if search_pattern in package.keywords or search_pattern == package.package_id:
                #_handle_dependencies(package['package_id'], self._packages)
                packages_found[package.package_id] = package
        #print package_id
    if len(packages_found) > 0:
        for package_id, package in packages_found.items():
            if package_id in installed_list:
                version, rev, date = installed_list[package_id]
                out = "%s (%s) [I: %s (%s) | U: %s (%s)]:\n\t%s" % (package_id, package.name, package.installed, version, package.upgrade_available, package.version, package.description)
            else:
                out = "%s (%s) [I: %s | U: %s]:\n\t%s" % (package_id, package.name, package.installed,  package.upgrade_available, package.description)
            print out
    else:
        print >>stdout, "Nothing found!"


cdef object _get_package(package_id):
    cdef:
        object _package_list
    if package_id in package_list:
        return package_list[package_id]

    for _package_list in package_lists:
        if package_id in _package_list:
            return _package_list[package_id]
    return None


cdef _handle_actions(action_list):
    cdef:
        object package_id
        object package
        int status
        list cmd_list
        dict dict_package
    for dict_package in action_list:
        try:
            if not "action" in dict_package:
                continue
            package_id = dict_package["package_id"]
            action = dict_package["action"]
            if not package_id in package_list:
                print "Package with package_id %s not found in package list" % package_id
                continue
            package = package_list[package_id]
            if dict_package["action"] == "install":
                if package.installed:
                    print "Nothing todo, %s (%s) is allready installed!" % (package_id, package.name)
                    continue
                print "Installing package: %s" % package_id
                status, cmd_list = package_list.install(package_id)
                print "status: %d, executed cmds: %s" % (status, cmd_list)

            elif dict_package["action"] == "uninstall":
                if not package.installed:
                    print "Nothing todo, %s (%s) is not installed!" % (package_id, package.name)
                print "Uninstalling package: %s" % package_id
                status, cmd_list = package_list.uninstall(package_id)
                print "status: %d, executed cmds: %s" % (status, cmd_list)
        except ChecksumViolation, e:
            print >>stderr, "Checksum violation!"
        except FileNotFound, e:
            print e
        except ConnectionError, e:
            print e
        except AuthenticationError, e:
            print e
    print "Done"


cdef _install(package_list, package_id):
    cdef:
        object package
        list action_list = []
    if package_id in package_list.keys():
        _handle_dependencies(package_id, action_list)
        action_list.append({'action': u'install', 'package_id': package_id})
    else:
        print "Package with id: %s not found!" % package_id
    _handle_actions(action_list)


cdef install(packages=[]):
    cdef:
        object package_id
        object package
        list action_list = []
    for package_id in packages:
        found = _install(package_list, package_id)
        if found:
            continue
        for _package_list in package_lists:
            found = _install(_package_list, package_id)
            if found:
                break
        if not found:
            print "Package with id: %s not found!" % package_id


cdef _upgrade(package_list, package_id):
    cdef:
        object package
        int status
        list cmd_list
    if package_id in package_list.keys():
        package = package_list[package_id]
        if not package.upgrade_available:
            print "Nothing todo, %s (%s) is up2date!" % (package_id, package.name)
            return True
        print "Upgrading package: %s" % package_id
        status, cmd_list = package_list.upgrade(package_id)
        print "status: %d, executed cmds: %s" % (status, cmd_list)
        return True
    return False


cdef upgrade(packages=[]):
    cdef:
        object package_id
        object _package_list
        bint found
    for package_id in packages:
        found = _upgrade(package_list, package_id)
        if found:
            continue
        for _package_list in package_lists:
            found = _upgrade(package_list, package_id)
            if found:
                break
        if not found:
            print >>stdout, "Could not found package %s!" % package_id


cdef _uninstall(package_list, package_id):
    cdef:
        object package
        int status
        list cmd_list
    if package_id in package_list.keys():
        package = package_list[package_id]
        if not package.installed:
            print "Nothing todo, %s (%s) is not installed!" % (package_id, package.name)
        print "Uninstalling package: %s" % package_id
        status, cmd_list = package_list.uninstall(package_id)
        print "status: %d, executed cmds: %s" % (status, cmd_list)
        print "Done"
        return True
    return False


cdef uninstall(packages=[]):
    cdef:
        object package_id
        bint found
        object _package_list
    for package_id in packages:
        found = _uninstall(package_list, package_id)
        if found:
            continue
        for _package_list in package_lists:
            found = _uninstall(package_list, package_id)
            if found:
                break
        if not found:
            print >>stdout, "Could not found package %s!" % package_id


cdef _show_installed(package_list):
    cdef:
        object package_id
        object package
    for package_id, package in package_list.iteritems():
        if package.installed:
            print package.package_id


cdef show_installed():
    cdef:
        object _package_list
    _show_installed(package_list)
    for _package_list in package_lists:
        _show_installed(_package_list)


cdef show_packages_in_installed_list():
    cdef:
        object package_id
    if len(installed_list) == 0:
        print "no entrys found!"
        return
    print "entrys in installed list:"

    for package_id in installed_list:
        print package_id, installed_list[package_id]


cdef rebuild_installed_list():
    cdef:
        object package_id
        object package
    for package_id, package in package_list.iteritems():
        if package.installed:
            installed_list.append(package_id, package.version, package.rev)
    installed_list.save()


if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        print "Please send this Error-report to support@unicom.ws. Error: %s" % e
        traceback.print_exc()
        sys.exit(1)
    #print "Done :-)!"
    #sys.stdout.flush()