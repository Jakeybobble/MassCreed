-- Jakeylib 3.0
-- Created by Jakeybobble

local lib = {}
local class = require("lib/30log")
local helper = require("jakeylib/helper")

local obj_path = "obj/"

objects = {}

local logs = false

lib.print = function(str)
    if logs then print(str) end
end

lib.init = function(do_logs)
    lib.print("Initializing Jakeylib...")
    if do_logs then logs = do_logs end

    lib.register_classes()

end

lib.register_classes = function()
    local res = love.filesystem.getDirectoryItems(obj_path)

    lib.print("--- Registering classes ---")
    for _, file in pairs(res) do
        local obj = lib.register_class(file)
    end
    lib.print("----------------------------")

end

lib.register_class = function(file)
    local name = helper.FirstToUpper(helper.GetFileName(file))
    local path = obj_path..file

    if objects[name] then return objects[name] end

    local chunk = assert(loadfile(path))
    local env = {}
    setmetatable(env, {__index = _G })

    local parent = nil
    env.inherit = function(p)
        parent = p
    end
    
    -- Prepare class
    local obj = class(name)
    env.class = obj
    setfenv(chunk, env)
    -- Fills env with functions/variables
    chunk()

    if parent then
        local parent_class = objects[parent] or lib.register_class(string.lower(parent..".lua"))
        obj = parent_class:extend(name)
        env.class = obj
        chunk()
    end
    
    -- Adds attributes to class
    for i,v in pairs(env) do
        if type(v) ~= "function" then
            obj[i] = v
        end
    end

    -- Add obj to table of all classes
    local register_string = "Registered class '"..name.."'"
    if parent then
        register_string = register_string.." inherited from "..parent
    end
    
    lib.print(register_string)
    objects[name] = obj

    return obj
end

lib.debug_instantiate_classes = function()
    lib.print("--- Instantiating classes ---")
    for _, thing in pairs(objects) do
        thing:new()
    end
end

return lib