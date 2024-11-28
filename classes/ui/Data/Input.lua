-- Input.lua: Value input, such as strings and numbers...
inherit("Button")
local gui_handler = require("jakeylib/gui_handler")

function class:init(options, elements)
    class.super.init(self, options, elements)

    
    self.value_type = "string" -- Types: string, number, char (boolean should be for a separate checkbox input)

    -- Todo: Don't have this start at string
    self.value = options.value or "" -- The value which will be grabbed by DataCapsule

    self.selected = false

end

function class:draw()
    -- TODO: Hover thing

    if self.selected then
        love.graphics.setColor(1, 1, 1, 0.8)
    else
        love.graphics.setColor(1, 1, 1, 0.2)
        
    end
    love.graphics.rectangle("line", 0, 0, self.width, self.height)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.printf(self.value, 0,0, self.width, "center")
    

end

function class:on_click()
    class.super.on_click(self)
    gui_handler.selected_input = self
    self.selected = true
end

function class:keypressed(key)
    -- TODO: Handle backspace, enter, etc...
    self.value = self.value..key
end