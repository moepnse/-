# -*- coding: utf-8 -*-

# standard library imports
import os
import sys
import re
import copy
import urllib
import distutils.util
import xml.dom
import xml.dom.minidom

# third party imports


# application/library imports
import libs.handlers.config
import libs
from libs.win import software
from libs.win import system
from libs.win.file_info import FileInfo

# application/library cimports
from libs.common cimport un_camel


OR = 'or'
AND = 'and'


file_extension = "xml"
plugin_name = "xml_md"

api_versions = ["1.0"]
flags = {1.0: 100}

"""
target source: install_list
╒══════════════╕ ╒══════════════╕
│ install_list ├─┤ package_list │
╘══════════════╛ ╘══════════════╛

target_source: host_list
╒══════════════╕ ╒══════════════╕ ╒══════════════╕
│ host_list    ├─┤ profile_list ├─┤ package_list │
╘══════════════╛ ╘══════════════╛ ╘══════════════╛
"""


def replace_variables(text, variables, var_start_char='$', var_end_char='$'):
    pos = 0
    var_start_pos = 0
    var_end_pos = 0
    found_var_start_char = False
    text_lenght = len(text)
    variable_name = ''
    char = ''
    last_char = ''
    while pos < text_lenght:
        last_char = char
        char = text[pos:pos+1]
        if last_char == '\\' and char in (var_start_char, var_end_char):
            text = text[:pos-1] + text[pos:]
            text_lenght = len(text)
            continue

        if char == var_start_char and found_var_start_char == False:
            var_start_pos = pos
            found_var_start_char = True
            pos += 1
            continue

        if found_var_start_char:
            if char == var_end_char:
                var_end_pos = pos + 1
                if variable_name in variables:
                    variable_value = variables[variable_name]
                    text = text[:var_start_pos] + variable_value + text[var_end_pos:]
                    pos = var_start_pos + len(variable_value)
                    text_lenght = len(text)
                pos += 1
                variable_name = ''
                found_var_start_char = False
                continue
            variable_name += char
        pos += 1
    return text

def get_absolute_config_path(settings_path, path):
    # is path absolute?
    m = re.match(r"[a-zA-Z]{1,1}:\\", path)
    # is path a url?
    m2 = re.match(r"[a-zA-Z]+://", path)
    if m is None and m2 is None:
        path = os.path.join(os.path.dirname(os.path.abspath(settings_path)), path)
    return path


class LogList(libs.handlers.config.LogList):

    def __init__(self, log_handler_list_path, protocol_plugins):
        libs.handlers.config.LogList.__init__(self, log_handler_list_path, protocol_plugins)
        print "LOG_HANDLER_PATH", log_handler_list_path
        self._xmldoc = xml.dom.minidom.parse(log_handler_list_path)
        for node in self._xmldoc.childNodes:
            if node.nodeType == node.ELEMENT_NODE:
                if node.tagName == "logs":
                    self._handle_logs(node)

    def _handle_logs(self, logs_node):
        for node in logs_node.childNodes:
            if node.nodeType == node.ELEMENT_NODE and node.tagName == 'log':
                if node.hasAttribute('protocol'):
                    protocol = node.getAttribute('protocol')
                else:
                    print >>sys.stderr, "Ignoring Log Handler: %s. Protocol attribute not found!" % node
                    continue
                kwargs = {}
                """
                if node.hasAttribute('url'):
                    kwargs['url'] = node.getAttribute('url')
                if node.hasAttribute('url_info'):
                    kwargs['url_info'] = node.getAttribute('url_info')
                if node.hasAttribute('url_warn'):
                    kwargs['url_warn'] = node.getAttribute('url_warn')
                if node.hasAttribute('url_err'):
                    kwargs['url_err'] = node.getAttribute('url_err')
                if node.hasAttribute('url_debug'):
                    kwargs['url_debug'] = node.getAttribute('url_debug')

                if node.hasAttribute('username'):
                    kwargs['username'] = node.getAttribute('username')
                if node.hasAttribute('password'):
                    kwargs['password'] = node.getAttribute('password')
                """
                if node.attributes:
                    for i in range(node.attributes.length):
                        attr = node.attributes.item(i)
                        kwargs[attr.name] = attr.value
                log_target_handler = self.protocol_plugins[protocol](**kwargs)

                self._logs.append(log_target_handler)

        self._max = len(self._logs)

    def next(self):
        return self._logs.next()

    def __iter__(self):
        return self._logs.__iter__()

    def __len__(self):
        return self._logs.__len__()

    def __getitem__(self, key):
        return self._logs[key]


class _Host(object):

    def __init__(self, regex, host_node):
        self._regex = re.compile(regex)
        self._host_node = host_node
        self._packages = self.get_packages()

    def __eq__(self, value):
        if value is None:
            return False
        return self._regex.match(value)

    def next(self):
        return self._packages.next()

    def __iter__(self):
        return self._packages.__iter__()

    def __len__(self):
        return self._packages.__len__()

    def __getitem__(self, key):
        return self._packages[key]

    def get_packages(self, actions=['install', 'upgrade', 'uninstall']):
        packages = []
        for node in self._host_node.childNodes:
            if node.nodeType == node.ELEMENT_NODE:
                if node.tagName == 'package' and node.hasAttribute('package_id'):
                    package_id = node.getAttribute('package_id')
                    if node.hasAttribute('action'):
                        action = node.getAttribute('action')
                    else:
                        action = 'install'
                    if action in actions:
                        packages.append({'action': action, 'package_id': package_id})
        return packages

    def get_profiles(self):
        profiles = []
        for node in self._host_node.childNodes:
            if node.nodeType == node.ELEMENT_NODE:
                if node.tagName == 'profile':
                    profile_id = node.getAttribute('profile_id')
                    if node.hasAttribute('action'):
                        action = node.getAttribute('action')
                    else:
                        action = 'install'
                    profiles.append({'action': action, 'profile_id': profile_id})
        return profiles


