Player = class{
	pos = {x = 0, y = 0}
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
		love.graphics.setColor( 0,0,0 )
		love.graphics.rectangle( self.pos.x, self.pos.y, 74, 200 )
	end
}

-- 74x200