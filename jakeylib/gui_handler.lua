local module = {}

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

    for i = #element.elements, 1, -1 do
        local child = element.elements[i]
        if module.mouse_inside(child) then
            -- Put that element last
            if element.frontable then
                element.elements[i], element.elements[#element.elements] =
                element.elements[#element.elements], element.elements[i]
            end

            if child.click then
                child.click()
                break
            end

            module.handle_click(child)
            
            break
        end
    end
end

return module