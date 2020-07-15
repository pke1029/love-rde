

local Slider = class('Slider', Gui)


-- init
function Slider:initialize(text, x, y, trackW, min, max)
	Gui.initialize(self, 'slider')
    self.text = text
    self.r = 8
	self.x = x
    self.y = y
    self.trackW = trackW        -- track width
    self.trackH = 4             -- track height
    self.spacing = 40           -- spacing between text and track
    self.min = min
    self.max = max
    self.val = (max + min) / 2
    self.bbox = {x = self.x-self.r, y = self.y+self.spacing-self.r, w = 2*self.r, h = 2*self.r}
    self.font = FONT.medium
    self.isSelected = false
    self:send(self.val)
end


function Slider:update(dt)
    -- move circle
    local mx, my = love.mouse.getPosition()
    if self.isSelected then
		self.bbox.x = fmath.clamp(mx, self.x, self.x+self.trackW) - self.r
    end
    
    -- update value
    self.val = (self.bbox.x + self.r - self.x) / self.trackW * (self.max - self.min) + self.min
end


function Slider:draw()
	-- track
    love.graphics.setColor(COL[8])
    local x = self.x - self.trackH/2
    local y = self.y + self.spacing - self.trackH/2
    local w = self.trackW + self.trackH
    local h = self.trackH
    local r = self.trackH/2
	love.graphics.rectangle('fill', x, y, w, h, r, r)
	love.graphics.rectangle('line', x, y, w, h, r, r)

    -- circle
    if self.isSelected then
        love.graphics.setColor(COL[8])
        love.graphics.circle('fill', self.bbox.x+self.r, self.bbox.y+self.r, self.r+3)
        love.graphics.setColor(COL[10])
        love.graphics.circle('fill', self.bbox.x+self.r, self.bbox.y+self.r, self.r+1)
    elseif self.mouseOver then
        love.graphics.setColor(COL[8])
        love.graphics.circle('fill', self.bbox.x+self.r, self.bbox.y+self.r, self.r+3)
        love.graphics.setColor(COL[10])
        love.graphics.circle('fill', self.bbox.x+self.r, self.bbox.y+self.r, self.r)
    else
        love.graphics.setColor(COL[10])
        love.graphics.circle('fill', self.bbox.x+self.r, self.bbox.y+self.r, self.r)
        love.graphics.setColor(COL[8])
        love.graphics.circle('line', self.bbox.x+self.r, self.bbox.y+self.r, self.r)
    end
    

	-- print text
	love.graphics.setColor(COL[1])
	love.graphics.setFont(self.font)
    love.graphics.print(self.text, self.x, self.y)
    love.graphics.printf(string.format("%.2f", self.val), self.x, self.y, self.trackW, 'right')
end


function Slider:mousepressed(x, y, key)
    if self.mouseOver then
		self.isSelected = true
	end
end


function Slider:mousereleased(x, y, key)
    self.isSelected = false
end


function Slider:send(val)
    self.val = val
    -- update slider position
    self.bbox.x = (val - self.min) / (self.max - self.min) * self.trackW + self.x - self.r 
end


return Slider