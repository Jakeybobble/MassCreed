local init = require("init_libraries")
local gui_handler = require("jakeylib/gui_handler")
local editor_settings = require("editor_settings")

current_view = nil

global_rooms = {}

local selectable_views = {}

function love.load()
    
    love.graphics.setBackgroundColor(0.157, 0.208, 0.251)
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    love.keyboard.setKeyRepeat(true)

    init.init()

    -- Set what views can be selected in ViewSelector
    selectable_views = {gameviews.Game, gameviews.Editor, gameviews.UiTesting}

    local view = editor_settings.get_init_view(selectable_views)
    current_view = view:new()

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

    if current_view == nil then
        current_view = gameviews.ViewSelector:new(selectable_views)
    end

    gui_handler.update_scroll()

    if current_view then
        current_view:update(dt)
    end
end

function love.keypressed(key)
    -- TODO: Move to ViewSelector view when pressing P
    if key == "p" then
        current_view = nil
    end

    if current_view then
        current_view:keypressed(key)
    end
 end

 function love.textinput(text)
    if current_view then
        current_view:textinput(text)
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

function love.wheelmoved(x, y)
    gui_handler.wheelmoved(x, y)
end