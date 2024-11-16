inherit("GameView")
local gui_handler = require("jakeylib/gui_handler")

function class:init()

    local w, h = love.window.getMode()
    self.element = ui.Element:new({width=w, height=h}, {
        -- Layers panel
        ui.Panel:new({width=200, height=300}, {
            ui.ElementList:new({inherit_size = "both", orientation = "vertical"}, {
                ui.Panel:new({inherit_size = "width", height = 50, text = "Layers"}),
                ui.ElementList:new({inherit_size = "both", orientation = "vertical", color = {1, 1, 1}, margins={6}})
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