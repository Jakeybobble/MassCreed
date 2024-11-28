local module = {}
local lerp = require("math.lerp")

function module.mouse_inside(element)
    local m_x, m_y = love.mouse.getPosition()
    if m_x >= element.global_x and m_x <= element.global_x + element.width then
        if m_y >= element.global_y and m_y <= element.global_y + element.height then
            return true
        end
    end
    return false
end

function module.handle_click(element)
    --print(element.class.name)
    if module.selected_input then
        module.selected_input.selected = false
        module.selected_input = nil
    end

    for i = #element.elements, 1, -1 do
        local child = element.elements[i]
        if module.mouse_inside(child) then
            -- Put that element last
            if element.frontable then
                element.elements[i], element.elements[#element.elements] =
                element.elements[#element.elements], element.elements[i]
            end

            if child.on_click then
                child:on_click()
                break
            end

            module.handle_click(child)
            
            break
        end
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

return module