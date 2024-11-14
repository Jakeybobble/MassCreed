inherit("GameView")
local gui_handler = require("jakeylib/gui_handler")

function class:init()
    --[[ Older stuff for reference...
    self.element = classes.Element:new({x = 50, y = 50, frontable = true },
    {
        classes.Hoverable:new({x = 50, y = 0, width = 200, height = 80 }),
        classes.Hoverable:new({x = 100, y = 50, width = 200, height = 80 },
        {
            classes.Button:new({x = 20, y = 20, width=60, height=30})
        })
    })
    ]]--
    local w, h = love.window.getMode()
    self.element = classes.Element:new({x = 16, y = 16, width=w, height=h}, {
        classes.ColorButton:new({width = 64, height = 64, color={0.5, 0.5, 0.5}})
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