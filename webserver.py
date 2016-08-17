# -*- coding: utf-8 -*-

__author__ = 'Richard Lamboj'
__copyright__ = 'Copyright 2016, Unicom'
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


status_hanlder = None

try:
    try:
        settings = settings_factory(get_settings_config_path('pi_ws_settings.path'))
    except IOError as e:
        if e.errno == 2:
            print >>sys.stderr, "[SettingsPath] File not found: %s" % e.filename
            sys.exit(1)
    plugins = get_ph_plugins()
    log_plugins = get_log_plugins()
    try:
        log_targets = log_list_factory(settings.log_list, log_plugins)
    except IOError as e:
        if e.errno == 2:
            print >>sys.stderr, "[LogList] File not found: %s" % e.filename
            #sys.exit(1)
    #log = Log(log_targets)
    log = Log([])
    try:
        connection_list = connection_list_factory(settings.connection_list, plugins, log, status_hanlder)
    except IOError as e:
        if e.errno == 2:
            print >>sys.stderr, "[ConnectionList] File not found: %s" % e.filename
            #sys.exit(1)
    try:
        installed_list = installed_list_factory(settings.installed_list, log)
    except IOError as e:
        if e.errno == 2:
            print >>sys.stderr, "[InstalledList] File not found: %s" % e.filename
            #sys.exit(1)
    try:
        package_list = package_list_factory(settings.package_list, connection_list, installed_list, log, status_hanlder)
    except IOError as e:
        if e.errno == 2:
            print >>sys.stderr, "[PackageList] File not found: %s" % e.filename
            #sys.exit(1)
    try:
        package_lists = package_lists_factory(settings.package_lists, connection_list, installed_list, log, status_hanlder)
    except IOError as e:
        if e.errno == 2:
            print >>sys.stderr, "[PackageList] File not found: %s" % e.filename
            #sys.exit(1)
    if settings.target_source == 'install_list':
        try:
            install_list = install_list_factory(settings.install_list, connection_list, log)
        except IOError as e:
            if e.errno == 2:
                print >>sys.stderr, "[InstallList] File not found: %s" % e.filename
                #sys.exit(1)
    else:
        try:
            host_list = host_list_factory(settings.host_list, log)
        except IOError as e:
            if e.errno == 2:
                print >>sys.stderr, "[HostList] File not found: %s" % e.filename
                #sys.exit(1)
except Exception as e:
    print "Please send this Error-report to support@unicom.ws. Error: %s" % e
    traceback.print_exc()
    sys.exit(1)


for package in package_list:
    print package
