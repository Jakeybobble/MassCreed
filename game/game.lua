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
    love.graphics.print("Game is running.")
end

function game.draw_world()
    love.graphics.print("Darn.")
end

function game.update(dt)
    if current_camera then
        current_camera:update(dt)
    end
end

return game