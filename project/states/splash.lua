states.splash = {}
function states.splash:enter()
	splashscreen = true
	splashscreenTimer = 150
	splashscreenSoundPlayed = false

        logoAlpha = 0
	logoX = love.graphics.getWidth()/3 - 50
	logoY = love.graphics.getHeight()/3 + 20
	diamond1 = {logoX-30,logoY+50,logoX,logoY+20,logoX+30,logoY+50,logoX,logoY+80}
	diamond1Base1 = {logoX-30,logoY+50, logoX-30,logoY+120, logoX, logoY+150, logoX,logoY+80} 
	diamond1Base2 = {logoX, logoY+150,logoX,logoY+80,logoX+30,logoY+50,logoX+30,logoY+120} 


	logo2X = logoX + 30
	logo2Y = logoY - 40 
	diamond2 = {logo2X-30,logo2Y+50,logo2X,logo2Y+20,logo2X+30,logo2Y+50,logo2X,logo2Y+80}
	diamond2Base1= {logo2X-30,logo2Y+50, logo2X-30,logo2Y+120, logo2X, logo2Y+150, logo2X,logo2Y+80} 
	diamond2Base2 = {logo2X, logo2Y+150,logo2X,logo2Y+80,logo2X+30,logo2Y+50,logo2X+30,logo2Y+120} 

	logo3X = logoX + 60
	logo3Y = logoY
	diamond3 = {logo3X-30,logo3Y+60,logo3X,logo3Y+30,logo3X+30,logo3Y+60,logo3X,logo3Y+90}
	diamond3Base1 = {logo3X-30,logo3Y+60, logo3X-30,logo3Y+120, logo3X, logo3Y+150, logo3X,logo3Y+90} 
	diamond3Base2 = {logo3X, logo3Y+150,logo3X,logo3Y+90,logo3X+30,logo3Y+60,logo3X+30,logo3Y+120} 

	
	logo4X = logoX + 30
	logo4Y = logoY + 40
	diamond4 = {logo4X-30,logo4Y+60,logo4X,logo4Y+30,logo4X+30,logo4Y+60,logo4X,logo4Y+90}
	diamond4Base1 = {logo4X-30,logo4Y+60, logo4X-30,logo4Y+110, logo4X, logo4Y+140, logo4X,logo4Y+90} 
	diamond4Base2 = {logo4X, logo4Y+140,logo4X,logo4Y+90,logo4X+30,logo4Y+60,logo4X+30,logo4Y+110} 

	outline = {logoX-40,logoY+120,logoX-40,logoY+40,logo2X,logo2Y+10,logo3X+40,logoY+40,logo3X+40,logoY+120,logo2X,logo4Y+150}
end

function states.splash:update()
         if splashscreen == true and splashscreenTimer > 0 then
			textAlpha = 0
			if logoAlpha < 255 then
				logoAlpha = logoAlpha + 5
			end
			if logoAlpha >= 255 and splashscreenSoundPlayed == false then
				splashscreenSoundPlayed = true
			end

			splashscreenTimer = splashscreenTimer - 1
		end
		if splashscreenTimer <= 0 then
			if logoAlpha > 0 then 
				logoAlpha = logoAlpha - 5
				if logoAlpha <= 0 then
					splashscreen = false
					gamestate.switch(states.game)
				end
			end
		end
end

function states.splash:draw()
	if splashscreen == true then
		--this is just the neoludo logo pls dont judge me
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
		love.graphics.setColor(255,184,255,logoAlpha)
		love.graphics.polygon("fill",diamond2Base1)
		love.graphics.setColor(255,153,255,logoAlpha)
		love.graphics.polygon("fill",diamond2Base2)
		love.graphics.setColor(255,130,255,logoAlpha)
		love.graphics.polygon("fill",diamond2)


		love.graphics.setColor(53,214,255,logoAlpha)
		love.graphics.polygon("fill",diamond1Base1)
		love.graphics.setColor(26,209,255,logoAlpha)
		love.graphics.polygon("fill",diamond1Base2)
		love.graphics.setColor(46,203,255,logoAlpha)
		love.graphics.polygon("fill",diamond1)



		love.graphics.setColor(255,212,45,logoAlpha)
		love.graphics.polygon("fill",diamond3Base1)
		love.graphics.setColor(255,204,0,logoAlpha)
		love.graphics.polygon("fill",diamond3Base2)
		love.graphics.setColor(247,200,13,logoAlpha)
		love.graphics.polygon("fill",diamond3)


		love.graphics.setColor(0,255,153,logoAlpha)
		love.graphics.polygon("fill",diamond4Base1)
		love.graphics.setColor(8,243,149,logoAlpha)
		love.graphics.polygon("fill",diamond4Base2)
		love.graphics.setColor(28,239,154,logoAlpha)
		love.graphics.polygon("fill",diamond4)

		love.graphics.setColor(0,0,0,logoAlpha)
		love.graphics.polygon("line",outline)
		love.graphics.setFont(hugeFont)
		love.graphics.printf("N E O L U D O",logo3X + 60,logo4Y - 12,love.graphics.getWidth(),"left")
		love.graphics.setFont(font)
		love.graphics.printf("TM",logo3X + 590,logo4Y - 2,love.graphics.getWidth(),"left")
	end
end
