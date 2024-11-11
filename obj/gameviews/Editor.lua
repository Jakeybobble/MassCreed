inherit("GameView")

function class:init()
    self.element = classes.Element:new({
        classes.Hoverable:new(nil, 50, 0, 200, 80),
        classes.Hoverable:new(nil, 100, 50, 200, 80)
    }, 50, 50)
end

function class:draw()
    love.graphics.print("Welcome to the (in its current state) editor view.")
    self.element:on_draw()

end

function class:update(dt)

end

function class:mousepressed(x, y, button, istouch)
    
end