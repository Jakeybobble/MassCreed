local module = {}

local class = require("lib/30log")
local helper = require("jakeylib/helper")

local obj_paths = {"obj", "rooms"}

-- Fill names and paths
local names_and_paths = {}

function module.register_classes()

    print("--- Registering classes ---")
    names_and_paths = helper.FillFileTree(obj_paths)

    for name, file in pairs(names_and_paths) do
        module.register_class(name)
    end

    print("----------------------------")

    module.run_post_load()

    --module.debug_instantiate_classes()

end

function module.register_class(name)
    local path = names_and_paths[name]

    if classes[name] then return classes[name] end

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
        local parent_class = classes[parent_name] or module.register_class(parent_name)
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
    classes[name] = obj

    return obj
end

function module.run_post_load()
    for _, obj in pairs(classes) do
        if obj.post_load ~= nil then
            obj.post_load(obj)
        end
    end
end

function module.debug_instantiate_classes()
    print("--- Instantiating classes ---")
    for _, thing in pairs(classes) do
        thing:new()
    end
end

return module