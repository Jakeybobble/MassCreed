inherit("Element")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.orientation = options.orientation or "horizontal" -- TODO: Add this feature
    self.mode = "none" -- TODO: Add this feature: Option to resize children

    self:update_order()

    self.child_width = self.width / #self.elements

end

function class:update_order()
    for i, v in ipairs(self.elements) do
        v.order = i - 1
        v.align = "horizontal"
    end
end