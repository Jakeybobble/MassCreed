local game = {}

global_rooms = {}
current_room = nil

current_camera = nil

function game.load()
    current_room = global_rooms["TestRoom"]:new()

    current_camera = classes["Camera"]:new(0, 0)
end

function game.draw()
    -- Draw everything in the camera view
    if current_camera then current_camera:draw(game.draw_world) end
    -- Draw anything above that, like GUI


end

function game.draw_world()
    if current_room then
        current_room:draw()
    end
end

function game.update(dt)
    if current_camera then
        current_camera:update(dt)
    end
end

return game