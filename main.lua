local init = require("init_libraries") -- Initiaizes pretty much everything... I hope

function love.load()
    init.init()
end

function love.draw()
    love.graphics.print("Hello dang world!")
end