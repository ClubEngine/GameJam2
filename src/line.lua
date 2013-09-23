-- Une line contient les obstacles

-- Renvoie les obstacles entre min et max.
function getObstacles(line,obstaclesPrec,min, max)
	local index1 = 1
	local index2 = 1
	local obstacles = {}
	if obstaclesPrec ~= nil then 
	--local n= table.getn(obstaclesPrec)
	local maxPos = -1
	while obstaclesPrec[index2] ~= nil do
		if obstaclesPrec[index2].position >= (min) then
		obstacles[index1] = obstaclesPrec[index2]
		index1=index1+1
		end
		if obstaclesPrec[index2].position > maxPos
		then maxPos = obstaclesPrec[index2].position end
		index2 = index2+1
	end
	else
	maxPos=min end
		
	for i = maxPos, max do
		if line[i] ~= nil then 
		obstacles[index1] = line[i]
		index1 = index1 + 1
		end
	end
	return obstacles
end

function checkCollisions(obstacles)
	index = 1
	if obstacles == nil then return end
	while obstacles[index] ~= nil do
		if collideWith(obstacles[index]) then
			applyCollision(obstacles[index])
		end	
		index = index + 1
	end	
end 


-- Ajoute l'obstacle à la ligne 
function addObstacle(line,obstacle)
	line[obstacle.position] = obstacle
end