local init = require("init_libraries") -- Initiaizes pretty much everything... I hope
local game = require("game/game")

function love.load()
    
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    init.init()
    game.load()

end

function love.draw()
    --love.graphics.print("Hello dang world!")
    game.draw()
end

function love.update(dt)
    game.update(dt)
end

function love.keypressed(key)
    if key == "r" then
        if current_room ~= nil then
            current_room = classes.TestRoom:new()
        end
    end
 end