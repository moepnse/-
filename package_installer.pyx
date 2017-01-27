# -*- coding: utf-8 -*-

# standard library imports
import os
import sys
import time
import platform
import subprocess

# third party imports

# application/library imports
from libs.handlers.status import INSTALLING, UPGRADING, REMOVING, INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN, SEND_STATUS, SEND_INFO, SEND_DONE, SEND_INFO_SUCCESS, SEND_INFO_WARN, SEND_INFO_ERROR
from libs.handlers.config import RETURN_PACKAGE, RETURN_ID, RET_CODE_UNKNOWN, RET_CODE_SUCCESS, RET_CODE_ERROR, RET_CODE_ALREADY_INSTALLED, RET_CODE_ALREADY_REMOVED, PackageList
import libs.handlers.plugin_handler


connections = {}


class Log(object):

    def __init__(self, logs):
        self._logs = logs

    def log_err(self, msg):
        for log in self._logs:
            log.log_err(msg)

    def log_info(self, msg):
        for log in self._logs:
            log.log_info(msg)

    def log_warn(self, msg):
        for log in self._logs:
            log.log_warn(msg)

    def log_debug(self, msg):
        for log in self._logs:
            log.log_debug(msg)


def get_application_path():
    cdef char* application_path
    application_path = sys.executable
    #print "Application path: %s" % application_path
    return os.path.dirname(os.path.abspath(application_path)) 


def get_settings_config_path(settings_path_file=""):
    if settings_path_file == "":
        settings_path_file = os.path.join(os.path.dirname(__file__), "settings.path")
    #print "Settings path file: %s" % settings_path_file 
    fh = open(settings_path_file, 'r')
    path = fh.readline()
    fh.close()
    return path


def get_ph_plugins():
    path = os.path.dirname(__file__)
    plugins_log_path = os.path.join(path, 'logs', 'core')
    if not os.path.exists(plugins_log_path):
        os.makedirs(plugins_log_path)
    fh = open(os.path.join(plugins_log_path, 'plugins.log'), 'a')
    plugins_path = os.path.join(path, 'plugins', 'protocol_handlers')
    fh.write(plugins_path+'\n`')
    plugin_handler_protocol = libs.handlers.plugin_handler.PluginSystem(plugins_path)
    protocol_plugins = {}
    for protocol_plugin in plugin_handler_protocol.load_plugins():
        if hasattr(protocol_plugin, 'url_prefix'):
            log_msg = 'registering: %s\n' % protocol_plugin.url_prefix
            protocol_plugin.register_handler(protocol_plugins)
        else:
            log_msg = 'Could not load plugin!'
        fh.write(log_msg)
    fh.close()
    return protocol_plugins


def get_config_plugins():
    path = os.path.dirname(__file__)
    plugin_handler_protocol = libs.handlers.plugin_handler.PluginSystem(os.path.join(path, 'plugins', 'config'))
    config_plugins = {}
    for config_plugin in plugin_handler_protocol.load_plugins():
        try:
            config_plugin.register_handler(config_plugins)
        except:
            pass
    return config_plugins


def get_log_plugins():
    path = os.path.dirname(__file__)
    plugin_handler_log = libs.handlers.plugin_handler.PluginSystem(os.path.join(path, 'plugins', 'logging'))
    log_plugins = {}
    for log_plugin in plugin_handler_log.load_plugins():
        try:
            log_plugin.register_handler(log_plugins)
        except:
            pass
    return log_plugins


def get_config_plugin(config_path):
    config_plugins = get_config_plugins()
    file_name, file_extension = os.path.splitext(config_path)
    return config_plugins[file_extension[1:]]


def log_list_factory(log_list_path, plugins):
    return get_config_plugin(log_list_path).LogList(log_list_path, plugins)


def host_list_factory(host_list_path, log):
    return get_config_plugin(host_list_path).HostList(host_list_path, log)


def connection_list_factory(connection_list_path, plugins, log, status_handler, window_handle=None):
    return get_config_plugin(connection_list_path).ConnectionList(connection_list_path, plugins, log, status_handler, window_handle)


def package_list_factory(package_list_path, connection_list, installed_list, log, status_handler):
    if package_list_path == '':
        return PackageList(package_list_path, connection_list, installed_list, log, status_handler)
    return get_config_plugin(package_list_path).PackageList(package_list_path, connection_list, installed_list, log, status_handler)


def package_lists_factory(package_lists, connection_list, installed_list, log, status_handler):
    cdef:
        list package_list_plugins = []

    for package_list_path in package_lists:
        package_list_plugins.append(get_config_plugin(package_list_path).PackageList(package_list_path, connection_list, installed_list, log, status_handler))

    return package_list_plugins


