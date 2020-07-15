
local react = {}


function react:load()

    shader = love.graphics.newShader('assets/shader/react.fs')
    render = love.graphics.newShader('assets/shader/render.fs')
    canvas = love.graphics.newCanvas(800, 400)
    buffer = love.graphics.newCanvas(800, 400)

    -- initial condition
    loadinit()

    -- slider
    s_feed = Slider:new('Feed Rate', 650, 50, 200, 0, 0.1)
    s_feed:send(0.04)
    s_kill = Slider:new('Kill Rate', 650, 100, 200, 0, 0.1)
    s_kill:send(0.062)

    -- button
    b_reset = Button:new('Reset', 690, 500)
    b_reset.click = loadinit

end


function react:update(dt)

    shader:send('dt', dt)
    shader:send('Feed', s_feed.val)
    shader:send('Kill', s_kill.val)
    timeMarch(canvas, shader, buffer)
    timeMarch(canvas, shader, buffer)
    timeMarch(canvas, shader, buffer)
    timeMarch(canvas, shader, buffer)
    timeMarch(canvas, shader, buffer)

end


function react:draw()

    -- bcakground
    love.graphics.setColor(COL[8])
    love.graphics.rectangle('fill', 0, 0, 600, 600)

    -- draw simulation
    love.graphics.setColor(1, 1, 1, 1)

    if debug.show then
        love.graphics.draw(canvas, 100, 100)
    else
        love.graphics.setShader(render)
        love.graphics.draw(canvas, 100, 100)
        love.graphics.setShader()
    end

    -- gui panel
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', 600, 0, 300, 600)

end


function timeMarch(canvas, shader, buffer)
    love.graphics.setColor(1, 1, 1, 1)
    -- buffer <- shader(canvas)
    love.graphics.setShader(shader)
    love.graphics.setCanvas(buffer)
    love.graphics.draw(canvas)
    -- canvas <- shader(buffer)
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.draw(buffer)
    love.graphics.setShader()
    -- buffer = 0
    love.graphics.setCanvas(buffer)
    love.graphics.clear()
    love.graphics.setCanvas()
end


function loadinit()
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    -- u initial condition
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.circle('fill', 200, 200, 199, 199)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 190, 190, 20, 20)
    -- v initial condition
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.circle('fill', 600, 200, 199, 199)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', 590, 190, 20, 20)
    love.graphics.setCanvas()
end


return react