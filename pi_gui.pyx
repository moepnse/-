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
import platform
import traceback
import threading

# third party imports
import wx
import wx.lib.mixins.listctrl as listmix
from wx.lib.agw import ultimatelistctrl as ULC

# application/library imports
from package_installer import get_config_plugins, installed_list_factory, settings_factory, package_list_factory, profile_list_factory, install_list_factory, connection_list_factory, log_list_factory, host_list_factory, groups_factory, Log, get_ph_plugins, get_log_plugins, get_settings_config_path
from libs.pi_status_gui import PIStatusGUI
from package_installer import get_application_path, settings_factory, install_list_factory, installed_list_factory, package_list_factory, host_list_factory, connection_list_factory, log_list_factory, Log, get_ph_plugins, get_log_plugins
from libs.handlers.config import RETURN_ID, RET_CODE_UNKNOWN, RET_CODE_SUCCESS, RET_CODE_ERROR, RET_CODE_ALREADY_INSTALLED, RET_CODE_ALREADY_REMOVED, RET_CODE_PACKAGE_NOT_FOUND, RET_CODE_DEPENDENCY_NOT_SATISFIABLE, ChecksumViolation
from libs.handlers.protocol import FileNotFound, ConnectionError, AuthenticationError
from libs.handlers.status import INSTALLING, UPGRADING, REMOVING, INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN, SEND_STATUS, SEND_INFO, SEND_INFO_SUCCESS, SEND_INFO_WARN, SEND_INFO_ERROR, SEND_DONE
from libs.common import get_application_path

import libs

from libs.handlers.config cimport StatusHandler as BaseStatusHandler, STATUS_SOURCE, ss__cmd, ss__connection_handler, ss__protocol, STATUS_TYPES, st__info, st__success, st__warn, st__error
from libs.handlers.dependencies cimport handle_dependencies, check_dependencies, add_package_status, check_if_package_is_needed


