do
    local _packages = {
        {   package_id = "gajim",
            name = "Gajim",
            version = "0.16.1",
            rev = 0,
            uninstall_cmds = 
                {
                    {
                        cmd = [["file://%PROGRAMFILES(X86)%\Gajim\Uninstall.exe"]],
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
                        cmd = "https://gajim.org/downloads/0.16/gajim-0.16.6-1.exe",
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
                    return is_in_software_list([[^Gajim]])
                end,
            is_upgrade_available = function()
                local installed, version, rev = is_in_installed_list("gajim")
                if installed and (version < "0.16.1" or (version == "0.16.1" and rev < "0")) then
                    return true
                end
                return false
            end,
            dependencies = {
            },
            keywords = {
                "xmpp", "jabber"
            },
            description = "Gajim is an instant messaging client for the XMPP protocol which uses the GTK+ toolkit.",
            ret_codes = windows_error_codes
        },
    }
    for k,v in ipairs(_packages) do
      table.insert(packages, v)
    end
end