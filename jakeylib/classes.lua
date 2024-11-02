local module = {}

local class = require("lib/30log")
local helper = require("jakeylib/helper")

local obj_path = "obj/"

module.register_classes = function()
    local res = love.filesystem.getDirectoryItems(obj_path)

    print("--- Registering classes ---")
    for _, file in pairs(res) do
        local obj = module.register_class(file)
    end
    print("----------------------------")

end

module.register_class = function(file) -- TODO: Work with paths instead to allow folder recursion
    local name = helper.FirstToUpper(helper.GetFileName(file))
    local path = obj_path..file

    if classes[name] then return classes[name] end

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
        local parent_class = classes[parent] or module.register_class(string.lower(parent..".lua"))
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
    
    print(register_string)
    classes[name] = obj

    return obj
end

module.debug_instantiate_classes = function()
    print("--- Instantiating classes ---")
    for _, thing in pairs(classes) do
        thing:new()
    end
end

return module