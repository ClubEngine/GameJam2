require("level")
require("line")




function obstacles_entre_min_et_max_ligne_i(level,obstaclesPrec,min,max,i)
	if level==nil then print("Je suis nul.") end

	if level[i] ~= nil then
		return getObstacles(level[i],obstaclesPrec,min,max)
	else
		return nil
	end
end

function affiche_obstacles_ligne(obstacles,lineNumber)
	local i=1
	while obstacles[i] ~= nil do
		affiche_obstacle(obstacles[i],lineNumber)
		i=i+1
	end
end

function update_obstacles(obstacles,dt)
	local i=1

	while obstacles[i] ~= nil do
		local j=1
		while obstacles[i][j] ~= nil do
			if obstacles[i][j].anim==true then
				updateAnimation(obstacles[i][j].animation,dt)
			end
			j=j+1
		end
		i=i+1
	end
end

function affiche_obstacle(obstacle,lineNumber)
	if obstacle.actif or (not obstacle.actif and not obstacle.objet) then
	if obstacle.anim then
		drawAnimation(obstacle.animation, obstacle.position * 70 + 35 - getAnimWidth(obstacle.animation) / 2, obstacle.yOffset + (lineNumber + 1) * 70)
	elseif obstacle.image ~= nil then
		love.graphics.draw(obstacle.image, obstacle.position * 70 + 35 - obstacle.image:getWidth() / 2, obstacle.yOffset + (lineNumber + 1) * 70)
	end
	end
end
