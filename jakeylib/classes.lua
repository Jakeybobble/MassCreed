local module = {}

local class = require("lib/30log")
local helper = require("jakeylib/helper")

-- Fill names and paths
local names_and_paths = {}
local trees = {}

function module.register_classes(...)
    print("--- Registering classes ---")

    local args = {...}

    for k, v in pairs(args) do
        local class_path, class_table = v[1], v[2]
        --print(class_path, class_table)
        local t = helper.FillFileTree({class_path}) -- TODO: Clean off those parenthesis...
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

    -- These do currently not work.
    --module.debug_instantiate_classes()
    --module.print_class_names()

end

function module.register_class(name)
    --local path = names_and_paths[name]
    local path = trees[name].file_path
    local class_table = trees[name].class_table

    if class_table[name] then return class_table[name] end

    local chunk = assert(loadfile(path))
    local env = {}
    setmetatable(env, {__index = _G })

    -- Inheritance
    local parent_name = nil
    env.inherit = function(p)
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
    
    -- Adds attributes to class
    for k,v in pairs(env) do
        if type(v) ~= "function" then
            obj[k] = v
        end
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
    for k, v in pairs(trees) do
        local class_table = v.class_table
        for _, obj in pairs(class_table) do
            if obj.post_load ~= nil then
                obj.post_load(obj)
            end
        end
    end
end

function module.debug_instantiate_classes() -- TODO: Update me!
    print("--- Instantiating classes ---")
    for _, thing in pairs(classes) do
        thing:new()
    end
end

function module.print_class_names() -- TODO: Update me!
    print("All classes:")
    local names = {}
    for k, v in pairs(classes) do
        table.insert(names, v.name)
    end
    print(table.concat(names, ", "))
end

return module