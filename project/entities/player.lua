Player = class{
	pos = {
		x = 0, 
		y = 0,
		dx = 0,
		dy = 0,
		ddx = 0,
		ddy = 0
	},

	speed = 10,
	accel = 3,

	img = love.graphics.newImage("assets/robot.png"),
	rot = 0,
	dir = 0,

	init = function( self, x, y )
		self.pos.x = x
		self.pos.y = y
	end,
	setX = function( self, x )
		self.pos.x = x
	end,
	setY = function( self, y )
		self.pos.y = y
	end,
	draw = function( self )
		love.graphics.draw( self.img, self.pos.x - 49/2 + (self.dir == 1 and 49 or 0), self.pos.y, self.rot, self.dir == 1 and -1 or 1, 1 )
	end,
	update = function( self )
		if love.keyboard.isDown( "left" ) then
			self.pos.ddx = -self.accel
			self.dir = 1
			self.rot = self.rot - 0.005
		end
		if love.keyboard.isDown( "right" ) then
			self.pos.ddx = self.accel
			self.dir = 0
			self.rot = self.rot + 0.005
		end

		if (not love.keyboard.isDown( "left" ) and not love.keyboard.isDown( "right" )) or (love.keyboard.isDown( "left" ) and love.keyboard.isDown( "right" )) then
			self.pos.dx = self.pos.dx * 0.8
			self.pos.ddx = 0

			self.rot = self.rot * 0.75
		end

		if self.rot > 0.1 then self.rot = 0.1 end
		if self.rot < -0.1 then self.rot = -0.1 end

		self.pos.dx = self.pos.dx + self.pos.ddx

		if self.pos.dx > self.speed then self.pos.dx = self.speed end
		if self.pos.dx < -self.speed then self.pos.dx = -self.speed end

		self.pos.x = self.pos.x + self.pos.dx
	end,
}

-- 49x132