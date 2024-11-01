-- Jakeylib 3.0
-- Created by Jakeybobble

local lib = {}
local class = require("lib/30log")
local helper = require("jakeylib/helper")

local obj_path = "obj/"

objects = {}

lib.init = function()
    print("Initializing Jakeylib...")

    lib.init_classes()
    -- TODO: Use recursion to load parent first.
    -- And also check that it hasn't been loaded already.

end

lib.init_classes = function()
    local res = love.filesystem.getDirectoryItems(obj_path)

    print("--- Initializing classes ---")
    for _, file in pairs(res) do
        local obj = lib.register_class(file)
    end
    print("--- Instantiating classes ---")
    for _, thing in pairs(objects) do
        thing:new()
    end
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
    
    -- Creates class and initializes it within its own environment
    local obj = class(name)
    env.class = obj
    setfenv(chunk, env)
    chunk()

    if parent then
        local parent_class = objects[parent] or lib.register_class(string.lower(parent..".lua"))
        obj = parent_class:extend(name)
        env.class = obj
    end
    
    -- Adds attributes to object
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
    
    print(register_string)
    objects[name] = obj

    return obj
end

return lib