class HostList(libs.handlers.config.HostList):

    def __init__(self, host_list_path, log):
        libs.handlers.config.HostList.__init__(self, host_list_path, log)
        self._xmldoc = xml.dom.minidom.parse(host_list_path)
        self._hosts = {}
        for node in self._xmldoc.childNodes:
            if node.nodeType == node.ELEMENT_NODE:
                if node.tagName == 'hosts':
                    self._handle_hosts(node)

    def _handle_hosts(self, hosts_node):
        ip = None
        hostname = None
        for node in hosts_node.childNodes:
            if node.nodeType == node.ELEMENT_NODE and node.tagName == 'host':
                if node.hasAttribute('name'):
                    hostname = node.getAttribute('name')
                if node.hasAttribute('ip'):
                    ip = node.getAttribute('ip')
                if hostname is not None:
                    self._hosts[hostname] = _Host(hostname, node)
        self._max = len(self._hosts)

    def next(self):
        return self._hosts.next()

    def __iter__(self):
        return self._hosts.__iter__()

    def __len__(self):
        return self._hosts.__len__()

    def __getitem__(self, key):
        return self._hosts[key]


class ConnectionList(libs.handlers.config.ConnectionList):

    def __init__(self, connection_list_path, protocol_plugins, log, status_handler):
        libs.handlers.config.ConnectionList.__init__(self, connection_list_path, protocol_plugins, log, status_handler)
        self._xmldoc = xml.dom.minidom.parse(connection_list_path)
        for node in self._xmldoc.childNodes:
            #if isinstance(node, xml.dom.minidom.Element):
            if node.nodeType == node.ELEMENT_NODE:
                if node.tagName == 'connections':
                    self._handle_connections(node)

    def _handle_connections(self, connections_node):
        log_targets = ['log_info', 'log_err', 'log_warn', 'log_debug']
        for node in connections_node.childNodes:
            if node.nodeType == node.ELEMENT_NODE and node.tagName == 'connection':
                kwargs = {}
                for log_target in log_targets:
                    if node.hasAttribute(log_target):
                        kwargs[log_target] = distutils.util.strtobool(node.getAttribute(log_target))
                """
                if node.hasAttribute('log_info'):
                    kwargs['log_info'] = distutils.util.strtobool(node.getAttribute('log_info'))
                if node.hasAttribute('log_err'):
                    kwargs['log_err'] = distutils.util.strtobool(node.getAttribute('log_err'))
                if node.hasAttribute('log_warn'):
                    kwargs['log_warn'] = distutils.util.strtobool(node.getAttribute('log_warn'))
                if node.hasAttribute('log_debug'):
                    kwargs['log_err'] = distutils.util.strtobool(node.getAttribute('log_debug'))
                """
                if node.hasAttribute('protocol'):
                    protocol = node.getAttribute('protocol')
                else:
                    self._log.log_err(u"[xml_md] [%d] %s: Ignoring Connection '%s'. Protocol attribute not found!" % (libs.common.get_current_line_nr(), plugin_name, node))
                    continue
                if node.hasAttribute('url'):
                    url = node.getAttribute('url')
                else:
                    self._log.log_err(u"[xml_md] [%d]  %s: Ignoring Connection '%'. URL attribute not found!" % (libs.common.get_current_line_nr(), plugin_name, node))
                    continue
                username = node.getAttribute('username') if node.hasAttribute('username') else None
                password = node.getAttribute('password') if node.hasAttribute('password') else None
                if protocol in self.protocol_plugins:
                    protocol_handler = self.protocol_plugins[protocol](self._log, url, username, password, **kwargs)
                    self._connections[url] = {'protocol': protocol, 'protocol_handler': protocol_handler, 'username': username, 'password': password}
                else:
                    self._log.log_err('No Plugin available to handle %s' % protocol)
        self._max = len(self._connections)

    def next(self):
        return self._connections.next()

    def keys(self):
        return self._connections.keys()

    def items(self):
        return self._connections.items()

    def values(self):
        return self._connections.values()

    def __iter__(self):
        return self._connections.__iter__()

    def __len__(self):
        return self._connections.__len__()

    def __getitem__(self, key):
        return self._connections[key]


class Settings(libs.handlers.config.Settings):

    def __init__(self, settings_path):

        libs.handlers.config.Settings.__init__(self, settings_path)
        print >>sys.stdout, "settings path:", settings_path
        self._xmldoc = xml.dom.minidom.parse(self._settings_path)

        for node in self._xmldoc.firstChild.childNodes:
            if node.nodeType == node.ELEMENT_NODE:
                if node.tagName == "install_list":
                    if node.hasAttribute('path'):
                        self._install_list = get_absolute_config_path(self._settings_path, node.getAttribute('path'))
                        self._install_list_node = node

                elif node.tagName == "installed_list":
                    if node.hasAttribute('path'):
                        self._installed_list = get_absolute_config_path(self._settings_path, node.getAttribute('path'))
                        self._installed_list_node = node

                elif node.tagName == "package_list":
                    if node.hasAttribute('path'):
                        self._package_list = get_absolute_config_path(self._settings_path, node.getAttribute('path'))
                        self._package_list_node = node

                elif node.tagName == "connection_list":
                    if node.hasAttribute('path'):
                        self._connection_list = get_absolute_config_path(self._settings_path, node.getAttribute('path'))
                        self._connection_list_node = node

                elif node.tagName == "log_list":
                    if node.hasAttribute('path'):
                        self._log_list = get_absolute_config_path(self._settings_path, node.getAttribute('path'))
                        self._log_list_node = node

                elif node.tagName == "host_list":
                    if node.hasAttribute('path'):
                        self._host_list = get_absolute_config_path(self._settings_path, node.getAttribute('path'))
                        self._host_list_node = node

                elif node.tagName == "profile_list":
                    if node.hasAttribute('path'):
                        self._profile_list = get_absolute_config_path(self._settings_path, node.getAttribute('path'))
                        self._profile_list_node = node

                elif node.tagName == "target_source":
                    if node.hasAttribute('src'):
                        self._target_source = node.getAttribute('src')
                        self._target_source_node = node

                elif node.tagName == "status_gui":
                    if node.hasAttribute('cmd'):
                        self._status_gui_cmd = node.getAttribute('cmd')
                        self._status_gui_node = node

    def save(self):

        self._package_list_node.setAttribute('path', self._package_list)
        self._profile_list_node.setAttribute('path', self._profile_list)
        self._installed_list_node.setAttribute('path', self._installed_list)
        self._install_list_node.setAttribute('path', self._install_list)
        self._connection_list_node.setAttribute('path', self._connection_list)
        self._log_list_node.setAttribute('path', self._log_list)
        self._target_source_node.setAttribute('src', self._target_source)
        self._status_node.setAttribute('cmd', self._status_gui)

        #if self._package_list_node.firstChild.nodeType == self._package_list_node.TEXT_NODE:
        #    self._package_list_node.firstChild.data = self._package_list

        #if self._install_list_node.firstChild.nodeType == self._install_list_node.TEXT_NODE:
        #    self._install_list_node.firstChild.data = self._install_list

        fh = file(self._xml_path, 'w')
        self._xmldoc.writexml(fh, indent="\t")
        fh.close()