class AtionHandlerThread(threading.Thread):

    def __init__(self, pi_status_gui, log, package_list, action_list):
        threading.Thread.__init__(self)
        self._package_list = package_list
        self._action_list = action_list
        self._pi_status_gui = pi_status_gui

    def run(self):
        self._handle_actions()

    def _handle_actions(self):
        cdef:
            unsigned char status = 0
            int ret_code = 0
            object package
            object action
            object package_id
            object package_name = ""
            object cmd_list
            unicode cmd = u""
            unicode file = u""
            unicode path = u""
            unicode cmd_info = u""
            dict package_status_mapping = {}

        for package in self._action_list:
            package_id = package['package_id']
            action = package['action']
            cmd_list = []
            try:
                #package_id = package['package_id']
                #action = package['action']
                if package_id in self._package_list.keys():
                    if action == 'install':
                        self._pi_status_gui.add_package_status(package_id, package_name, INSTALLING)
                        if check_dependencies(package_status_mapping, self._package_list[package_id]):
                            ret_code, cmd_list = self._package_list.install(package_id)
                            if ret_code in (RET_CODE_SUCCESS, RET_CODE_ALREADY_INSTALLED):
                                status = INSTALLED
                            elif ret_code == RET_CODE_UNKNOWN:
                                status = UNKNOWN
                            else:
                                status = FAILED
                        else:
                            ret_code = RET_CODE_DEPENDENCY_NOT_SATISFIABLE
                            status = FAILED
                    elif action == 'upgrade':
                        self._pi_status_gui.add_package_status(package_id, package_name, UPGRADING)
                        if check_dependencies(package_status_mapping, self._package_list[package_id]):
                            ret_code, cmd_list = self._package_list.upgrade(package_id)
                            if ret_code in (RET_CODE_SUCCESS, RET_CODE_ALREADY_INSTALLED):
                                status = UPGRADED
                            elif ret_code == RET_CODE_UNKNOWN:
                                status = UNKNOWN
                            else:
                                status = FAILED
                        else:
                            ret_code = RET_CODE_DEPENDENCY_NOT_SATISFIABLE
                            status = FAILED
                    elif action == 'remove' or action == 'uninstall':
                        self._pi_status_gui.add_package_status(package_id, package_name, REMOVING)
                        if not check_if_package_is_needed(package_status_mapping, package, self._package_list):
                            ret_code, cmd_list = self._package_list.uninstall(package_id)
                            if ret_code in (RET_CODE_SUCCESS, RET_CODE_ALREADY_REMOVED):
                                status = REMOVED
                            elif ret_code == RET_CODE_UNKNOWN:
                                status = UNKNOWN
                            else:
                                status = FAILED
                        else:
                            ret_code = RET_CODE_DEPENDENCY_NOT_SATISFIABLE
                            status = FAILED
                    else:
                        status = FAILED
                else:
                    status = FAILED
                    ret_code = RET_CODE_PACKAGE_NOT_FOUND
                add_package_status(package_status_mapping, package_id, False if status == FAILED else True)
                #print status, package_id
                if ret_code != RET_CODE_PACKAGE_NOT_FOUND:
                    self._pi_status_gui.update_package_status_by_id(package_id, status)
                if ret_code == RET_CODE_ALREADY_INSTALLED:
                    self._pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Already installed!")
                elif ret_code == RET_CODE_ALREADY_REMOVED:
                    self._pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Already removed!")
                elif ret_code == RET_CODE_PACKAGE_NOT_FOUND:
                    self._pi_status_gui.add_info(SEND_INFO_ERROR, u"Package with id: %s not found!" % package_id)
                elif ret_code == RET_CODE_DEPENDENCY_NOT_SATISFIABLE:
                    self._pi_status_gui.add_info(SEND_INFO_ERROR, u"Package with id: %s has dependency problems!" % package_id)
                else:
                    self._pi_status_gui.add_info(SEND_INFO_ERROR, u'Status Code: %d' % ret_code)

                """
                if self._send_cmd_infos:
                    for entry in cmd_list:
                        cmd = entry[0]
                        exit_code = entry[1]
                        if self._send_cmd_full_path or cmd == "":
                            cmd_info = cmd
                        else:
                            path, file = os.path.split(libs.win.commandline.parse(cmd)[0])
                            cmd_info = file
                        self._pi_status_gui._lb_packages.Append((u'%s: %d' % (cmd_info, exit_code), ))
                """
            #except ChecksumViolation, e:
                #if self._status_gui:
                    #self._send_status(FAILED, package_id)
                    #self._send_info(u"%s %s" % (package_id, str(e)), SEND_INFO_ERROR)
                #print >>stderr, "Error: Checksum violation!"
            #except FileNotFound, e:
                #if self._status_gui:
                    #self._send_status(FAILED, package_id)
                    #self._send_info(u"%s %s" % (package_id, str(e)), SEND_INFO_ERROR)
                #print >>stderr, "Error: ", e
            #except ConnectionError, e:
                #if self._status_gui:
                    #self._send_status(FAILED, package_id)
                    #self._send_info(u"%s %s" % (package_id, str(e)), SEND_INFO_ERROR)
                #print >>stderr, "Error: ", e
            except (AuthenticationError, ConnectionError, FileNotFound, ChecksumViolation), e:
                    self._pi_status_gui.update_package_status_by_id(package_id, FAILED)
                    #self._send_info(u"%s %s" % (package_id, str(e)), SEND_INFO_ERROR)
                #print >>stderr, "Error: ", e
            except Exception as e:
                print str(e)
                print traceback.format_exc()
                #self._send_status(FAILED, package_id)
                self._pi_status_gui.update_package_status_by_id(package_id, FAILED)
                self._pi_status_gui.add_info(<unsigned char>SEND_INFO_ERROR, u"%s %s" % (package_id, str(e)))



class StatusHandler(BaseStatusHandler):

    def __init__(self):
        self._status_gui = None

    def set_status_gui(self, status_gui):
        self._status_gui = status_gui

    def set_status(self, int source_id, int status_type, unicode status_source_name, int status_id, unicode description):
        status_id =  BaseStatusHandler.set_status(self, source_id, status_type, status_source_name, status_id, description)
        if self._status_gui is not None:
            self._status_gui.add_info(status_type, description)
        return status_id

    def update_status(self, int old_status_id, int status_type, int status_id, unicode description):
        pass


