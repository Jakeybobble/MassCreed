-- The class will inherit from the Dad class
inherit("Dad")

-- Variables of the class may be defined in the outer scope like this
class.heck = 1

-- The created 30log class is created and then passed over for use in this file :-)
function class:init()
    class.super.init(self)
    print(self.name.." has been instantiated!")
end

function class:update()
    print(self.heck)
    self.heck = self.heck + 1
    print(self.super.name)
end
