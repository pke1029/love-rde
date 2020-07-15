-- button gui
-- pke1029

-- create class
local Button = class('Button', Gui)


-- init
function Button:initialize(text, x, y)
	Gui.initialize(self, 'button')
	self.text = text
	self.x = x
	self.y = y
	self.w = 120
	self.h = 40
	self.bbox = {x = self.x, y = self.y, w = self.w, h = self.h}
	self.font = FONT.medium
	self.centerY = self.y + (self.h / 2) - (self.font:getAscent() - self.font:getDescent()) / 2
end


function Button:update(dt)
	-- button animation
end


function Button:draw()
	-- draw rect
	local col1 = 10 
	local col2 = 8
	if self.mouseOver and love.mouse.isDown(1) then
		col1 = 7
		col2 = 7
	elseif self.mouseOver then
		col1 = 8
	end
	love.graphics.setColor(COL[col1])
	love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.h/2, self.h/2)
	love.graphics.setColor(COL[col2])
	love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.h/2, self.h/2)

	-- print text
	love.graphics.setColor(COL[1])
	love.graphics.setFont(self.font)
	love.graphics.printf(self.text, self.x, self.centerY, self.w, 'center')
end


-- when clicked
function Button:mousepressed(x, y, key)
	if self.mouseOver then
		if type(self.click) == 'function' then
			self.click()
		end
	end
end


function Button:mousereleased(x, y, key)
	
end


function Button:resize()
	self.w = math.floor(love.graphics.getWidth() * 0.3)
	self.h = math.floor(love.graphics.getHeight() * 0.1)
	self.centerY = self.y + (self.h / 2) - (self.font:getAscent() - self.font:getDescent()) / 2
end


return Button
