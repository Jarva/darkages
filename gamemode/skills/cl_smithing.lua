function Cl_Smithing()

local Amount = {}

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 2-300,ScrH() / 2-250)
Menu:SetSize(600, 500)
Menu:SetTitle("Smithing")
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
List:SetSize(580,460)

	for k,v in pairs(Smithing) do

		local restext = ""
	
		for x,y in pairs(Smithing[k]) do
		
			restext = restext .. y .. " " .. GetIName(x) .. " "
		
		end
		
		local model = GetIModel(k .. " bar")
		local skin = GetISkin(k .. " bar")
				  
		local APanel = vgui.Create('DPanel')
		APanel:SetTall(50)
		APanel:SetBackgroundColor(Color(60,60,60,255))
		
		local icon = vgui.Create( "SpawnIcon", APanel )
		icon:SetModel( model,skin )
		icon:SetPos(0,0)
		icon:SetToolTip("LvL Needed : " .. SmithingLvL[k])
		icon:SetSize(50,50)
		
		local Name = vgui.Create("DLabel", APanel)
		Name:SetPos(50,5)
		Name:SetText( GetIName(k .. " bar") )
		Name:SetFont("KnightM")
		Name:SizeToContents()
		
		local Res = vgui.Create("DLabel", APanel)
		Res:SetPos(50,30)
		Res:SetText( "Resources : " .. restext )
		Res:SetFont("AdventureS")
		Res:SizeToContents()
	
		Amount[k] = vgui.Create("DNumSlider",APanel)
		Amount[k]:SetPos(360,5)
		Amount[k]:SetWide(210)
		Amount[k]:SetTall(20)
		Amount[k]:SetDecimals(0)
		Amount[k]:SetText("Amount")
		Amount[k]:SetMin(1)
		Amount[k]:SetMax(20)
		Amount[k]:SetValue(1)
		Amount[k].Label:SetMouseInputEnabled( false )
		Amount[k].Label:SetWide(50)
	
		Create = vgui.Create("DButton",APanel)
		Create:SetPos(250,5)
		Create:SetSize(100,20)
		Create:SetText("Smelt")
		Create.DoClick = function()
			
			if (!InAction) then
			
			local x = math.Round(Amount[k]:GetValue())
			RunConsoleCommand("Smith",k,math.Round(Amount[k]:GetValue()))
			
			end
			
		end
	
		List:AddItem(APanel)

	end

end
concommand.Add("Cl_Smithing",Cl_Smithing)

function Cl_Forging(material)

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 4,ScrH() / 4)
Menu:SetSize(ScrW() / 2, ScrH() / 2)
Menu:SetTitle("Forging")
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

	for k,v in pairs(Forging[material]) do

		local restext = ""
	
		for x,y in pairs(Forging[material][k].res) do
		
			restext = restext .. y .. " " .. GetIName(x) .. " "
		
		end
		
		local model = GetIModel(material .. "_" .. k)
		local skin = GetISkin(material .. "_" .. k)
				  
		local APanel = vgui.Create('DPanel')
		APanel:SetTall(50)
		APanel:SetBackgroundColor(Color(80,80,80,255))
		
		local icon = vgui.Create( "SpawnIcon", APanel )
		icon:SetModel( model,skin )
		icon:SetPos(0,0)
		icon:SetToolTip("LvL needed : " .. SmithingLvL[material] + Forging[material][k].lvl)
		icon:SetSize(50,50)
		
		local Name = vgui.Create("DLabel", APanel)
		Name:SetPos(50,5)
		Name:SetText( GetIName(material .. "_" .. k) )
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
		Create:SetText("Create")
		Create.DoClick = function()		
			if (!InAction) then RunConsoleCommand("Forge",material,k) else HudPrint("You are in action") end
		end
	
		List:AddItem(APanel)

	end

end

function Cl_ForgingSelect()

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 2 - 121,ScrH() - 200)
Menu:SetSize(250, 90)
Menu:SetTitle("Choose a material")
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

local List = vgui.Create( "DPanelList", Menu)
List:EnableVerticalScrollbar( true )
List:EnableHorizontal( true )
List:SetSpacing( 5 )
List:SetPadding( 5 )
List:SetPos(10,25)
List:SetSize(225,60)

	for k,v in pairs(Forging) do

		local model = GetIModel(k .. " bar")
		local skin = GetISkin(k .. " bar")
	
		local icon = vgui.Create( "SpawnIcon", APanel )
		icon:SetModel( model, skin )
		icon:SetPos(0,0)
		icon:SetSize(50,50)
		icon:SetToolTip(GetIName(k))
		icon.DoClick = function()
		
			Menu:Close()
			Cl_Forging(k)
		
		end
		
		List:AddItem(icon)

	end

end
concommand.Add("Cl_Forging",Cl_ForgingSelect)



