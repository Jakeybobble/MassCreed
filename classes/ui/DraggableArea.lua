-- DraggableArea.lua: An area inside an element that moves (configurable) parent position when dragged.
-- Bounds are the parent's parent.
inherit("Element")
local gui_handler = require("jakeylib/gui_handler")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.dragging = false
    self.last_mouse_pos = nil

    -- How far up the tree the parent to move is. 0 is self.
    self.parent_depth = options.parent_depth or 1
    
    --self.moving_parent = (self.parent_depth == 0 and self) or self:get_depth_parent(self, self.parent_depth)
    --print(self.moving_parent)
    self.moving_parent = nil

end

function class:get_depth_parent(element, depth)
    if depth == 0 then
        return element
    end
    return self:get_depth_parent(element.parent, depth - 1)
end

local lm = love.mouse
function class:move()
    if self.moving_parent == nil then
        self.moving_parent = self:get_depth_parent(self, self.parent_depth)
    end
    -- TODO: Clamp to prevent windows getting stuck...

    local mouse_x, mouse_y = lm.getPosition()

    if not self.last_mouse_pos then
        self.last_mouse_pos = { mouse_x, mouse_y }
    end

    self.moving_parent.x = self.moving_parent.x + mouse_x - self.last_mouse_pos[1]
    self.moving_parent.y = self.moving_parent.y + mouse_y - self.last_mouse_pos[2]

    self.last_mouse_pos = {mouse_x, mouse_y}

end