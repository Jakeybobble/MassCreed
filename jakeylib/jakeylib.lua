-- Jakeylib 3.0
-- Created by Jakeybobble

local lib = {}
local class = require("lib/30log")
local helper, jakeyclasses = require("jakeylib/helper"), require("jakeylib/classes")

classes = {}

lib.init = function()
    print("Initializing Jakeylib...")

    jakeyclasses.register_classes()

end

return lib