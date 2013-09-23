



function createAnimation()
	res = {}
	res.pictures = {}
	res.frame = 0
	res.frequency = 5
	res.state = nil
	res.yOffset = 0
	return res
end

function setAnimationState(animation, state)
	animation.state = state
end

function setAnimationFrequency(animation, frequency)
	animation.frequency = frequency
end

function addPictureInAnimation(animation, pic, state)
	if (animation.pictures[state] == nil) then
		animation.pictures[state] = {}
	end
	table.insert(animation.pictures[state], pic)
end

function updateAnimation(animation, dt)
	animation.frame = animation.frame + animation.frequency * dt
end

function getCurrentPicAnimation(animation)
	a = animation
	n = table.getn(a.pictures[animation.state])
	return a.pictures[animation.state][1 + (math.floor(a.frame) % n) ]
end

function drawAnimation(animation, x, y)
	a = animation
	love.graphics.draw(getCurrentPicAnimation(a), x, y + a.yOffset)
end

function getAnimWidth(animation)
	return getCurrentPicAnimation(animation):getWidth()
end

function getAnimHeight(animation)
	return getCurrentPicAnimation(animation):getHeight()
end
