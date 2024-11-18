inherit("Button")
local gui = require("jakeylib/gui_handler")
local lerp = require("math/lerp")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.color = options.color or {0.5, 0.5, 0.5}

    self.shrink, self.shrink_to = 0, 0

    self.text = options.text or ""

    self.text_height = love.graphics.getFont():getHeight()

end

function class:draw()
    local text_offset = 0
    if gui.mouse_inside(self) then
        self.shrink_to = 3
        text_offset = -1
    else
        self.shrink_to = 0
        text_offset = 0
    end
    self.shrink = lerp(self.shrink, self.shrink_to, 0.5)
    
    local x1, y1, x2, y2 = self.shrink, self.shrink, self.width - self.shrink * 2, self.height - self.shrink * 2
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)
    love.graphics.setColor(self.color)
    love.graphics.rectangle("line", x1, y1, x2, y2)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.printf(self.text, 0, text_offset + (self.height / 2) - self.text_height/2, self.width, "center")



end

function class:on_click()
    class.super.on_click(self)
    
    self.shrink = 8
end