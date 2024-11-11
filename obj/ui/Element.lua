-- Element.lua: The base element of any UI element

function class:init(elements, x, y, width, height)
    self.elements = elements or {}
    self.parent = nil
    self.x, self.y = x or 0, y or 0
    self.width, self.height = width or 0, height or 0

    self.depth = 0

    self.visible = true
    self.debug_visible = false

    for k, v in pairs(self.elements) do
        v.parent = self
    end

end

class.draw = nil

function class:on_draw()
        
    if not self.visible then do return end end

    love.graphics.push()
    love.graphics.translate(self.x, self.y)

    if self.draw ~= nil then self:draw() end

    for k, v in pairs(self.elements) do
        v:on_draw()
    end
    -- Debug draw
    love.graphics.setColor(1, 0, 0, 0.1)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(self.depth, 0, 12)
    
    love.graphics.pop()
end