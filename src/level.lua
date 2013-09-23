require("obstacle")
require("line")

level={}

function level:addLine(line)
	level:insert(line)
end

function importLevel(filename)
	level = {}
	if not(love.filesystem.isFile(filename)) then
		exit(3)
	end
	contents = love.filesystem.read(filename)
	ln = contents:sub(1, 1)
	local d = 0
	local cl = 0
	for i = 2, #contents do
		local c = contents:sub(i, i)
		if c == "\n" then
			d = i
			break
		end
	end
	local sums = {}
	for i = d+1, #contents do
		local c = contents:sub(i, i)
		local isBlankLine = false
		if c == "\n" then
			if not isBlankLine then
				cl = (cl + 1) % ln
				isBlankLine = true
			end
		else
			isBlankLine = false
			if sums[cl+1]==nil then sums[cl+1]=0 end
			sums[cl+1] = sums[cl+1] + 1
			if c ~= " " and c ~= "-" then
				obstacle=getNewObstacle(c, sums[cl+1])
				if level[cl+1]==nil then level[cl+1]={} end
				addObstacle(level[cl+1],obstacle)
			end
		end
	end
	return level
end
