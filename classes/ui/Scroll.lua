inherit("Element")
local gui = require("jakeylib/gui_handler")

function class:init(options, elements)
    class.super.init(self, options, elements)

    options = options or {}

    self.inherit_size = "both"
    self.orientation = options.orientation or "vertical"

    -- TODO: Create a canvas and draw children inside...?
    --self.canvas = love.graphics.newCanvas(self.parent.width, self.parent.height)

    self.offset_x, self.offset_y = options.offset_x or 0, options.offset_y or 0



    self.scrollbar = options.scrollbar or false

end

function class:draw()
    -- Temporary scrolling code

    if not gui.mouse_inside(self) then do return end end -- Does not function properly.

    local h = self.elements[1].height

    self.offset_y = self.offset_y + gui.scroll_y * 10
    gui.scroll_y = 0 -- Temporary solution until a better scroll system exists
    --print(self.offset_y)

    if h > self.height then
        self.offset_y = math.min(math.max(self.offset_y, self.height - h), 0)
    else
        self.offset_y = 0
    end
    
end

local lg = love.graphics
function class:on_draw()

    -- Problem: Scroll in scroll does not work... Even though it is a limitation I could live with.
    -- Problem 2: This element freaks out when there are margins. There must be an increment somewhere.
    -- Buttons don't function properly either!!!

    self:draw_resize()
    if not self.canvas then
        self.canvas = lg.newCanvas(self.width, self.height)
    end

    lg.push()
    lg.translate(self.x, self.y)
    local global_x, global_y = love.graphics.transformPoint(0,0)
    lg.pop()

    lg.setCanvas(self.canvas)
    lg.origin()
    lg.clear(0, 0, 0, 0)

    lg.push()
    
    lg.translate(self.offset_x - self.x, self.offset_y - self.y) -- Accounts for width/height of previous items in ListElement... TODO: Find better fix
    class.super.on_draw(self, true) -- Skip resize so we can do it here instead.
    lg.pop()
    lg.setCanvas()

    lg.draw(self.canvas, global_x, global_y)
end
