
credits = {}
credits.font = love.graphics.newFont(20)
credits.fontTitle = love.graphics.newFont(60)
credits.OFF = 40

function credits:draw()
	-- save graphics state
	r, g, b, a = love.graphics.getColor()
	previousFont = love.graphics.getFont()
	
	love.graphics.setColor(255, 255, 0, 255)
	love.graphics.setFont(credits.fontTitle)
	x = 250
	y = 20
	love.graphics.print("WTF Game", x, y)
	x = 85
	y = 85
	love.graphics.print("Club Engine Ensimag", x, y)
	
	love.graphics.setFont(credits.font)
	x = 30
	y = 150
	y = y + credits.OFF
	love.graphics.print("<3 Lucas Cimon <3", x, y)
	y = y + credits.OFF
	love.graphics.print("Héloïse Guillemaud", x, y)
	y = y + credits.OFF
	love.graphics.print("Julien Fleury", x, y)
	y = y + credits.OFF
	love.graphics.print("Benoit Person", x, y)
	y = y + credits.OFF
	love.graphics.print("Gilles Laurent", x, y)
	y = y + credits.OFF
	love.graphics.print("Louis Dureuil", x, y)
	y = y + credits.OFF
	love.graphics.print("Benoît Genevaux", x, y)
	y = y + credits.OFF
	love.graphics.print("Cyril Kamowski", x, y)
	y = y + credits.OFF
	love.graphics.print("Guillaume Bérard", x, y)
	y = y + credits.OFF
	love.graphics.print("Benoît Morel", x, y)
	
	-- set previous graphics state
	love.graphics.setColor(r, g, b, a)
	love.graphics.setFont(previousFont)
end

