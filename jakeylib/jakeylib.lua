-- Jakeylib 3.0
-- Created by Jakeybobble

local lib = {}
local class = require("lib/30log")
local helper, jakeyclasses = require("jakeylib/helper"), require("jakeylib/classes")

classes = {}

-- Initializes Jakeylib.\
-- Args: String names of folders which to add classes from, i.e. "rooms", "obj"...
lib.init = function(...)
    print("Initializing Jakeylib...")
    jakeyclasses.register_classes({...})

end

return lib