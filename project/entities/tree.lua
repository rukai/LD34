Tree = class{
	pos = {x = 0, y = 0}
}

function Tree:init()
	self.pos.x = 0
	self.pos.y = 0
	self.growth = 0
	self.health = 10
	self.water = 10
	self.food = 10
	
	--drawing constants
	self.ratioConstant = rand(0.4, 0.7)
	self.ratioMultiplier = 170
	self.angleOffset = rand(0.4, 0.9)
	self.angleSplit = rand(-self.angleOffset, self.angleOffset)

	self.canvas = love.graphics.newCanvas(love.window.getWidth(), love.window.getHeight())
	self.startTime = love.timer.getTime()
	self.growthRate = 1 -- number of seconds before tree grows
	self.maxGrowth = 10
end

function Tree:draw ()
	love.graphics.setCanvas(self.canvas)
	love.graphics.setColor(0, 0, 0)
	local width = self.canvas:getWidth()
	local height = self.canvas:getHeight()
	if self.growth > 0 then
		self.drawBranch(self, width/2, height, math.pi/2, 0)
	end
	love.graphics.setCanvas()
	
	--fade out when finished growing
	if self.growth == self.maxGrowth then
		local alpha = 255 - math.min(255 * (love.timer.getTime() - self.startTime)/self.growthRate, 255)
		love.graphics.setColor(0, 0, 0, alpha)
	end
	love.graphics.draw(self.canvas, self.pos.x, self.pos.y)
end

function Tree:drawBranch(x, y, angle, iteration) -- x and y refer to the ends of the previously drawn branch
	local ratio = self.ratioConstant ^ iteration * self.ratioMultiplier

	local newX = x + (math.cos(angle) * ratio)
	local newY = y - (math.sin(angle) * ratio)
	if iteration == self.growth-1 then 
		local alpha = 255 * (love.timer.getTime() - self.startTime)/self.growthRate
		love.graphics.setColor(0, 0, 0, alpha)
	end
	love.graphics.line(x, y, newX, newY)
	love.graphics.setColor(0, 0, 0)
	if iteration < self.growth-1 then
		self.drawBranch(self, newX, newY, angle + self.angleOffset + self.angleSplit, iteration + 1)
		self.drawBranch(self, newX, newY, angle - self.angleOffset + self.angleSplit, iteration + 1)
	end
end

function Tree:update(dt)

	--grow
	local newTime = love.timer.getTime()
	if newTime - self.startTime > self.growthRate and self.growth <= self.maxGrowth then
		self.startTime = newTime
		self.growth = self.growth + 1
	end
	
	self.water = self.water - 0.003
	self.food = self.food - 0.003

	if self.water <= 0 then
		self.water = 0
		self.startTime = newTime
		self.health = self.health - 0.003
	end
	if self.food <= 0 then
		self.food = 0
		self.startTime = newTime
		self.health = self.health - 0.003
	end

	if self.health < 0 then
		self.health = 0
	end
end

function Tree:giveWater()
	self.water = self.water + 2
	if self.water > 10 then
		self.water = 10
	end
end

function Tree:feed()
	self.food = self.food + 2
	if self.food > 10 then
		self.food = 10
	end
end
