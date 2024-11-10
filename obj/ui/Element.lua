function class:init(parent, x, y, width, height)
    self.parent = parent
    self.x, self.y = x or 0, y or 0
    self.width, self.height = width or 0, height or 0

    self.visible = true

    self.elements = {}


end