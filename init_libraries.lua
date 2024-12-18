local module = {}

local jakeylib = require("jakeylib/jakeylib")

-- Table of general classes
classes = {}
-- Table of UI element classes
ui = {}
-- Table of room classes
rooms = {}
-- Table of editor classes
editor = {}
-- Table of gameview classes
gameviews = {}

module.init = function()
    jakeylib.init(
    {"classes/obj", classes},
    {"classes/ui", ui},
    {"classes/rooms", rooms},
    {"classes/editor", editor},
    {"classes/gameviews", gameviews})
end

return module