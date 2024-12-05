-- JakeyPanel.lua: Stylish panel in my style
inherit("Element")
local fonts = require("jakeylib.fonts")
local lg = love.graphics

function class:init(options, elements)
    class.super.init(self, options, elements)
    self.title = options.title or ""
    self.font = fonts.get("assets/fonts/SairaCondensed-Medium.ttf")


end

function class:draw()
    lg.setFont(self.font)

    lg.push("all")

    lg.setColor(0,0,0)
    lg.rectangle("fill", 0,0, self.width, self.height)
    

    lg.setColor(1,1,1)
    lg.setLineWidth(3)

    local h = self.font:getHeight()
    local o = 5

    lg.print(self.title, o, -h + o)
    lg.rectangle("line", o, o, self.width-o*2, self.height-o*2)
    lg.pop()
    
    --lg.setColor(1,1,1)

    fonts.reset()
end