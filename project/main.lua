local states = {}

-- util
gamestate = require "gamestate"
class = require "class"

-- actual states
require "states.menu"
require "states.game"
require "states.score"

function love.load()

	gamestate.registerEvents()
	gamestate.switch( states.game )

end

function love.update( dt )

end

function love.draw()

end





