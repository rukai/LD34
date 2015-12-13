states.score = {}

function states.score:enter()
	self.rightArrowUp = love.graphics.newImage("assets/arrow.png")
	self.rightArrowPressed = love.graphics.newImage("assets/arrowpressed.png")

	self.leftArrowUp = love.graphics.newImage("assets/leftarrow.png")
	self.leftArrowPressed = love.graphics.newImage("assets/leftarrowpressed.png")

	self.arrow1state = 0
	self.arrow2state = 0
	self.fadeAlpha = 255

	--setup tree for i in title
	self.tree = Tree()
	self.tree:init()
	self.tree.pos.x = 0
	self.tree.pos.y = -138
	self.tree.growth = 9
	self.tree.ratioConstant = 0.7
	self.tree.ratioMultiplier = 130
	self.tree.angleOffset = 0.7
	self.tree.angleSplit = 0
	self.tree.growthRate = 0
end
function states.score:update(dt)
	if love.keyboard.isDown("left") then
		self.arrow1state = 1
	else 
		self.arrow1state = 0
	end

	if love.keyboard.isDown("right") then
		self.arrow2state = 1
	else
		self.arrow2state = 0 
	end

	if love.keyboard.isDown("left") and love.keyboard.isDown("right") then
		gamestate.switch(states.game)
	end

	if self.fadeAlpha > 0 then
		self.fadeAlpha = self.fadeAlpha - 100 * dt
	end
end
function states.score:draw()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(0, 0, 0) 
	
	love.graphics.setFont(medFont)
	love.graphics.printf("YOU GREW", 0, 70, love.graphics.getWidth(), 'center')
	love.graphics.setFont(hugeFont)
	love.graphics.printf(states.game.treeCount .. " TREES", 0, 100, love.graphics.getWidth(), 'center')

	love.graphics.setFont(medFont)
	love.graphics.print("PRESS", 530, love.graphics.getHeight() - 120)
	love.graphics.printf("TO GET BACK TO WORK", 0, love.graphics.getHeight() - 80, love.graphics.getWidth(), 'center')

	love.graphics.setColor(255, 255, 255) 
	local arrow1X = 637
	local arrow2X = 689
	local arrowY = love.graphics.getHeight() - 130
	if self.arrow1state == 0 then
		love.graphics.draw(self.leftArrowUp, arrow1X, arrowY)
	else
		love.graphics.draw(self.leftArrowPressed, arrow1X, arrowY)
	end
	if self.arrow2state == 0 then
		love.graphics.draw(self.rightArrowUp, arrow2X, arrowY)
	else
		love.graphics.draw(self.rightArrowPressed, arrow2X, arrowY)
	end

	self.tree:draw()

	--fade in
	love.graphics.setColor(255, 255, 255, self.fadeAlpha)
	love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end
