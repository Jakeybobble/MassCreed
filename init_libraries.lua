local module = {}

local jakeylib = require("jakeylib/jakeylib")

module.init = function()
    jakeylib.init(true)
end

return module