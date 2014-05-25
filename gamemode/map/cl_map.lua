MAPEDITOR = {}
MAPEDITOR.Clicks = 0
MAPEDITOR.DrawMode = "line"
MAPEDITOR.DrawList = {}

include('panels.lua')
include('draw.lua')

MapIcons = {}

function AddMapIcon(id,icon,name,w,h)



end

MapButtons = {}

function AddMapButton(id,icon,text,options)

	local i = table.Count(MapButtons) + 1

	MapButtons[i] = {}
	MapButtons[i].id = id
	MapButtons[i].icon = icon
	MapButtons[i].text = text
	MapButtons[i].options = {}

	for a = 1,table.Count(options) / 2 do

		MapButtons[i].options[options[a*2 - 1]] = options[a*2]

	end

	MAPEDITOR.DrawList[id] = {}
 
end

include('adder.lua')

function MapEditor()

	local mapframe = vgui.Create("MapEditor")
	mapframe:SetSize(860,520)
	mapframe:SetPos(ScrW() / 2 - 420,ScrH()/2 - 260)
	mapframe:DrawCloseButton()

	local mapdrawarea = vgui.Create("DrawArea",mapframe)
	mapdrawarea:SetPos(20,20)
	mapdrawarea:SetSize(600,480)

	local i = 0

	for k,v in pairs(MapButtons) do

		local mbutton = vgui.Create("MapEditorButton",mapframe)
		mbutton:SetPos(640,20 + i*30)
		mbutton:SetSize(200,24)
		mbutton:SetIcon(v.icon)
		mbutton:SetText(v.text)
		mbutton:SetOption(v.id)

		i = i + 1

	end

end
concommand.Add("MapEditor",MapEditor)
