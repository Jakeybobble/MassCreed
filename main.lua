local init = require("init_libraries") -- Initiaizes pretty much everything... I hope
local game = require("game/game")

function love.load()
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