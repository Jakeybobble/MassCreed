local game = {}

global_rooms = {}
game.current_room = nil

game.current_camera = nil

function game.load()
    game.current_room = global_rooms["TestRoom"]:new()

    game.current_camera = classes["Camera"]:new(0, 0)
end

function game.draw()
    -- Draw everything in the camera view
    if game.current_camera then game.current_camera:draw(game.draw_world) end
    -- Draw anything above that, like GUI


end

function game.draw_world()
    if game.current_room then
        game.current_room:draw()
    end
end

function game.update(dt)

    if game.current_room then
        game.current_room:update(dt)
    end

    if game.current_camera then
        game.current_camera:update(dt)
    end
end

return game