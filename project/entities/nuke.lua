Nuke = class{
	img = love.graphics.newImage( "assets/nuke.png" ),
	init = function( self, x, y, dx )
		self.pos = {
			x = 0, 
			y = 0,
			dx = 2,
			dy = 0,
			ddx = 0,
			ddy = 0.02
		}
		self.pos.x = x
		self.pos.y = y
		self.pos.dx = dx
	end,
	draw = function( self )
		love.graphics.setColor(255,255,255)
		love.graphics.draw( self.img, self.pos.x, self.pos.y, math.atan2(self.pos.dy, self.pos.dx) - math.pi/2, 1, 1, 52/2, 101/2 )
	end,
	update = function( self )
		self.pos.dx = self.pos.dx + self.pos.ddx

		self.pos.x = self.pos.x + self.pos.dx

		self.pos.dy = self.pos.dy + self.pos.ddy

		self.pos.y = self.pos.y + self.pos.dy
	end,

}