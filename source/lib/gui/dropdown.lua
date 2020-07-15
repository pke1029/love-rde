
local Dropdown = class('Dropdown', Gui)


function Dropdown:initialize(x, y, choice)
    Gui.initialize(self, 'dropdown')
	self.x = x
    self.y = y
    self.w = 200
    self.h = 40
    self.bbox = {x = self.x, y = self.y, w = self.w, h = self.h}
    self.choice = choice
    self.current = 1
    self.val = self.choice[self.current]
    self.font = FONT.medium
    self.isSelected = false
    self.onChoice = nil
    self.triVerts = fmath.regPoly(3, self.x+self.w-self.h/2, self.y+self.h/2, 8, 0)
    self.centerY = self.y + (self.h / 2) - (self.font:getAscent() - self.font:getDescent()) / 2
end


function Dropdown:update(dt)
    --selection
    local mx, my = love.mouse.getPosition()
    self.onChoice = nil

    if self.isSelected then
        -- determine mouse position
        if mx > self.x and mx < self.x+self.w then
            i =  math.floor((my-self.y)/self.h)
            if i > 0 and i <= #self.choice then
                self.onChoice = i
            end
        end
    end

end


function Dropdown:draw()

    local r = self.h/2

    -- box
    if self.isSelected then
        love.graphics.setColor(COL[10])
        love.graphics.rectangle('fill', self.x, self.y, self.w, self.h + #self.choice*self.h, r, r)
        love.graphics.setColor(COL[8])
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h + #self.choice*self.h, r, r)
    else
        love.graphics.setColor(COL[8])
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h, r, r)
    end

    -- highlight
    if self.onChoice then
        love.graphics.setColor(COL[8])
        love.graphics.rectangle('line', self.x, self.y+self.onChoice*self.h, self.w, self.h, r, r)
        love.graphics.rectangle('fill', self.x, self.y+self.onChoice*self.h, self.w, self.h, r, r)
    end

    love.graphics.setColor(COL[1])
    love.graphics.print(self.choice[self.current], self.x+r, self.centerY)
    -- selection text
    if self.isSelected then
        love.graphics.setColor(COL[1])
        for i = 1,#self.choice do
            love.graphics.print(self.choice[i], self.x+r, self.centerY+i*self.h)
        end
    end

    -- triangle
    if self.mouseOver then
        love.graphics.setColor(COL[8])
        love.graphics.polygon('line', self.triVerts)
    else
        love.graphics.setColor(COL[8])
        love.graphics.polygon('fill', self.triVerts)
        love.graphics.polygon('line', self.triVerts)
    end

end


function Dropdown:mousepressed(x, y, key)
    -- lock and unlock other gui
    if self.mouseOver then
        self.isSelected = not self.isSelected
        if self.isSelected then 
            Gui.static.lock = self 
        else
            Gui.static.lock = nil 
        end
    else
        self.isSelected = false
        Gui.static.lock = nil
    end

    -- update selection
    if self.onChoice then
        self.current = self.onChoice
        self.val = self.choice[self.current]
        self.isSelected = false
    end
end


function Dropdown:mousereleased(x, y, key)

end


return Dropdown