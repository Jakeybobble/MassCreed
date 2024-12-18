inherit("GameView")
local gui_handler = require("jakeylib/gui_handler")

local function multi_new(class, count, options)
    local t = {}
    for i=1, count do
        local obj = class:new(options, elements)
        table.insert(t, obj)
    end
    return unpack(t)
end


function class:init()

    love.graphics.setBackgroundColor(0.157, 0.208, 0.251)

    local white = {1, 1, 1, 0.2}
    local w, h = love.window.getMode()
    self.element = ui.Element:new({width=w, height=h, margins={13}}, {

        -- Vertical fit list
        ui.ElementList:new({mode="fit", margins={10}, width=64, height=300, orientation="vertical", color = white}, {
            multi_new(ui.ColorButton, 4, {inherit_size = "width", height=32})
        }),

        -- Vertical shrink list
        ui.ElementList:new({x=64, mode="shrink", margins={10}, width=64, orientation="vertical", color = white}, {
            multi_new(ui.ColorButton, 4, {inherit_size = "width", height=32})
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
            multi_new(ui.ColorButton, 4, {inherit_size = "height", width=32})
        }),

        -- Horizontal shrink list
        ui.ElementList:new({y=320+64, mode="shrink", margins={10}, height=64, orientation="horizontal", color = white}, {
            multi_new(ui.ColorButton, 4, {inherit_size = "height", width=32})
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
        ui.Scroll:new({x = 64*6, width=64, height=64*3, scrollbar = true}, {
            ui.ElementList:new({mode="shrink", inherit_size="both", orientation="vertical"}, {
                multi_new(ui.ColorButton, 6, {inherit_size="width", height=64}, nil)
            })
        }),

        ui.Scroll:new({x = 64*7, width=64, height=64*3, scrollbar = true, orientation="horizontal"}, {
            ui.ElementList:new({mode="shrink", inherit_size="both", orientation="horizontal"}, {
                multi_new(ui.ColorButton, 6, {inherit_size="height", width=32}, nil)
            })
        }),

        -- DataCapsule and Input
        ui.DataCapsule:new({x = 64*8}, {
            ui.ElementList:new({mode="shrink", width = 64, orientation = "vertical"}, {
                ui.Panel:new({key="output", height = 64, inherit_size="width"}),
                ui.Panel:new({height = 64, inherit_size="width"}, {
                    ui.Input:new({key="input", inherit_size="both", color={1,1,1,0.1}})
                })
            })
        }),
        
        -- Nested inheriteds in margins test. All children should share size.
        ui.Panel:new({x = 64*5, y = 64*4, width=64*2, height=64*2, margins={10}}, {
            ui.Panel:new({inherit_size="both"}, {
                ui.Panel:new({inherit_size="both"}, {
                    ui.Panel:new({inherit_size="both"})
                })
            })
        }),

        -- Draggable window
        ui.ElementList({x = 64*7, y = 64*4, width = 64*2, height = 64*2, orientation="vertical", frontable = true}, {
            ui.DraggableArea({inherit_size="width", height=32}, {
                ui.Panel({inherit_size="both"})
            }),
            ui.Panel({inherit_size="both", margins={1, 5}}, {
                ui.Text({text="^ Draggable ^", inherit_size="width", height = 32, align="center", text_color={0.5, 0.5, 0.5}})
            })
        }),
        -- Another one, overlapping
        ui.ElementList({x = 64*8, y = 64*5, width = 64*2, height = 64*2, orientation="vertical", frontable = true}, {
            ui.DraggableArea({inherit_size="width", height=32}, {
                ui.Panel({inherit_size="both"})
            }),
            ui.Panel({inherit_size="both", margins={1, 5}}, {
                ui.Text({text="^ Draggable ^", inherit_size="width", height = 32, align="center", text_color={0.5, 0.5, 0.5}})
            })
        }),

    })
end

function class:draw()
    self.element:render()

end

function class:update(dt)
    gui_handler.handle_draggable(self.element)
end

function class:mousepressed(x, y, button, istouch)
    gui_handler.handle_click(self.element)
end

function class:resize(w, h)
    self.element:resize(w,h)
end

function class:keypressed(key)
    gui_handler.keypressed(key)
end

function class:textinput(text)
    gui_handler.textinput(text)
end