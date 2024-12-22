inherit("Element")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.orientation = options.orientation or "horizontal"
    -- Modes:\
    -- none - No resizing\
    -- "shrink" - Shrinks self to size of children\
    -- "fit" - Resizes children to fit inside element\
    self.mode = options.mode or "none"

    if self.orientation == "h" then
        self.orientation = "horizontal"
    elseif self.orientation == "v" then
        self.orientation = "vertical"
    end

    if self.orientation == "horizontal" then
        self.child_width = self.width / #self.elements
    else
        self.child_width = self.height / #self.elements
    end

    self.spacing = options.spacing or 0
    
    self:refresh()

end

function class:refresh()
    local child_w, child_h = 0, 0
    for i, v in ipairs(self.elements) do
        v.list_index = i
    end
end

function class:get_list_data(element)
    local x, y, w, h = element.x, element.y, element.width, element.height
    local pos = element.list_index
    --x, y = self.margins[4], self.margins[1]
    x, y = 0, 0

    if self.mode == "fit" then
        local child_width = 0
        if self.orientation == "horizontal" then
            child_width = (self.width - self.spacing * (#self.elements - 1) - self.margins[4] - self.margins[2]) / #self.elements
            w = child_width
        else
            child_width = (self.height - self.spacing * (#self.elements - 1) - self.margins[1] - self.margins[3]) / #self.elements
            h = child_width
        end
        
        
    end

    local prev = self.elements[pos-1]
    local total_width = 0
    if prev then
        local val = 0
        if self.orientation == "horizontal" then
            val = prev.x + prev.width + self.spacing
            x, total_width = val, val
        else
            val = prev.y + prev.height + self.spacing
            y, total_width = val, val
        end
    end
    
    if self.mode == "shrink" and pos == #self.elements then
        if self.orientation == "horizontal" then
            self.width = total_width + element.width + self.margins[3] + self.margins[1]
        else
            self.height = total_width + element.height + self.margins[2] + self.margins[4]
        end
        
    end

    -- I'd love to shorten this.
    if element.inherit_size == "width" then
        if self.orientation == "horizontal" then
            w = self.width - total_width - self.margins[2]
        else
            w = self.width - self.margins[2] * 2
        end
    elseif element.inherit_size == "height" then
        if self.orientation == "horizontal" then
            h = self.height - self.margins[3] * 2
        else
            h = self.height - total_width - self.margins[3]
        end
        
    elseif element.inherit_size == "both" then
        if self.orientation == "horizontal" then
            w = self.width - total_width - self.margins[2]
            h = self.height - self.margins[3] * 2
        else
            w = self.width - self.margins[2] * 2
            h = self.height - total_width - self.margins[3]
        end
        
    end

    return x, y, w, h
end

function class:add_child(element)
    element.parent = self
    table.insert(self.elements, element)
    self:refresh()
end