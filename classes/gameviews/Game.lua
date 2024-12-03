inherit("GameView")

function class:init()

    love.graphics.setBackgroundColor(0.157, 0.208, 0.251)

    self.current_room = global_rooms["TestRoom"]:new()
    self.current_camera = classes["Camera"]:new(0,0)
end

function class:draw()
    if self.current_camera then
        self.current_camera:draw(function() self:draw_world() end)
     end
end

function class:draw_world()
    if self.current_room then
        self.current_room:draw()
    end
end

function class:update(dt)
    if self.current_room then
        self.current_room:update(dt)
    end

    if self.current_camera then
        self.current_camera:update(dt)
    end
end

function class:keypressed(key)
    if key == "r" then
        if self.current_room ~= nil then
            self.current_room = rooms.TestRoom:new()
        end
    end
end