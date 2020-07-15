

local Checkbox = class('Checkbox', Gui)

function Checkbox:initialize(text, x, y)
	Gui.initialize(self, 'chcekbox')
	self.text = text
	self.x = x
    self.y = y
    self.w = 200
    self.r = 15
    self.val = false
	self.bbox = {x = self.x, y = self.y, w = 2*self.r, h = 2*self.r}
    self.font = FONT.medium
    self.centerY = self.y + self.r - (self.font:getAscent() - self.font:getDescent()) / 2
end


function Checkbox:draw()
    
    if self.mouseOver then
        love.graphics.setColor(COL[8])
        love.graphics.circle('line', self.x+self.r, self.y+self.r, self.r)
        love.graphics.circle('fill', self.x+self.r, self.y+self.r, self.r)
    else
        love.graphics.setColor(COL[8])
        love.graphics.circle('line', self.x+self.r, self.y+self.r, self.r)
    end

    if self.val then
        if self.mouseOver then
            love.graphics.setColor(COL[10])
        else
            love.graphics.setColor(COL[8])
        end
        love.graphics.circle('fill', self.x+self.r, self.y+self.r, 8)
        love.graphics.circle('line', self.x+self.r, self.y+self.r, 8)
    end    

    -- text
    love.graphics.setColor(COL[1])
    love.graphics.print(self.text, self.x+3*self.r, self.centerY)

end


function Checkbox:mousepressed(x, y, key)
    if self.mouseOver then
		self.val = not self.val
	end
end


function Checkbox:send(val)
    self.val = val
end


return Checkbox