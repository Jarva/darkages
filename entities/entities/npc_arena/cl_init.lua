function ArenaMenu(data)

local arena = data:ReadString()
local name = Arena[arena].name

local x = data:ReadShort()
local y = "Enter"
if (x == 1) then y = "Leave" end 

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 4,ScrH() / 2 - 55)
Menu:SetSize(ScrW() / 2, 110)
Menu:SetTitle("Arena")
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

Question = vgui.Create("DLabel",Menu)
Question:SetText(name)
Question:SetFont("Default")
Question:SetPos(50,40)
Question:SizeToContents()


Enter = vgui.Create("DButton", Menu)
Enter:SetPos(50,75)
Enter:SetSize(50,25)
Enter:SetText(y)
Enter.DoClick = function()

	RunConsoleCommand(y .. "Arena",arena)		
	Menu:Close()

end

if (x == 2) then Enter:SetDisabled(true) end

Cancel = vgui.Create("DButton", Menu)
Cancel:SetPos(ScrW()/2-100,75)
Cancel:SetSize(50,25)
Cancel:SetText("Cancel")
Cancel.DoClick = function()
		
	Menu:Close()

end

end
usermessage.Hook("arenamenu",ArenaMenu)
