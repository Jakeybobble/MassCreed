inherit("GameView")
local gui_handler = require("jakeylib/gui_handler")

function class:init()
    self.element = classes.Element:new({x = 50, y = 50, frontable = true },
    {
        classes.Hoverable:new({x = 50, y = 0, width = 200, height = 80 }),
        classes.Hoverable:new({x = 100, y = 50, width = 200, height = 80 },
        {
            classes.Button:new({x = 20, y = 20, width=60, height=30})
        })
    })
end

function class:draw()
    love.graphics.print("Welcome to the (in its current state) editor view.")
    self.element:on_draw()

end

function class:update(dt)

end

function class:mousepressed(x, y, button, istouch)
    gui_handler.handle_click(self.element)
    --print(gui_handler.mouse_inside(self.element.elements[1]))
end