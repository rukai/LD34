states.game = {}
states.game.entities = {}

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
	for k,v in pairs(self.entities) do
		v:update(dt)
	end
end

function states.game:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle( "fill", 0, 0, 1024, 768 )

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

	drawBar(love.graphics.getWidth()/2, 80, "Health", tree.health, 10, {255, 0, 0})
	drawBar(love.graphics.getWidth()/2-300, 100, "Water", tree.water, 10, {0, 0, 255})
	drawBar(love.graphics.getWidth()/2+300, 100, "Food", tree.food, 10, {0, 255, 0})
end

function drawBar(x, y, name, value, maxValue, color)
	local width = maxValue * 25
	local height = 10

	love.graphics.setColor(color)
	love.graphics.rectangle('fill', x, y, width/2 * value/maxValue, height)
	love.graphics.rectangle('fill', x, y, -width/2 * value/maxValue, height)

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle('line', x - width/2, y, width, height)

	love.graphics.setFont(medFont)
	love.graphics.printf(name, x-width/2, y+15, width, 'center')
end
