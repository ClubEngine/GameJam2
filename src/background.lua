require("hud")

background = {}
background.bleachers = {}
background.grass = {}
background.track = {}
background.track.pos_first = 180
background.track.height = 70
background.track.offsetX = {}

function background.loadElement(e, filename)
	e.sprite = love.graphics.newImage(filename)
	e.size = {}
	e.size.y = e.sprite:getHeight()
	e.size.x = e.sprite:getWidth()
end

function background.load()
	background.loadElement(background.grass, "assets/grass.png")
	background.loadElement(background.bleachers, "assets/bleachers.png")
	background.loadElement(background.track, "assets/track_empty.png")
	for i = 0,5 do
		background.track.offsetX[i] = math.random(800)
	end
end

function background.drawElementHoriz(e, posX, posY)
	local repeatIndex = math.floor((camera.x + e.size.x) / e.size.x)
	love.graphics.draw(e.sprite, posX + e.size.x * (repeatIndex - 2), posY)
	love.graphics.draw(e.sprite, posX + e.size.x * (repeatIndex - 1), posY)
	love.graphics.draw(e.sprite, posX + e.size.x * repeatIndex, posY)
end

function background.draw()
	background.drawElementHoriz(background.bleachers, 0, 0)
end

function background.drawTrack(i)
	if (i < tonumber(ln)) then
		background.drawElementHoriz(background.track, background.track.offsetX[i], background.track.pos_first + i * background.track.height)
	else
		background.drawElementHoriz(background.grass, background.track.offsetX[i] - 6 * background.grass.size.x, background.track.pos_first + i * background.track.height)
		background.drawElementHoriz(background.grass, background.track.offsetX[i] - 3 * background.grass.size.x, background.track.pos_first + i * background.track.height)
		background.drawElementHoriz(background.grass, background.track.offsetX[i], background.track.pos_first + i * background.track.height)
		background.drawElementHoriz(background.grass, background.track.offsetX[i] + 3 * background.grass.size.x, background.track.pos_first + i * background.track.height)
		background.drawElementHoriz(background.grass, background.track.offsetX[i] + 6 * background.grass.size.x, background.track.pos_first + i * background.track.height)
-- 		background.drawElementHoriz(background.grass, background.track.offsetX[i], background.track.pos_first + i * background.track.height)
-- 		love.graphics.draw(background.grass, background.track.offsetX[i] + 70 * math.floor(camera.x / 70), background.track.pos_first + i * background.track.height)
	end
end
