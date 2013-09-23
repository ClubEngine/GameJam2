function select_objet(key)
	local object = ""
	if key == "z" then itemselected = "B" end
	if key == "x" then itemselected = "D" end
	if key == "c" then itemselected = "C" end
end

function usableWith(oType,object)
	return (oType == "s" and object == "C")
	or (oType == "w" and object == "C")
	or (oType == "p" and object == "D")
	or (oType == "w" and object == "D")
	or (oType == "s" and object == "B")
	or (oType == "p" and object == "B")
end