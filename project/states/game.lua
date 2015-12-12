states.game = {}
states.game.entities = {}
states.game.clock = 0
states.game.nukeInterval = 0.5
states.game.player = nil

function states.game:enter()
	for k,v in pairs(self.entities) do
		self.entities[k] = nil
	end

	self.player = Player( love.graphics.getWidth()/2 - 98, love.graphics.getHeight() - 142 )

	table.insert( self.entities, self.player )
	tree = Tree()
	table.insert( self.entities, tree )

    wellImg = love.graphics.newImage("assets/well.png")
	fertilizerImg = love.graphics.newImage("assets/fertilizer.png")
	potImg = love.graphics.newImage("assets/pot.png")
	self.treeCount = 0
end

local function dist(x1,y1,x2,y2)
	return math.sqrt( math.pow(x1-x2,2) + math.pow(y1-y2,2) )
end

function states.game:update( dt )
	self.clock = self.clock + dt
	if self.clock > self.nukeInterval then
		local x = math.random( love.window.getWidth() )
		local nuke = Nuke( x, -100, 0 )
		table.insert( self.entities, nuke )
		self.clock = 0

		local frac = x/love.window.getWidth()
		if frac > 0.5 then frac = -(frac-0.5)
		elseif frac < 0.5 then frac = 0.5-frac end

		nuke.pos.dx = frac*math.random( 2.5, 6.5 )
	end
	if tree.growth > tree.maxGrowth then
		for k,v in pairs(self.entities) do
			if self.entities[k] == tree then
				table.remove(self.entities, k)
			end
		end

		tree = Tree()
		table.insert( self.entities, tree )
		self.treeCount = self.treeCount + 1
	end

	for i = 1, #self.entities do
		if self.entities[i] ~= nil then
			local v = self.entities[i]
			v:update(dt)

			-- check collisions using chull
			if v.nuke == true then
				if dist(v.pos.x, v.pos.y, self.player.pos.x, self.player.pos.y) < v.chull.r + self.player.chull.r then
					--self.entities[i] = nil
					v:bounce()
				end
			end
		end

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

	drawBar(love.graphics.getWidth()/2, 60, "HEALTH", tree.health, 10, {244, 0, 0})
	drawBar(love.graphics.getWidth()/2-300, 80, "WATER", tree.water, 10, {0, 97, 255})
	drawBar(love.graphics.getWidth()/2+300, 80, "LOVE", tree.food, 10, {255, 102, 153})

	love.graphics.setFont(bigFont)
	love.graphics.printf(self.treeCount .. " TREES", 0, 110, love.graphics.getWidth(), 'center')
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
	love.graphics.printf(name, x-width/2, y-35, width, 'center')
end
