function Cl_Runecrafting()

local amount = {}

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 2-300,ScrH() / 2-200)
Menu:SetSize(600, 400)
Menu:SetTitle("Runecrafting")
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

local List = vgui.Create( "DPanelList", Menu)
List:EnableVerticalScrollbar( true )
List:EnableHorizontal( false )
List:SetSpacing( 5 )
List:SetPadding( 5 )
List:SetPos(10,30)
List:SetSize(580,340)

	for k,v in pairs(Runes) do
	
		model = GetIModel(k)
		skin = GetISkin(k)
				  
		local APanel = vgui.Create('DPanel')
		APanel:SetTall(50)
		APanel:SetBackgroundColor(Color(60,60,60,255))
		
		local icon = vgui.Create( "SpawnIcon", APanel )
		icon:SetModel( model,skin )
		icon:SetPos(5,5)
		icon:SetSize(40,40)
		icon:SetToolTip("LvL Needed : " .. Runes[k].level)
		
		local Name = vgui.Create("DLabel", APanel)
		Name:SetPos(50,5)
		Name:SetText( GetIName(k) )
		Name:SetFont("KnightM")
		Name:SetSize(150,20)
		
		local Orb = vgui.Create("DLabel", APanel)
		Orb:SetPos(50,25)
		Orb:SetText( "Orb : " .. GetIName(Runes[k].orb) )
		Orb:SetFont("AdventureS")
		Orb:SetSize(150,20)
		
		amount[k] = vgui.Create("DNumSlider",APanel)
		amount[k]:SetPos(200,10)
		amount[k]:SetWide(200)
		amount[k]:SetDecimals(0)
		amount[k]:SetText("Amount")
		amount[k]:SetMin(1)
		amount[k]:SetMax(50)
		amount[k]:SetValue(1)
		amount[k].Label:SetMouseInputEnabled( false )
		amount[k].Label:SetWide(50)
	
		local Create = vgui.Create("DButton",APanel)
		Create:SetPos(420,15)
		Create:SetSize(120,20)
		Create:SetText("Create")
		Create.DoClick = function()
		
			if (!InAction) then RunConsoleCommand("DA_Runecrafting",k,amount[k]:GetValue()) else HudPrint("You are in action") end
			
		end
		
		if (plydata.skills.runecrafting < Runes[k].level) then
		
			Create:SetDisabled(true)
		
		end
	
		List:AddItem(APanel)

	end

end

usermessage.Hook("Cl_Runecrafting",Cl_Runecrafting)