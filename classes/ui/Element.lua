-- Element.lua: The base element of any UI element
local lg = love.graphics

function class:init(options, elements)
    
    options = options or {}

    self.elements = elements or {}
    self.parent = nil

    self.inherit_size = options.inherit_size or "none"

    self.x, self.y = options.x or 0, options.y or 0
    self.width, self.height = options.width or 0, options.height or 0

    self.frontable = options.frontable or false
    self.depth = 0

    self.visible = true
    self.color = options.color or nil

    for k, v in pairs(self.elements) do
        v.parent = self
    end

    self.global_x, self.global_y = 0, 0

    self.click = options.click or nil

    -- Margins order: Top, right, bottom left
    local _m = options.margins
    if _m then
        if #_m == 1 then
            -- All
            self.margins = {_m[1], _m[1], _m[1], _m[1]}
        elseif #_m == 2 then
            -- Top bottom
            self.margins = {_m[1], _m[2], _m[1], _m[2]}
        elseif #_m == 3 then
            -- Top, left/right, bottom
            self.margins = {_m[1], _m[2], _m[3], _m[2]}
        else
            self.margins = options.margins
        end
    else
        self.margins = {0, 0, 0, 0}
    end

    self.combined_margins = {0, 0} -- This was previously {self.margins[2], self.margins[3]} and I don't remember why.

    self.list_index = nil

    if options.init_func then
        options.init_func(self)
    end

    self.offset_x, self.offset_y = 0, 0 -- Were first a local variable in render(), might consider moving back

end

class.draw = nil

function class:set_transform()
    local x, y = self.x, self.y
    local w, h = self.width, self.height
    local offset_x, offset_y = 0, 0

    local margins = {0, 0}

    if self.parent then
        self.offset_x = self.parent.margins[4]
        self.offset_y = self.parent.margins[1]

        margins = self.parent.combined_margins
        self.combined_margins = {self.margins[2] + margins[1], self.margins[3] + margins[2]}
    
    end

    if self.list_index ~= nil then
        local _x, _y, _w, _h = self.parent:get_list_data(self)
        x, y, w, h = _x, _y, _w, _h
    else
        if self.inherit_size == "both" then
            w = self.parent.width - x - self.parent.combined_margins[1]
            h = self.parent.height - y - self.parent.combined_margins[2]
        elseif self.inherit_size == "width" then
            w = self.parent.width - x - self.parent.combined_margins[1]
        elseif self.inherit_size == "height" then
            h = self.parent.height - y - self.parent.combined_margins[2]
        end
    end
    self.x, self.y = x, y
    self.width, self.height = w, h
end

function class:render()
    
    if not self.visible then do return end end

    self:set_transform()

    lg.push()
    lg.translate(self.x + self.offset_x, self.y + self.offset_y)
    self.global_x, self.global_y = lg.transformPoint(0,0)

    if self.color then
        lg.setColor(self.color[1], self.color[2], self.color[3], self.color[4] or 1)
        lg.rectangle("fill", 0, 0, self.width, self.height)
        lg.setColor(1, 1, 1, 1)
    end

    if self.draw ~= nil then self:draw() end
    for k, v in pairs(self.elements) do
        v:render()
    end
    
    lg.pop()
end

function class:resize(w, h)
    self.width, self.height = w, h
end

function class:add_child(element)
    element.parent = self
    table.insert(self.elements, element)
end

class.on_click = nil -- If an element should be able to be clickable without being a button, this should be changed.
class.init_func = nil