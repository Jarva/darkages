function Cl_CheckQuest(quest)

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 2 - 300,ScrH() / 2 - 300)
Menu:SetSize(600, 600)
Menu:SetTitle(Quests[quest].title)
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

local Panel = vgui.Create("DPanel",Menu)
Panel:SetSize(240,560)
Panel:SetPos(350,30)

local Title = vgui.Create("DLabel",Menu)
Title:SetPos(10,30)
Title:SetText( Quests[quest].title )
Title:SetFont("KnightL")
Title:SizeToContents()


local Task = vgui.Create("DLabel",Menu)
Task:SetPos(10,50)
Task:SetText( Quests[quest].task )
Task:SetWidth(320)
Task:SetTall(500)
Task:SetFont("Adventure")
Task:SetWrap(true)


local XpRewards = vgui.Create( "DPanelList",Panel )
XpRewards:EnableVerticalScrollbar( true )
XpRewards:EnableHorizontal( false )
XpRewards:SetSpacing( 5 )
XpRewards:SetPadding( 5 )
XpRewards:SetPos(10,30)
XpRewards:SetSize(220,115)

local Rewards = vgui.Create( "DPanelList",Panel )
Rewards:EnableVerticalScrollbar( true )
Rewards:EnableHorizontal( false )
Rewards:SetSpacing( 5 )
Rewards:SetPadding( 5 )
Rewards:SetPos(10,175)
Rewards:SetSize(220,115)

local Require = vgui.Create( "DPanelList",Panel )
Require:EnableVerticalScrollbar( true )
Require:EnableHorizontal( false )
Require:SetSpacing( 5 )
Require:SetPadding( 5 )
Require:SetPos(10,320)
Require:SetSize(220,115)

local Text = vgui.Create("DLabel",Panel)
Text:SetPos(10,10)
Text:SetText( "XP Rewards" )
Text:SetFont("ChatFont")
Text:SizeToContents()

local Text = vgui.Create("DLabel",Panel)
Text:SetPos(10,155)
Text:SetText( "Rewards" )
Text:SetFont("ChatFont")
Text:SizeToContents()

local Text = vgui.Create("DLabel",Panel)
Text:SetPos(10,300)
Text:SetText( "Requirements" )
Text:SetFont("ChatFont")
Text:SizeToContents()

for k,v in pairs(Quests[quest].requirements) do

	local RPanel = vgui.Create("DPanel")
	RPanel:SetSize(150,50)

	local model = GetIModel(k)
	local skin = GetISkin(k)
	
	local icon = vgui.Create( "SpawnIcon", RPanel )
	icon:SetModel( model,skin )
	icon:SetSize(40,40)
	icon:SetPos(5,5)
	icon:SetToolTip(v .. " " ..GetIName(k))
	
	local Item = vgui.Create("DLabel",RPanel)
	Item:SetPos(50,10)
	Item:SetText(v .. " " ..GetIName(k))
	Item:SetWidth(100)
	Item:SetTall(30)

	Require:AddItem(RPanel)

end

for k,v in pairs(Quests[quest].rewards) do

	RPanel = vgui.Create("DPanel")
	RPanel:SetSize(150,50)

	local model = GetIModel(k)
	local skin = GetISkin(k)
	
	local icon = vgui.Create( "SpawnIcon", RPanel )
	icon:SetModel( model,skin )
	icon:SetSize(40,40)
	icon:SetPos(5,5)
	icon:SetToolTip(v .. " " ..GetIName(k))
	
	local Item = vgui.Create("DLabel",RPanel)
	Item:SetPos(50,10)
	Item:SetText(v .. " " ..GetIName(k))
	Item:SetWidth(100)
	Item:SetTall(30)

	Rewards:AddItem(RPanel)

end

for k,v in pairs(Quests[quest].xprewards) do

	XRPanel = vgui.Create("DPanel")
	XRPanel:SetSize(ScrW()/8-15,50)

	Skill = vgui.Create("DLabel",XRPanel)
	Skill:SetPos(5,5)
	Skill:SetText( k )
	Skill:SizeToContents()

	XP = vgui.Create("DLabel",XRPanel)
	XP:SetPos(5,25)
	XP:SetText( "XP : " .. v  )
	XP:SizeToContents()

	XpRewards:AddItem(XRPanel)

end

	if (plydata.quests[quest] == nil or plydata.quests[quest] == "") then

		local Accept = vgui.Create("DButton", Menu)
		Accept:SetPos(100,560)
		Accept:SetSize(140,30)
		Accept:SetText("Accept Task")
		Accept.DoClick = function()

		RunConsoleCommand("QuestAccepted",quest)
		Menu:Close()

		end
		
		

	else
		
		Complete = vgui.Create("DButton", Menu)
		Complete:SetPos(100,560)
		Complete:SetSize(140,30)
		Complete:SetText("Complete Task")
		Complete.DoClick = function()

		RunConsoleCommand("QuestEnd",quest)
		Menu:Close()
		
		QRemoveTrack(quest)

		end
		
		for k,v in pairs(Quests[quest].requirements) do

			if (plydata.inventory[k] == nil or plydata.inventory[k] < v) then

				Complete:SetDisabled(true)
				break
			
			end
			
		end
		
	end

end

function DA_QuestThx()

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 4,ScrH() / 4)
Menu:SetSize(ScrW() / 2, ScrH() / 8)
Menu:SetTitle("")
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

Name = vgui.Create("DLabel",Menu)
Name:SetPos(20,ScrH()/16 - 5)
Name:SetText( "Thank you for your help " .. LocalPlayer():Nick()  )
Name:SizeToContents()

end

function Cl_Quests()

	local data = net.ReadTable()

	PrintTable(data)
	print(data.ply)

	plydata.quests = {}

	for k,v in pairs(data.ply) do
		
		if (plydata.quests == nil) then plydata.quests = {} end
		
		plydata.quests[k] = v
	
	end

	local quests = {}
	local plyquests = {}

	quests = string.Explode(",",data.quests)
	plyquests = data.ply

	Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW() / 2 - 200,ScrH() / 2 - 200)
	Menu:SetSize(400, 400)
	Menu:SetTitle("Quests")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(true)
	Menu:SetVisible(true)
	Menu:MakePopup()

	local QuestList = vgui.Create( "DPanelList",Menu )
	QuestList:EnableVerticalScrollbar( true )
	QuestList:EnableHorizontal( false )
	QuestList:SetSpacing( 10 )
	QuestList:SetPadding( 10 )
	QuestList:SetPos(10,30)
	QuestList:SetSize(380,360)

	for k,v in pairs(quests) do

		if (plyquests[v] == nil or plyquests[v] == "TIP") then
	
			Panel = vgui.Create("DPanel")
			Panel:SetSize(260,60)
			
			Title = vgui.Create("DLabel",Panel)
			Title:SetPos(30,5)
			Title:SetText( Quests[v].title )
			Title:SetWidth(230)
			Title:SetTall(20)
			Title:SetFont("ChatFont")
			
			Check = vgui.Create("DButton", Panel)
			Check:SetPos(30,35)
			Check:SetSize(130,20)
			Check:SetText("Check Task")
			Check.DoClick = function()
			
			Menu:Close()
			Cl_CheckQuest(v)
			
			end
			
			for k,v in pairs(Quests[v].quests) do
			
				if (plydata.quests[v] == nil or plydata.quests[v] == "") then
				
				Check:SetDisabled(true)
				
				end
			
			end
			
			QuestList:AddItem(Panel)
			
		end

	end

end
net.Receive("questmenu",Cl_Quests)

