local module = {}

local jakeylib = require("jakeylib/jakeylib")

-- Table of general classes
classes = {}
-- Table of UI element classes
ui = {}
-- Table of room classes
rooms = {}

module.init = function()
    jakeylib.init({"classes/obj", classes}, {"classes/ui", ui}, {"classes/rooms", rooms})
end

return module