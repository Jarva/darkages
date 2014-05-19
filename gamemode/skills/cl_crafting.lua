function Cl_Crafting()

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 4,ScrH() / 4)
Menu:SetSize(ScrW() / 2, ScrH() / 2)
Menu:SetTitle("Crafting")
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

	for k,v in pairs(Crafting) do

		local restext = ""
	
		for x,y in pairs(Crafting[k].res) do
		
			restext = restext .. y .. " " .. GetIName(x) .. " "
		
		end
		
		if (DropModels[k] == nil) then
		model = "models/medieval/sack.mdl"
		else
			model = DropModels[k]
		end
				  
		local APanel = vgui.Create('DPanel')
		APanel:SetTall(50)
		APanel:SetBackgroundColor(Color(60,60,60,255))
		
		local icon = vgui.Create( "SpawnIcon", APanel )
		icon:SetModel( model )
		icon:SetPos(0,0)
		icon:SetToolTip("LvL Needed : " .. Crafting[k].lvl)
		icon:SetSize(50,50)
		
		local Name = vgui.Create("DLabel", APanel)
		Name:SetPos(50,5)
		Name:SetText( GetIName(k) )
		Name:SetFont("Knight")
		Name:SizeToContents()
		
		local Res = vgui.Create("DLabel", APanel)
		Res:SetPos(50,30)
		Res:SetText( "Resources : " .. restext )
		Res:SetFont("AdventureS")
		Res:SizeToContents()
	
		Create = vgui.Create("DButton",APanel)
		Create:SetPos(ScrW() / 4 - 10,5)
		Create:SetSize(100,20)
		Create:SetText("Craft")
		Create.DoClick = function()
			if (!InAction) then RunConsoleCommand("DA_Crafting",k) else HudPrint("You are in action") end
		end
	
		List:AddItem(APanel)

	end

end

concommand.Add("Cl_Crafting",Cl_Crafting)