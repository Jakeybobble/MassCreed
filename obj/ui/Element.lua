-- Element.lua: The base element of any UI element

function class:init(options, elements)
    
    options = options or {}

    self.elements = elements or {}
    self.parent = nil
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

end

class.draw = nil

function class:on_draw()
        
    if not self.visible then do return end end

    love.graphics.push()
    local x, y = self.x, self.y

    love.graphics.translate(x, y)
    self.global_x, self.global_y = love.graphics.transformPoint(0,0)

    if self.color then
        love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4] or 1)
        love.graphics.rectangle("fill", 0, 0, self.width, self.height)
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