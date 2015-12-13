Particle = class{
	
	init = function( self, x, y )
		self.pos = {
			x = 0, 
			y = 0,
			dx = 0,
			dy = 0,
			ddx = 0,
			ddy = 0.0
		}
		self.chull = {
			xo = 0,
			yo = 10,
			r = 20,
		}
		self.col = {
			r = 255,
			g = 0,
			b = 0
		}
		self.pos.x = x
		self.pos.y = y
		self.hp = 100
		self.r = 16
		self.decay = 1
	end,
	draw = function( self )
		love.graphics.setColor(self.col.r*self.hp/100,self.col.g*self.hp/100,self.col.b*self.hp/100, 195)
		love.graphics.circle("fill",self.pos.x, self.pos.y, self.r*(self.hp/100))
		
	end,
	update = function( self, dt )
		self.pos.dx = self.pos.dx + self.pos.ddx

		self.pos.x = self.pos.x + self.pos.dx

		self.pos.dy = self.pos.dy + self.pos.ddy

		self.pos.y = self.pos.y + self.pos.dy

		self.hp = self.hp - dt*40*self.decay

		if self.hp < 0 then 
			self.hp = 0 
			self.update = function() end
			self.draw = function() end
		end

	end,

}