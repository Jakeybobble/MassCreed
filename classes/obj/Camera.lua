inherit("GameObject")

-- TODO: Give the camera the ability to draw to a rect

function class:init(x, y, width, height, scale, boundaries)
    self.x, self.y = x, y
    self.width, self.height = width or 400, height or 250
    self.scale = scale or 2
    self.boundaries = boundaries or {
        x1 = 0, y1 = 0,
        x2 = 1000, y2= 1000
    }
end

function class:update(dt)
    -- Simple camera movement
    local keys = love.keyboard
    local hsp = (keys.isDown("d") and 1 or 0) - (keys.isDown("a") and 1 or 0)
    local vsp = (keys.isDown("s") and 1 or 0) - (keys.isDown("w") and 1 or 0)
    local speed = 3
    self.x = self.x + hsp * speed
    self.y = self.y + vsp * speed
    
    self:clamp_to_boundaries()
end

function class:draw(func)
    love.graphics.push()
    love.graphics.translate((self.width / 2) - self.x, (self.height / 2) - self.y)
    love.graphics.scale(self.scale)

    func()
    love.graphics.pop()
end

function class:clamp_to_boundaries()
    self.x = math.min(math.max(self.x, self.boundaries.x1 + self.width / 2), self.boundaries.x2 - self.width / 2)
    self.y = math.min(math.max(self.y, self.boundaries.y1 + self.height / 2), self.boundaries.y2 - self.height / 2)
end