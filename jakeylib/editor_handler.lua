local module = {}

function module.add(layer_class)
    table.insert(registered_layers, layer_class)
    print("Registered layer type "..layer_class.name)
end

return module