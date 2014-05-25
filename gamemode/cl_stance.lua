function Cl_Stance(data)

local Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 2 - 256,ScrH() / 2 - 112)
Menu:SetSize(512,224)
Menu:SetTitle("Stances")
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

local Attack = vgui.Create("DImageButton", Menu)
Attack:SetMaterial( "gui/attack.vtf" )
Attack:SetSize(128,128)
Attack:SetPos(32,64)
Attack.DoClick = function()
	RunConsoleCommand("SetStance","attack")
	Menu:Close()
end

local Defense = vgui.Create("DImageButton", Menu)
Defense:SetMaterial( "gui/defense.vtf" )
Defense:SetSize(128,128)
Defense:SetPos(192,64)
Defense.DoClick = function()
	RunConsoleCommand("SetStance","defense")
	Menu:Close()
end

local Aggressive = vgui.Create("DImageButton", Menu)
Aggressive:SetMaterial( "gui/strength.vtf" )
Aggressive:SetSize(128,128)
Aggressive:SetPos(352,64)
Aggressive.DoClick = function()
	RunConsoleCommand("SetStance","strength")
	Menu:Close()
end

local ALabel = vgui.Create("DLabel",Menu)
ALabel:SetText("Attack")
ALabel:SetPos(64,32)
ALabel:SetSize(128,32)

local ALabel = vgui.Create("DLabel",Menu)
ALabel:SetText("Defense")
ALabel:SetPos(222,32)
ALabel:SetSize(128,32)

local ALabel = vgui.Create("DLabel",Menu)
ALabel:SetText("Aggressive")
ALabel:SetPos(386,32)
ALabel:SetSize(128,32)

end
usermessage.Hook("stancemenu",Cl_Stance)