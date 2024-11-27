-- Scroll.lua: Draws first child in canvas and adds scrolling if child dimensions are larger
inherit("Element")
local lg = love.graphics

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.orientation = options.orientation or "vertical" -- TODO: Add horizontal functionality
    self.scroll_x, self.scroll_y = options.scroll_x or 0, options.scroll_y or 0

end

function class:draw_above()
    -- TODO: Add mouse scrolling
    local h = self.elements[1].height
    local s = 5 -- Speed/sensitivity

    if love.keyboard.isDown("w") then
        self.scroll_y = self.scroll_y + 1 * s
    elseif love.keyboard.isDown("s") then
        self.scroll_y = self.scroll_y - 1 * s
    end

    if h > self.height then
    local min_offset = self.height - h
        self.scroll_y = math.min(math.max(self.scroll_y, min_offset), 0)
    else
        self.scroll_y = 0
    end

end

function class:render()
    lg.push("all")
    lg.stencil(function() lg.rectangle("fill", self.x + self.offset_x, self.y + self.offset_y, self.width, self.height) end, "replace", 1)
    lg.setStencilTest("greater", 0)
    lg.translate(self.scroll_x, self.scroll_y)
    class.super.render(self)
    lg.pop()
    self:draw_above()
end

