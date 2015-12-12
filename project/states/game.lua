states.game = {}
states.game.entities = {}
states.game.clock = 0
states.game.nukeInterval = 5

function states.game:enter()
	for k,v in pairs(self.entities) do
		self.entities[k] = nil
	end

	table.insert( self.entities, Player( love.graphics.getWidth()/2 - 98, love.graphics.getHeight() - 142 ) )
	tree = Tree()
	table.insert( self.entities, tree )

    wellImg = love.graphics.newImage("assets/well.png")
	fertilizerImg = love.graphics.newImage("assets/fertilizer.png")
	potImg = love.graphics.newImage("assets/pot.png")


end

function states.game:update( dt )
	self.clock = self.clock + dt
	if self.clock > self.nukeInterval then
		local x = math.random( love.window.getWidth() )
		local nuke = Nuke( x, -100, 0 )
		table.insert( self.entities, nuke )
		self.clock = 0
	end
	if tree.growth > 10 then
		for k,v in pairs(self.entities) do
			if self.entities[k] == tree then
				table.remove(self.entities, k)
			end
		end

		tree = Tree()
		table.insert( self.entities, tree )
	end

	for k,v in pairs(self.entities) do
		v:update(dt)
	end
end

function states.game:draw()
	love.graphics.setBackgroundColor(255, 255, 255)

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle( "fill", 0, love.graphics.getHeight()-10, love.graphics.getWidth(), love.graphics.getHeight())

	love.graphics.setColor(255, 255, 255)
    local yOffset = love.graphics.getHeight() - wellImg:getHeight()
    love.graphics.draw(wellImg, 0, yOffset)

	local xOffset = love.graphics.getWidth() - fertilizerImg:getWidth()
	local yOffset = love.graphics.getHeight() - fertilizerImg:getHeight()
	love.graphics.draw(fertilizerImg, xOffset, yOffset)

	local xOffset = love.graphics.getWidth()/2 - potImg:getWidth()/2
	local yOffset = love.graphics.getHeight() - potImg:getHeight() - 9
	love.graphics.draw(potImg, xOffset, yOffset)

	for k,v in pairs(self.entities) do
		v:draw()
	end

	drawBar(love.graphics.getWidth()/2, 80, "HEALTH", tree.health, 10, {244, 0, 0})
	drawBar(love.graphics.getWidth()/2-300, 100, "WATER", tree.water, 10, {0, 97, 255})
	drawBar(love.graphics.getWidth()/2+300, 100, "LOVE", tree.food, 10, {255, 102, 153})
end

function drawBar(x, y, name, value, maxValue, color)
	local width = maxValue * 25
	local height = 10

	love.graphics.setColor(color)
	love.graphics.rectangle('fill', x, y, width/2 * value/maxValue, height)
	love.graphics.rectangle('fill', x, y, -width/2 * value/maxValue, height)

	love.graphics.setColor(0, 0, 0)
	--love.graphics.rectangle('line', x - width/2, y, width, height)

	love.graphics.setFont(medFont)
	--love.graphics.printf(name, x-width/2, y+15, width, 'center')
	love.graphics.printf(name, x-width/2, y-45, width, 'center')
end
