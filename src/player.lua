require("animation")


PLAYER_MIN_SPEED = 0
PLAYER_NORMAL_SPEED = 250
PLAYER_MAX_SPEED = 400

player = {}
player.x = 0
player.y = 90
player.line = 0
player.speed = PLAYER_NORMAL_SPEED
player.animation = nil
player.won = false
player.jumping = false
player.jumpTime = 0
player.jumpSound = love.audio.newSource("assets/sounds/jump.wav", "static")
player.deathSound = love.audio.newSource("assets/sounds/hurt.wav", "static")
player.victorySound = love.audio.newSource("assets/sounds/victory.wav")
player.numCrosses = 0
player.numSprings = 0
player.numBaskets = 0
player.dead = false
player.musicOver = love.audio.newSource("assets/sounds/loose.wav")
player.useObjectAnim = nil
player.useObjectPos = {}


function player:load()
	player.animation = createAnimation()
	addPictureInAnimation(player.animation, love.graphics.newImage("assets/seriousjoe/seriousjoe1.png"), "normal")
	addPictureInAnimation(player.animation, love.graphics.newImage("assets/seriousjoe/seriousjoe2.png"), "normal")
	addPictureInAnimation(player.animation, love.graphics.newImage("assets/seriousjoe/seriousjoe3.png"), "normal")
	addPictureInAnimation(player.animation, love.graphics.newImage("assets/seriousjoe/seriousjoe2.png"), "normal")
	addPictureInAnimation(player.animation, love.graphics.newImage("assets/seriousjoe/seriousjoe1.png"), "jump")
	addPictureInAnimation(player.animation, love.graphics.newImage("assets/seriousjoe/seriousjoe2.png"), "still")

	setAnimationState(player.animation, "normal")
end

function player:update(dt)
   updateAnimation(player.animation, dt)
   if not player.dead then
	   -- jump management
	   if (love.timer.getMicroTime() - player.jumpTime) > 0.4 and player.jumping then
		  player:stopJumping()
	   end

	   player.y = 90 + player.line * 70

	   if player.jumping then
		   player.y = player.y - 40
		   setAnimationState(player.animation, "jump")
	   end

		player.x = player.speed * dt + player.x

	   if (player.x - camera.x) <= 0 then
		  player.x = camera.x
		  player.getSpeed("normal")
	   elseif (player.x - camera.x) >= (800 - getAnimWidth(player.animation)) then
		  player.x = camera.x + 800 - getAnimWidth(player.animation)
		  player.getSpeed("normal")
	   end
	end
end

function player:draw()
	if (player.useObjectAnim) then
		drawAnimation(player.useObjectAnim, player.useObjectPos.x, player.useObjectPos.y)
		updateAnimation(player.useObjectAnim, 1)
		if (player.useObjectAnim.frame > table.getn(player.useObjectAnim.pictures.normal)) then
			player.useObjectAnim.frame = 0
			player.useObjectAnim = nil
		end
	else
		drawAnimation(player.animation, player.x, player.y)
	end
end

function player:setSpeed(sType)
	if (player.useObjectAnim) then -- No qpeed change during object use
		return
	end

   if sType == "normal" then
      player.speed = PLAYER_NORMAL_SPEED
      setAnimationState(player.animation, "normal")
   elseif sType == "max" then
      player.speed = PLAYER_MAX_SPEED
      setAnimationState(player.animation, "normal")
   elseif sType == "min" then
      player.speed = PLAYER_MIN_SPEED
      setAnimationState(player.animation, "still")
   end

   player.animation.frequency = player.speed / 50

end

function player:getSpeed()

   if player.speed == PLAYER_NORMAL_SPEED then
      return "normal"
   elseif player.speed == PLAYER_MAX_SPEED then
      return "max"
   elseif player.speed == PLAYER_MIN_SPEED then
      return "min"
   end

end

function player:setLine(lType)

   if lType == "up" then
      player.line = player.line - 1
   elseif lType == "down" then
      player.line = player.line + 1
   end

end

function player:getLine()
   return player.line;
end

function player:startJumping()
	player.jumping = true;
	player.jumpTime = love.timer.getMicroTime()
	love.audio.stop(player.jumpSound)
	love.audio.play(player.jumpSound)
end

function player:stopJumping()
   player.jumping = false
   setAnimationState(player.animation, "normal")
end

function player:kill(animation, sound)
	player.dead = true
	player.animation = animation
	love.audio.play(sound)
	love.audio.play(player.musicOver)
end

function player:win()
	love.audio.play(player.victorySound)
	player.won = true
end

