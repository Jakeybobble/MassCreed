inherit("GameView")
local gui_handler = require("jakeylib/gui_handler")

function class:init()

    local white = {1, 1, 1, 0.2}
    local w, h = love.window.getMode()
    self.element = ui.Element:new({width=w, height=h}, {

        -- Vertical fit list with
        ui.ElementList:new({mode="fit", margins={10}, width=64, height=300, orientation="vertical", color = white}, {
            ui.ColorButton:new({inherit_size = "width", height=32}),
            ui.ColorButton:new({inherit_size = "width", height=32}),
            ui.ColorButton:new({inherit_size = "width", height=32}),
            ui.ColorButton:new({inherit_size = "width", height=32})
        }),

        -- Vertical shrink list
        ui.ElementList:new({x=64, mode="shrink", margins={10}, width=64, orientation="vertical", color = white}, {
            ui.ColorButton:new({inherit_size = "width", height=32}),
            ui.ColorButton:new({inherit_size = "width", height=32}),
            ui.ColorButton:new({inherit_size = "width", height=32}),
            ui.ColorButton:new({inherit_size = "width", height=32})
        }),

        -- Nested vertical lists
        ui.ElementList:new({x=64*2, spacing=3, mode="fit", margins = {5}, width=128, height=300, orientation="vertical", color = white}, {
            ui.ElementList:new({mode="fit", spacing=3, inherit_size="width", margins ={5}, orientation="vertical", color=white}, {
                ui.ElementList:new({mode="fit", spacing=3, inherit_size="width", margins ={5}, orientation="vertical", color=white}, {

                }),
                ui.ElementList:new({mode="fit", spacing=3, inherit_size="width", margins ={5}, orientation="vertical", color=white}, {
                    
                })
            }),
            ui.ElementList:new({mode="fit", spacing=3, inherit_size="width", margins ={5}, orientation="vertical", color=white}, {
                ui.ElementList:new({mode="fit", spacing=3, inherit_size="width", margins ={5}, orientation="vertical", color=white}, {

                }),
                ui.ElementList:new({mode="fit", spacing=3, inherit_size="width", margins ={5}, orientation="vertical", color=white}, {
                    -- TODO: Add horizontals inside
                })
            })
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