class PackageList(ULC.UltimateListCtrl, listmix.ColumnSorterMixin, listmix.ListCtrlAutoWidthMixin):

    def __init__(self, parent, package_list, installed_list, lb_actions):
        ULC.UltimateListCtrl.__init__(self, parent, agwStyle=ULC.ULC_REPORT | ULC.ULC_HAS_VARIABLE_ROW_HEIGHT)
        #self.itemDataMap = DATA
        listmix.ColumnSorterMixin.__init__(self, 7)
        listmix.ListCtrlAutoWidthMixin.__init__(self)

        self._package_list = package_list
        self._installed_list = installed_list
        self._lb_actions = lb_actions

        self.InsertColumn(0, "Package Name")
        self.InsertColumn(1, "Version (A)")
        self.InsertColumn(2, "Revision (A)")
        self.InsertColumn(3, "Version (I)")
        self.InsertColumn(4, "Revision (I)")
        self.InsertColumn(5, "Description")
        self.InsertColumn(6, "Action")

        self.Bind(wx.EVT_LIST_COL_CLICK, self.OnColumn)

        self._bmp_install = wx.Bitmap("imgs/icons/16x16/install.png", wx.BITMAP_TYPE_ANY)
        self._bmp_uninstall = wx.Bitmap("imgs/icons/16x16/uninstall.png", wx.BITMAP_TYPE_ANY)
        self._bmp_upgrade = wx.Bitmap("imgs/icons/16x16/upgrade.png", wx.BITMAP_TYPE_ANY)

        self.setResizeColumn(6)

        self._fill()

    def OnSortOrderChanged(self):
        count = self.GetItemCount()
        for row in xrange(count):
            if row % 2:
                colour = wx.Colour(255,255,255)
            else:
                colour = wx.Colour(214,219, 99)
            self.SetItemBackgroundColour(row, colour)

    def _fill(self, packages=None):
        self.DeleteAllItems()
        self._mapping = []
        for package_id, package in self._package_list.iteritems():
            if packages is not None and package_id not in packages:
                continue
            if package_id in self._installed_list:
                installed_package = self._installed_list[package_id]
                installed_version = installed_package[1]
                installed_rev = installed_package[2]
            else:
                installed_version = ""
                installed_rev = ""
            index = self.Append((package_id if len(package.name.strip()) == 0 else package.name, package.version, package.rev, installed_version, installed_rev, package.description))
            self._mapping.append(package_id)
            self.SetItemData(index, len(self._mapping) - 1)
            if index % 2:
                colour = wx.Colour(255,255,255)
            else:
                colour = wx.Colour(214,219, 99)
            self.SetItemBackgroundColour(index, colour)
            action_field = ActionField(self, package, self._lb_actions)
            action_field.SetBackgroundColour(colour)
            self.SetItemWindow(index, col=6, wnd=action_field, expand=True)
        self.itemDataMap = self._mapping


    def OnColumn(self, e):
        self.Refresh()
        e.Skip()

    def GetListCtrl(self):
        return self

    def show_packages(self, list packages):
        self._fill(packages)


class ActionList(ULC.UltimateListCtrl, listmix.ColumnSorterMixin, listmix.ListCtrlAutoWidthMixin):

    def __init__(self, parent, columns):
        ULC.UltimateListCtrl.__init__(self, parent, agwStyle=ULC.ULC_REPORT | ULC.ULC_HAS_VARIABLE_ROW_HEIGHT)
        #self.itemDataMap = DATA
        listmix.ColumnSorterMixin.__init__(self, columns)
        listmix.ListCtrlAutoWidthMixin.__init__(self)

        self.Bind(wx.EVT_LIST_COL_CLICK, self.OnColumn)

        self._bmp_install = wx.Bitmap("imgs/icons/16x16/install.png", wx.BITMAP_TYPE_ANY)
        self._bmp_uninstall = wx.Bitmap("imgs/icons/16x16/uninstall.png", wx.BITMAP_TYPE_ANY)
        self._bmp_upgrade = wx.Bitmap("imgs/icons/16x16/upgrade.png", wx.BITMAP_TYPE_ANY)

    def OnColumn(self, e):
        self.Refresh()
        e.Skip()

    def GetListCtrl(self):
        return self


