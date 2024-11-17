local init = require("init_libraries") -- Initiaizes pretty much everything... I hope
current_view = nil

global_rooms = {}

function love.load()
    
    love.graphics.setBackgroundColor(0.157, 0.208, 0.251)
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    init.init()

    --current_view = classes.Game:new()
    current_view = classes.Editor:new()

end

local draw_black_timer = 0
local draw_black_timer_max = 30

function love.draw()
    --love.graphics.print("Hello dang world!")
    if current_view then
        current_view:draw()
    end

    if draw_black_timer > 0 then
        draw_black_timer = draw_black_timer - 1
        local alpha = draw_black_timer / draw_black_timer_max
        love.graphics.setColor(0, 0, 0, alpha)
        local w, h = love.window.getMode()
        love.graphics.rectangle("fill", 0, 0, w, h)
        love.graphics.setColor(1, 1, 1)
        
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

 function love.resize(w, h)
    draw_black_timer = draw_black_timer_max
    if current_view then
        current_view:resize(w, h)
    end
end