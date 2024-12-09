inherit("Element")
local lg = love.graphics

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.color = options.color or {0,0,0}
    self.selected_color = options.selected_color or {0.3,0.3,0.3}
    self.border_color = options.border_color or {1, 1, 1}
    self.text = options.text or ""
    self.text_height = lg.getFont():getHeight()

    self.selected = false

end

function class:draw()
    local shrink = 3
    local x1, y1, x2, y2 = shrink, shrink, self.width - shrink * 2, self.height - shrink * 2
    lg.setColor(self.color)
    if self.selected then
        lg.setColor(self.selected_color)
    end
    lg.rectangle("fill", 0, 0, self.width, self.height)
    lg.setColor(self.border_color)
    lg.rectangle("line", x1, y1, x2, y2)
    lg.setColor(1, 1, 1, 1)

    lg.printf(self.text, 0, self.height / 2 - self.text_height/2, self.width, "center")



end