class ActionField(wx.Panel):

    def __init__(self, parent, package, lb_actions):
        wx.Panel.__init__(self, parent)
        afs = ActionFieldSizer()
        self._package = package
        self._lb_actions = lb_actions
        self.SetSizer(afs)
        self._cmd_install = wx.BitmapButton(self, id=wx.ID_ANY,  bitmap=parent._bmp_install)
        self._cmd_uninstall = wx.BitmapButton(self, id=wx.ID_ANY,  bitmap=parent._bmp_uninstall)
        self._cmd_upgrade = wx.BitmapButton(self, id=wx.ID_ANY,  bitmap=parent._bmp_upgrade)
        afs.AddMany((self._cmd_install, self._cmd_uninstall, self._cmd_upgrade))
        if package.installed:
            self._cmd_install.Disable()
        else:
            self._cmd_uninstall.Disable()
        if not package.upgrade_available:
            self._cmd_upgrade.Disable()

        self.Bind(wx.EVT_BUTTON, self._cmd_install_on_button, self._cmd_install)
        self.Bind(wx.EVT_BUTTON, self._cmd_uninstall_on_button, self._cmd_uninstall)
        self.Bind(wx.EVT_BUTTON, self._cmd_upgrade_on_button, self._cmd_upgrade)

    def _cmd_install_on_button(self, e):
        self._lb_actions.Append(("install", self._package.package_id, self._package.name, self._package.version))

    def _cmd_uninstall_on_button(self, e):
        self._lb_actions.Append(("uninstall", self._package.package_id, self._package.name, self._package.version))

    def _cmd_upgrade_on_button(self, e):
        self._lb_actions.Append(("upgrade", self._package.package_id, self._package.name, self._package.version))


class ActionsSizer(wx.BoxSizer):

    def __init__(self):
        wx.BoxSizer.__init__(self, wx.VERTICAL)


class ActionsButtonSizer(wx.BoxSizer):

    def __init__(self):
        wx.BoxSizer.__init__(self, wx.HORIZONTAL)


class ActionFieldSizer(wx.BoxSizer):

    def __init__(self):
        wx.BoxSizer.__init__(self, wx.HORIZONTAL)


class ActionsButtonPanel(wx.Panel):

    def __init__(self, parent):
        wx.Panel.__init__(self, parent)
        self._sizer = ActionsButtonSizer()
        self.SetSizer(self._sizer)

    def add_many(self, blah):
        self._sizer.AddMany(blah)


class ActionsHSPanel(wx.Panel):

    def __init__(self, parent, package_list, status_handler, package_lists=[]):

        self._package_list = package_list
        self._status_handler = status_handler
        self._package_lists = package_lists

        wx.Panel.__init__(self, parent)

        self._lb_actions = ActionList(self, 3)
        self._lb_actions.InsertColumn(0, "Action")
        self._lb_actions.InsertColumn(1, "Package ID")
        self._lb_actions.InsertColumn(2, "Package Name")
        self._lb_actions.InsertColumn(3, "Version")

        self._lb_actions.setResizeColumn(3)

        self._bmp_handle_actions = wx.Bitmap("imgs/icons/16x16/h.png", wx.BITMAP_TYPE_ANY)
        self._bmp_clear_actions = wx.Bitmap("imgs/icons/16x16/x.png", wx.BITMAP_TYPE_ANY)

        self._action_sizer = ActionsSizer()
        self._actions_button_panel = ActionsButtonPanel(self)

        self._cmd_handle_actions = wx.BitmapButton(self._actions_button_panel, id=wx.ID_ANY,  bitmap=self._bmp_handle_actions)
        self._cmd_clear_actions = wx.BitmapButton(self._actions_button_panel, id=wx.ID_ANY,  bitmap=self._bmp_clear_actions)

        self.SetSizer(self._action_sizer)
        self._action_sizer.AddMany(((self._lb_actions, 1, wx.EXPAND), (self._actions_button_panel, 0, wx.EXPAND)))
        self._actions_button_panel.add_many(((self._cmd_handle_actions, 1, wx.EXPAND), (self._cmd_clear_actions, 1, wx.EXPAND)))

        self.Bind(wx.EVT_BUTTON, self.__cmd_handle_actions_on_button, self._cmd_handle_actions)
        self.Bind(wx.EVT_BUTTON, self.__cmd_clear_actions_on_button, self._cmd_clear_actions)

    def __cmd_clear_actions_on_button(self, e):
        self._lb_actions.DeleteAllItems()

    def __cmd_handle_actions_on_button(self, e):
        acd = ActionConfirmDialog(None, self._package_list, self._status_handler)
        for row in range(self._lb_actions.GetItemCount()):
            action_list = []
            #index = self._lb_actions.GetItemData(row)
            #package_id = self._mapping[index]
            package_id = self._lb_actions.GetItem(row, 1).GetText()
            action = self._lb_actions.GetItem(row, 0).GetText()
            handle_dependencies(package_id, action_list, self._package_list, self._package_lists)
            for dict_package in action_list:
                acd.add_package(dict_package['package_id'], dict_package['action'])
            acd.add_package(package_id, action)
        acd.Show()


