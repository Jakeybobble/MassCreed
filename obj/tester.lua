inherit("dad")

heck = 1

function class:init()
    print("I have been created.")
    print(self.heck)
    print(class.name)
end

function class:update()
    print(self.heck)
    self.heck = self.heck + 1
end
