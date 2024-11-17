inherit("Element")

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.orientation = options.orientation or "horizontal"
    -- Modes:\
    -- none - No resizing\
    -- "shrink" - Shrinks self to size of children\
    -- "fit" - Resizes children to fit inside element\
    self.mode = options.mode or "none"

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
        --[[
        v.order = i - 1
        v.align = self.orientation
        ]]--

        v.list_index = i
        
        -- TODO: This part could be made inside Element:draw() for more flexibility.
        --[[
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
        ]]
        
    end

    --[[
    if self.mode == "shrink" then
        if self.orientation == "horizontal" then
            self.width = child_w
        else
            self.height = child_h
        end
    end
    ]]
end

function class:get_list_data(element)
    local x, y, w, h = element.x, element.y, element.width, element.height
    local pos = element.list_index
    x, y = self.margins[4], self.margins[1]

    if self.mode == "fit" then
        local child_width = (self.height - self.spacing * (#self.elements - 1) - self.margins[1] - self.margins[3]) / #self.elements
        h = child_width
    end

    local prev = self.elements[pos-1]
    local total_width = 0
    if prev then
        local val = prev.y + prev.height + self.spacing
        y, total_width = val, val
    end
    
    if self.mode == "shrink" and pos == #self.elements then -- TODO: Horizontal case
        self.height = total_width + element.height + self.margins[2]
    end

    -- TODO: Horizontal case
    if element.inherit_size == "width" then
        w = self.width - self.margins[2] * 2
    elseif element.inherit_size == "height" then
        h = self.height - self.margins[3] * 2
    elseif element.inherit_size == "both" then
        w = self.width - self.margins[2] * 2
        h = self.height - total_width - self.margins[3]
    end

    return x, y, w, h
end