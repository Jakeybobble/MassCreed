-- Scroll.lua: Draws first child in canvas and adds scrolling if child dimensions are larger
inherit("Element")
function class:init(options, elements)
    class.super.init(self, options, elements)

    self.orientation = options.orientation or "vertical"
    self.scroll_x, self.scroll_y = options.scroll_x or 0, options.scroll_y or 0

    self.canvas = nil

    self.inherit_size = "both"

    self.color = {1, 0, 0, 0.3}

end