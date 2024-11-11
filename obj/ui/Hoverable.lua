inherit("Element")

function class:init(elements, x, y, width, height)
    self.super.init(self, elements, x, y, width, height)

    self.debug_visible = true

    
end

function class:draw()
    if self:is_hovered() then
        love.graphics.print("Mouse is inside.")
    end
end

function class:is_hovered()
    local g_x, g_y = love.graphics.transformPoint(0, 0)
    local m_x, m_y = love.mouse.getPosition()
    if m_x >= g_x and m_x <= g_x + self.width then
        if m_y >= g_y and m_y <= g_y + self.height then
            return true
        end
    end

    return false
end