inherit("Element")

function class:init(options, elements)
    class.super.init(self, options, elements)
end

function class:on_click()
    if self.click then self.click() end
end