inherit("GameView")

function class:init()
    self.element = classes.Element:new({
        classes.Element:new()
    })
end

function class:draw()
    love.graphics.print("Welcome to the (in its current state) editor view.")
    self.element.on_draw()

end

function class:update(dt)

end