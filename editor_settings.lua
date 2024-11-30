-- A collection of functions related to editor_settings.txt
-- TODO: Find a better name for this file, maybe?

local m = {}

local file_name = "editor_settings.txt"

-- Returns preferred view from editor_settings.txt
function m.get_init_view(selectable_views)
    -- TODO: Always return Game if fused
    local fs = love.filesystem

    local fall_back = false

    local fall_back_view = gameviews.Game

    if fs.getInfo(file_name) == nil then
        local success, message = fs.write(file_name, "preferred_view=Game")
        if success then
            print("Created new '"..file_name.."' in "..fs.getSaveDirectory())
        else
            print("File write in '"..fs.getSaveDirectory().."' failed. Falling back to default Game GameView.\nException message: "..message)
            return fall_back_view
        end
    end

    local lines = fs.lines(file_name)

    -- Fill table with keys and values from editor_settings.txt
    local t = {}
    for line in lines do
        local key, value = string.match(line, "(.+)=(.+)")
        t[key] = value
    end

    -- Return view class if name in settings matches
    if t.preferred_view then
        for i, v in ipairs(selectable_views) do
            if v.name == t.preferred_view then
                return v
            end
        end
    end

    return fall_back_view
end

-- Set preferred_view in editor_settings.txt to class_name
function m.write_preferred_view(class_name)
    local fs = love.filesystem
    local lines = {}

    local value_found = false

    if fs.getInfo(file_name) then
        for line in fs.lines(file_name) do
            if string.match(line, "^preferred_view=") then
                line = "preferred_view="..class_name
                value_found = true
            end
            table.insert(lines, line)
        end
    end

    if not value_found then
        table.insert(lines, "preferred_view="..class_name)
    end

    local success, message = fs.write(file_name, table.concat(lines, "\n"))
    if not success then
        print("File write in '"..fs.getSaveDirectory().."' failed. \nException message: "..message)
    end

    return success
end

return m