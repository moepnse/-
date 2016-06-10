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
import sys
import platform
import traceback

# third party imports
import wx
import wx.lib.mixins.listctrl as listmix
from wx.lib.agw import ultimatelistctrl as ULC

# application/library imports
from package_installer import get_application_path, settings_factory, install_list_factory, installed_list_factory, package_list_factory, host_list_factory, connection_list_factory, log_list_factory, Log, get_ph_plugins, get_log_plugins, get_settings_config_path
import libs

from libs.handlers.config cimport StatusHandler as BaseStatusHandler, STATUS_SOURCE, ss__cmd, ss__connection_handler, ss__protocol, STATUS_TYPES, st__info, st__success, st__warn, st__error


class StatusHandler(BaseStatusHandler):
    def set_status(self, int source_id, int status_type, unicode status_source_name, int status_id, unicode description):
        return BaseStatusHandler.set_status(self, source_id, status_type, status_source_name, status_id, description)

    def update_status(self, int old_status_id, int status_type, int status_id, unicode description):
        pass


class PackageList(ULC.UltimateListCtrl, listmix.ColumnSorterMixin):
    def __init__(self, parent, columns):
        ULC.UltimateListCtrl.__init__(self, parent, agwStyle=ULC.ULC_REPORT | ULC.ULC_HAS_VARIABLE_ROW_HEIGHT)
        #self.itemDataMap = DATA
        listmix.ColumnSorterMixin.__init__(self, columns)
        self.Bind(wx.EVT_LIST_COL_CLICK, self.OnColumn)

        self._bmp_install = wx.Bitmap("imgs/icons/16x16/install.png", wx.BITMAP_TYPE_ANY)
        self._bmp_uninstall = wx.Bitmap("imgs/icons/16x16/uninstall.png", wx.BITMAP_TYPE_ANY)
        self._bmp_upgrade = wx.Bitmap("imgs/icons/16x16/upgrade.png", wx.BITMAP_TYPE_ANY)

    def OnColumn(self, e):
        self.Refresh()
        e.Skip()

    def GetListCtrl(self):
        return self


class ActionList(ULC.UltimateListCtrl, listmix.ColumnSorterMixin):
    def __init__(self, parent, columns):
        ULC.UltimateListCtrl.__init__(self, parent, agwStyle=ULC.ULC_REPORT | ULC.ULC_HAS_VARIABLE_ROW_HEIGHT)
        #self.itemDataMap = DATA
        listmix.ColumnSorterMixin.__init__(self, columns)
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
        self._lb_actions.Append(("install", self._package.name, self._package.version))

    def _cmd_uninstall_on_button(self, e):
        self._lb_actions.Append(("uninstall", self._package.name, self._package.version))

    def _cmd_upgrade_on_button(self, e):
        self._lb_actions.Append(("upgrade", self._package.name, self._package.version))


class ActionFieldSizer(wx.BoxSizer):
    def __init__(self):
        wx.BoxSizer.__init__(self, wx.HORIZONTAL)


class MainWindow(wx.Frame):
    def __init__(self, *args, **kwargs):
        wx.Frame.__init__(self, *args, **kwargs)
        status_hanlder = StatusHandler()
        settings = settings_factory(get_settings_config_path('pi_settings.path'))
        plugins = get_ph_plugins()
        log_plugins = get_log_plugins()
        log_targets = log_list_factory(settings.log_list, log_plugins)
        log = Log(log_targets)
        connection_list = connection_list_factory(settings.connection_list, plugins, log, status_hanlder)
        installed_list = installed_list_factory(settings.installed_list, log)
        package_list = package_list_factory(settings.package_list, connection_list, installed_list, log, status_hanlder)
        if settings.target_source == 'install_list':
            install_list = install_list_factory(settings.install_list, connection_list, log)
        else:
            host_list = host_list_factory(settings.host_list, log) 

        self._h_splitter = wx.SplitterWindow(self)

        self._lb_packages = PackageList(self._h_splitter, 7)
        self._lb_packages.InsertColumn(0, "Package Name")
        self._lb_packages.InsertColumn(1, "Version (A)")
        self._lb_packages.InsertColumn(2, "Revision (A)")
        self._lb_packages.InsertColumn(3, "Version (I)")
        self._lb_packages.InsertColumn(4, "Revision (I)")
        self._lb_packages.InsertColumn(5, "Description")
        self._lb_packages.InsertColumn(6, "Action")

        self._lb_actions = ActionList(self._h_splitter, 3)
        self._lb_actions.InsertColumn(0, "Action")
        self._lb_actions.InsertColumn(1, "Package Name")
        self._lb_actions.InsertColumn(2, "Version")

        self._h_splitter.SplitHorizontally(self._lb_packages, self._lb_actions)
        self._h_splitter.SetSashGravity(0.5)
        self._action_list = []
        for package_id, package in package_list.iteritems():
            if package_id in installed_list:
                installed_package = installed_list[package_id]
                installed_version = installed_package[1]
                installed_rev = installed_package[2]
            else:
                installed_version = ""
                installed_rev = ""
            index = self._lb_packages.Append((package_id if len(package.name.strip()) == 0 else package.name, package.version, package.rev, installed_version, installed_rev, package.description))
            self._lb_packages.SetItemData(index, package_id)
            if index % 2:
                colour = wx.Colour(255,255,255)
            else:
                colour = wx.Colour(214,219, 99)
            self._lb_packages.SetItemBackgroundColour(index, colour)
            action_field = ActionField(self._lb_packages, package, self._lb_actions)
            action_field.SetBackgroundColour(colour)
            self._lb_packages.SetItemWindow(index, col=6, wnd=action_field, expand=True)

        self.Show()

app = wx.App(False)
win = MainWindow(None)
app.MainLoop()