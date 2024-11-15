-- Jakeylib 3.0
-- Created by Jakeybobble

local lib = {}
local class = require("lib/30log")
local helper, jakeyclasses = require("jakeylib/helper"), require("jakeylib/classes")

-- Initializes Jakeylib.\
-- Args: {classes_path, classes_table}...\
-- Example:
-- ```Lua
-- jakeylib.init({"classes/obj", classes}, {"classes/rooms"}, rooms)
-- ```
lib.init = function(...)
    print("Initializing Jakeylib...")
    jakeyclasses.register_classes(...)
    -- TODO: Asserts
end

return lib