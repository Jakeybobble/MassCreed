inherit("GameView")
local gui_handler = require("jakeylib/gui_handler")

function class:init()

    local white = {1, 1, 1, 0.2}
    local w, h = love.window.getMode()
    self.element = ui.Element:new({width=w, height=h, margins={13}}, {

        -- Vertical fit list
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
                ui.ElementList:new({mode="fit", spacing=3, inherit_size="width", margins ={5}, orientation="horizontal", color=white}, {
                    ui.ColorButton:new({inherit_size = "height"}),
                    ui.ColorButton:new({inherit_size = "height"})
                })
            })
        }),

        -- Horizontal fit list
        ui.ElementList:new({y=320, mode="fit", margins={10}, width=300, height=64, orientation="horizontal", color = white}, {
            ui.ColorButton:new({inherit_size = "height", width=32}),
            ui.ColorButton:new({inherit_size = "height", width=32}),
            ui.ColorButton:new({inherit_size = "height", width=32}),
            ui.ColorButton:new({inherit_size = "height", width=32})
        }),

        -- Horizontal shrink list
        ui.ElementList:new({y=320+64, mode="shrink", margins={10}, height=64, orientation="horizontal", color = white}, {
            ui.ColorButton:new({inherit_size = "height", width=32}),
            ui.ColorButton:new({inherit_size = "height", width=32}),
            ui.ColorButton:new({inherit_size = "height", width=32}),
            ui.ColorButton:new({inherit_size = "height", width=32})
        }),

        -- Nested horizontal lists
        ui.ElementList:new({y=320+64*2, spacing=3, mode="fit", margins = {5}, width=300, height=128, orientation="horizontal", color = white}, {
            ui.ElementList:new({mode="fit", spacing=3, inherit_size="height", margins ={5}, orientation="horizontal", color=white}, {
                ui.ElementList:new({mode="fit", spacing=3, inherit_size="height", margins ={5}, orientation="horizontal", color=white}, {

                }),
                ui.ElementList:new({mode="fit", spacing=3, inherit_size="height", margins ={5}, orientation="horizontal", color=white}, {
                    
                })
            }),
            ui.ElementList:new({mode="fit", spacing=3, inherit_size="height", margins ={5}, orientation="horizontal", color=white}, {
                ui.ElementList:new({mode="fit", spacing=3, inherit_size="height", margins ={5}, orientation="horizontal", color=white}, {

                }),
                ui.ElementList:new({mode="fit", spacing=3, inherit_size="height", margins ={5}, orientation="vertical", color=white}, {
                    ui.ColorButton:new({inherit_size = "width"}),
                    ui.ColorButton:new({inherit_size = "width"})
                })
            })
        }),

        -- Images
        ui.Image:new({x = 64*4, width=64, height=64, image="assets/bip.png"}),
        ui.Image:new({x = 64*4, y=64, width=128, height=128, image="assets/bip.png", color=white}),
        ui.Image:new({x = 64*4, y=64*3, width=128, height=32, image="assets/bip.png", color=white}),

        -- Scroll -- TODO: Add horizontal Scroll example
        ui.Scroll:new({x = 64*6, width=64, height=64*3}, {
            ui.ElementList:new({mode="shrink", inherit_size="both", orientation="vertical"}, {
                ui.Panel({inherit_size="width", height=64}),
                ui.Panel({inherit_size="width", height=64}),
                ui.Panel({inherit_size="width", height=64}),
                ui.Panel({inherit_size="width", height=64}),
                ui.Panel({inherit_size="width", height=64}),
                ui.Panel({inherit_size="width", height=64})
            })
        })

    })
end

function class:draw()
    self.element:render()

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