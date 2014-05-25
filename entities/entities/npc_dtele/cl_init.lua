function npcdtele(data)

local id = data:ReadString()
local dir = data:ReadShort()
local text = ""

if (dir == 2) then text = "Enter" else text = "Leave" end

Main = vgui.Create("DFrame")
Main:SetPos(ScrW() / 4,ScrH() / 4)
Main:SetSize(ScrW() / 2, ScrH() / 5)
Main:SetTitle("Dungeon")
Main:SetDraggable(true)
Main:ShowCloseButton(true)
Main:SetVisible(true)
Main:MakePopup()

Question = vgui.Create("DLabel",Main)
Question:SetText(Dungeons[id].name .. " [ " .. Dungeons[id].lvl .. " ]")
Question:SetFont("Default")
Question:SetPos(50,40)
Question:SizeToContents()
Question:SetWidth(ScrW() / 2)

Enter = vgui.Create("DButton", Main)
Enter:SetPos(50,75)
Enter:SetSize(50,25)
Enter:SetText(text)
Enter.DoClick = function()

	RunConsoleCommand("DA_DTele")		
	Main:Close()

end

Cancel = vgui.Create("DButton", Main)
Cancel:SetPos(ScrW()/2-100,75)
Cancel:SetSize(50,25)
Cancel:SetText("Cancel")
Cancel.DoClick = function()
		
	Main:Close()

end



end

usermessage.Hook("npcdtele",npcdtele)