class GroupsTree(wx.TreeCtrl):

    def __init__(self, parent, groups, lb_packages):
        wx.TreeCtrl.__init__(self, parent)
        self._root = self.AddRoot('Groups')
        self._mapping = {}
        self._handle_group('root', self._root, groups)
        self._lb_packages = lb_packages
        self.Bind(wx.EVT_TREE_ITEM_ACTIVATED, self.on_click, self)

    def _handle_group(self, last_id, root, groups):
        for group in groups:
            new_id = '_'.join((last_id, group['id']))
            new_root = self.AppendItem(root, group['name'], data=wx.TreeItemData(new_id))
            self._mapping[new_id] = group
            self._handle_group(new_id, new_root, group['groups'])

    def on_click(self, event):
        self._lb_packages.show_packages(self._mapping[self.GetPyData(event.GetItem())]['packages'])


class GroupsPanel(wx.Panel):

    def __init__(self, parent, package_list, installed_list, groups, status_handler):
        wx.Panel.__init__(self, parent)
        self._groups = groups
        self._v_splitter = wx.SplitterWindow(self)
        self._pl_panel = PackagelistPanel(self._v_splitter, package_list, installed_list, status_handler)
        self._groups_tree = GroupsTree(self._v_splitter, groups, self._pl_panel._lb_packages)
        self._v_splitter.SplitVertically(self._groups_tree, self._pl_panel)
        self._v_splitter.SetSashGravity(0.5)
        self._v_splitter.SetSashPosition(200)
        #self._groups_tree.SetSize((200, -1))
        sizer = wx.BoxSizer()
        sizer.Add(self._v_splitter, 1, wx.EXPAND)
        self.SetSizer(sizer)


class PackagelistPanel(wx.Panel):

    def __init__(self, parent, package_list, installed_list, status_handler):
        wx.Panel.__init__(self, parent)
        self._h_splitter = wx.SplitterWindow(self)

        self._actions_hs_panel = ActionsHSPanel(self._h_splitter, package_list, status_handler)
        self._lb_packages = PackageList(self._h_splitter, package_list, installed_list, self._actions_hs_panel._lb_actions)

        self._h_splitter.SplitHorizontally(self._lb_packages, self._actions_hs_panel)
        self._h_splitter.SetSashGravity(0.5)
        sizer = wx.BoxSizer()
        sizer.Add(self._h_splitter, 1, wx.EXPAND)
        self.SetSizer(sizer)
        self._action_list = []


class MainWindow(wx.Frame):

    def __init__(self, parent, *args, **kwargs):
        wx.Frame.__init__(self, parent, title="Package Installer", *args, **kwargs)

    def init(self, package_list, groups, installed_list, status_handler):

        self._package_list = package_list
        self._nb = wx.Notebook(self)
        self._plp = PackagelistPanel(self._nb, package_list, installed_list, status_handler)
        self._groups_panel = GroupsPanel(self._nb, package_list, installed_list, groups, status_handler)
        self._nb.AddPage(self._plp, "Packages")
        self._nb.AddPage(self._groups_panel, "Groups")
        sizer = wx.BoxSizer()
        sizer.Add(self._nb, 1, wx.EXPAND)
        self.SetSizer(sizer)
        self.SetSize((800, 600))
        self.Show()


class ActionConfirmDialogButtons(wx.Panel):

    def __init__(self, parent, lb_actions, package_list, status_handler, *args, **kwargs):
        wx.Panel.__init__(self, parent, *args, **kwargs)
        self._lb_actions = lb_actions
        self._package_list = package_list
        self._status_handler = status_handler
        self._h_sizer = wx.BoxSizer(wx.HORIZONTAL)

        self._bmp_handle_actions = wx.Bitmap("imgs/icons/16x16/h.png", wx.BITMAP_TYPE_ANY)
        self._cmd_handle_actions = wx.BitmapButton(self, id=wx.ID_ANY,  bitmap=self._bmp_handle_actions)

        self._bmp_cancel = wx.Bitmap("imgs/icons/16x16/x.png", wx.BITMAP_TYPE_ANY)
        self._cmd_cancel= wx.BitmapButton(self, id=wx.ID_ANY,  bitmap=self._bmp_cancel)

        self.SetSizer(self._h_sizer)
        self._h_sizer.AddMany(((self._cmd_handle_actions, 1, wx.EXPAND), (self._cmd_cancel, 1, wx.EXPAND)))
        self.Show()
        self.Bind(wx.EVT_BUTTON, self.__cmd_handle_actions_on_button, self._cmd_handle_actions)
        self.Bind(wx.EVT_BUTTON, self.__cmd_cancel_on_button, self._cmd_cancel)

    def __cmd_cancel_on_button(self, e):
        self.Parent.Close()

    def __cmd_handle_actions_on_button(self, e):
        log = None
        pi_status_gui = PIStatusGUI(log)
        self._status_handler.set_status_gui(pi_status_gui)
        pi_status_gui.Show()
        action_list = []
        for row in range(self._lb_actions.GetItemCount()):
            #index = self._lb_actions.GetItemData(row)
            #package_id = self._mapping[index]
            package_id = self._lb_actions.GetItem(row, 0).GetText()
            action = self._lb_actions.GetItem(row, 1).GetText()
            action_list.append({'package_id': package_id, 'action': action})
        aht = AtionHandlerThread(pi_status_gui, log, self._package_list, action_list)
        aht.start()


