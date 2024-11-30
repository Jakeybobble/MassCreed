inherit("GameView")
local lerp = require("math/lerp")
local editor_settings = require("editor_settings")

function class:init(selectable_views)
    self.selectable_views = selectable_views
    self.cursor = 1
    self.squish = 0
    self.info_text = ""
    self.set_view = nil

    -- Wishlist (but unnecessary): Return to last room if P is pressed

end

local lg = love.graphics
function class:draw()
    local window_w, window_h = love.window.getMode()
    lg.setColor(0,0,0)
    lg.rectangle("fill", 16, 16, window_w - 32, window_h - 32)
    lg.setColor(1,1,1)
    lg.rectangle("line", 24, 24, window_w - 48, window_h - 48)
    local x, y = 48, 48
    local c_x, c_y = window_w / 4, window_h / 4
    local h = 20
    local cursor_w = 16
    lg.print("GameView selector. Press Q to set selected view as default on start-up!", x, y)

    lg.print(self.info_text, x, y + h)

    for i,v in ipairs(self.selectable_views) do
        local y = y + h + (i * h)
        lg.print(v.name, cursor_w + x, y)
        if self.cursor == i then
            lg.rectangle("line", x, y + self.squish, 8, 16 - self.squish*2)
        end
    end

    self.squish = lerp(self.squish, 0, 0.1)

end

function class:keypressed(key)
    local vsp = 0
    if key == "w" or key == "up" then vsp = -1 end
    if key == "s" or key == "down" then vsp = vsp + 1 end

    self.cursor = ((self.cursor + vsp - 1) % #self.selectable_views) + 1

    self.squish = 5

    local class = self.selectable_views[self.cursor]

    if key == "q" and class.name ~= self.set_view then
        local success = editor_settings.write_preferred_view(class.name)
        if success then
            local success_text = "Preferred view has been set to "..class.name.."!"
            self.info_text = success_text
            self.set_view = class.name
            print(success_text)
        end
    end

    if key == "return" or key == "e" then
        -- Set global current_view to instantiated/selected GameView
        _G.current_view = class:new()
    end

end