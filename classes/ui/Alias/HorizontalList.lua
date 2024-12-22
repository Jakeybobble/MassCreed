inherit("ElementList")

function class:init(options, elements)
    options.orientation = "horizontal"
    class.super.init(self, options, elements)
end