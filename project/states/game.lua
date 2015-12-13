states.game = {}
states.game.entities = {}
states.game.clock = 0
states.game.nukeInterval = 4
states.game.player = nil
states.game.partClock = 0
states.game.tutorial = true

function states.game:enter()
	self.flash = 0
	self.fade = 255
	for k,v in pairs(self.entities) do
		self.entities[k] = nil
	end

	self.player = Player( love.graphics.getWidth()/2 - 98, love.graphics.getHeight() - 142 )
	self.player.entities = self.entities

	table.insert( self.entities, self.player )
	tree = Tree()
	self.tree = tree
	table.insert( self.entities, tree )

    wellImg = love.graphics.newImage("assets/well.png")
	fertilizerImg = love.graphics.newImage("assets/fertilizer.png")
	potImg = love.graphics.newImage("assets/pot.png")
	tutorialArrowImg = love.graphics.newImage("assets/tutorialArrow.png")

	self.treeCount = 0
	self.tutorialTime = love.timer.getTime()
	self.tutorialWarningState = 0

	if love.filesystem.exists('highscores.sav') then
		self.tutorial = false
	end
end

local function dist(x1,y1,x2,y2)
	return math.sqrt( math.pow(x1-x2,2) + math.pow(y1-y2,2) )
end

function states.game:update( dt )

	for k,v in pairs( self.entities ) do
		--if self.entities[i] ~= nil then
			--local v = self.entities[i]
		v:update(dt)

		-- check collisions using chull
		if v.nuke == true then
			if dist(v.pos.x, v.pos.y, self.player.pos.x + self.player.chull.xo, self.player.pos.y + self.player.chull.yo) < v.chull.r + self.player.chull.r then
				--self.entities[i] = nil
				v:bounce()
				v.pos.dx = v.pos.dx + self.player.pos.dx/5
			end

			if v.pos.x > love.window.getWidth() + 100*0.7*0.5 then
				self.entities[k] = nil
			end
			if v.pos.x < -100*0.7*0.5 then
				self.entities[k] = nil
			end
			if v.pos.y > love.window.getHeight() - 101*0.7*0.5 then
				v:explode()
				self.flash = self.flash + 192
				if self.flash > 255 then self.flash = 255 end
				for i = 1,100 do
					local p = Particle( v.pos.x, v.pos.y )
					local ang = math.random(-180) * math.pi/180
					p.pos.dx = math.cos(ang)*5 * math.random(100)/200
					p.pos.dy = math.sin(ang)*5 * math.random(100)/100
					p.pos.ddy = 0.02
					p.r = 22

					if math.random(2) == 2 then
						p.col.r = 255
						p.col.g = 102
					else
						p.col.r = 255
						p.col.g = 204
						p.col.b = 102
					end
					table.insert(self.entities, p)
					
				end
				self.entities[k] = nil
				self.tree.health = self.tree.health - 2
			end
		end

		if v.hp then
			if v.hp <= 0 then
				self.entities[k] = nil
			end
		end
		--end

	end

	self.flash = self.flash - dt * 200
	if self.flash < 0 then self.flash = 0 end

	self.fade = self.fade - dt * 100
	if self.fade < 0 then self.fade = 0 end

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
			if v.isTree == true then
				self.entities[k] = nil
			end
		end
		self.tree = nil

		tree = Tree()
		self.tree = tree
		table.insert( self.entities, tree )
		self.treeCount = self.treeCount + 1
	end

	self.partClock = self.partClock + dt
	if self.partClock > 0.1 then
		self.partClock = 0
		for k,v in pairs( self.entities ) do
			if v.nuke == true then
				local rot = v.rot - math.pi/2
				local p = Particle( v.pos.x + math.cos(rot)*30, v.pos.y + math.sin(rot)*30 )
				p.r = 8
				p.decay = 4
				table.insert( self.entities, p )
			end
		end
	end
end

function states.game:draw()
	love.graphics.setBackgroundColor(255, 255, 255)

	love.graphics.setColor(200,0,0,self.flash/2)
	love.graphics.rectangle("fill",0,0,love.window.getWidth(), love.window.getHeight())

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

	drawBar(love.graphics.getWidth()/2, 60, "HEALTH", tree.health, 10, {244, 0, 0, 100})
	drawBar(love.graphics.getWidth()/2-300, 80, "WATER", tree.water, 10, {0, 97, 255, 100})
	drawBar(love.graphics.getWidth()/2+300, 80, "LOVE", tree.food, 10, {255, 102, 153, 100})

	love.graphics.setFont(bigFont)
	love.graphics.printf(self.treeCount .. " TREES", 0, 110, love.graphics.getWidth(), 'center')

	if self.tutorial then
		love.graphics.setFont(medFont)
		love.graphics.setColor(0, 0, 0)
		if love.timer.getTime() - self.tutorialTime < 10 then
			
			--water
			love.graphics.print("Hydrate your tree", 5, 440)
			love.graphics.draw(tutorialArrowImg, 45, 550, 3 * math.pi/2)
			
			--love
			love.graphics.print("Love your tree", love.graphics.getWidth() - 180, 500)
			love.graphics.draw(tutorialArrowImg, love.graphics.getWidth() - 100, 600, 3 * math.pi/2)

			--nukes
			for k, entity in pairs(self.entities) do
				if entity.nuke then
					local x = entity.pos.x + 20
					local y = entity.pos.y
					love.graphics.print("STOP THIS", x, y)
				end
			end
		end

		--warning
		local danger = tree.water == 0 or tree.food == 0
		if self.tutorialWarningState == 0 and danger then
			self.tutorialWarningState = 1 --begin warning
		elseif self.tutorialWarningState == 1 and not danger then
			self.tutorialWarningState = 2 --end warning
		end
		if self.tutorialWarningState == 1 then
			love.graphics.print("YOUR TREE NEEDS\nWATER & LOVE OR\nIT WILL STOP GROWING\nAND LOSE HEALTH", 860, 300)
		end
	end

	love.graphics.setColor(255,255,255,self.flash)
	love.graphics.rectangle("fill", 0,0, love.window.getWidth(), love.window.getHeight())

	love.graphics.setColor(255,255,255,self.fade)
	love.graphics.rectangle("fill", 0,0, love.window.getWidth(), love.window.getHeight())
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
