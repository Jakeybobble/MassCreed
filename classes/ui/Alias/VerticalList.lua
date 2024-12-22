inherit("ElementList")

function class:init(options, elements)
    options.orientation = "vertical"
    class.super.init(self, options, elements)
end