class InstalledList(libs.handlers.config.InstalledList):

    def __init__(self, installed_list_path, log):
        libs.handlers.config.InstalledList.__init__(self, installed_list_path, log)
        self._xmldoc = xml.dom.minidom.parse(self._installed_list_path)
        self._node_installed_list = self._xmldoc.firstChild
        self._update()

    def __iter__(self):
        self._update()
        return self

    def __len__(self):
        return len(self._package_ids)

    def next(self):
        if self._index >= self._max:
            raise StopIteration
        ret_val = self._package_ids[self._index]
        self._index += 1
        return ret_val

    def _update(self):
        self._index = 0
        self._package_ids = []
        for node in self._node_installed_list.childNodes:
            if node.nodeType == node.ELEMENT_NODE:
                if node.hasAttribute('package_id'):
                    self._package_ids.append(node.getAttribute('package_id'))
        self._max = len(self._package_ids)

    def remove(self, package_id):
        if package_id in self._package_ids:
            #self._package_ids.remove(package_id)
            element = self._xmldoc.getElementById(package_id)
            for node in self._node_installed_list.childNodes:
                if node.nodeType == node.ELEMENT_NODE:
                    if node.getAttribute('package_id') == package_id:
                        self._node_installed_list.removeChild(node)
                        return True
        return False

    def append(self, package_id, version, rev):
        if not package_id in self._package_ids:
            self._package_ids.append(package_id)
            package = self._xmldoc.createElement('package')
            package.setAttribute('package_id', package_id)
            package.setAttribute('version', version)
            package.setAttribute('rev', rev)
            self._node_installed_list.appendChild(package)

    def update(self, package_id, version, rev):
        if package_id in self._package_ids:
            element = self._xmldoc.getElementById(package_id)
            for node in self._node_installed_list.childNodes:
                if node.nodeType == node.ELEMENT_NODE:
                    if node.getAttribute('package_id') == package_id:
                        node.setAttribute('package_id', package_id)
                        node.setAttribute('version', version)
                        node.setAttribute('rev', rev)
                        return True
        return False

    def save(self):
        fh = file(self._installed_list_path, 'w')
        self._xmldoc.writexml(fh, indent="\t")
        fh.close()

    def __exit__(self, type, value, traceback):
        self.save()


class InstallList(libs.handlers.config.InstallList):

    def __init__(self, install_list_path, connection_list, log):
        libs.handlers.config.InstallList.__init__(self, install_list_path, connection_list, log)

        self._index = -1
        self._package_ids = []

        self._xmldoc = xml.dom.minidom.parse(self._install_list_path)

        self._node_install_list = self._xmldoc.firstChild

    def __iter__(self):
        for node in self._node_install_list.childNodes:
            #if isinstance(node, xml.dom.minidom.Element):
            if node.nodeType == node.ELEMENT_NODE:
                if node.hasAttribute('package_id'):
                    self._package_ids.append(node.getAttribute('package_id'))

        self._max = len(self._package_ids) -1
        self._index = -1
        return self

    def __len__(self):
        return self._max +1

    """
    def __reset__(self):
        self._index = -1
    """

    def next(self):
        self._index = self._index + 1
        if self._index > self._max:
            raise StopIteration
        return self._package_ids[self._index]

    def remove(self, package_id):
        if package_id in self._package_ids:
            self._package_ids.remove(package_id)
            element = self._xmldoc.getElementById(package_id)
            for node in self._node_install_list.childNodes:
                if node.nodeType == node.ELEMENT_NODE:
                    if node.getAttribute('package_id') == package_id:
                        self._node_install_list.removeChild(node)
                        return True
        return False

    def append(self, package_id):
        if not package_id in self._package_ids:
            self._package_ids.append(package_id)
            package = self._xmldoc.createElement('package')
            package.setAttribute('package_id', package_id)
            self._node_install_list.appendChild(package)

    def save(self):
        fh = file(self._install_list_path, 'w')
        self._xmldoc.writexml(fh, indent="\t")
        fh.close()


class XMLNode(object):

    def __init__(self, connection_handlers, log):
        self._log = log
        self._warn_unknown_tags = False
        self._connection_handlers = connection_handlers

    def _get_attribute(self, node, attribute, default_value=''):
        return node.getAttribute(attribute) if node.hasAttribute(attribute) else default_value

    def _get_child_nodes(self, node, tag_name=None, node_type=xml.dom.Node.ELEMENT_NODE):
        for child_node in node.childNodes:
            if child_node.nodeType == node_type or tag_name is None:
                if child_node.tagName == tag_name:
                    yield child_node
                else:
                    if self._warn_unknown_tags:
                        self._log.log_warn(u"[xml_md] [%d] unknown tag: %s" % (libs.common.get_current_line_nr(), child_node.tagName))
            else:
                if self._warn_unknown_tags:
                    self._log.log_warn(u"[xml_md] [%d] unknown node type: %s" % (libs.common.get_current_line_nr(), child_node.nodeType))


