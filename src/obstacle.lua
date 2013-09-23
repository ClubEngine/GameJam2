obstacleAnim = {}

function loadOneAnim(animat,dossier,nm,nb,freq,yOff,xOff)
	local nbs =""
	for i = 1,nb do
		if i<10 then nbs = "0"..i
		else nbs = ""..i end
		addPictureInAnimation(animat, love.graphics.newImage("assets/"..dossier.."/"..nm.."00"..nbs..".png"), "normal")
	end
	setAnimationState(animat, "normal")
	setAnimationFrequency(animat, freq)
	animat.yOffset = yOff
	animat.xOffset = xOff
end

function loadAnims()
	-- Crosse-sand
	obstacleAnim.cross_sand = createAnimation()
	loadOneAnim(obstacleAnim.cross_sand,"cross_sand","cs",8,0.15,-160,35)
	
	-- Crosse-wall
	obstacleAnim.cross_wall = createAnimation()
	loadOneAnim(obstacleAnim.cross_wall,"crosse_wall","cw",5,0.15,-111,15)
	
	-- Doink-punch
	obstacleAnim.doink_punch = createAnimation()
	loadOneAnim(obstacleAnim.doink_punch,"doink_pounching","dp",4,0.15,-208,24)
	
	-- Doink-wall
	obstacleAnim.doink_wall = createAnimation()
	loadOneAnim(obstacleAnim.doink_wall,"doink_wall","dw",4,0.15,-216,0)
	
	-- Running-punch
	obstacleAnim.run_punch = createAnimation()
	loadOneAnim(obstacleAnim.run_punch,"running_punching","rp",5,0.15,-100,15)
	
	-- Running-sand
	obstacleAnim.run_sand = createAnimation()
	loadOneAnim(obstacleAnim.run_sand,"running_sand","rs",8,0.15,-90,0)	
	
end

function getNewObstacle(oType, position)
	local obstacle = {}
	obstacle.oType = oType
	obstacle.position = position
	obstacle.actif = true
	obstacle.objet = false
	if obstacle.oType == "A" then
		obstacle.anim = false
		obstacle.yOffset = 0
		obstacle.image = love.graphics.newImage("assets/finish.png")
	elseif obstacle.oType == "h" then
		obstacle.anim = false
		obstacle.yOffset = 0
		obstacle.image = love.graphics.newImage("assets/hurdle.png")
		obstacle.deathAnim = createAnimation()
	elseif obstacle.oType == "w" then
		obstacle.anim = false
		obstacle.yOffset = -30
		obstacle.image = love.graphics.newImage("assets/wall.png")
	elseif obstacle.oType == "s" then
		obstacle.anim = false
		obstacle.yOffset = 25
		obstacle.image = love.graphics.newImage("assets/sand.png")
	elseif obstacle.oType == "B" then
		obstacle.anim = false
		obstacle.objet = true
		obstacle.yOffset = 30
		obstacle.image = love.graphics.newImage("assets/baskets.png")
	elseif obstacle.oType == "C" then
		obstacle.anim = false
		obstacle.objet = true
		obstacle.yOffset = 0
		obstacle.image = love.graphics.newImage("assets/crosse.png")
	elseif obstacle.oType == "D" then
		obstacle.anim = false
		obstacle.objet = true
		obstacle.yOffset = 20
		obstacle.image = love.graphics.newImage("assets/doinkdoink.png")
	elseif obstacle.oType == "p" then
		obstacle.yOffset = 10
		obstacle.anim = false
		obstacle.image = love.graphics.newImage("assets/running_punching/punching_ball.png")
	end
	return obstacle
end

function collideWith(obstacle)
	if obstacle.oType == "A" then
		return obstacle.position * 70 - 50 < player.x
		and obstacle.position * 70 + 100 > player.x
	elseif obstacle.oType == "h" then
		return obstacle.position * 70 - 25 < player.x
		and obstacle.position * 70 + 25 > player.x
		and not player.jumping
	elseif obstacle.oType == "w" then
		return obstacle.position * 70 - 30  < player.x
		and obstacle.position * 70 + 30 > player.x
	elseif obstacle.oType == "s" then
		return obstacle.position * 70 - 175  < player.x
		and obstacle.position * 70 + 150 > player.x
	elseif obstacle.oType == "p" then
		return obstacle.position * 70 - 15  < player.x
		and obstacle.position * 70 + 15 > player.x
	elseif obstacle.oType == "C" then
		return obstacle.position * 70 - 25  < player.x
		and obstacle.position * 70 + 25 > player.x
		and not player.jumping
	elseif obstacle.oType == "B" then
		return obstacle.position * 70 - 20  < player.x
		and obstacle.position * 70 + 20 > player.x
		and not player.jumping
	elseif obstacle.oType == "D" then
		return obstacle.position * 70 - 30 < player.x
		and obstacle.position * 70 + 20 > player.x
		and not player.jumping
	else return false
	end
end

