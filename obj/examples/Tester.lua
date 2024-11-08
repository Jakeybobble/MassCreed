-- The class will inherit from the Dad class
inherit("Dad")

-- The class will be initialized with these variables
heck = 1

-- The created 30log class is created and then passed over for use in this file :-)
function class:init()
    self.super.init(self)
    print(self.name.." has been instantiated!")
end

function class:update()
    print(self.heck)
    self.heck = self.heck + 1
    print(parent.name)
end
