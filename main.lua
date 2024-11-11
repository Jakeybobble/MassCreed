local init = require("init_libraries") -- Initiaizes pretty much everything... I hope
current_view = nil

global_rooms = {}

function love.load()
    
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    init.init()

    current_view = classes.Game:new()

end

function love.draw()
    --love.graphics.print("Hello dang world!")
    if current_view then
        current_view:draw()
    end
    
end

function love.update(dt)
    if current_view then
        current_view:update(dt)
    end
end

function love.keypressed(key)
    if key == "p" then
        if current_view.name == "Game" then
            print("Entered Game View")
            current_view = classes.Editor:new()
        elseif current_view.name == "Editor" then
            print("Entered Editor View")
            current_view = classes.Game:new()
        end
        do return end
    end
    

    if current_view then
        current_view:keypressed(key)
    end
 end

 function love.mousepressed(x, y, button, istouch)
    if current_view then
        current_view:mousepressed(x, y, button, istouch)
    end
 end