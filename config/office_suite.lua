do
    local _packages = {
        {   package_id = "libreoffice",
            name = "LibreOffice",
            version = "5.1.6",
            rev = 0,
            uninstall_cmds = 
                {
                    {
                        cmd = [["file://msiexec"]],
                        args = {
                            {   parameter = "/qn",
                                values = {
                                    {
                                        "",
                                        false
                                    }
                                }
                            },
                            {   parameter = "/x",
                                values = {
                                    {
                                        "http://mirror.7he.at/pub/tdf/libreoffice/stable/5.1.6/win/x86/LibreOffice_5.1.6_Win_x86.msi",
                                        true
                                    }
                                }
                            }
                        }
                    }
                },
            install_cmds = 
                {
                    {
                        cmd = [["file://msiexec"]],
                        args = {
                            {   parameter = "/qn",
                                values = {
                                    {
                                        "",
                                        false
                                    }
                                }
                            },
                            {   parameter = "/i",
                                values = {
                                    {
                                        "http://mirror.7he.at/pub/tdf/libreoffice/stable/5.1.6/win/x86/LibreOffice_5.1.6_Win_x86.msi",
                                        true
                                    }
                                }
                            }
                        }
                    }
                },
            is_installed = 
                function()
                    return is_in_software_list([[^LibreOffice]])
                end,
            is_upgrade_available = function()
                local installed, version, rev = is_in_installed_list("libreoffice")
                if installed and (version < "5.1.6" or (version == "5.1.6" and rev < "0")) then
                    return true
                end
                return false
            end,
            dependencies = {
            },
            keywords = {
                "office", "word", "writer"
            },
            description = "LibreOffice is a free and open source office suite.",
            ret_codes = windows_error_codes
        },
    }
    for k,v in ipairs(_packages) do
      table.insert(packages, v)
    end
end