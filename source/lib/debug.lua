-- Debug log management 
-- pke1029
-- 8th July 2020


-- init 
local debug = {
    show = false,
    log = {}
}


-- clear debug log
function debug:clear()
    self.log = {}
end


-- print debug log
function debug:print()
    local n = 0
    for k,v in pairs(self.log) do
        love.graphics.print(k..' : '..v, 0, n*10)
        n = n + 1 
    end
end


function debug:update(dt)
    self.log['FPS'] = love.timer.getFPS()
    self.log['State'] = state:getState()
end


function debug:draw()
    
    if self.show == true then
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', 0, 0, 300, 200)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(FONT.small)
        self:print()
    end

end


function debug:keypressed(key)
    if key == 'f1' then
        self.show = not self.show
    end
end


return debug