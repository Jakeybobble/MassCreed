-- DataCapsule.lua: Will instantiate children with a key value so that those values can be accessed
inherit("Element")

-- This class might not be able to get values from elements created after this has been created.
-- TODO: Fix that. Should be possible through Element:add_child()

local function add_keys(p, elements)
    for _,child in pairs(elements) do
        if child.key then
            p.data_elements[child.key] = child
            child.data_capsule = p -- Not sure if needed?
        end
        add_keys(p, child.elements)
    end
end

function class:init(options, elements)

    class.super.init(self, options, elements)

    self.data_elements = {}
    add_keys(self, elements)
    

end

function class:render()
    class.super.render(self)
    local child = self.elements[1]
    self.width = child.width
    self.height = child.height
end

-- Get value by key
function class:get(key)
    -- I don't know if I want to do this through a function.
    -- Considering refreshing from the input object every time the value changes.
    return self.data_elements[key].value
end