
require('globals')


function love.load()

    love.graphics.setDefaultFilter("nearest", "nearest")
    
    state:loadState('assets/state')
    state:setState('react')
	state:load()

end


function love.update(dt)

    state:update(dt)
    Gui:update(dt)
    debug:update(dt)

end


function love.draw()

    state:draw()
    Gui:draw()
    debug:draw()

end


function love.keypressed(key)

    state:keypressed(key)
    debug:keypressed(key)

end


function love.mousepressed(x, y, key)

    state:mousepressed(x, y, key)
    Gui:mousepressed(x, y, key)

end


function love.mousereleased(x, y, key)

    state:mousereleased(x, y, key)
    Gui:mousereleased(x, y, key)

end