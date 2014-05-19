function Cl_Cooking(data)

local Amount = {}

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 4,ScrH() / 4)
Menu:SetSize(ScrW() / 2, ScrH() / 2)
Menu:SetTitle("Cooking")
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

local List = vgui.Create( "DPanelList", Menu)
List:EnableVerticalScrollbar( true )
List:EnableHorizontal( false )
List:SetSpacing( 5 )
List:SetPadding( 5 )
List:SetPos(5,30)
List:SetSize(ScrW() / 2 - 10,ScrH() / 2-35)

	for k,v in pairs(Cook) do

		local restext = ""
	
		for x,y in pairs(Cook[k].res) do
		
			restext = restext .. y .. " " .. GetIName(x) .. " "
		
		end
		
		local model = GetIModel(k)
		local skin = GetISkin(k)
				  
		local APanel = vgui.Create('DPanel')
		APanel:SetTall(50)
		APanel:SetBackgroundColor(Color(60,60,60,255))
		
		local icon = vgui.Create( "SpawnIcon", APanel )
		icon:SetModel( model,skin )
		icon:SetPos(5,5)
		icon:SetSize(40,40)
		icon:SetToolTip("LvL Needed : " .. Cook[k].lvl)
		
		local Name = vgui.Create("DLabel", APanel)
		Name:SetPos(50,5)
		Name:SetText( GetIName(k) )
		Name:SetFont("KnightM")
		Name:SizeToContents()
		
		local Res = vgui.Create("DLabel", APanel)
		Res:SetPos(50,30)
		Res:SetText( "Resources : " .. restext )
		Res:SetFont("AdventureS")
		Res:SizeToContents()
	
		Create = vgui.Create("DButton",APanel)
		Create:SetPos(ScrW() / 4 - 10,10)
		Create:SetSize(100,20)
		Create:SetText("Cook")
		Create.DoClick = function()
		
			if (!InAction) then RunConsoleCommand("Cook",k) else HudPrint("You are in action") end
			
		end
	
		List:AddItem(APanel)

	end

end
usermessage.Hook("cl_cooking",Cl_Cooking)