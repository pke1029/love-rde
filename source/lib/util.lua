
-- check if is LUA file
function isLuaFile(file)
	if string.match(file, "%.lua") then
		return true
	else
		return false
	end
end