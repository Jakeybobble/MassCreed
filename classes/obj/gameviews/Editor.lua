inherit("GameView")
local gui_handler = require("jakeylib/gui_handler")

function class:init()

    local w, h = love.window.getMode()
    self.element = ui.Element:new({width=w, height=h}, {

        ui.ElementList:new({width = 64, height = 500, orientation="vertical"}, {
            ui.ColorButton:new({width = 64, height = 64, color={0.5, 0.5, 0.5}}),
            ui.ColorButton:new({width = 64, height = 64, color={0.5, 0.5, 0.5}}),
            ui.ColorButton:new({width = 64, height = 64, color={0.5, 0.5, 0.5}, click = function(obj)
                print("Ok.")
                obj.width = obj.width + 5
            end})
        }),

        ui.ElementList:new({x = 128, width = 500, height = 64, orientation="horizontal"}, {
            ui.ColorButton:new({width = 64, height = 64, color={0.5, 0.5, 0.5}}),
            ui.ColorButton:new({width = 64, height = 64, color={0.5, 0.5, 0.5}}),
            ui.ColorButton:new({width = 64, height = 64, color={0.5, 0.5, 0.5}})
        }),

        ui.ElementList:new({x = 128, y = 128, width = 64*5, height = 64, orientation="horizontal", mode="fit"}, {
            ui.ColorButton:new({height = 64, color={0.5, 0.5, 0.5}}),
            ui.ColorButton:new({height = 64, color={0.5, 0.5, 0.5}}),
            ui.ColorButton:new({height = 64, color={0.5, 0.5, 0.5}})
        }),

        ui.ElementList:new({y = 64*4, width = 64, height = 64*5, orientation="vertical", mode="fit"}, {
            ui.ColorButton:new({width = 64, color={0.5, 0.5, 0.5}}),
            ui.ColorButton:new({width = 64, color={0.5, 0.5, 0.5}}),
            ui.ColorButton:new({width = 64, color={0.5, 0.5, 0.5}})
        }),
    })
end

function class:draw()
    self.element:on_draw()

end

function class:update(dt)

end

function class:mousepressed(x, y, button, istouch)
    gui_handler.handle_click(self.element)
    --print(gui_handler.mouse_inside(self.element.elements[1]))
end

function class:resize(w, h)
    self.element:resize(w,h)
end