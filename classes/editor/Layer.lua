local editor_handler = require("jakeylib.editor_handler")

function class.post_load(class)
    if class.name ~= "Layer" then
        editor_handler.add(class)
    end
end

class.type_name = "Layer"

function class:init()
    self.name = "Layer" -- Default layer display name

    self.DEBUG_random = love.math.random(10)
    print(self.DEBUG_random)
end

function class:draw_world() -- Draw in the editor world
    love.graphics.print(self.DEBUG_random, 200 + self.DEBUG_random*20, self.DEBUG_random*20)
end