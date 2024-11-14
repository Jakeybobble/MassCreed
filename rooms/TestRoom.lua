inherit("Room")

room_name = "TestRoom"

function class:init()
     class.super.init(self)

     local new_obj = classes.TestWorm:new(100, 100)
     table.insert(self.objects, new_obj)
     

    local image = love.graphics.newImage("assets/tilemap/debug.png")
    local w, h = image:getDimensions()
    self.tiles_batch = {}

    self.batch = love.graphics.newSpriteBatch(image)

    for y = 0, h - 16, 16 do
        for x = 0, w - 16, 16 do
            local quad = love.graphics.newQuad(x, y, 16, 16, w, h)
            table.insert(self.tiles_batch, quad)
        end
    end

    self.tiles = {
        {1, 5, 10}, {2, 6, 10}, {2, 7, 10}, {2, 8, 10}, {2, 9, 10}, {3, 10, 10}
    }

    love.graphics.setBackgroundColor(0.157, 0.208, 0.251)

end

function class:update(dt)
    -- Todo: Instance order?
    for k, v in pairs(self.objects) do
        v:update(dt)

    end
end

function class:draw()

    

    -- Draw test tilemap
    self.batch:clear()
    for _, v in pairs(self.tiles) do
        self.batch:add(self.tiles_batch[v[1]], v[2] * 16, v[3] * 16)
    end
    

    love.graphics.draw(self.batch)

    -- Todo: Draw order by depth
    for k, v in pairs(self.objects) do
        v:draw()

    end
end