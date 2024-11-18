inherit("Element")

function class:init(options, elements)
    class.super.init(self, options, elements)

    if options.image then
        self.image = love.graphics.newImage(options.image)
    end


end

function class:draw()
    -- TODO: Add the ability to draw from SpriteBatch. Either that or have it in another class.
    if self.image then
        local w, h = self.image:getDimensions()
        love.graphics.draw(self.image, 0, 0, 0, self.width / w, self.height / h)
    end
end