class IFStatement(XMLNode):
    # default condition

    def __init__(self, if_node, variables, connection_handlers, log):

        XMLNode.__init__(self, connection_handlers, log)
        self._debug_condition = False
        self._conditions = []
        self._condition = AND
        self.cmds = []
        self.condition_is = False
        self._log = log
        self._child_nodes = []

        if if_node.nodeType != if_node.ELEMENT_NODE:
            pass
        if if_node.tagName != "if":
            pass

        if if_node.hasAttribute('condition'):
            self.condition = if_node.getAttribute('condition')

        for node in if_node.childNodes:

            # default condition values
            regex = False
            regex_pattern = None
            regex_group = 0
            condition = "=="
            reverse_condition = False
            condition_return_val = False

            if node.nodeType == node.ELEMENT_NODE:
                if node.tagName == "check":
                    # If not
                    if node.hasAttribute('not'):
                        reverse_condition = True

                    # RegEx
                    if node.hasAttribute('regex'):
                        regex = True
                    if node.hasAttribute('regex_pattern'):
                        regex_pattern = node.getAttribute('regex_pattern')
                    if node.hasAttribute('regex_group'):
                        regex_group = int(node.getAttribute('regex_group'))

                    # Types
                    if node.hasAttribute('type'):
                        type = node.getAttribute('type')

                        if node.hasAttribute('condition'):
                            condition = node.getAttribute('condition')
                        if type == "file":
                            for entry in (u"Comments", u"InternalName",	u"ProductName", u"CompanyName", u"LegalCopyright", u"ProductVersion", "FileDescription", u"LegalTrademarks", u"PrivateBuild", u"FileVersion", u"OriginalFilename", u"SpecialBuild"):
                                u_c_entry = un_camel(entry)
                                if node.hasAttribute(u_c_entry):
                                    value = node.getAttribute(u_c_entry)

                                    path = node.getAttribute('path')
                                    if os.path.isfile(path):
                                        file_info = FileInfo(path)
                                        fi_value = file_info[entry]

                                        condition_return_val = self._check(fi_value, value, condition, reverse_condition)

                                        self._conditions.append(condition_return_val)

                        elif type == "file_exists":
                            if node.hasAttribute('path'):
                                path = node.getAttribute('path')
                                if os.path.isfile(path):
                                    self._conditions.append(True)
                                else:
                                    self._conditions.append(False)
                        elif type == "arch":
                            if node.hasAttribute("value"):
                                value = node.getAttribute("value")

                                arch = libs.win.system.get_arch()

                                if condition == "==":
                                    if arch == value:
                                        condition_value = True
                                    else:
                                        condition_value = False
                                elif condition == "!=":
                                    if arch != value:
                                        condition_value = True
                                    else:
                                        condition_value = False

                                if reverse_condition == True:
                                    condition_value = {True: False, False: True}[condition_value]

                                self._conditions.append(condition_value)

                        elif type == "uninstall":
                            if node.hasAttribute('entry'):

                                product_name = node.getAttribute('value')

                                entry = node.getAttribute('entry')

                                if libs.win.software.is_installed(entry):
                                    if condition == "==":
                                        condition_value = True
                                    elif condition == "!=":
                                        condition_value = False

                                if reverse_condition == True:
                                    condition_value = {True: False, False: True}[condition_value]

                                self._conditions.append(condition_value)

                        elif type == "uninstall_list":
                            if node.hasAttribute('value'):

                                product_name = node.getAttribute('value')

                                for product in libs.win.software.SoftwareList().values():
                                    reg_product_name = product.product_name
                                    self._log.log_debug('[xml_md] [%d] product_name: %s' % (libs.common.get_current_line_nr(), reg_product_name))
                                    if reg_product_name.strip() == "":
                                        self._log.log_warn('[xml_md] [%d] Found an empty Entry in the Software-List!'  % libs.common.get_current_line_nr())
                                        continue
                                    condition_return_val = self._check(reg_product_name, product_name, condition, reverse_condition)
                                    self._log.log_debug('[xml_md] [%d] return value: %s' % (libs.common.get_current_line_nr(), condition_return_val))
                                    if condition_return_val:
                                        break
                                self._conditions.append(condition_return_val)

                elif node.tagName == "then":
                    self._child_nodes += node.childNodes
                    """
                    for then_child_node in node.childNodes:
                        if then_child_node.nodeType == then_child_node.ELEMENT_NODE:
                            if then_child_node.tagName == 'cmd':
                                cmd = Cmd(then_child_node, variables, connection_handlers, log)
                                self.cmds.append(cmd.cmd)
                            elif then_child_node.tagName == "if":
                                if_statement = IFStatement(then_child_node, variables, connection_handlers, self._log)
                                if if_statement.condition_is == True:
                                    self._child_nodes += if_statement.child_nodes
                                    self.cmds.extend(if_statement.cmds)
                    """
        if self.condition == AND:
            if False in self._conditions:
                self.condition_is = False
            else: 
                self.condition_is = True
        elif self.condition == OR:
            if True in self._conditions:
                self.condition_is = True
            else:
                self.condition_is = False

    def _get_ret_codes(self, node, code_type):
        ret_codes = {}
        for node in self._get_child_nodes(node, code_type):
            ret_codes = self._get_ret_codes_list(node, ret_codes)
        return ret_codes

    def _get_ret_codes_list(self, node, ret_codes):
        for code_node in self._get_child_nodes(node, 'code'):
            name = self._get_attribute(code_node, 'name')
            nr = int(self._get_attribute(code_node, 'nr'))
            ret_codes[nr] = {'nr': nr, 'name': name , 'value': code_node.firstChild.data}
        return ret_codes

    def _check(self, value1, value2, condition, reverse_condition=False):

        if self._debug_condition:
            self._log.log_debug(u"[xml_md] [%d] condition: %s(%s) %s %s(%s), reverse_condition: %s" % (libs.common.get_current_line_nr(), value1, type(value1), condition, value2, type(value2), reverse_condition))

        condition_return_val = False

        if condition == "==" or condition == "equal":
            text = u"if \"%s\" == \"%s\"" % (value1, value2)
            if  value1 == value2:
                condition_return_val = True
            else:
                condition_return_val = False
        elif condition == "!=" or condition == "not-equal":
            text = u"if \"%s\" != \"%s\"" % (value1, value2)
            if  value1 != value2:
                condition_return_val = True
            else:
                condition_return_val = False
        elif condition == ">" or condition == "greater-than":
            value1 = value1.replace(".", "")
            value1 = value1.replace("-", "")

            value2 = value2.replace(".", "")
            value2 = value2.replace("-", "")

            text = "if %s > %s" % (value1, value2)

            if  int(value1) > int(value2):
                condition_return_val = True
            else:
                condition_return_val = False
        elif condition == "<" or condition == "less-than":

            value1 = value1.replace(".", "")
            value1 = value1.replace("-", "")

            value2 = value2.replace(".", "")
            value2 = value2.replace("-", "")

            text = "if %s < %s" % (value1, value2)

            if  int(value1) < int(value2):
                condition_return_val = True
            else:
                condition_return_val = False
        elif condition == ">=":

            value1 = value1.replace(".", "")
            value1 = value1.replace("-", "")

            value2 = value2.replace(".", "")
            value2 = value2.replace("-", "")

            text = "if %s >= %s" % (value1, value2)

            if  int(value1) >= int(value2):
                condition_return_val = True
            else:
                condition_return_val = False
        elif condition == "<=":

            value1 = value1.replace(".", "")
            value1 = value1.replace("-", "")

            value2 = value2.replace(".", "")
            value2 = value2.replace("-", "")

            text = "if %s <= %s" % (value1, value2)

            if  int(value1) <= int(value2):
                condition_return_val = True
            else:
                condition_return_val = False
        elif condition == "regex":

            text = u"regex"
            self._log.log_debug(u"[xml_md] [%d] regex: %s %s" % (libs.common.get_current_line_nr(), value2, value1))
            result = re.match(value2, value1)
            self._log.log_debug(u"[xml_md] [%d] regex: %s" % (libs.common.get_current_line_nr(), result))
            if result is None:
                condition_return_val = False
            else:
                condition_return_val = True
        elif condition == "startswith":

            text = u"if \"%s\" startswith \"%s\"" % (value1, value2)

            if value1.startswith(value2):
                condition_return_val = True
            else:
                condition_return_val = False
        elif condition == "endswith":

            text = u"if \"%s\" endswith \"%s\"" % (value1, value2)

            if value1.endswith(value2):
                condition_return_val = True
            else:
                condition_return_val = False
        else:
            text = u"Unknown Condition!"

        #print >>sys.stdout, text, condition_return_val
        if reverse_condition == True:
            condition_return_val = {True: False, False: True}[condition_return_val]

        return condition_return_val

    @property
    def child_nodes(self):
        return self._child_nodes


