local editor_handler = require("jakeylib.editor_handler")

function class.post_load(class)
    if class.name ~= "Layer" then
        editor_handler.add(class)
    end
end

class.type_name = "Layer"

function class:init()
    self.name = "Layer" -- Default layer display name
end