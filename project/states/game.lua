states.game = {}
states.game.entities = {}

function states.game:enter()
	for k,v in pairs(self.entities) do
		self.entities[k] = nil
	end

	table.insert( self.entities, Player( 0, 576 - 132 ) )
end

function states.game:update( dt )
	for k,v in pairs(self.entities) do
		v:update()
	end
end

function states.game:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle( "fill", 0, 0, 1024, 768 )

	for k,v in pairs(self.entities) do
		v:draw()
	end

end