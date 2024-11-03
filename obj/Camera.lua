inherit("GameObject")

-- TODO: Give the camera the ability to draw to a rect

function class:init(x, y, width, height, scale)
    self.x, self.y = x, y
    self.width, self.height = width or 400, height or 250
    self.scale = scale or 2
end

function class:update(dt)
    self.x = self.x + 0.1
end

function class:draw(func)
    love.graphics.push()
    love.graphics.translate((self.width / 2) - self.x, (self.height / 2) - self.y)
    love.graphics.scale(self.scale)

    func()
    love.graphics.pop()
end