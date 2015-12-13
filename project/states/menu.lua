states.menu = {}
function states.menu:enter()
	menubg = love.graphics.newImage("assets/menubg.png")
	rightArrowUp = love.graphics.newImage("assets/arrow.png")
	rightArrowPressed = love.graphics.newImage("assets/arrowpressed.png")

	leftArrowUp = love.graphics.newImage("assets/leftarrow.png")
	leftArrowPressed = love.graphics.newImage("assets/leftarrowpressed.png")

	arrow1state = 0
	arrow2state = 0
	arrow1X = 637
	arrow2X = 689
	arrowY = 347

	--setup tree for i in title
	tree = Tree()
	tree:init()
	tree.pos.x = 354
	tree.pos.y = -430
	tree.growth = 9
	tree.ratioConstant = 0.7
	tree.ratioMultiplier = 90
	tree.angleOffset = 0.7
	tree.angleSplit = 0
	tree.growthRate = 0
end

function states.menu:update()
	if love.keyboard.isDown("left") then
		arrow1state = 1
	else 
		arrow1state = 0
	end

	if love.keyboard.isDown("right") then
		arrow2state = 1
	else
		arrow2state = 0 
	end

	if love.keyboard.isDown("left") and love.keyboard.isDown("right") then
		gamestate.switch(states.game)
	end
end

function states.menu:draw()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(255, 255, 255) 
	love.graphics.draw(menubg,0,0)

	if arrow1state == 0 then
		love.graphics.draw(leftArrowUp,arrow1X,arrowY)
	else
		love.graphics.draw(leftArrowPressed,arrow1X,arrowY)
	end

	if arrow2state == 0 then
		love.graphics.draw(rightArrowUp,arrow2X,arrowY)
	else
		love.graphics.draw(rightArrowPressed,arrow2X,arrowY)
	end

	tree:draw()
end
