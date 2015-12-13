Nuke = class{
	img = love.graphics.newImage( "assets/nuke.png" ),
	nuke = true,
	bounceCooldown = 0,
	init = function( self, x, y, dx )

		self.bounceSnd = love.audio.newSource("assets/nukeBounce.wav",static)
		self.bounceSnd:setVolume(0.1)

		self.explodeSnd = love.audio.newSource("assets/explode.wav",static)
		self.explodeSnd:setVolume(0.2)

		self.pos = {
			x = 0, 
			y = 0,
			dx = 2,
			dy = 0,
			ddx = 0,
			ddy = 0.02
		}
		self.chull = {
			xo = 0,
			yo = 0,
			r = 20,
		}
		self.pos.x = x
		self.pos.y = y
		self.pos.dx = dx
		self.particles = {}
		self.partClock = 0
		self.rot = 0
	end,
	draw = function( self )

		for k,v in ipairs( self.particles ) do
			v:draw()
		end


		love.graphics.setColor(255,255,255)
		love.graphics.draw( self.img, self.pos.x, self.pos.y,  self.rot, 0.7, 0.7, 52/2, 101/2 )

		--love.graphics.setColor(255,0,0)
		--love.graphics.circle( "line", self.pos.x + self.chull.xo, self.pos.y + self.chull.yo, self.chull.r )
	end,
	update = function( self, dt )

		self.rot = math.atan2(self.pos.dy, self.pos.dx) - math.pi/2

		self.pos.dx = self.pos.dx + self.pos.ddx

		self.pos.x = self.pos.x + self.pos.dx

		self.pos.dy = self.pos.dy + self.pos.ddy

		self.pos.y = self.pos.y + self.pos.dy

		self.bounceCooldown = self.bounceCooldown - dt
		if self.bounceCooldown < 0 then self.bounceCooldown = 0 end

		self.partClock = self.partClock + dt
		if self.partClock > 0.15 then
			self.partClock = 0
			--table.insert( self.particles, Particle( self.pos.x, self.pos.y) )
		end

		for i = 1, #self.particles do
			if self.particles[i] ~= nil then
				local v = self.particles[i]
				v:update( dt )
				if v.hp <= 0 then self.particles[i] = nil end
			end
		end

	end,
	bounce = function( self )
		if self.bounceCooldown == 0 then
			self.pos.dy = -self.pos.dy
			self.pos.ddy = -0.04
			self.bounceCooldown = 1

			self.bounceSnd:stop()
			self.bounceSnd:play()
		end
	end,
	explode = function( self )
		self.explodeSnd:stop()
		self.explodeSnd:play()
		self.pos.dx = 0
		self.pos.dy = 0
		self.pos.ddy = 0
		
		
	end

}