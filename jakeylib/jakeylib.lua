local lib = {}
local class = require("lib/30log")

local obj_path = "obj/"

lib.init = function()
    print("Initializing Jakeylib...")

    local chunk = assert(loadfile("obj/tester.lua"))
    local env = {}

    setmetatable(env, {__index = _G })

    local parent = nil -- TODO: Parenting.

    env.inherit = function(p)
        parent = p
    end

    -- Creates a class and puts variables from the object inside
    setfenv(chunk, env)
    local obj = class("Name")
    env.class = obj
    chunk()

    for i,v in pairs(env) do
        if type(v) ~= "function" then
            obj[i] = v
        end
    end

    -- Instance testing

    local instance = obj:new()
    

end

return lib