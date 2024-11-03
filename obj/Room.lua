room_name = nil

function class.post_load(class)
    if class.room_name then
        global_rooms[class.room_name] = class
    end
end

-- When room is created
function class:init()
    
end