inherit("Element")

function class:init(options, elements)
    class.super.init(self, options, elements)
end

function class:click()
    print("Button has been pressed.")
end