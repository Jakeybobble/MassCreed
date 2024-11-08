inherit("GameObject")

function class:init(x, y, rot, depth)
    class.super:init(x, y, rot, depth)

    self.image = love.graphics.newImage("assets/wormish.png")

    self.increment = 0
end

function class:update(dt)
    class.super:update(dt)
    self.increment = self.increment + 1 * dt
    self.x = 50 + math.sin(self.increment) * 25

end

function class:draw()
    love.graphics.draw(self.image, self.x, self.y)
end