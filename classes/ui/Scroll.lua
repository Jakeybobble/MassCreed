-- Scroll.lua: Draws first child in canvas and adds scrolling if child dimensions are larger
inherit("Element")
local lg = love.graphics
local gui_handler = require("jakeylib/gui_handler")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.orientation = options.orientation or "vertical" -- TODO: Add horizontal functionality
    self.scroll_x, self.scroll_y = options.scroll_x or 0, options.scroll_y or 0

end

function class:draw_above()
    -- TODO: Add mouse scrolling

    if not gui_handler.mouse_inside(self) then do return end end

    local h = self.elements[1].height
    local s = 5 -- Speed/sensitivity

    self.scroll_y = self.scroll_y + gui_handler.scroll_value

    if h > self.height then
    local min_offset = self.height - h
        self.scroll_y = math.min(math.max(self.scroll_y, min_offset), 0)
    else
        self.scroll_y = 0
    end

end

function class:render()
    if not self.visible then do return end end

    lg.push("all")

    -- FIXME: Currently, the position of this element is being set properly, x/y relies on the scroll.
    -- This might also be the reason to why margins aren't working properly on this object.
    lg.stencil(function() lg.rectangle("fill", self.x + self.offset_x, self.y + self.offset_y, self.width, self.height) end, "replace", 1)
    
    lg.setStencilTest("greater", 0)
    lg.translate(self.scroll_x, self.scroll_y)
    class.super.render(self)

    self.global_x = self.x + self.offset_x
    self.global_y = self.y + self.offset_y

    lg.pop()
    self:draw_above()
end

