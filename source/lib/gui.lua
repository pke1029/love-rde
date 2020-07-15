-- GUI class
-- pke1029
-- 9th March 2019


-- init class
local Gui = class('Gui')

-- class variables
Gui.static.objects = {}
Gui.static.lock = nil

-- initialise new gui
function Gui:initialize(type)
	self.type = type
	self.mouseOver = false

	table.insert(Gui.static.objects, self)
end


-- clear all gui object
function Gui.static:removeAll()
	Gui.static.objects = {}
end


-- remove self
function Gui:remove()
	for i, v in ipairs(Gui.static.objects) do
		if v == self then
			table.remove(Gui.static.objects, i)
		end
	end
end


-- add self
function Gui:add()
	table.insert(Gui.static.objects, self)
end


-- update gui
function Gui.static:update(dt)
	
	local mx, my = love.mouse.getPosition()

	-- call child update function
	for i, v in ipairs(Gui.static.objects) do
		if type(v.update) == 'function' then
			v:update(dt)
		end
	end

	-- if skip mouseOver check if locked
	if self.lock then
		if fmath.pointInRect(mx, my, self.lock.bbox) then 
			self.lock.mouseOver = true
		else
			self.lock.mouseOver = false
		end
		return
	end

	for i, v in ipairs(Gui.static.objects) do
		-- if interactive gui is on hover
		if v.bbox then
			if fmath.pointInRect(mx, my, v.bbox) then
				v.mouseOver = true
			else
				v.mouseOver = false
			end
		end
	end
end


-- resize all gui (use if screen setting is changed)
function Gui.static:resize()
	for i, v in ipairs(Gui.static.objects) do
		if type(v.resize) == 'function' then
			v:resize()
		end
	end
end


-- check if any (interactive) gui is on hover
function Gui.static:anyOver()
	for i, v in ipairs(Gui.static.objects) do
		if v.mouseOver == true then
			return true
		end
	end
	return false
end


-- draw every gui in array
function Gui.static:draw()
	for i, v in ipairs(Gui.static.objects) do
		v:draw()
	end
end


-- click every gui (which one is pressed is check in the respective gui)
function Gui.static:mousepressed(x, y, key)
	for i, v in ipairs(Gui.static.objects) do
		if type(v.mousepressed) == 'function' then
			v:mousepressed(x, y, key)
		end
	end
end


function Gui.static:mousereleased(x, y, key)
	for i, v in ipairs(Gui.static.objects) do
		if type(v.mousereleased) == 'function' then
			v:mousereleased(x, y, key)
		end
	end
end


function Gui.static:wheelmoved(x, y, key)
	for i, v in ipairs(Gui.static.objects) do
		if type(v.wheelmoved) == 'function' then
			v:wheelmoved(x, y, key)
		end
	end
end


return Gui
