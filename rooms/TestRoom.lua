inherit("Room")

room_name = "TestRoom"

function class:init()
     self.super.init(self)

     local new_obj = classes.TestWorm:new(100, 100)
     table.insert(self.objects, new_obj)

end

function class:update(dt)
    -- Todo: Instance order?
    for k, v in pairs(self.objects) do
        v:update(dt)

    end
end

function class:draw()
    -- Todo: Draw order by depth
    for k, v in pairs(self.objects) do
        v:draw()

    end
end