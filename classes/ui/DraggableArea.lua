-- DraggableArea.lua: An area inside an element that moves (configurable) parent position when dragged.
-- Bounds are the parent's parent.
inherit("Element")
local gui_handler = require("jakeylib/gui_handler")

function class:init(options, elements)
    class.super.init(self, options, elements)

    -- Which parent within the same tree (backwards) to move
    self.parent_depth = options.parent_depth or 1

end