
local Tile = class('Tile')

Tile.static.path = 'assets/image'
Tile.static.objects = {}


function Tile:initialize(filename, w, h, sw, sh)
    self.name = filename 
    self.img = love.graphics.newImage(filename)
    self.w = w
    self.h = h 
    self.sw = sw 
    self.sh = sh
    
    self.static.objects[filename] = self
end


function Tile:getQuad(i, j)

    local x = j * (self.w + self.sw)
    local y = i * (self.h + self.sh)
    return love.graphics.newQuad(x, y, self.h, self.w, self.img:getDimensions())

end


return Tile 