function applyCollision(obstacle)
	if obstacle.actif then
		if (obstacle.oType == "p" or obstacle.oType == "w" or obstacle.oType == "s") then
			if usableWith(obstacle.oType,itemselected) then
				if itemselected == "C" then
					if player.numCrosses ~= 0 then
						player.numCrosses = player.numCrosses - 1
						obstacle.actif = false
						local sound
						if obstacle.oType == "s" then
							player.useObjectAnim = obstacleAnim.cross_sand
							player:setSpeed("normal")
							player.useObjectPos.x = obstacle.position * 70 + player.useObjectAnim.xOffset - getAnimWidth(player.useObjectAnim) / 2
							player.useObjectPos.y = 180 + player.line * 70
							sound = love.audio.newSource("assets/sounds/highjump.wav")
						else
							player.useObjectAnim = obstacleAnim.cross_wall
							player:setSpeed("normal")
							player.useObjectPos.x = obstacle.position * 70 + player.useObjectAnim.xOffset - getAnimWidth(player.useObjectAnim) / 2
							player.useObjectPos.y = 180 + player.line * 70
							sound = love.audio.newSource("assets/sounds/break.wav")
						end
						love.audio.play(sound)
					end
				elseif itemselected == "D" then
					if player.numSprings ~= 0 then
						local sound = love.audio.newSource("assets/sounds/boing.wav")
						love.audio.play(sound)
						player.numSprings = player.numSprings - 1
						obstacle.actif = false
						if obstacle.oType == "p" then
							player.useObjectAnim = obstacleAnim.doink_punch
							player:setSpeed("normal")
							player.useObjectPos.x = obstacle.position * 70 + player.useObjectAnim.xOffset - getAnimWidth(player.useObjectAnim) / 2
							player.useObjectPos.y = 180 + player.line * 70
						else
							player.useObjectAnim = obstacleAnim.doink_wall
							player:setSpeed("normal")
							player.useObjectPos.x = obstacle.position * 70 + player.useObjectAnim.xOffset - getAnimWidth(player.useObjectAnim) / 2
							player.useObjectPos.y = 180 + player.line * 70
						end
					end
				elseif itemselected == "B" then
					if player.numBaskets ~= 0 then
						player.numBaskets = player.numBaskets - 1
						obstacle.actif = false
						if obstacle.oType == "p" then
							player.useObjectAnim = obstacleAnim.run_punch
							player:setSpeed("normal")
							player.useObjectPos.x = obstacle.position * 70 + player.useObjectAnim.xOffset - getAnimWidth(player.useObjectAnim) / 2
							player.useObjectPos.y = 180 + player.line * 70
						else
							player.useObjectAnim = obstacleAnim.run_sand
							player:setSpeed("normal")
							player.useObjectPos.x = obstacle.position * 70 + player.useObjectAnim.xOffset - getAnimWidth(player.useObjectAnim) / 2
							player.useObjectPos.y = 180 + player.line * 70
						end
					end
				end
				setAnimationState(player.animation, "normal")
			end
			if obstacle.actif then
			player:kill(getDeathCollision(obstacle), getDeathSound(obstacle))
			end
		elseif obstacle.oType == "h" then
			if obstacle.actif then
			player:kill(getDeathCollision(obstacle), getDeathSound(obstacle))
			end
		elseif 	obstacle.oType == "B" then
			local sound = love.audio.newSource("assets/sounds/get.wav", "static")
			love.audio.play(sound)
			if player.numBaskets ~= 9 then

				player.numBaskets = player.numBaskets + 1
			end
		elseif obstacle.oType == "C" then
			local sound = love.audio.newSource("assets/sounds/get.wav", "static")
			love.audio.play(sound)
			if player.numCrosses ~= 9 then

				player.numCrosses = player.numCrosses + 1
			end
		elseif obstacle.oType == "D" then
			local sound = love.audio.newSource("assets/sounds/get.wav", "static")
			love.audio.play(sound)
			if player.numSprings ~= 9 then

				player.numSprings = player.numSprings + 1
			end
		elseif  obstacle.oType == "A" then
			if player.jumping then
				player:win()
			else
				player:kill(getDeathCollision(obstacle), getDeathSound(obstacle))
			end
		end
		obstacle.actif = false
	end
end

function getDeathCollision(obstacle)
	res = createAnimation()
	if obstacle.oType == "w" then
		addPictureInAnimation(res, love.graphics.newImage("assets/death_wall/dw.png"), "normal")
	elseif obstacle.oType == "h" then
		for i = 1, 9 do
			addPictureInAnimation(res, love.graphics.newImage("assets/death_hurdle/dh000"..i..".png"), "normal")
		end
		for i = 10, 11 do
			addPictureInAnimation(res, love.graphics.newImage("assets/death_hurdle/dh00"..i..".png"), "normal")
		end
	elseif obstacle.oType == "s" then
		for i = 1, 9 do
			addPictureInAnimation(res, love.graphics.newImage("assets/death_sand/ds000"..i..".png"), "normal")
		end
		for i = 10, 10 do
			addPictureInAnimation(res, love.graphics.newImage("assets/death_sand/ds00"..i..".png"), "normal")
		end
	elseif obstacle.oType == "p" then
		for i = 1, 9 do
			addPictureInAnimation(res, love.graphics.newImage("assets/death_punching/dp000"..i..".png"), "normal")
		end
		for i = 10, 12 do
			addPictureInAnimation(res, love.graphics.newImage("assets/death_punching/dp00"..i..".png"), "normal")
		end
	elseif obstacle.oType == "A" then
		for i = 1, 9 do
			addPictureInAnimation(res, love.graphics.newImage("assets/death_unheaded/unheaded000"..i..".png"), "normal")
		end
		for i = 10,10 do
			addPictureInAnimation(res, love.graphics.newImage("assets/death_unheaded/unheaded00"..i..".png"), "normal")
		end
	end
	setAnimationState(res, "normal")
	return res
end

function getDeathSound(obstacle)
	if obstacle.oType == "s" then
		return love.audio.newSource("assets/sounds/splouf.wav", "static")
	else
		return love.audio.newSource("assets/sounds/hurt.wav", "static")
	end
end
