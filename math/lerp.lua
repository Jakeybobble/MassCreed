return function(a, b, t)
	local result = a + (b - a) * t
	return (math.abs(result) < 1e-5 and 0) or result
end