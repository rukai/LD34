states.game = {}
states.game.entities = {}

function states.game:enter()
	for k,v in pairs(self.entities) do
		self.entities[k] = nil
	end

	table.insert( self.entities, Player( 0, love.graphics.getHeight() - 142 ) )
	table.insert( self.entities, Tree() )
end

function states.game:update( dt )
	for k,v in pairs(self.entities) do
		v:update(dt)
	end
end

function states.game:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle( "fill", 0, 0, 1024, 768 )
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle( "fill", 0, love.graphics.getHeight()-10, love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.setColor(255, 255, 255)

	for k,v in pairs(self.entities) do
		v:draw()
	end

end
