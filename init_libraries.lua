local module = {}

local jakeylib = require("jakeylib/jakeylib")

module.init = function()
    jakeylib.init("obj", "rooms")
end

return module