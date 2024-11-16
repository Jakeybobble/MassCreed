-- Element.lua: The base element of any UI element

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

    self.margins = options.margins or {0}

    -- TODO: bool variable for keeping element inside its parent

end

class.draw = nil

function class:on_draw()
        
    if not self.visible then do return end end

    local margin = self.margins[1] -- TODO: Add margins for different sides

    love.graphics.push()
    local x, y = self.x + margin, self.y + margin

    -- X/Y is subtracted from the width/height to allow lists to fill the rest
    self.width = ((self.inherit_size == "width" or self.inherit_size == "both") and self.parent.width - self.x or self.width)
    self.height = ((self.inherit_size == "height" or self.inherit_size == "both") and self.parent.height - self.y or self.height)

    local width, height = self.width - margin*2, self.height - margin*2

    love.graphics.translate(x, y)
    self.global_x, self.global_y = love.graphics.transformPoint(0,0)

    if self.color then
        love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4] or 1)
        love.graphics.rectangle("fill", 0, 0, width, height)
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.draw ~= nil then self:draw() end

    for k, v in pairs(self.elements) do
        v:on_draw()
    end
    
    love.graphics.pop()
end

function class:resize(w, h)
    self.width, self.height = w, h
end

class.on_click = nil -- If an element should be able to be clickable without being a button, this should be changed.