
-- load global functions 
require('lib/util')

-- third-party lib
class = require('lib/middleclass')      -- https://github.com/kikito/middleclass

-- load modules
state = require('lib/state')
debug = require('lib/debug')
fmath = require('lib/fmath')

-- load class
Gui = require('lib/gui')
Button = require('lib/gui/button')
Slider = require('lib/gui/slider')
Dropdown = require('lib/gui/dropdown')
Checkbox = require('lib/gui/checkbox')
Tile = require('lib/tile')

-- global variables
COL = {
    [0] = {0.0, 0.0, 0.0},
    {0.1, 0.1, 0.1},
    {0.2, 0.2, 0.2},
    {0.3, 0.3, 0.3},
    {0.4, 0.4, 0.4},
    {0.5, 0.5, 0.5},
    {0.6, 0.6, 0.6},
    {0.7, 0.7, 0.7},
    {0.8, 0.8, 0.8},
    {0.9, 0.9, 0.9},
    {1.0, 1.0, 1.0},
    red = {0.9, 0.1, 0.1},
    green = {0.255, 0.961, 0.648},
    blue = {0.207, 0.687, 0.945},
}

FONT = {
	small = love.graphics.newFont("assets/font/KenneyPixel.ttf", 18),
	medium = love.graphics.newFont("assets/font/KenneyPixel.ttf", 32),
	large = love.graphics.newFont("assets/font/KenneyPixel.ttf", 60),
	huge = love.graphics.newFont("assets/font/KenneyPixel.ttf", 80),
}
