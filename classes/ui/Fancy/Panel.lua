inherit("Element")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.border_color = options.border_color or {1, 1, 1}
    self.text = options.text or ""
    self.text_height = love.graphics.getFont():getHeight()

end

function class:draw()
    local shrink = 3
    local x1, y1, x2, y2 = shrink, shrink, self.width - shrink * 2, self.height - shrink * 2
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)
    love.graphics.setColor(self.border_color)
    love.graphics.rectangle("line", x1, y1, x2, y2)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.printf(self.text, 0, self.height / 2 - self.text_height/2, self.width, "center")



end