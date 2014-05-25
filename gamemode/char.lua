local models = {}
local icons = {}

function AddModel(model)

models[table.Count(models) + 1] = model

end

AddModel("models/player/group01/male_01.mdl")
AddModel("models/player/group01/male_02.mdl")
AddModel("models/player/group01/male_03.mdl")
AddModel("models/player/group01/male_04.mdl")
AddModel("models/player/group01/male_05.mdl")
AddModel("models/player/group01/male_06.mdl")
AddModel("models/player/group01/male_07.mdl")
AddModel("models/player/group01/male_08.mdl")
AddModel("models/player/group01/male_09.mdl")
AddModel("models/player/group01/female_01.mdl")
AddModel("models/player/group01/female_02.mdl")
AddModel("models/player/group01/female_03.mdl")
AddModel("models/player/group01/female_04.mdl")
AddModel("models/player/group01/female_06.mdl")
AddModel("models/player/group01/female_07.mdl")

AddModel("models/player/group03/male_01.mdl")
AddModel("models/player/group03/male_02.mdl")
AddModel("models/player/group03/male_03.mdl")
AddModel("models/player/group03/male_04.mdl")
AddModel("models/player/group03/male_05.mdl")
AddModel("models/player/group03/male_06.mdl")
AddModel("models/player/group03/male_07.mdl")
AddModel("models/player/group03/male_08.mdl")
AddModel("models/player/group03/male_09.mdl")
AddModel("models/player/group03/female_01.mdl")
AddModel("models/player/group03/female_02.mdl")
AddModel("models/player/group03/female_03.mdl")
AddModel("models/player/group03/female_04.mdl")
AddModel("models/player/group03/female_06.mdl")
AddModel("models/player/group03/female_07.mdl")

function character(data)

cmodel = models[1]

local Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 2-300,ScrH() / 2-200)
Menu:SetSize(600,400)
Menu:SetTitle("Menu Selection")
Menu:SetDraggable(false)
Menu:ShowCloseButton(false)
Menu:SetVisible(true)
Menu:MakePopup()

local Models = vgui.Create( "DPanelList" , Menu)
Models:EnableVerticalScrollbar( true ) 
Models:EnableHorizontal( true ) 
Models:SetSpacing( 5 ) 
Models:SetPadding( 10 )
Models:SetPos(10,30)
Models:SetSize(380,300)

local model = vgui.Create( "DModelPanel", Menu )
model:SetModel( models[1] ) 
model:SetPos( 400, 75)
model:SetSize( 180, 180 )
model:SetLookAt(Vector(0,0,35));
model:SetCamPos(Vector(60, 60,35));

local Create = vgui.Create("DButton" , Menu)
Create:SetPos(200,350)
Create:SetSize(200,30)
Create:SetText("Create Character")
Create.DoClick = function()

	RunConsoleCommand("char_set",cmodel)
	Menu:Remove()

end

for k,v in pairs(models) do

	icons[v] = vgui.Create( "SpawnIcon" )
	icons[v]:SetModel( v )
	icons[v]:SetSize(65,65)
	icons[v]:SetPos(0,0)
	icons[v].DoClick = function()
	
		cmodel = v
		model:SetModel( v ) 
	
	end
	
	Models:AddItem(icons[v])

end

end

usermessage.Hook("character",character)
