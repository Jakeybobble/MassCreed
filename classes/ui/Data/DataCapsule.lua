-- DataCapsule.lua: Will instantiate children with a key value so that those values can be accessed
inherit("Element")

-- This class might not be able to get values from elements created after this has been created.
-- TODO: Fix that. Should be possible through Element:add_child()

local function add_keys(p, elements)
    for _,child in pairs(elements) do
        child.data_capsule = p -- TODO: Properly set the data capsule when data capsules can be inside data capsules
        if child.key then
            p.data_elements[child.key] = child
        end
        add_keys(p, child.elements)
    end
end

function class:init(options, elements)

    class.super.init(self, options, elements)

    self.data_elements = {}
    add_keys(self, elements)

    self.ping_func = options.ping_func or nil

end

-- Get value by key
function class:get(key)
    -- I don't know if I want to do this through a function.
    -- Considering refreshing from the input object every time the value changes.
    return self.data_elements[key].value
end

function class:ping(pinger)
    self.ping_func(self, pinger)
end