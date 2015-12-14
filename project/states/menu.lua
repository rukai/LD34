states.menu = {}
function states.menu:enter()
	self.menubg = love.graphics.newImage("assets/menubg.png")
	self.rightArrowUp = love.graphics.newImage("assets/arrow.png")
	self.rightArrowPressed = love.graphics.newImage("assets/arrowpressed.png")

	self.leftArrowUp = love.graphics.newImage("assets/leftarrow.png")
	self.leftArrowPressed = love.graphics.newImage("assets/leftarrowpressed.png")

	self.arrow1state = 0
	self.arrow2state = 0
	self.arrow1X = 637
	self.arrow2X = 689
	self.arrowY = 347

	--setup tree for i in title
	local tree = Tree()
	tree:init()
	tree.growth = 12
	tree.ratioConstant = 0.7
	tree.ratioMultiplier = 90
	tree.angleOffset = 0.7
	tree.angleSplit = 0
	tree.growthRate = 0
	self.treeCanvas = tree:getStaticCanvas()
end

function states.menu:update()
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
end

function states.menu:draw()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(255, 255, 255) 
	love.graphics.draw(self.menubg,0,0)

	if self.arrow1state == 0 then
		love.graphics.draw(self.leftArrowUp,self.arrow1X,self.arrowY)
	else
		love.graphics.draw(self.leftArrowPressed,self.arrow1X,self.arrowY)
	end

	if self.arrow2state == 0 then
		love.graphics.draw(self.rightArrowUp,self.arrow2X,self.arrowY)
	else
		love.graphics.draw(self.rightArrowPressed,self.arrow2X,self.arrowY)
	end

	love.graphics.draw(self.treeCanvas, 354, -430)
end