class CmdPattern(XMLNode):

    def __init__(self, cmd_node, variables, connection_handlers, log, status_handler):

        XMLNode.__init__(self, connection_handlers, log)

        self._success_codes = {}
        self._error_codes = {}
        self._parameters = []
        self._variables = variables
        self._cmd_node = cmd_node
        self._path = ''
        self._cmd_id = ''
        self._id = self._get_attribute(cmd_node, 'id')
        self._md5sum = ''
        self._hash = ''
        self._algorithm = ''
        self._status_handler = status_handler
        if self._cmd_node.hasAttribute('path'):
            self._path = replace_variables(self._cmd_node.getAttribute('path'), self._variables)
            self._path = replace_variables(self._path, os.environ, var_start_char='%', var_end_char='%')
            self._get_parameters()
            self._get_ret_codes()
        for attr in ("md5", "md5sum"):
            if self._cmd_node.hasAttribute(attr):
                self._md5sum = self._cmd_node.getAttribute(attr)
        if self._cmd_node.hasAttribute('hash'):
            self._hash = self._cmd_node.getAttribute('hash')
        if self._cmd_node.hasAttribute('hash_algorithm'):
            self._hash_algorithm = self._cmd_node.getAttribute('hash_algorithm')
        self._mapping = {   'success_codes': self._success_codes,
                            'error_codes': self._error_codes,
                            'parameters': self._parameters,
                            'path': self._path
                        }

        self._log.log_debug('[xml_md] [%d] %s' % (libs.common.get_current_line_nr(), self._mapping))

    def _get_parameters(self):
        for args_child_node in self._get_child_nodes(self._cmd_node, 'args'):
            for parameter_node in self._get_child_nodes(args_child_node, 'parameter'):
                parameter_name = replace_variables(self._get_attribute(parameter_node, 'name'), self._variables)
                values = []
                for value in self._get_child_nodes(parameter_node, 'value'):
                    allow_connection_handler = distutils.util.strtobool(self._get_attribute(value, 'allow_connection_handler', 'false'))
                    values.append({'value': replace_variables(value.firstChild.data, self._variables), 'allow_connection_handler': allow_connection_handler})
                self._parameters.append({'argument': parameter_name, 'values': values})

    def _get_ret_codes(self):
        for ret_codes_child_node in self._get_child_nodes(self._cmd_node, 'ret_codes'):
            self._get_ret_codes_by_type(ret_codes_child_node, 'success', self._success_codes)
            self._get_ret_codes_by_type(ret_codes_child_node, 'error', self._error_codes)
        self._log.log_debug(u"[xml_md] [%d] %s - Success Codes: %s" % (libs.common.get_current_line_nr(), self._path, self._success_codes))
        self._log.log_debug(u"[xml_md] [%d] %s - Error Codes: %s" % (libs.common.get_current_line_nr(), self._path, self._error_codes))    

    def _get_ret_codes_by_type(self, node, code_type, ret_codes):
        for node in self._get_child_nodes(node, code_type):
            self._get_ret_codes_list(node, ret_codes)

    def _get_ret_codes_list(self, node, ret_codes):
        for code_node in self._get_child_nodes(node, 'code'):
            name = self._get_attribute(code_node, 'name')
            nr = int(self._get_attribute(code_node, 'nr'))
            ret_codes[nr] = {'nr': nr, 'name': name , 'value': code_node.firstChild.data}

    def __getitem__(self, key):
        return self._mapping[key]

    def __iter__(self):
        self._mapping

    def keys(self):
        return self._mapping.keys()

    def items(self):
        return self._mapping.items()

    def values(self):
        return self._mapping.values()

    @property
    def paramters(self):
        return self._parameters

    @paramters.setter
    def paramters(self, value):
        self._parameters = value

    @property
    def success_codes(self):
        return self._success_codes

    @property
    def error_codes(self):
        return self._error_codes

    @property
    def cmd_id(self):
        return self._cmd_id

    @cmd_id.setter
    def cmd_id(self, value):
        self._cmd_id = value

    @property
    def id(self):
        return self._id

    @property
    def path(self):
        return self._path

    @property
    def parameters(self):
        return self._parameters

    @property
    def cmd(self):
        self._cmd = libs.handlers.config.Cmd(self._path, self._parameters, self._md5m, self._hash, self._hash_algorithm, self._connection_handlers, self._success_codes, self._error_codes, self._status_handler)
        return self._cmd


