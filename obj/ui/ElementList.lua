inherit("Element")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.orientation = options.orientation or "horizontal"
    self.mode = "none" -- TODO: Add this feature: Option to resize children

    self:update_order()

    if self.orientation == "horizontal" then
        self.child_width = self.width / #self.elements
    else
        self.child_width = self.height / #self.elements
    end
    

end

function class:update_order()
    for i, v in ipairs(self.elements) do
        v.order = i - 1
        v.align = self.orientation
    end
end