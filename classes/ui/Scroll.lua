inherit("Element")

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
    if love.keyboard.isDown("down") then
        self.offset_y = self.offset_y + 5
    elseif love.keyboard.isDown("up") then
        self.offset_y = self.offset_y - 5
    end

    -- TODO: Little transparent scrollbar
end

local lg = love.graphics
function class:on_draw()
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
    lg.translate(self.offset_x, self.offset_y)
    class.super.on_draw(self, true) -- Skip resize so we can do it here instead.
    lg.pop()
    lg.setCanvas()

    lg.draw(self.canvas, global_x, global_y)
end