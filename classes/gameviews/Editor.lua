inherit("GameView")
local gui_handler = require("jakeylib/gui_handler")

function class:init()

    -- Each layer...
    self.layers = {}

    self.layers_list = nil

    local w, h = love.window.getMode()
    self.element = ui.Element:new({width=w, height=h}, {
        -- Layers panel
        ui.Panel:new({width=200, height=300}, {
            ui.ElementList:new({inherit_size = "both", orientation = "vertical"}, {
                ui.Panel:new({inherit_size = "width", height = 50, text = "Layers"}),
                ui.Scroll:new({}, {
                    ui.ElementList:new({margins={1, 5}, inherit_size = "both", orientation="vertical", init_func = function(e) self.layers_list = e end}, {
                        -- Contains each layer...
                        
                    })
                })
            })
        })
    })

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
end

function class:update(dt)

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