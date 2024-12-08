inherit("GameView")
local gui_handler = require("jakeylib/gui_handler")
local lg = love.graphics

function class:init()

    --love.graphics.setBackgroundColor(1, 0.827, 0) -- Yellow
    love.graphics.setBackgroundColor(0.157, 0.208, 0.251)

    -- Each layer...
    self.layers = {}

    self.layers_list = nil

    local w, h = love.window.getMode()
    
    self.element = ui.Element({width=w, height=h}, {
        
        -- Windows
        ui.Element({inherit_size="both"}, {
            -- Layers panel
            ui.ElementList({x = 50, y = 100, width = 256, height = 128, orientation = "v", frontable = true}, {
                ui.DraggableArea({
                    inherit_size="width", height=32
                }),
                ui.JakeyPanel({
                    title = "Layers:",
                    inherit_size = "both",
                    margins = {10, 10, 10, 10}
                }, {
        
                })
            })
        }),
        -- Hotbar (TODO)
        ui.Element({inherit_size="both"}, {

        }),
        -- Pop-ups (TODO)
        ui.Element({inherit_size="both"}, {

        })
        
    })


    --[[
        self.element = ui.Element:new({width=w, height=h}, {
        -- Layers panel
        ui.Panel:new({width=200, height=300}, {
            ui.ElementList:new({inherit_size = "both", orientation = "vertical"},{
                ui.ElementList:new({inherit_size = "width",  height = 300-32, orientation = "vertical"}, {
                    ui.Panel:new({inherit_size = "width", height = 50, text = "Layers"}),
                    ui.Scroll:new({inherit_size="both"}, {
                        ui.ElementList:new({margins={0,5}, mode="shrink", inherit_size = "both", orientation="vertical", init_func = function(e) self.layers_list = e end}, {
                            -- Contains each layer...
                            
                        })
                    })
                }),
                -- Buttons
                ui.Panel:new({inherit_size="width", height=32}, {
                    ui.ElementList:new({inherit_size="both", mode="fit", margins={5}}, {
                        ui.ColorButton:new({text="Add...", inherit_size="height", click=function()
                            print("TODO: Layer type selection dialog")

                            end}),
                    })
                })
            }
        )

            
        })
    })
    ]]
    

end

function class:new_layer()
    -- TODO: Add a prompt for picking what layer type to add
    local new_layer = editor.TileMapLayer:new()
    local new_element = ui.ColorButton:new({inherit_size="width", height=32, text=new_layer.name})
    new_element.layer = new_layer

    --table.insert(self.layers_list.elements, new_element)
    --self.layers_list:refresh()
    self.layers_list:add_child(new_element)
    table.insert(self.layers, new_layer)
    
end

function class:draw()

    for i, v in ipairs(self.layers) do
        v:draw_world()
    end

    self.element:render()

    local w, h = love.window.getMode()
    
    -- Cool border
    lg.setColor(0.2, 0.2, 0.2)
    lg.setLineWidth(4)
    lg.rectangle("line", 0,0, w,h)
    lg.setLineWidth(1)
    lg.setColor(1,1,1)
end

function class:update(dt)
    gui_handler.handle_draggable(self.element)
end

function class:keypressed(key)
    if key == "a" then
        self:new_layer()
    end
end

function class:mousepressed(x, y, button, istouch)
    gui_handler.handle_click(self.element)
    --print(gui_handler.mouse_inside(self.element.elements[1]))
end

function class:resize(w, h)
    self.element:resize(w,h)
end