class ActionConfirmDialog(wx.Frame):

    def __init__(self, parent, package_list, status_handler, *args, **kwargs):
        wx.Frame.__init__(self, parent, title="Confirm changes", *args, **kwargs)
        self._package_list = package_list
        self._v_sizer = wx.BoxSizer(wx.VERTICAL)
        self._lb_actions = ActionList(self, 2)
        self._lb_actions.InsertColumn(0, "Package ID")
        self._lb_actions.InsertColumn(1, "Action")

        self.SetSizer(self._v_sizer)
        self._acdb = ActionConfirmDialogButtons(self, self._lb_actions, package_list, status_handler)
        self._v_sizer.AddMany(((self._lb_actions, 1, wx.EXPAND), (self._acdb, 0, wx.EXPAND)))
        self.Show()

    def add_package(self, package_id, action):
        index = self._lb_actions.Append((package_id, action))
        self._lb_actions.SetItemData(index, package_id)


class Loader(threading.Thread):

    def __init__(self, win, pi_status_gui):
        threading.Thread.__init__(self)
        self._pi_status_gui = pi_status_gui
        self._win = win

    def run(self):
        pi_status_gui = self._pi_status_gui

        status_handler = StatusHandler()
        pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Loading Settings")
        settings = settings_factory(get_settings_config_path('pi_settings.path'))
        pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Loading Protocol-Handlers")
        plugins = get_ph_plugins()
        pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Loading Logging Plugins")
        log_plugins = get_log_plugins()
        log_targets = log_list_factory(settings.log_list, log_plugins)
        log = Log(log_targets)
        pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Loading Connection List")
        try:
            connection_list = connection_list_factory(settings.connection_list, plugins, log, status_handler, window_handle=pi_status_gui.GetHandle())
        except IOError:
            pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Could not load Connection-List! Please check your configuration!")
            pi_status_gui.add_info(SEND_INFO_SUCCESS, u"STOPPED!")
            return False
        pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Loading Installed List")
        try:
            installed_list = installed_list_factory(settings.installed_list, log)
        except IOError:
            pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Could not load Installed-List! Please check your configuration!")
        pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Loading Package List")
        try:
            package_list = package_list_factory(settings.package_list, connection_list, installed_list, log, status_handler)
        except IOError:
            pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Could not load Installed-List! Please check your configuration!")
            pi_status_gui.add_info(SEND_INFO_SUCCESS, u"STOPPED!")
            return False
        if settings.target_source == 'install_list':
            pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Loading Install List")
            try:
                install_list = install_list_factory(settings.install_list, connection_list, log)
            except IOError:
                pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Could not load Install-List! Please check your configuration!")
        else:
            pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Loading Host List")
            try:
                host_list = host_list_factory(settings.host_list, log)
            except IOError:
                pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Could not load Host-List! Please check your configuration!")
        pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Loading Groups List")
        try:
            groups = groups_factory(settings.groups, log)
        except IOError:
            pi_status_gui.add_info(SEND_INFO_SUCCESS, u"Could not load Groups-List! Please check your configuration!")

        wx.CallAfter(self._win.init, package_list=package_list, groups=groups, installed_list=installed_list, status_handler=status_handler)
        wx.CallAfter(pi_status_gui.Close)



app = wx.App(False)
win = MainWindow(None)
pi_status_gui = PIStatusGUI()
pi_status_gui.Show()
loader = Loader(win, pi_status_gui)
loader.start()
app.MainLoop()