-- basic math function

local fmath = {}

-- check if point in rect
function fmath.pointInRect(px, py, bbox)
	if px > bbox.x and px < bbox.x + bbox.w and py > bbox.y and py < bbox.y + bbox.h then
		return true
	else
		return false
	end
end


function fmath.clamp(val, min, max)
	return math.max(min, math.min(val, max))
end


-- return polygon verticies
function fmath.regPoly(n, x0, y0, r, theta)
	local verts = {}
	for i = 1,n do
		local x = r * math.sin(2*math.pi * (i/n) + theta) + x0
		local y = r * math.cos(2*math.pi * (i/n) + theta) + y0
		table.insert(verts, x)
		table.insert(verts, y)
	end
	return verts
end


return fmath
