states.score = {}

function states.score:enter()
	--graphics
	self.rightArrowUp = love.graphics.newImage("assets/arrow.png")
	self.rightArrowPressed = love.graphics.newImage("assets/arrowpressed.png")
	self.leftArrowUp = love.graphics.newImage("assets/leftarrow.png")
	self.leftArrowPressed = love.graphics.newImage("assets/leftarrowpressed.png")
	
	--menu state
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

	--load highscore
	local saveFile = love.filesystem.newFile("highscores.sav")
	self.score = states.game.treeCount
	self.highscore = 0
	saveFile:open("r") -- open file for reading.
	local data = saveFile:read()
	saveFile:close()
	if data then
		self.highscore = tonumber(data)
	end

	--update highscore
	if self.score >= self.highscore then
		self.highscore = self.score
		saveFile:open('w')
		saveFile:write(tostring(self.highscore))
		saveFile:close()
		saved = 1
	end
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

	--fade in
	if self.fadeAlpha > 0 then
		self.fadeAlpha = self.fadeAlpha - 100 * dt
	end
	if self.fadeAlpha < 0 then
		self.fadeAlpha = 0
	end
end

function states.score:draw()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(0, 0, 0) 
	
	--score
	love.graphics.setFont(medFont)
	love.graphics.printf("YOU GREW", 0, 40, love.graphics.getWidth(), 'center')

	love.graphics.setFont(hugeFont)
	scoreString = self.score .. " TREE"
	if self.score ~= 1 then
		scoreString = scoreString .. "S"
	end
	love.graphics.printf(scoreString, 0, 70, love.graphics.getWidth(), 'center')

	--highscore
	local highscoreString = "NEW HIGHSCORE"
	if self.score < self.highscore then
		highscoreString = "BEST: " .. self.highscore
	end
	love.graphics.setFont(medFont)
	love.graphics.printf(highscoreString, 0, 175, love.graphics.getWidth(), 'center')

	--play again
	love.graphics.setFont(medFont)
	love.graphics.print("PRESS", 530, love.graphics.getHeight() - 120)
	love.graphics.printf("TO GET BACK TO WORK", 0, love.graphics.getHeight() - 80, love.graphics.getWidth(), 'center')

	--play again buttons
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