#class Cmd(libs.handlers.config.Cmd, XMLNode):
class Cmd(XMLNode):

    def __init__(self, cmd_node, variables, connection_handlers, log, stauts_handler, path='', parameters=[], success_codes={}, error_codes={}):
        #libs.handlers.config.__init__(self, path, parameters, "", connection_handlers, success_codes, error_codes)
        XMLNode.__init__(self, connection_handlers, log)

        self._success_codes = copy.deepcopy(success_codes)
        self._error_codes = copy.deepcopy(error_codes)
        self._parameters = copy.deepcopy(parameters)
        self._variables = variables
        self._cmd_node = cmd_node
        self._path = path
        self._cmd_id = ''
        self._md5sum = ''
        self._hash = ''
        self._algorithm = ''
        self._id = self._get_attribute(cmd_node, 'id')
        self._log.log_debug('[xml_md] [%d] inherited - path: %s, parameters: %s, success_codes: %s, error_codes: %s, variables: %s' % (libs.common.get_current_line_nr(), path, parameters, success_codes, error_codes, variables))
        if self._cmd_node.hasAttribute('path') or self._cmd_node.hasAttribute('cmd_id'):
            if self._cmd_node.hasAttribute('path'):
                self._path = replace_variables(self._cmd_node.getAttribute('path'), self._variables)
                self._path = replace_variables(self._path, os.environ, var_start_char='%', var_end_char='%')
            if self._cmd_node.hasAttribute('cmd_id'):
                self._cmd_id = self._cmd_node.getAttribute('cmd_id')
            for attr in ("md5", "md5sum"):
                if self._cmd_node.hasAttribute(attr):
                    self._md5sum = self._cmd_node.getAttribute(attr)
            if self._cmd_node.hasAttribute('hash'):
                self._hash = self._cmd_node.getAttribute('hash')
            if self._cmd_node.hasAttribute('hash_algorithm'):
                self._hash_algorithm = self._cmd_node.getAttribute('hash_algorithm')
            for args_child_node in self._get_child_nodes(self._cmd_node, 'args'):
                for parameter_node in self._get_child_nodes(args_child_node, 'parameter'):
                    parameter_name = replace_variables(self._get_attribute(parameter_node, 'name'), self._variables)
                    values = []
                    for value in self._get_child_nodes(parameter_node, 'value'):
                        allow_connection_handler = distutils.util.strtobool(self._get_attribute(value, 'allow_connection_handler', 'false'))
                        values.append({'value': replace_variables(value.firstChild.data, self._variables), 'allow_connection_handler': allow_connection_handler})
                    self._parameters.append({'argument': parameter_name, 'values': values})
            self._get_ret_codes()
        elif self._cmd_node.hasAttribute('execute'):
            cmd_execute = replace_variables(self._cmd_node.getAttribute('execute'), self._variables)
            self._get_ret_codes()
            args = libs.win.commandline.parse(cmd_execute)
            self._path = args[0]
            args = args [1:]
            parameter_name = ''
            values = []
            for arg in args:
                if arg.startswith('/'):
                    parameter = {'argument': parameter_name, 'values': values}
                    self._parameters.append(parameter)
                    parameter_name = ''
                    values = []
                    parameter_name = arg
                    continue
                values.append({'value': arg, 'allow_connection_handler': False})
            parameter = {'argument': parameter_name, 'values': values}
            self._parameters.append(parameter)

    def _get_ret_codes(self):
        for ret_codes_child_node in self._get_child_nodes(self._cmd_node, 'ret_codes'):
            self._get_ret_codes_by_type(ret_codes_child_node, 'success', self._success_codes)
            self._get_ret_codes_by_type(ret_codes_child_node, 'error', self._error_codes)
        self._log.log_debug(u"[xml_md] [%d] %s - Success Codes: %s" % (libs.common.get_current_line_nr(), self._path, self._success_codes))
        self._log.log_debug(u"[xml_md] [%d] %s - Error Codes: %s" % (libs.common.get_current_line_nr(), self._path, self._error_codes))    

    def _get_ret_codes_by_type(self, node, code_type, ret_codes):
        for node in self._get_child_nodes(node, code_type):
            self._get_ret_codes_list(node, ret_codes)

    def _get_ret_codes_list(self, node, ret_codes):
        for code_node in self._get_child_nodes(node, 'code'):
            name = self._get_attribute(code_node, 'name')
            nr = int(self._get_attribute(code_node, 'nr'))
            ret_codes[nr] = {'nr': nr, 'name': name , 'value': code_node.firstChild.data}

    @property
    def paramters(self):
        return self._parameters

    @paramters.setter
    def paramters(self, value):
        self._parameters = value

    @property
    def cmd_id(self):
        return self._cmd_id

    @cmd_id.setter
    def cmd_id(self, value):
        self._cmd_id = value

    @property
    def id(self):
        return self._id

    @property
    def path(self):
        return self._cmd_path

    @property
    def parameters(self):
        return self._parameters

    @property
    def cmd(self):
        self._cmd = libs.handlers.config.Cmd(self._path, self._parameters, self._md5, self._hash, self._hash_algorithm, self._connection_handlers, self._success_codes, self._error_codes, self._status_handler)
        return self._cmd


