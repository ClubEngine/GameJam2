require("player")
-- itemselected
hud = {}
hud.picSpring = love.graphics.newImage("assets/doinkdoink.png")
hud.picCross = love.graphics.newImage("assets/crosse.png")
hud.picBasket = love.graphics.newImage("assets/baskets.png")
hud.picLvl = love.graphics.newImage("assets/niv.png")
hud.picSelected = love.graphics.newImage("assets/selected.png")
-- Image des Nombres
hud.picFontNombre = {}
for i = 0, 9 do
	hud.picFontNombre[i + 1] = love.graphics.newImage("assets/fonts/num_" .. i .. ".png")
end
hud.SPRINGSCALE = 0.2
hud.CROSSSCALE = 0.25
hud.BASKETSCALE = 0.4
hud.LVLSCALE = 0.8
hud.OFFSETX = 15
hud.SPRINGX = 15
hud.CROSSX = hud.SPRINGX + 100
hud.BASKETX = 15
hud.SPRINGY = 5
hud.CROSSY = 5
hud.BASKETY = 40
hud.LVLX = 75 + hud.BASKETX
hud.LVLY = 37
hud.FONT = love.graphics.newFont(30)

function hud:printNombre(nombre, x, y)
	love.graphics.draw(hud.picFontNombre[nombre + 1], x, y)
end
 
function hud:draw()
	-- save graphics state
	r, g, b, a = love.graphics.getColor()
	previousFont = love.graphics.getFont()
	
	basex = 450
	basey = 80
	local spriteWidth = background.bleachers.sprite:getWidth()
	local repeatIndex = math.floor((camera.x + spriteWidth) / spriteWidth)
	hud:drawAux(basex % spriteWidth + repeatIndex * spriteWidth, basey)
	hud:drawAux(basex % spriteWidth + (repeatIndex - 1) * spriteWidth, basey)
	
	-- set previous graphics state
	love.graphics.setColor(r, g, b, a)
	love.graphics.setFont(previousFont)
end

function hud:drawAux(basex, basey)

	-- set new graphics state
	love.graphics.setColor(255, 255, 0, 255)

	-- w = (hud.BASKETX + hud.picBasket:getWidth() * hud.BASKETSCALE - hud.SPRINGX
	-- love.graphics.rectangle("fill", hud.SPRINGX - hud.OFFSETX, hud.SPRINGY - hud.OFFSETY, 
							-- getScaled(, height )
	
	-- set previous graphics state
	love.graphics.setColor(r, g, b, a)

	if itemselected == "D" then 
		love.graphics.draw(hud.picSelected, basex + hud.SPRINGX - 11, basey + hud.SPRINGY - 10)
	elseif itemselected == "B" then
		love.graphics.draw(hud.picSelected, basex + hud.SPRINGX - 11, basey + hud.SPRINGY + 25)
	elseif itemselected == "C" then
		love.graphics.draw(hud.picSelected, basex + hud.CROSSX - 11, basey + hud.SPRINGY - 10)		
	end
	love.graphics.draw(hud.picSpring, basex + hud.SPRINGX, basey + hud.SPRINGY + 3, 0, hud.SPRINGSCALE, hud.SPRINGSCALE)
	love.graphics.draw(hud.picCross, basex + hud.CROSSX, basey + hud.CROSSY, 0, hud.CROSSSCALE, hud.CROSSSCALE)
	love.graphics.draw(hud.picBasket, basex + hud.BASKETX, basey + hud.BASKETY, 0, hud.BASKETSCALE, hud.BASKETSCALE)
	love.graphics.draw(hud.picLvl, basex + hud.LVLX, basey + hud.LVLY, 0, hud.LVLSCALE, hud.LVLSCALE)
	
	-- set new graphics state
	love.graphics.setColor(255, 255, 0, 255)
	love.graphics.setFont(hud.FONT)

	-- draw texts
	x = basex + hud.SPRINGX + hud.picSpring:getWidth() * hud.SPRINGSCALE + hud.OFFSETX
	y = basey + hud.SPRINGY
	hud:printNombre(player.numSprings, x, y)
	--love.graphics.print("x"..player.numSprings, x, y)
	
	x = basex + hud.CROSSX + hud.picCross:getWidth() * hud.CROSSSCALE + hud.OFFSETX
	y = basey + hud.CROSSY
	hud:printNombre(player.numCrosses, x, y)
	--love.graphics.print("x"..player.numCrosses, x, y)
	
	x = basex + hud.BASKETX + hud.picBasket:getWidth() * hud.BASKETSCALE + hud.OFFSETX + 3
	y = basey + hud.BASKETY 
	hud:printNombre(player.numBaskets, x, y)
	
	x = basex + hud.LVLX + hud.picLvl:getWidth() * hud.LVLSCALE + hud.OFFSETX
	y = basey + hud.BASKETY 
	hud:printNombre(nextLevelIndex - 1, x, y)
	--love.graphics.print("x"..player.numBaskets, x, y)
end