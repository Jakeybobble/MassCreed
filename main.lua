local init = require("init_libraries") -- Initiaizes pretty much everything... I hope
local game = require("game/game")

function love.load()
    
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    init.init()
    game.load()

    print(game.current_camera)

    

end

function love.draw()
    --love.graphics.print("Hello dang world!")
    if game then
        game.draw()
    end
    
end

function love.update(dt)
    if game then
        game.update(dt)
    end
end

function love.keypressed(key)
    if key == "r" then
        if current_room ~= nil then
            current_room = classes.TestRoom:new()
        end
    elseif key == "p" then
        game = nil
    end
 end