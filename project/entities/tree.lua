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
	self.canvas = love.graphics.newCanvas(1024, 768)
	self.startTime = love.timer.getTime()
	self.growthRate = 2 -- number of seconds before tree grows
end

function Tree:draw ()
	love.graphics.setCanvas(self.canvas)
	love.graphics.setColor(0, 0, 0)
	local width = self.canvas:getWidth()
	local height = self.canvas:getHeight()
	self.drawBranch(self, width/2, height, math.pi/2, 0)
	love.graphics.setCanvas()

	love.graphics.draw(self.canvas, 0, 0)
end

function Tree:drawBranch(x, y, angle, iteration) -- x and y refer to the ends of the previously drawn branch
	local ratio = 0.7 ^ iteration * 170 

	local newX = x + (math.cos(angle) * ratio)
	local newY = y - (math.sin(angle) * ratio)
	if iteration == self.growth then 
		local alpha = 255 * (love.timer.getTime() - self.startTime)/self.growthRate
		love.graphics.setColor(0, 0, 0, alpha)
	end
	love.graphics.line(x, y, newX, newY)
	love.graphics.setColor(0, 0, 0)
	if iteration < self.growth then
		self.drawBranch(self, newX, newY, angle + 0.6, iteration + 1)
		self.drawBranch(self, newX, newY, angle - 0.6, iteration + 1)
	end
end

function Tree:update(dt)

	--grow
	local newTime = love.timer.getTime()
	if newTime - self.startTime > self.growthRate and self.growth <= 10 then
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
