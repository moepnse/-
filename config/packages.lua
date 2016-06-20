
include([[C:\pi\config\error_codes.lua]])

firefox_esr = {}

firefox_esr.MFFESR_IN = [[smb://\\10.0.19.10\software\mffesr.ini]]
firefox_esr.MFFESR_EXE = "http://download-installer.cdn.mozilla.net/pub/firefox/releases/24.2.0esr/win32/de/Firefox%20Setup%2024.2.0esr.exe"
firefox_esr.UNINSTALL_EXE = [[%PROGRAMFILES%\Mozilla Firefox\uninstall\helper.exe]]
firefox_esr.UNINSTALL_SILENT = "/S"
firefox_esr.KILL_FF = "taskkill /F /IM firefox.exe"

firefox_esr.install = function(l)
    install_cmds = {KILL_FF, MFFESR_EXE .. ' '.. MFFESR_IN}
    upgrade_cmds = {}
    uninstall_cmds = {}
    register_package('package_installer', install_cmds, upgrade_cmds, uninstall_cmds)
end

include([[C:\pi\config\mozilla.lua]])
include([[C:\pi\config\microsoft.lua]])

do
    local UNINSTALL_CMD = 
    {
        cmd = [["file://%PROGRAMFILES(X86)%\7-Zip\uninstall.exe"]],
        args = {
            {   parameter = [[/S]],
                values = {
                    {
                        "",
                        false
                    },
                }
            }
        }
    }
    local INSTALL_CMD = 
    {
        cmd = "http://www.7-zip.org/a/7z920.exe",
        args = {
        {   parameter = "/S",
                values = {
                    {
                        "",
                        false
                    }
                }
            }
        }
    }
    function test123 ()
        --print("OLA")
        execute("cmd.exe", false, {}, {}, {})
    end
    local install_cmds = {INSTALL_CMD}
    local upgrade_cmds = {}
    local uninstall_cmds = {UNINSTALL_CMD, test123}
    register_package("7zip", "7zip", "9.20", "1", is_in_software_list([[^7-Zip\s9\.2]]), false, install_cmds, upgrade_cmds, uninstall_cmds, "", {})
end

function sevenzip_is_installed ()
    return is_in_software_list([[^7-Zip\s9\.2]])
end

function sevenzip_is_upgrade_avalaible ()
    return is_in_software_list([[^7-Zip\s9\.2]])
end

set_package_check_functions('7zip', 'sevenzip_is_installed', 'sevenzip_is_upgrade_avalaible')

function print_products()
    for product_name in software_list() do
    --print(startswith(product_name, [[Microsoft Office Professional Plus 2013]]))
    end
end

local status, err = pcall(print_products)
--print(err.code)  -->  121

for share in net_shares("SAMBA") do
    local t_stype = {
        --STYPE_DISKTREE = "DISK",
        --STYPE_PRINTQ = "PRINT",
        --STYPE_DEVICE = "DEVICE",
        --STYPE_IPC = "IPC",
        --STYPE_SPECIAL = "SPECIAL",
        --STYPE_TEMPORARY = "TEMPORARY"
    }
    t_stype[STYPE_DISKTREE] = "DISK"
    t_stype[STYPE_PRINTQ] = "PRINT"
    t_stype[STYPE_DEVICE] = "DEVICE"
    t_stype[STYPE_IPC] = "IPC"
    t_stype[STYPE_SPECIAL] = "SPECIAL"
    t_stype[STYPE_TEMPORARY] = "TEMPORARY"
    local t_access = {
        --ACCESS_READ = "READ",
        --ACCESS_WRITE = "WRITE",
        --ACCESS_CREATE = "CREATE",
        --ACCESS_EXEC = "EXEC",
        --ACCESS_DELETE = "DELETE",
        --ACCESS_ATRIB = "ATRIB",
        --ACCESS_PERM = "PERM",
        --ACCESS_ALL = "ALL"
    }
    local share_types = ""
    for key, value in pairs(t_stype) do
        -- lua 5.2
        --if(bit32.band(share["type"], key) == key) then
        -- lua 5.3
        if (share["type"] & key) == key then
            if share_types == "" then
                share_types = value
            else
                share_types = share_types .. " " ..  value
            end
        end
    end

    --print("SHARE:" .. share["path"] .. " " .. share["netname"] .. " " .. share["remark"] .. " " .. share["type"] .. " " .. share_types)
 end

for installed_software in software_list() do
    print(installed_software)
end
for installed_package in installed_list() do
    print(installed_package['package_id'])
    print(installed_package['version'] > "1.0")
end

--print(arch)
fvi = get_file_version_info([[c:\pi_cython\host_status.exe]])
--fvi = get_file_version_info([[C:\Program Files (x86)\Notepad++\notepad++.exe]])
--print(fvi.file_os)
--print(hiword(fvi.file_version_ms))
--print(loword(fvi.file_version_ms))
--print(hiword(fvi.file_version_ls))
--print(loword(fvi.file_version_ls))

--dwLeftMost = HIWORD(dwFileVersionMS)
--dwSecondLeft = LOWORD(dwFileVersionMS)
--dwSecondRight = HIWORD(dwFileVersionLS)
--dwRightMost = LOWORD(dwFileVersionLS)
--printf( "Version: %d.%d.%d.%d\n" , dwLeftMost, dwSecondLeft, dwSecondRight, dwRightMost );

--HKEY_CLASSES_ROOT
--HKEY_CURRENT_CONFIG
--HKEY_CURRENT_USER
--HKEY_LOCAL_MACHINE
--HKEY_USERS 

--REG_NONE
--REG_SZ
--REG_EXPAND_SZ

--REG_BINARY
--REG_DWORD
--REG_DWORD_LITTLE_ENDIAN
--REG_DWORD_BIG_ENDIAN
--REG_LINK
--REG_MULTI_SZ
--REG_RESOURCE_LIST
--REG_FULL_RESOURCE_DESCRIPTOR
--REG_RESOURCE_REQUIREMENTS_LIST
--REG_QWORD
--REG_QWORD_LITTLE_ENDIAN
-- http://www.howtogeek.com/howto/37920/the-50-best-registry-hacks-that-make-windows-better/
packages = {
    {   package_id = "winrar",
        is_installed = 
            function()
                return true
            end,
        is_upgrade_available = function()
            return false
        end,
        ret_codes = windows_error_codes
    },
    {   package_id = "winzip",
        is_installed = 
            function()
                return true
            end,
        is_upgrade_available = function()
            return false
        end,
        ret_codes = windows_error_codes
    },
    {   package_id = "7zip",
        version = "9.20",
        rev = 0,
        uninstall_cmds = 
            {
                {
                    cmd = [["file://%PROGRAMFILES(X86)%\7-Zip\uninstall.exe"]],
                    args = {
                        {   parameter = [[/S]],
                            values = {
                                {
                                    "",
                                    false
                                },
                            }
                        }
                    }
                }
            },
        install_cmds = 
            {
                {
                    cmd = "http://www.7-zip.org/a/7z920.exe",
                    md5 = "b3fdf6e7b0aecd48ca7e4921773fb606",
                    args = {
                        {   parameter = "/S",
                            values = {
                                {
                                    "",
                                    false
                                }
                            }
                        }
                    }
                }
            },
        is_installed = 
            function()
                --print("7zip is installed: " .. tostring(is_in_software_list([[^7-Zip\s9\.2]])))
                return is_in_software_list([[^7-Zip\s9\.2]])
            end,
        is_upgrade_available = function()
            return false
        end,
        dependencies = {
            {   package_id = "winrar",
                installed = false,
            },
            {   package_id = "winzip",
                installed = false,
            }
        },
        keywords = {
            "archiv", "compress", "zip", "rar", "tar", "7z"
        },
        description = "7-Zip is an open source file archiver, or an application used to compress files.",
        ret_codes = windows_error_codes
    },
    {   package_id = "x2goclient",
        name = "X2Go Client",
        version = "4.0.5.0",
        rev = 0,
        uninstall_cmds = 
            {
                {
                    cmd = [["file://%PROGRAMFILES(X86)%\x2goclient\Uninstall.exe"]],
                    args = {
                        {   parameter = [[/S]],
                            values = {
                                {
                                    "",
                                    false
                                },
                            }
                        }
                    }
                }
            },
        install_cmds = 
            {
                {
                    cmd = "http://code.x2go.org/releases/binary-win32/x2goclient/releases/4.0.5.0-2015.07.31/x2goclient-4.0.5.0-2015.07.31-setup.exe",
                    args = {
                        {   parameter = "/S",
                            values = {
                                {
                                    "",
                                    false
                                }
                            }
                        }
                    }
                }
            },
        is_installed = 
            function()
                return is_in_software_list([[^X2Go Client for Windows]])
            end,
        is_upgrade_available = function()
            local installed, version, rev = is_in_installed_list("x2goclient")
            if installed and (version < "4.0.5.0" or (version == "4.0.5.0" and rev < "0")) then
                return true
            end
            return false
        end,
        dependencies = {
        },
        keywords = {
            "remote desktop", "x11"
        },
        description = "Client to connect to a X2Go Server (Linux Remote Desktop). Its also possible to start only an remote application.",
        ret_codes = windows_error_codes
    }
}

include([[C:\pi\config\windows_registry_hacks.lua]])

do
    local installed, version, rev = is_in_installed_list("7zip")
    print(tostring(installed) .. " " .. version .. " " .. rev)
    print(is_upgrade_available("7zip", "9.20", "0"))
end

