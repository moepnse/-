connections = {
    {   protocol = "smb",
        url = [[smb://\\10.0.19.10\software]],
        username = [[sds\sc]],
        password = "test"
    },
    {   protocol = "smb",
        url = [[smb://\\10.0.19.102\software]],
        interactive = true,
        prompt = true
    },
    {
        protocol = "http",
        url = "http://"
    },
    {
        protocol="http",
        url="https://"
    },
    {   protocol = "file",
        url = "file://"
    }
}