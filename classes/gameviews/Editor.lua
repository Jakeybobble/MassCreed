inherit("GameView")
local gui_handler = require("jakeylib/gui_handler")
local editor_handler = require("jakeylib/editor_handler")
local lg = love.graphics

function class:init()

    --love.graphics.setBackgroundColor(1, 0.827, 0) -- Yellow
    love.graphics.setBackgroundColor(0.157, 0.208, 0.251)

    -- Each layer...
    self.layers = {}

    self.layers_list = nil
    self.new_layer_prompt = nil

    local w, h = love.window.getMode()
    
    self.element = ui.Element({width=w, height=h}, {
        
        -- Windows
        ui.Element({inherit_size="both", click_passthrough=true}, {
            -- Layers panel
            ui.VerticalList({x = 50, y = 100, width = 200, mode="shrink", frontable = true}, {
                ui.DraggableArea({
                    inherit_size="width", height=32
                }),
                ui.JakeyPanel({
                    title = "Layers:",
                    inherit_size = "width", height=224,
                    margins = {10, 10, 10, 10},
                }, {
                    ui.Scroll({inherit_size="both"}, {
                        ui.ElementList({orientation="v", mode="shrink", inherit_size="both", init_func = function(e) self.layers_list = e end}, {
                            -- Layers go here
                        })
                    })
                    
                }),
                -- Buttons
                ui.HorizontalList({
                    inherit_size="width", height=36, spacing=5,
                    mode="fit",
                    color={0,0,0},
                    margins={5,5}
                }, {
                    -- 
                    ui.ColorButton({inherit_size="height", text="New Layer...", click = function(e)
                        self.new_layer_prompt.enabled = true
                    end}),
                    ui.ColorButton({inherit_size="height"})
                })
            })
        }),
        -- Hotbar (TODO)
        ui.Element({inherit_size="both", click_passthrough=true}, {

        }),
        -- Pop-ups
        ui.Element({inherit_size="both", click_passthrough = true}, {
            -- New Layer window
            ui.DataCapsule({inherit_size="both", color={0.05,0,0.05,0.3}, init_func = function(e) self.new_layer_prompt = e end, enabled = false}, {
                ui.JakeyPanel({
                    title = "Add a new layer...",
                    width = 640, height = 400,
                    margins = {20},
                    centered = true,
                }, {
                    ui.HorizontalList({inherit_size="both", mode="fit", spacing=10}, {
                        -- Layer type list
                        ui.JakeyPanel({
                            width = 256, inherit_size="height",
                        }, {
                            ui.Scroll({inherit_size="both"}, {
                                ui.ListSelectable({
                                    orientation="vertical", inherit_size="width", mode = "shrink", init_func = function(e) self:init_layer_presets(e) end,
                                    margins={6}, key="LAYERLIST",
                                }, {
                                    -- Layer types go here
                                })
                            })
                        }),
                        ui.VerticalList({
                            inherit_size="height"
                        }, {
                            -- Layer type info
                            ui.ElementBuilder({
                                color={1,1,1, 0.15}, key="LAYERINFO",
                                inherit_size="width", height=360-32-20,
                                build_func = function(self, args)
                                    local name = args.type_name
                                    return ui.Text({inherit_size="both", text=name})
                                end
                            }),
                            ui.HorizontalList({
                                mode="fit",
                                inherit_size="width", height=32,
                                width=50, height=50, spacing=5,
                            }, {
                                ui.ColorButton({
                                    inherit_size="height", text="Cancel", click=function(e)
                                        self.new_layer_prompt.enabled = false
                                    end
                                }, {}),
                                ui.ColorButton({
                                    inherit_size="height", text="Create"
                                }, {})
                            })
                        })
                        
                    })
                })
            })
        })
        
    })
    

end

function class:init_layer_presets(list_element)
    for k,layer_type in pairs(registered_layers) do
        local element = ui.Panel({
            inherit_size = "width", height = 64,
        }, {
            ui.Button({inherit_size="both", key="_",
                click=function(e)
                    list_element:select(e.parent.list_index)
                    --e.parent.data_capsule.data_elements["LAYERINFO"]:build()
                    e.data_capsule.data_elements["LAYERINFO"]:build(layer_type)
                end}, {
                ui.HorizontalList({inherit_size = "both"}, {
                    ui.Element({width = 64, height = 64}, {
                        ui.Image:new({width=48, height=48, image="assets/bip.png", centered=true}),
                    }),
                    ui.VerticalList({margins={3,3,10,0}, inherit_size="both", mode="fit"}, {
                        ui.Text({text=layer_type.type_name, inherit_size="width", align="left"}),
                        ui.Text({text=layer_type.desc, inherit_size="width", align="left"})
                    })
                    
                })
            }),
        })

        list_element:add_child(element)

    end
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