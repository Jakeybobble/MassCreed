inherit("Dad")

heck = 1

function class:init()
    print("I have been created.")
end

function class:update()
    print(self.heck)
    self.heck = self.heck + 1
    print(parent.name)
end
