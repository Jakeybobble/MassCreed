inherit("GameView")
local gui_handler = require("jakeylib/gui_handler")

function class:init()

    local w, h = love.window.getMode()
    self.element = ui.Element:new({width=w, height=h}, {
        -- Layers panel
        ui.Panel:new({width=200, height=300, x = 5, y = 5}, {
            ui.ElementList:new({inherit_size = "both", margins={10}, orientation = "vertical", color={0, 1, 1, 0.5}}, {
                ui.Panel:new({inherit_size = "width", height = 50, text = "Layers"}),
                ui.Panel:new({inherit_size = "width", height = 50, text = "Layers"}),
                ui.ElementList:new({inherit_size = "both", orientation="vertical", color = {1, 0, 0, 0.5}})
            })
        }),

        ui.ElementList:new({x=300, mode="fit", margins={10, 10}, width=200, height=400, orientation="vertical", color = {1, 1, 1, 0.2}}, {
            ui.ColorButton:new({inherit_size = "width", height=32}),
            ui.ColorButton:new({inherit_size = "width", height=32}),
            ui.ColorButton:new({inherit_size = "width", height=32}),
            ui.ColorButton:new({inherit_size = "width", height=32})
        }),

        ui.ElementList:new({x=520, mode="fit", margins={10, 10}, width=200, height=400, orientation="vertical", color = {1, 1, 1, 0.2}}, {
            ui.ElementList:new({mode="fit", margins={10, 10}, inherit_size="both", orientation="vertical", color = {1, 1, 1, 0.2}}, {
                ui.ColorButton:new({inherit_size = "width", height=32}),
                ui.ColorButton:new({inherit_size = "width", height=32}),
                ui.ColorButton:new({inherit_size = "width", height=32}),
                ui.ColorButton:new({inherit_size = "width", height=32})
            })
        })
        
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