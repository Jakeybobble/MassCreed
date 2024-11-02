local module = {}

module.GetFileName = function(url)
    return url:match("(.+)%..+")
end

module.FirstToUpper = function(str)
    return (str:gsub("^%l", string.upper))
end

module.GetFileNameUpper = function(name)
    return module.FirstToUpper(module.GetFileName(name))
end

module.FillFileTree = function(rootPath, tree)
    tree = tree or {}
    local filesTable = love.filesystem.getDirectoryItems(rootPath)
    for i, v in ipairs(filesTable) do
        local file = rootPath.."/"..v
        local info = love.filesystem.getInfo(file)
        if info then
            if info.type == "file" then
                local name = module.GetFileNameUpper(v)
                if tree[name] ~= nil then error("Class file with non-unique name found.") end
                tree[name] = file
            elseif info.type == "directory" then
                tree = module.FillFileTree(file, tree)
            end
        end
    end
    return tree
end

return module