local module = {}
local lerp = require("math.lerp")
local lm = love.mouse

function module.mouse_inside(element)
    local m_x, m_y = love.mouse.getPosition()
    if m_x >= element.global_x and m_x <= element.global_x + element.width then
        if m_y >= element.global_y and m_y <= element.global_y + element.height then
            return true
        end
    end
    return false
end

function module.update(element)
    -- TODO: Refactor handle_click and handle_draggable into this
end

function module.handle_click(element, depth)
    
    -- IMPORTANT TODO: Update this function to return first clickable instead
    -- Currently, multiple buttons on separate layers can be clicked at once.
    -- Make sure that it also returns a value that helps decide whether the click is in the world (behind) or in the ui

    -- Debug printing
    local debug = false
    if debug then
        if depth then
            depth = depth + 1
        else
            depth = 0
        end

        local spaces = ""
        for i=1, depth do
            spaces = spaces.."  "
        end
        if spaces == "" then print("---") end
        local str = spaces..element.name.." - "..element.width..'x'..element.height.." - "..element.global_x..","..element.global_y.." - ".."Elements: "..#element.elements
        if element.key then str = str.." - "..element.key end
        print(str)
    end

    -- Set selected input box
    if module.selected_input then
        module.selected_input.selected = false
        module.selected_input = nil
    end

    -- Recursively iterate through elements to find clickable/frontable
    for i = #element.elements, 1, -1 do
        local child = element.elements[i]
        if child.enabled == false then goto continue end
        if module.mouse_inside(child) then
            if element.frontable then
                element:front()
            end

            if child.on_click then
                child:on_click() -- Todo: Separate click and drag somehow
                break
            end

            module.handle_click(child, depth)
            
            if child.click_passthrough == nil then
                break
            end
        end

        ::continue::
    end
end

module.scroll_value = 0
local scroll_to = 0
local scroll_moved = false
local sensitivity = 23

-- Mouse wheel stuff
function module.update_scroll()
    if scroll_moved then
        scroll_moved = false
    else
        scroll_to = 0
    end

    module.scroll_value = lerp(module.scroll_value, scroll_to, 0.5)
end

function module.wheelmoved(x, y)
    scroll_moved = true
    scroll_to = y * sensitivity
end

-- Selected element stuff
module.selected_input = nil

function module.keypressed(key)
    if module.selected_input then
        module.selected_input:keypressed(key)
    end
end

function module.textinput(text)
    if module.selected_input then
        module.selected_input:textinput(text)
    end
end

-- Draggable stuff

local function get_draggable(element) -- Finds first draggable element
    for i = #element.elements, 1, -1 do
        local child = element.elements[i]
        if child.enabled == false then goto continue end -- Might not be necessary

        if module.mouse_inside(child) then
            if child.name == "DraggableArea" then
                return child
            end

            local result = get_draggable(child)
            if result then
                return result
            end
        end

        ::continue::
    end
    return nil
end

local default_cursor = love.mouse.getSystemCursor("arrow")
local move_cursor = love.mouse.getSystemCursor("sizeall")

local dragged_element = nil

function module.handle_draggable(element)

    -- TODO: Store draggable in variable and draggable:move() until letting go of cursor

    local hovered_draggable = get_draggable(element)

    if dragged_element then
        if lm.isDown(1) then
            dragged_element:move(grabbed_x, grabbed_y)
        else
            dragged_element.last_mouse_pos = nil
            dragged_element = nil
        end
    else
        if lm.isDown(1) and hovered_draggable then
            dragged_element = hovered_draggable
            dragged_element.parent:front() -- Update this if parent depth is added
        end
    end

    lm.setGrabbed((dragged_element and true) or false)
    love.mouse.setCursor((hovered_draggable and move_cursor) or default_cursor)
    
end

return module