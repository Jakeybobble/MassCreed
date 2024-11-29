-- Input.lua: Value input, such as strings and numbers...
inherit("Button")
local gui_handler = require("jakeylib/gui_handler")
local utf8 = require("utf8")

function class:init(options, elements)
    class.super.init(self, options, elements)

    
    self.value_type = "string" -- Types: string, number, char (boolean should be for a separate checkbox input)

    -- Todo: Don't have this start at string
    self.value = options.value or "" -- The value which will be grabbed by DataCapsule

    self.selected = false

    self.locked = options.locked or false

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
    if self.locked == false then
        gui_handler.selected_input = self
        self.selected = true
    end
end

function class:keypressed(key)
    -- TODO: Handle backspace, enter, etc...
    if key == "backspace" then
        local byteoffset = utf8.offset(self.value, -1)
        if byteoffset then
            self.value = string.sub(self.value, 1, byteoffset - 1)
        end
    elseif key == "return" then
        gui_handler.selected_input = nil
        self.selected = false
        -- TODO: Have the option to activate something in self.data_capsule if specified
    end
end

function class:textinput(text)
    self.value = self.value..text
end