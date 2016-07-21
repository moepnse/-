# -*- coding: utf-8 -*-

__author__ = 'Richard Lamboj'
__copyright__ = 'Copyright 2013, Unicom'
__credits__ = ['Richard Lamboj']
__license__ = 'Proprietary'
__version__ = '1.0'
__maintainer__ = 'Richard Lamboj'
__email__ = 'rlamboj@unicom.ws'
__status__ = 'Development'


# standard library imports
import os
import sys
import time
import platform

# third party imports


# application/library imports
from package_installer import get_application_path, installed_list_factory, settings_factory, package_list_factory, install_list_factory, connection_list_factory, log_list_factory, host_list_factory, Log, get_ph_plugins, get_log_plugins, get_settings_config_path, INSTALLING, UPGRADING, REMOVING, INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN
from libs.handlers.config import RETURN_ID, RET_CODE_UNKNOWN, RET_CODE_SUCCESS, RET_CODE_ERROR, RET_CODE_ALREADY_INSTALLED
import libs.win.commandline

# standard library cimports
from libs.handlers.config cimport StatusHandler as BaseStatusHandler

# application/library cimports
from c_windows cimport DSROLE_PRIMARY_DOMAIN_INFO_BASIC
from libs.win.system cimport _get_domain_info


class StatusHandler(BaseStatusHandler):
    pass



cdef class PIStatus:
    cdef:
        unicode _local_hostname
        unicode _local_workgroup
        unicode _local_domain_name
        unicode _local_forest_name
        object _settings
        object _plugins
        object _log
        object _connection_list
        object _installed_list
        object _package_list
        object _install_list
        object _host_list
        object _status_handler

    def __cinit__(self):
        cdef:
            DSROLE_PRIMARY_DOMAIN_INFO_BASIC *info
        self._local_workgroup = u""
        self._local_domain_name = u""
        self._local_forest_name = u""

        _get_domain_info(&info)

        if info.DomainNameDns != NULL:
            self._local_domain_name = info.DomainNameDns

        if info.DomainForestName != NULL:
            self._local_forest_name = info.DomainForestName

        self._local_workgroup = info.DomainNameFlat

    def __init__(self):
        self._initiate()
        self._status_handler = StatusHandler()

    def _initiate(self):
        cdef:
            object settings_path
            object log_plugins
            object log_targets
            object log

        settings_path = os.path.join(get_application_path(), 'settings.path')
        #print settings_path
        self._settings = settings_factory(get_settings_config_path(settings_path))
        self._plugins = get_ph_plugins()
        log_plugins = get_log_plugins()
        log_targets = log_list_factory(self._settings.log_list, log_plugins)
        log = Log([])
        self._log = log
        self._connection_list = connection_list_factory(self._settings.connection_list, self._plugins, self._log, self._status_handler)
        self._installed_list = installed_list_factory(self._settings.installed_list, self._log)
        self._package_list = package_list_factory(self._settings.package_list, self._connection_list, self._installed_list, self._log, self._status_handler)
        if self._settings.target_source == 'host_list':
            self._host_list = host_list_factory(self._settings.host_list, self._log)
        else:
            self._install_list = install_list_factory(self._settings.install_list, self._connection_list, self._log)
        # better way?
        self._local_hostname = unicode(platform.node())

    def _get_packages(self):
        cdef:
            list packages = []
            object package
            object package_action_information
            object package_id
            object action

        self._log.log_info(u"[host_status] [%d] Target Source: %s" % (libs.common.get_current_line_nr(), self._settings.target_source))
        # since version 0.2
        if self._settings.target_source == 'host_list':
            for host in self._host_list:
                if not host.hostname_is(self._local_hostname) and not host.workgroup_is(self._local_workgroup) and not host.domain_name_is(self._local_domain_name) and not host.forest_name_is(self._local_forest_name):
                    continue
                for package_action_information in host:
                    package = self._package_list[package_action_information['package_id']]
                    action = package_action_information['action']
                    yield (package.package_id, action, package.installed, package.upgrade_available)
        # since version 0.1
        elif self._settings.target_source == 'install_list':
            for package_action_information in self._install_list:
                package_id = package_action_information['package_id']
                action = package_action_information['action']
                if package_id in self._package_list.keys():
                    package = self._package_list[package_id]
                    yield (package_id, action, package.installed, package.upgrade_available)

    def target_source(self):
        return self._settings.target_source

    def json_str(self):
        cdef:
            list packages = []

        for package_informations in self._get_packages():
           packages.append(u"{'package_id': '%s', 'action': %s, 'installed': %s, 'upgrade available': %s}" % package_informations)
        return u"[%s]" % ','.join(packages)

    def json(self):
        cdef:
            packages = []
        for package_informations in self._get_packages():
           packages.append({'package_id': package_informations[0], 'action': package_informations[1], 'installed': package_informations[2], 'upgrade available': package_informations[3]})
        return packages

    def xml(self):
        cdef:
            unicode xml = u"<packages>"
        for package_informations in self._get_packages():
           xml += u"<package><package_id>%s</package_id><action>%s</action><installed>%s</installed><upgrade_available>%s</upgrade_available></package>" % package_informations
        return xml + "</packages>"

    def text(self):
        cdef:
            unicode text = u''
        for package_informations in self._get_packages():
           text += u"package_id: %s, action: %s, installed: %s, upgrade available: %s" % package_informations
        return text

    def csv(self):
        cdef:
            unicode csv = u"package_id;action;installed;upgrade_available"
        for package_informations in self._get_packages():
            # does'nt work, becouse a tuple is immutable!
           #package_informations[2] = str(package_informations[2])
           #package_informations[3] = str(package_informations[3])
           csv += u";".join(package_informations[:2]+ (str(package_informations[2]), str(package_informations[3])))
        return csv


def main():
    cdef:
        object stdout = sys.stdout
        object stderr = sys.stderr
        object devnull = open(os.devnull, 'w')
        list args = sys.argv[1:]
        object pi_status
        unicode data = u""
        dict arguments
        list current_values
        str current_arg
        object out

    current_arg = None
    arguments = {}
    current_values = []
    for arg in args:
        if arg.startswith("--"):
            if not current_arg is None:
                arguments[current_arg] = current_values
            current_arg = arg
            current_values = []
            continue
        current_values.append(arg)
    if not current_arg is None:
        arguments[current_arg] = current_values

    if "--path" in arguments:
        if len(arguments["--path"]) > 0:
            path = arguments["--path"][0]
            try:
                out = open(path, "w")
            except IOError as e:
                print >>sys.stderr, "Could not open file: %s!" % path
                sys.exit(1)
    else:
        out = sys.stdout

    #sys.stderr = devnull
    #sys.stdout = devnull
    pi_status = PIStatus()
    if '--text' in args:
        data = pi_status.text()
    if '--json' in args:
        data = unicode(pi_status.json())
    if '--xml' in args:
        data = pi_status.xml()
    if '--csv' in args:
        data = pi_status.csv()
    if '--target_source' in args:
        data = pi_status.target_source()
    #sys.stdout = stdout
    print >>out, data

if __name__=='__main__':
    main()