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
    local h = (self.orientation == "vertical" and self.elements[1].height) or self.elements[1].width
    

    self.scroll_y = self.scroll_y + gui_handler.scroll_value

    -- Clamping scroll value
    if h > ((self.orientation == "vertical" and self.height) or self.width) then
        local min_offset = ((self.orientation == "vertical" and self.height) or self.width) - h
        self.scroll_y = math.min(math.max(self.scroll_y, min_offset), 0)
    else
        self.scroll_y = 0
    end 

    -- Scrollbar
    -- TODO: Move scrollbar drawing to separate method
    if self.scrollbar == true then
        -- Lazy code alert -- TODO: Refactor for nicer code
        if self.orientation == "vertical" then
            local bar_height = (self.height / h) * self.height
            if bar_height < self.height then
                local bar_y = (-self.scroll_y / (h - self.height)) * (self.height - bar_height)
                local bar_width = 2
                lg.setColor(1, 1, 1, 0.5)
                lg.rectangle("fill", self.width - bar_width, bar_y, bar_width, bar_height)
                lg.setColor(1,1,1,1)
            end
        else
            local bar_width = (self.width / h) * self.width
            if bar_width < self.width then
                local bar_x = (-self.scroll_y / (h - self.width)) * (self.width - bar_width)
                local bar_height = 2
                lg.setColor(1, 1, 1, 0.5)
                lg.rectangle("fill", bar_x, self.height - bar_height, bar_width, bar_height)
                lg.setColor(1,1,1,1)
            end
        end
    end

end

function class:render()
    if self.enabled == false then do return end end
    local child = self.elements[1]
    self:set_transform()
    lg.push()
    lg.translate(self.x + self.offset_x, self.y + self.offset_y)
    self.global_x, self.global_y = lg.transformPoint(0,0)

    lg.push("all")

    lg.stencil(function() lg.rectangle("fill", 0, 0, self.width, self.height) end, "replace", 1)
    lg.setStencilTest("greater", 0)
    
    if self.orientation == "vertical" then
        lg.translate(0, self.scroll_y)
    else
        lg.translate(self.scroll_y, 0)
    end
    
    child:render()

    lg.pop()
    self:draw()

    if self.color then
        lg.setColor(self.color)
        lg.rectangle("fill", 0, 0, self.width, self.height)
        lg.setColor(1, 1, 1)
    end

    lg.pop()
    
end