def profile_list_factory(profile_list_path, log):
    return get_config_plugin(profile_list_path).ProfileList(profile_list_path, log)


def installed_list_factory(installed_list_path, log):
    return get_config_plugin(installed_list_path).InstalledList(installed_list_path, log)


def install_list_factory(install_list_path, connection_list, log):
    return get_config_plugin(install_list_path).InstallList(install_list_path, connection_list, log)


def groups_factory(groups_path, log):
    return get_config_plugin(groups_path).Groups(groups_path, log)


def settings_factory(config_path=""):
    if config_path == "":
        config_path = os.path.abspath(get_settings_config_path())
    #print "Configuration path: %s" % config_path
    #sys.stdout.flush()
    return get_config_plugin(config_path).Settings(config_path)


def init():
    config_plugins = get_config_plugins()


def send_status(status, package_id):
    pass


def test():

    cdef:
        int status

    print "initiate"
    settings_path = os.path.join(os.path.dirname(__file__), 'settings.path')
    print settings_path
    settings = settings_factory(get_settings_config_path(settings_path))
    print "get_plugins"
    plugins = get_ph_plugins()
    print "get_plugins"
    log_plugins = get_log_plugins()
    log_targets = log_list_factory(settings.log_list, log_plugins)
    log = Log(log_targets)
    connection_list = connection_list_factory(settings.connection_list, plugins, log)
    installed_list = installed_list_factory(settings.installed_list, log)
    package_list = package_list_factory(settings.package_list, connection_list, installed_list, log)
    install_list = install_list_factory(settings.install_list, connection_list, log)
    host_list = host_list_factory(settings.host_list, log)
    print settings.status_gui_cmd
    sys.stdout.flush()

    host = None
    local_hostname = platform.node()
    if settings.target_source == 'host_list':
        for hostname in host_list:
            host = host_list[hostname]
            if host == local_hostname:
                break

    packages = [] if host is None else host.get_packages()

    log.log_info("[pi_service] [%d] Target Source: %s" % (libs.common.get_current_line_nr(), settings.target_source))
    # since version 0.2
    if settings.target_source == 'host_list' and host is not None:
        for package in packages:
            package_id = package['package_id']
            action = package['action']
            log.log_info("[pi_service] [%d] %s %s" % (libs.common.get_current_line_nr(), package_id, action))
            if package_id in package_list.keys():
                if action == 'install':
                    send_status(INSTALLING, package_id)
                    status = package_list.install(package_id)
                    #time.sleep(10)
                    log.log_info("[pi_service] [%d] %s - status %s" % (libs.common.get_current_line_nr(), package_id, status))
                    if status in (RET_CODE_SUCCESS, RET_CODE_ALREADY_INSTALLED):
                        status = INSTALLED
                    elif status == RET_CODE_UNKNOWN:
                        status = UNKNOWN
                    else:
                        status = FAILED
                    send_status(status, package_id)
                elif action == 'upgrade':
                    send_status(UPGRADING, package_id)
                    status = package_list.upgrade(package_id)
                    #time.sleep(10)
                    log.log_info("[pi_service] [%d] %s - status %s" % (libs.common.get_current_line_nr(), package_id, status))
                    if status in (RET_CODE_SUCCESS, RET_CODE_ALREADY_INSTALLED):
                        status = UPGRADED
                    elif status == RET_CODE_UNKNOWN:
                        status = UNKNOWN
                    else:
                        status = FAILED
                    send_status(status, package_id)

                elif action == 'remove' or action == 'uninstall':
                    send_status(REMOVING, package_id)
                    status = package_list.uninstall(package_id)
                    #time.sleep(10)
                    log.log_info("[pi_service] [%d] %s - status %s" % (libs.common.get_current_line_nr(), package_id, status))
                    if status in (RET_CODE_SUCCESS, RET_CODE_ALREADY_INSTALLED):
                        status = REMOVED
                    elif status == RET_CODE_UNKNOWN:
                        status = UNKNOWN
                    else:
                        status = FAILED
                    send_status(status, package_id)
                else:
                    log.log_err("[pi_service] [%d] Unknown action %s!" % (libs.common.get_current_line_nr(), action))

            else:
                log.log_err("[pi_service] [%d] Could not found package %s!" % (libs.common.get_current_line_nr(), package_id))
    # since version 0.1
    elif settings.target_source == 'install_list':
        for package_id in install_list:
            if package_id in package_list and package_id in install_list:
                package_list.install(package_id)
            else:
                print >>sys.stdout, "[pi_service] [%d] Could not found package %s!" % (libs.common.get_current_line_nr(), package_id)


if __name__ == '__main__':
    pass