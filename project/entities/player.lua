Player = class{
	pos = {x = 0, y = 0}
	init = function( self, x, y )
		pos.x = x
		pos.y = y
	end,
	setX = function( self, x )
		self.x = x
	end,
	setY = function( self, y )
		self.y = y
	end

}

-- 74x200