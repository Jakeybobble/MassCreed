-- Text.lua: An element to display text
inherit("Element")
local fonts = require("jakeylib.fonts")
local lg = love.graphics

function class:init(options, elements)
    class.super.init(self, options, elements)

    self.text = options.text or ""
    self.align = options.align or "center"

    self.text_color = options.text_color or {1,1,1}

    -- TODO: Customizable fonts, when that system is made better
    self.font = fonts.get("assets/fonts/SairaCondensed-Medium.ttf")
    

end

function class:draw()
    lg.setFont(self.font)

    lg.setColor(self.text_color)
    lg.printf(self.text, 0,0, self.width, self.align)
    lg.setColor(1,1,1)

    fonts.reset()
end