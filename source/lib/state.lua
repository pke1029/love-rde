
local state = {
    states = {},			-- all state in the state directory (key: stateName, item: stateData)
    currentState = nil,	    -- current stateData
    stateName = nil
}

-- load all state in path
function state:loadState(path)
    -- if not love.filesystem.getInfo(path) then
    --     error("'"..path.."' does not exist.")
    -- else
        for i, v in ipairs(love.filesystem.getDirectoryItems(path)) do
            if isLuaFile(v) then
                -- get state name (gsub remove .lua extension)
                local name = string.gsub(v, '.lua', '')
                -- excecute state and store in states (.. means concatination)
                self.states[name] = require(path.."/"..name)
            end
        end
    -- end
end

-- set currentState by specifying state name
function state:setState(name)
    self.currentState = self.states[name]
    self.stateName = name
end

-- return current stateName
function state:getState()
    return self.stateName
end

-- callback function ------------------------------------------------

function state:load(data)
    if type(self.currentState.load) == 'function' then
        self.currentState:load(data)
    end
end

function state:update(dt)
    if type(self.currentState.update) == 'function' then
        self.currentState:update(dt)
    end
end

function state:draw()
    if type(self.currentState.draw) == 'function' then
        self.currentState:draw()
    end
end

function state:keypressed(key)
    if type(self.currentState.keypressed) == "function" then
        self.currentState:keypressed(key)
    end
end

function state:mousepressed(x, y, key)
    if type(self.currentState.mousepressed) == "function" then
        self.currentState:mousepressed(x, y, key)
    end
end

function state:mousereleased(x, y, key)
    if type(self.currentState.mousereleased) == "function" then
        self.currentState:mousereleased(x, y, key)
    end
end

function state:quit()
    if type(self.currentState.quit) == "function" then
        self.currentState:quit()
    end
end

-- return state to main
return state