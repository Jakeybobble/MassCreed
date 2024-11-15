inherit("Element")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.orientation = options.orientation or "horizontal"
    -- Modes:\
    -- nil - No resizing\
    -- "shrink" - Shrinks self to size of children\
    -- "fit" - Resizes children to fit inside element (TODO)\
    self.mode = options.mode or "shrink"

    if self.orientation == "horizontal" then
        self.child_width = self.width / #self.elements
    else
        self.child_width = self.height / #self.elements
    end

    self:refresh()

end

function class:refresh()
    local child_w, child_h = 0, 0
    for i, v in ipairs(self.elements) do
        --[[
        v.order = i - 1
        v.align = self.orientation
        ]]--
        
        -- TODO: This part could be made inside Element:draw() for more flexibility.
        if self.mode == "fit" then
            if self.orientation == "horizontal" then
                v.x = self.child_width * (i-1)
                v.width = self.child_width
            else
                v.y = self.child_width * (i-1)
                v.height = self.child_width
            end
        else
            if self.orientation == "horizontal" then
                v.x = child_w
            else
                v.y = child_h
            end
        end
        child_w, child_h = child_w + v.width, child_h + v.height
        
    end

    if self.mode == "shrink" then
        if self.orientation == "horizontal" then
            self.width = child_w
        else
            self.height = child_h
        end
    end
end