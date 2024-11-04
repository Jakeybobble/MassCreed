inherit("Room")

room_name = "TestRoom"

function class:init()
     self.super:init()

     self.image = love.graphics.newImage("assets/wormish.png")

end

function class:draw()
    love.graphics.draw(self.image)
end