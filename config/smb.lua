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