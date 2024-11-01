local module = {}

module.GetFileName = function(url)
    return url:match("(.+)%..+")
end

module.FirstToUpper = function(str)
    return (str:gsub("^%l", string.upper))
end

return module