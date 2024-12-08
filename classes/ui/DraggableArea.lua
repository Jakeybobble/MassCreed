-- DraggableArea.lua: An area inside an element that moves (configurable) parent position when dragged.
-- Bounds are the parent's parent.
inherit("Element")
local gui_handler = require("jakeylib/gui_handler")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.dragging = false
    self.last_mouse_pos = nil

end

local lm = love.mouse
function class:move()
    local mouse_x, mouse_y = lm.getPosition()

    if not self.last_mouse_pos then
        self.last_mouse_pos = { mouse_x, mouse_y }
    end

    self.parent.x = self.parent.x + mouse_x - self.last_mouse_pos[1]
    self.parent.y = self.parent.y + mouse_y - self.last_mouse_pos[2]

    self.last_mouse_pos = {mouse_x, mouse_y}

end