local module = {}

local class = require("lib/30log")

-- Fill names and paths
local trees = {}
local class_tables = {}

function module.register_classes(...)
    print("--- Registering classes ---")

    local args = {...}

    for k, v in pairs(args) do
        local class_path, class_table = v[1], v[2]
        table.insert(class_tables, class_table)
        local t = module.FillFileTree(class_path)
        -- t: {name = file_path}
        -- i.e: table = {"box" = "classes/obj/box.lua", "thing" = "classes/obj/thing.lua"}
        for name, file in pairs(t) do
            --trees[class_table][name] = file
            trees[name] = {file_path = file, class_table = class_table}
        end
    end

    for name, paths_classes in pairs(trees) do
        module.register_class(name)
    end

    print("----------------------------")

    module.run_post_load()
    --module.print_class_names()

end

local fs = love.filesystem

function module.register_class(name)
    local path = trees[name].file_path
    local class_table = trees[name].class_table

    if class_table[name] then return class_table[name] end

    local chunk = assert(fs.load(path))
    local env = {}
    setmetatable(env, {__index = _G })

    -- Inheritance
    local parent_name = nil
    env.inherit = function(p) -- TODO: Add argument for from what table to grab class from, or same as parent as default
        parent_name = p
    end
    
    -- Prepare class
    local obj = class(name)
    env.class = obj

    -- Run file in its own environment
    setfenv(chunk, env)
    chunk()

    if parent_name then
        local parent_class = module.register_class(parent_name)
        obj = parent_class:extend(name)
        obj.post_load = parent_class.post_load or nil
        env.class = obj
        chunk()
    end

    -- Add obj to table of all classes
    local register_string = "Registered class '"..name.."'"
    if parent_name then
        register_string = register_string.." inherited from "..parent_name
    end
    
    print(register_string)
    class_table[name] = obj

    return obj
end

function module.run_post_load()

    for _,v in pairs(class_tables) do
        for _,obj in pairs(v) do
            if obj.post_load ~= nil then
                obj.post_load(obj)
            end
        end
    end
end

function module.print_class_names()
    print("All classes:")
    local names = {}
    for k, v in pairs(trees) do
        table.insert(names, k)
    end
    print(table.concat(names, ", "))
end

-- Helper functions

function module.GetFileName(url)
    return url:match("(.+)%..+")
end

function module.FillFileTree(rootPath, tree)
    tree = tree or {}
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
                tree = module.FillFileTree(file, tree)
            end
        end
    end
    return tree
end

return module