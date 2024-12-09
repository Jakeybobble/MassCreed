inherit("ElementList")

function class:init(options, elements)
    class.super.init(self, options, elements)

    for i,v in ipairs(self.elements) do
        v.selected = false
    end

    self.selected_element = nil

    -- Potential feature: select multiple
end

function class:select(index) -- Run from button
    for i,v in ipairs(self.elements) do
        self.selected_element = v
        v.selected = (index == i and true) or false
    end
end