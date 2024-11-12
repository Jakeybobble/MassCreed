inherit("Element")

function class:init(options, elements)
    self.super.init(self, options, elements)
    self.debug_visible = true
end

function class:click()
    print("Button has been pressed.")
end