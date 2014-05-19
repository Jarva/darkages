MEDraw = {}

function MEDraw.line(x,y,click,options)

	local i = table.Count(MAPEDITOR.DrawList["line"])

	if (click == 1) then

		MAPEDITOR.DrawList["line"][i+1] = {}
		MAPEDITOR.DrawList["line"][i+1].data = {}
		MAPEDITOR.DrawList["line"][i+1].data.point1 = x .. "," .. y

		MAPEDITOR.DrawList["line"][i+1].options = {} 
		--MAPEDITOR.DrawList["line"][i+1].options = options

	end

	if (click == 2) then

		MAPEDITOR.DrawList["line"][i].data.point2 = x .. "," .. y
		MAPEDITOR.Clicks = 0
		MAPEDITOR.LastDraw = "line"

	end


	MAPEDITOR.LastStarted = "line"

end

function MEDraw.rect(x,y,click,options)

	local i = table.Count(MAPEDITOR.DrawList["rect"])

	if (click == 1) then

		MAPEDITOR.DrawList["rect"][i+1] = {}
		MAPEDITOR.DrawList["rect"][i+1].data = {}
		MAPEDITOR.DrawList["rect"][i+1].data.start = x .. "," .. y

		MAPEDITOR.DrawList["rect"][i+1].options = {} 
		--MAPEDITOR.DrawList["rect"][i+1].options = options

	end

	if (click == 2) then

		tx, ty = StringTo2D(MAPEDITOR.DrawList["rect"][i].data.start)

			if (x < tx and y < ty) then 
				MAPEDITOR.DrawList["rect"][i].data.start = x .. "," .. y
				MAPEDITOR.DrawList["rect"][i].data.wh = tx - x .. "," .. ty - y
			end
			if (x > tx and y < ty) then 
				MAPEDITOR.DrawList["rect"][i].data.start = tx .. "," .. y
				MAPEDITOR.DrawList["rect"][i].data.wh = x - tx .. "," .. ty - y
			end
			if (x < tx and y > ty) then 
				MAPEDITOR.DrawList["rect"][i].data.start = x .. "," .. ty
				MAPEDITOR.DrawList["rect"][i].data.wh = tx - x .. "," .. y - ty
			end
			if (x > tx and y > ty) then 
				MAPEDITOR.DrawList["rect"][i].data.start = tx .. "," .. ty
				MAPEDITOR.DrawList["rect"][i].data.wh = x - tx .. "," .. y - ty
			end

		MAPEDITOR.Clicks = 0
		MAPEDITOR.LastDraw = "rect"

	end

	MAPEDITOR.LastStarted = "rect"

end

function MEDraw.circle(x,y,click,options)

	local i = table.Count(MAPEDITOR.DrawList["circle"])



	MAPEDITOR.LastStarted = "circle"

end

function MEDraw.text(x,y,click,options)

	local i = table.Count(MAPEDITOR.DrawList["text"])



	MAPEDITOR.LastStarted = "text"

end

function MEDraw.icon(x,y,click,options)

	local i = table.Count(MAPEDITOR.DrawList["icon"])



	MAPEDITOR.LastStarted = "icon"

end

MDraw = {}

function MDraw.line(data,options)

	if (data == nil or data.point1 == nil or data.point2 == nil) then return end

	local x1,y1 = StringTo2D(data.point1)
	local x2,y2 = StringTo2D(data.point2)

	surface.SetDrawColor(0,0,0,255)
	surface.DrawLine(x1,y1,x2,y2)

end

function MDraw.rect(data,options)

	if (data == nil or data.start == nil or data.wh == nil) then return end

	local x,y = StringTo2D(data.start)
	local w,h = StringTo2D(data.wh)

	surface.SetDrawColor(0,0,0,255)
	surface.DrawRect(x,y,w,h)

end

function MDraw.circle(data,options)



end

function MDraw.text(data,options)



end

function MDraw.icon(data,options)



end

function StringTo2D(string)

	local array = string.Explode(",",string)

	local x = tonumber(array[1])
	local y = tonumber(array[2])

	return x,y

end