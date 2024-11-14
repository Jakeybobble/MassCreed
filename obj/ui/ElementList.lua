inherit("Element")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.orientation = options.orientation or "horizontal"
    -- Modes:\
    -- nil - Regular behavior\
    -- "shrink" - Shrinks self to size of children\
    -- "fit" - Resizes children to fit inside element (TODO)\
    self.mode = "shrink"

    if self.orientation == "horizontal" then
        self.child_width = self.width / #self.elements
    else
        self.child_width = self.height / #self.elements
    end

    self.debug_visible = true



    self:refresh()

end

function class:refresh()
    local child_w, child_h = 0, 0
    for i, v in ipairs(self.elements) do
        v.order = i - 1
        v.align = self.orientation
        
        if self.orientation == "horizontal" then
            v.x = child_w
        else
            v.y = child_h
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