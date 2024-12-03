local m = {}

-- Fonts cache
local fonts = {}
local standard = love.graphics.getFont()

function m.get(font_path)
    fonts[font_path] = fonts[font_path] or love.graphics.newFont(font_path, 20)
    return fonts[font_path]
end

function m.reset()
    love.graphics.setFont(standard)
end

return m