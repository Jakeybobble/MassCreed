local editor = {}

local element = nil

function editor.load()
    print("---")
    print(element)
    element = classes.Element:new()
    print(element)
end

function editor.draw()
    love.graphics.print("Welcome to the room editor test!")
end

function editor.update()

end

return editor