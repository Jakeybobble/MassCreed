local init = require("init_libraries") -- Initiaizes pretty much everything... I hope
game = nil
room_editor = nil

global_rooms = {}

function love.load()
    
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    init.init()

    -- Load game
    game = require("game/game")
    game.load()

end

function love.draw()
    --love.graphics.print("Hello dang world!")
    if game then
        game.draw()
    elseif room_editor then -- TODO: Turn both game and room_editor into separate classes inhereting a view? I really dislike how repetitive this is...
        room_editor.draw()
    end
    
end

function love.update(dt)
    if game then
        game.update(dt)
    elseif room_editor then
        room_editor.update(dt)
    end
end

function love.keypressed(key)
    if key == "r" then
        if current_room ~= nil then
            current_room = classes.TestRoom:new()
        end
    elseif key == "p" then
        if game then
            room_editor = require("jakeylib/roomeditor/editor")
            room_editor.load()
            game = nil

        else
            game = require("game/game")
            game.load()
            room_editor = nil
        end
    end
 end