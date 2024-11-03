local module = {}

function module.GetFileName(url)
    return url:match("(.+)%..+")
end

function module.FillFileTree(rootPaths, tree)
    tree = tree or {}
    for _, rootPath in pairs(rootPaths) do
        local filesTable = love.filesystem.getDirectoryItems(rootPath)
        for i, v in ipairs(filesTable) do
            local file = rootPath.."/"..v
            local info = love.filesystem.getInfo(file)
            if info then
                if info.type == "file" then
                    local name = module.GetFileName(v)
                    if tree[name] ~= nil then error("Class file with non-unique name found.") end
                    tree[name] = file
                elseif info.type == "directory" then
                    tree = module.FillFileTree({file}, tree)
                end
            end
        end
    end
    return tree
end

return module