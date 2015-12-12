states = {}

--require "splashscreen"

-- util
gamestate = require "gamestate"
class = require "class"

-- classes
require "entities.player"
require "entities.tree"
require "entities.nuke"
require "entities.particle"

-- actual states
require "states.menu"
require "states.game"
require "states.score"
require "states.splash"

function love.load()
	min_dt = 1/60
	next_time = love.timer.getTime()
	gamestate.registerEvents()
	gamestate.switch( states.game )

	tinyFont = love.graphics.newFont("assets/roboto.ttf", 12)
	font = love.graphics.newFont("assets/roboto.ttf", 20)
	medFont = love.graphics.newFont("assets/roboto.ttf", 25)
	bigFont = love.graphics.newFont("assets/roboto.ttf", 40)
	hugeFont = love.graphics.newFont("assets/roboto.ttf", 90)
end

function love.update( dt )
	next_time = next_time + min_dt
end

function love.draw()
	local cur_time = love.timer.getTime()
	if next_time <= cur_time then
		next_time = cur_time
		return
	end
	love.timer.sleep(next_time - cur_time)
end

function rand(min, max)
	local range = max - min
	return min + range * math.random()
end