class PackageList(libs.handlers.config.PackageList, XMLNode):

    def __init__(self, package_list_path, connection_list, installed_list, log, status_handler):

        libs.handlers.config.PackageList.__init__(self, package_list_path, connection_list, installed_list, log, status_handler)
        self._warn_unknown_tags = False
        self._xmldoc = xml.dom.minidom.parse(self._package_list_path)
        for child in self._xmldoc.childNodes:
            #if isinstance(child, xml.dom.minidom.Element):
            if child.nodeType == child.ELEMENT_NODE:
                self._packages_node = child
                break
        #self._index = 0
        self._packages = {}
        #self._packages = [child.getAttribute('id') for child in self._packages_node.childNodes if child is not None and child.nodeType == xml.dom.Node.ELEMENT_NODE and child.tagName == 'package' and child.hasAttribute('id')]
        for child in self._packages_node.childNodes:
            try:
                if child is not None and child.nodeType == xml.dom.Node.ELEMENT_NODE and child.tagName == 'package' and child.hasAttribute('id'):
                    package_id = child.getAttribute('id')
                    self._packages[package_id] = self._get_package(child)
                    #self._packages.append(package_id)
            except Exception as e:
                self._log.log_err('[xml_md] [%d] %s' % (libs.common.get_current_line_nr(), e))

        self._log.log_info(unicode(self._packages))
        self._packages_count = len(self._packages) - 1

    def __len__(self):
        return len(self._packages)

    def _if_statement(self, if_node, variables):
        if_statement = IFStatement(if_node, variables, self._connection_list, self._log)
        return if_statement

    def uninstall(self, package_id):
        cmd_list = []
        package = self._get_package_by_id(package_id)
        self._log.log_debug(u"[xml_md] [%d] package '%s' installed: %s" % (libs.common.get_current_line_nr(), package_id, package.installed))
        status = 0
        for dependency in package.dependencies_list:
            package_id = dependency['package_id']
            installed = dependency['installed']
            if installed:
                self.install(package_id)
            else:
                self.uninstall(package_id)
        if package.installed:
            self._log.log_info(u"[xml_md] [%d] uninstalling package '%s'..." % (libs.common.get_current_line_nr(), package_id))
            status, cmd_list = package.uninstall()
            #self._installed_list.remove(package_id)

        else:
            status = libs.handlers.config.RET_CODE_ALREADY_REMOVED
        return status, cmd_list

    def install(self, package_id):
        cmd_list = []
        package = self._get_package_by_id(package_id)
        self._log.log_debug(u"[xml_md] [%d] package '%s' installed: %s" % (libs.common.get_current_line_nr(), package_id, package.installed))
        status = 0
        for dependency in package.dependencies_list:
            package_id = dependency['package_id']
            installed = dependency['installed']
            if installed:
                status = self.install(package_id)
            else:
                self.uninstall(package_id)
        if not package.installed:
            self._log.log_info(u"[xml_md] [%d] installing package '%s'..." % (libs.common.get_current_line_nr(), package.package_id))
            status, cmd_list = package.install()
            if package_id in self._installed_list:
                self._log.log_info(u"[xml_md] [%d] Installed File inconsistent. '%s' exists in File but was not installed!" % (libs.common.get_current_line_nr(), package.package_id))
                self._installed_list.update(package.package_id, package.version, package.rev)
            else:
                self._log.log_info(u"[xml_md] [%d] '%s' added to Installed File!" % (libs.common.get_current_line_nr(), package.package_id))
                self._installed_list.append(package.package_id, package.version, package.rev)
        else:
            status = libs.handlers.config.RET_CODE_ALREADY_INSTALLED
            if not package_id in self._installed_list:
                self._installed_list.append(package.package_id, package.version, package.rev)
        self._installed_list.save()
        return status, cmd_list

    def upgrade(self, package_id):
        cmd_list = []
        self._log.log_info(u"[xml_md] [%d] upgrading package '%s' " % (libs.common.get_current_line_nr(), package_id))
        package = self._get_package_by_id(package_id)
        self._log.log_info(u"[xml_md] [%d] package '%s' upgrade available: %s" % (libs.common.get_current_line_nr(), package_id, package.upgrade_available))
        status = 0
        for dependency in package.dependencies_list:
            package_id = dependency['package_id']
            installed = dependency['installed']
            if installed:
                status = self.install(package_id)
            else:
                self.uninstall(package_id)
        if package.upgrade_available:
            self._log.log_info(u"[xml_md] [%d] upgrading package '%s'..." % (libs.common.get_current_line_nr(), package.package_id))
            status, cmd_list = package.install()
            if package_id in self._installed_list:
                self._log.log_warn(u"[xml_md] [%d] Installed File inconsistent. '%s' exists in File but was not installed!" % (libs.common.get_current_line_nr(), package.package_id))
                self._installed_list.update(package.package_id, package.version, package.rev)
            else:
                self._log.log_info(u"[xml_md] [%d] '%s' added to Installed File!" % (libs.common.get_current_line_nr(), package.package_id))
                self._installed_list.append(package.package_id, package.version, package.rev)
        else:
            status = libs.handlers.config.RET_CODE_ALREADY_INSTALLED
            if not package_id in self._installed_list:
                self._installed_list.append(package.package_id, package.version, package.rev)
        self._installed_list.save()
        return status, cmd_list

    def _get_package_by_id(self, package_id):
        element = self._xmldoc.getElementById(package_id)
        return self._get_package(element)

    def _get_package(self, element):
        #if not isinstance(element, xml.dom.minidom.Element):
        if element is None or element.nodeType != xml.dom.Node.ELEMENT_NODE:
            return None

        file_path = None
        installed = False
        upgrade_available = False
        install_cmds = []
        upgrade_cmds = []
        uninstall_cmds = []
        variables = {}
        dependencies_list = []
        package_id = element.getAttribute('id')
        cmds = {}
        keywords = []

        if element.hasAttribute('name'):
            name = element.getAttribute('name')
        else:
            name = element.getAttribute('id')

        if element.hasAttribute('version'):
            version = element.getAttribute('version')
        else:
            version = "1"

        if element.hasAttribute('rev'):
            rev = element.getAttribute('rev')
        else:
            rev = "1"

        if element.hasAttribute('description'):
            description = element.getAttribute('description')
        else:
            description = ""

        if element.hasAttribute('icon'):
            icon = element.getAttribute('icon')
        else:
            icon = ""

        if element.hasAttribute('icon_type'):
            icon_type = element.getAttribute('icon_type')
        else:
            icon_type = ""

        #print >>sys.stdout, name

        for node in element.childNodes:
            #if isinstance(node, xml.dom.minidom.Element):

            if node.nodeType == node.ELEMENT_NODE:
                if node.tagName == "keywords":
                    pass
                elif node.tagName == "if":
                    if_statement = self._if_statement(node, variables)
                    self._log.log_debug('[xml_md] [%d] %s' % (libs.common.get_current_line_nr(), if_statement.child_nodes))
                    if if_statement.condition_is:
                        for child_node in if_statement.child_nodes:
                            if child_node.nodeType != node.ELEMENT_NODE:
                                continue
                            self._log.log_info(child_node.tagName)
                            if child_node.tagName == "installed":
                                if child_node.firstChild.nodeType == child_node.TEXT_NODE:
                                   installed = libs.common.str2bool(child_node.firstChild.data)
                                   self._log.log_debug('[xml_md] [%d] %s - installed: %s' % (libs.common.get_current_line_nr(), package_id, installed))
                            elif child_node.tagName == "upgrade_available":
                                if child_node.firstChild.nodeType == child_node.TEXT_NODE:
                                    upgrade_available = libs.common.str2bool(child_node.firstChild.data)
                                    self._log.log_debug('[xml_md] [%d] %s - upgrade_available: %s' % (libs.common.get_current_line_nr(), package_id, upgrade_available))
                elif node.tagName == "variable":
                    variable_name = self._get_attribute(node, 'name')
                    if node.firstChild.nodeType == node.TEXT_NODE:
                        variable_value = node.firstChild.data
                        variables[variable_name] = variable_value
                elif node.tagName == "cmd":
                    if node.hasAttribute('id'):
                        cmd_id = node.getAttribute('id')
                    else:
                        self._log.log_warn(u"[xml_md] [%d] %s - cmd declaration without id is useless!" % (libs.common.get_current_line_nr(), package_id))
                        continue
                    cmds[cmd_id] = CmdPattern(node, variables, self._connection_list, self._log, self._status_handler)
                elif node.tagName == "install":
                    install_cmds += self._handle_action_node(node.childNodes, cmds, variables)
                    self._log.log_debug(u"[xml_md] [%d] %s - install cmds: %s " % (libs.common.get_current_line_nr(), package_id, install_cmds))
                elif node.tagName == "upgrade":
                    upgrade_cmds += self._handle_action_node(node.childNodes, cmds, variables)
                    self._log.log_debug(u"[xml_md] [%d] %s - upgrade cmds: %s " % (libs.common.get_current_line_nr(), package_id, upgrade_cmds))
                elif node.tagName == "uninstall" or node.tagName == "remove":
                    uninstall_cmds += self._handle_action_node(node.childNodes, cmds, variables)
                    self._log.log_debug(u"[xml_md] [%d] %s - uninstall cmds: %s " % (libs.common.get_current_line_nr(), package_id, uninstall_cmds))

        return libs.handlers.config.Package(package_id, name, version, rev, installed, install_cmds, upgrade_available, upgrade_cmds, uninstall_cmds, description, keywords, icon, icon_type, self._connection_list, dependencies_list, self._log, self._status_handler)

    def _handle_action_node(self, child_nodes, pattern_cmds, variables):
        cmds = []
        for child_node in child_nodes:
            pattern_cmd = {}
            if child_node.nodeType == child_node.ELEMENT_NODE:
                if child_node.tagName == "if":
                    if_statement = self._if_statement(child_node, variables)
                    self._log.log_debug('[xml_md] [%d] %s' % (libs.common.get_current_line_nr(), if_statement.child_nodes))
                    if if_statement.condition_is:
                        cmds += self._handle_action_node(if_statement.child_nodes, pattern_cmds, variables)
                        self._log.log_debug('[xml_md] [%d] cmds: %s' % (libs.common.get_current_line_nr(), cmds))
                elif child_node.tagName == "depends":
                    pass
                    # FIX ME!!!
                    #dependencies_list.append(self._handle_depend_node(child_node))
                elif child_node.tagName == "cmd":
                    self._log.log_debug('[xml_md] [%d] xml: "%s"' % (libs.common.get_current_line_nr(), child_node.toxml()))
                    cmd_id = ''
                    if child_node.hasAttribute('cmd_id'):
                        cmd_id = child_node.getAttribute('cmd_id')
                        if cmd_id in pattern_cmds:
                            pattern_cmd = pattern_cmds[cmd_id]
                    self._log.log_debug('[xml_md] [%d] cmd id: "%s"' % (libs.common.get_current_line_nr(), cmd_id))
                    cmd = Cmd(child_node, variables, self._connection_list, self._log, self._status_handler, **pattern_cmd).cmd
                    cmds.append(cmd)
                else:
                    if self._warn_unknown_tags:
                        self._log.log_warn('[xml_md] [%d] Unknown Tag: %s' % (libs.common.get_current_line_nr(), child_node.tagName))
        return cmds

    def _handle_depend_node(self, node):
        installed = True
        package_id = node.getAttribute('package_id')
        if node.hasAttribute('installed'):
            installed = node.getAttribute('installed')
        return {'package_id': package_id, 'installed': installed}

    def __iter__(self):
        return iter(self._packages)
        #self._packages_count = len(self._packages) - 1
        #self._index = 0
        #return self

    def iteritems(self):
        return self._packages.iteritems()

    def next(self):
        #print self._index, self._packages_count, self._packages[self._index]
        if self._index == self._packages_count:
            raise StopIteration
        package_id = self._packages[self._index]
        self._index += 1
        return package_id

    def keys(self):
        return self._packages.keys()

    def values(self):
        return self._packages.values()

    def items(self):
        return self._packages.items()

    def __getitem__(self, package_id):
        element = self._xmldoc.getElementById(package_id)
        return self._get_package(element)


def register_handler(plugins):
    #current_modul = globals()
    current_module = sys.modules[__name__]
    plugins[file_extension] = current_module
    return (file_extension, current_module)