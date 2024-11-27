-- Scroll.lua: Draws first child in canvas and adds scrolling if child dimensions are larger
inherit("Element")
local lg = love.graphics
local gui_handler = require("jakeylib/gui_handler")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.orientation = options.orientation or "vertical" -- TODO: Add horizontal functionality
    self.scroll_x, self.scroll_y = options.scroll_x or 0, options.scroll_y or 0

    self.scrollbar = options.scrollbar or false

end

function class:draw()

    if not gui_handler.mouse_inside(self) then do return end end
    local h = self.elements[1].height

    self.scroll_y = self.scroll_y + gui_handler.scroll_value

    -- Clamping scroll value
    if h > self.height then
    local min_offset = self.height - h
        self.scroll_y = math.min(math.max(self.scroll_y, min_offset), 0)
    else
        self.scroll_y = 0
    end 

    -- Scrollbar
    if self.scrollbar == true then
        local bar_height = (self.height / h) * self.height
        if bar_height < self.height then
            local bar_y = (-self.scroll_y / (h - self.height)) * (self.height - bar_height)
            local bar_width = 2
            lg.setColor(1, 1, 1, 0.5)
            lg.rectangle("fill", self.width - bar_width, bar_y, bar_width, bar_height)
            lg.setColor(1,1,1,1)
        end
    end

end

function class:render()
    if not self.visible then do return end end
    local child = self.elements[1]
    self:set_transform()
    lg.push()
    lg.translate(self.x + self.offset_x, self.y + self.offset_y)
    self.global_x, self.global_y = lg.transformPoint(0,0)

    

    lg.push("all")

    lg.stencil(function() lg.rectangle("fill", 0, 0, self.width, self.height) end, "replace", 1)
    lg.setStencilTest("greater", 0)

    lg.translate(self.scroll_x, self.scroll_y)
    child:render()

    lg.pop()
    self:draw()
    lg.pop()
    
end

