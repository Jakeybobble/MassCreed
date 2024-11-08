inherit("GameObject")

function class:init(x, y, rot, depth)
    class.super.init(self, x, y, rot, depth)

    self.image = love.graphics.newImage("assets/wormish.png")

    self.increment = 0
end

function class:update(dt)
    class.super:update(dt)
    self.increment = self.increment + 1 * dt
    self.draw_x = self.x + math.sin(self.increment) * 25

end

function class:draw()
    love.graphics.draw(self.image, self.draw_x, self.y)
end