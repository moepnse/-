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
import os
import sys
import platform
import traceback

# third party imports
import cherrypy

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


class WS:
    _template_search = u'<form action="/search" method="post"><label>Search-String:</label><input type="text" name="search_string"><button type="submit">Search</button></form>'
    _template_index = u"""
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <title>Packages</title>
        <meta name="keywords" content="Package Search">
        <meta name="robots" content="index, follow" />
        <meta name="author" content="Richard Lamboj" />
        <!-- HTML 4.x -->
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <!-- <link rel="stylesheet" type="text/css" href="/style.css"> -->
    </head>
    <body>
        %(search)s
        %%(html)s
    </body>
</html>
    """ % {"search": _template_search}
    _template_list_entry_package = u"<div><a href='/package/%s'>%s</a></div>"

    def __init__(self):
        if not os.path.exists("tmp"):
            os.makedirs("tmp")

    @cherrypy.expose
    def index(self, **kwargs):
        html = u""
        for package in package_list:
            html += self._template_list_entry_package % (package, package)

        html = self._template_index % {'html': html}
        return  html

    @cherrypy.expose
    def package(self, package_id=""):
        if package_id in package_list:
            package = package_list[package_id]
            html = u"id: %(id)s name: %(name)s description: %(description)s install cmds: %(install_cmds)s uninstall cmds: %(uninstall_cmds)s upgrade cmds: %(upgrade_cmds)s" % {
                "id": package.package_id,
                "name": package.name,
                "keywords": package.keywords,
                "install_cmds": package.install_cmds,
                "uninstall_cmds": package.uninstall_cmds,
                "upgrade_cmds": package.upgrade_cmds,
                "description": package.description
            }
        else:
            html = u"Nothing found!"
        return self._template_index % {'html': html}

    @cherrypy.expose
    def search(self, search_string=""):
        html = u""
        for package_id in package_list:
            if package_id.find(search_string) != -1:
                html += self._template_list_entry_package % (package_id, package_id)
            else:
                package = package_list[package_id]
                for keyword in package.keywords:
                    if keyword.find(search_string) != -1:
                        html += self._template_list_entry_package % (package_id, package_id)
                        break
        html = self._template_index % {'html': html}
        return  html


if __name__ == '__main__':
    if not os.path.exists("sessions"):
        os.makedirs("sessions")

    cherrypy.config.update({'server.socket_port': 8080,
                        'server.socket_host': '127.0.0.1',
                        'engine.autoreload_on': False,
                        'log.access_file': './access.log',
                        'log.error_file': './error.log'})
    conf = {
        '/': {
            #'request.dispatch': cherrypy.dispatch.MethodDispatcher(),
            'tools.sessions.on': True,
            'tools.sessions.storage_type': 'file',
            'tools.sessions.storage_path': os.path.join(os.path.abspath(os.getcwd()), 'sessions'),
            'tools.staticdir.root': os.path.abspath(os.getcwd()),
            'tools.encode.on': True,
            'tools.encode.encoding"': "utf-8"
        }
    }
    cherrypy.quickstart(WS(), '/', conf)