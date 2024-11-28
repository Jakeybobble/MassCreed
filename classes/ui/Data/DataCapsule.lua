-- DataCapsule.lua: Will instantiate children with a key value so that those values can be accessed
inherit("Element")

local function add_keys(element)
    -- TODO: Recursive function adding all the values...
end

function class:init(options, elements)

    class.super.init(self, options, elements)
    
    

end

function class:render()
    class.super.render(self)
    local child = self.elements[1]
    self.width = child.width
    self.height = child.height
end

-- Get value by key
function class:get(key)
    
end
