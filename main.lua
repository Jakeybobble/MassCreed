local init = require("init_libraries")
local gui_handler = require("jakeylib/gui_handler")

current_view = nil

global_rooms = {}

local selectable_views = {}

-- Returns preferred view from editor_settings.txt
function get_init_view()
    -- TODO: Always go to Game if fused
    local fs = love.filesystem

    local file_name = "editor_settings.txt"
    local file = fs.getInfo(file_name)
    local fall_back = false

    local fall_back_view = gameviews.Game

    if file == nil then
        local success, message = fs.write(file_name, "preferred_view=Game")
        if success then
            print("Created new '"..file_name.."' in "..fs.getSaveDirectory())
        else
            print("File write in '"..fs.getSaveDirectory().."' failed. Falling back to default Game GameView.\nException message: "..message)
            return fall_back_view
        end
    end

    local lines = fs.lines(file_name)

    -- Fill table with keys and values from editor_settings.txt
    local t = {}
    for line in lines do
        local key, value = string.match(line, "(.+)=(.+)")
        t[key] = value
    end

    -- Return view class if name in settings matches
    if t.preferred_view then
        for i, v in ipairs(selectable_views) do
            if v.name == t.preferred_view then
                return v
            end
        end
    end

    return fall_back_view
end

function love.load()
    
    love.graphics.setBackgroundColor(0.157, 0.208, 0.251)
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    love.keyboard.setKeyRepeat(true)

    init.init()

    -- Set what views can be selected in ViewSelector
    selectable_views = {gameviews.Game, gameviews.Editor, gameviews.UiTesting}

    local view = get_init_view()
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

    gui_handler.update_scroll()

    if current_view then
        current_view:update(dt)
    end
end

function love.keypressed(key)
    -- TODO: Move to ViewSelector view when pressing P

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