Player = class{
	chull = {
		xo = 102/2 - 25,
		yo = -5,
		r = 102/2 - 7,
	},
	pos = {
		x = 0, 
		y = 0,
		dx = 0,
		dy = 0,
		ddx = 0,
		ddy = 0
	},
	item = "",
	--item values:
	--	bucket
	--	sack
	--	umbrella

	speed = 10,
	accel = 3,

	img = love.graphics.newImage("assets/robot.png"),
	bucketimg = love.graphics.newImage("assets/bucket.png"),
	sackimg = love.graphics.newImage("assets/sack.png"),
	umbrellaimg = love.graphics.newImage("assets/umbrella.png"),
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
		local x = self.pos.x - 49/2 + (self.dir == 1 and 49 or 0)
		local y = self.pos.y
		love.graphics.draw( self.img, x, y, self.rot, self.dir == 1 and -1 or 1, 1 )

		if self.item == "bucket" then
			love.graphics.draw( self.bucketimg, x, y+70, 0, 1, 1, 11, 17)
		end

		if self.item == "sack" then
			love.graphics.draw( self.sackimg, x, y+70, 0, 1, 1, 29, 36)
		end

		love.graphics.draw( self.umbrellaimg, self.pos.x+102/2 - 25, self.pos.y -35, 0, -1, 1, 102/2)

		love.graphics.setColor(255,0,0)
		love.graphics.circle( "line", self.pos.x + self.chull.xo, self.pos.y + self.chull.yo, self.chull.r)
	end,

	update = function( self, dt )
		--account for held items in speed
		if self.item == "bucket" or self.item == "sack" then
			self.speed = 5
		else
			self.speed = 10
		end

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
	
		--pickup location items
		if self.pos.x < 102 then
			self.item = "bucket"
		end
		if self.pos.x > love.graphics.getWidth()-134 then
			self.item = "sack"
		end
		
		--give item to tree
		if self.pos.x > love.graphics.getWidth()/2 and self.item == "bucket"  then
			self.item = ""
			tree:giveWater()
		elseif self.pos.x < love.graphics.getWidth()/2 and self.item == "sack" then
			self.item = ""
			tree:feed()
		end
	end,
}

-- 49x132
