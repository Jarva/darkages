function npcgtele(data)

local question = data:ReadString()
local cost = data:ReadShort()

local Main = vgui.Create("DFrame")
Main:SetPos(ScrW() / 2-200,ScrH() / 2-60)
Main:SetSize(400,120)
Main:SetTitle("Main Menu")
Main:SetDraggable(true)
Main:ShowCloseButton(true)
Main:SetVisible(true)
Main:MakePopup()

local Question = vgui.Create("DLabel",Main)
Question:SetText(question)
Question:SetPos(20,30)
Question:SizeToContents()
Question:SetWidth(400)
Question:SetFont("ChatFont")

local Cost = vgui.Create("DLabel",Main)
Cost:SetText("Cost : " .. cost)
Cost:SetPos(20,50)
Cost:SetFont("TargetIDSmall")
Cost:SizeToContents()

local Yes = vgui.Create("DButton", Main)
Yes:SetPos(50,90)
Yes:SetSize(100,20)
Yes:SetText("Yes")
Yes.DoClick = function()

	RunConsoleCommand("DA_GTele")		
	Main:Close()

end

local No = vgui.Create("DButton", Main)
No:SetPos(250,90)
No:SetSize(100,20)
No:SetText("No")
No.DoClick = function()
		
	Main:Close()

end



end

usermessage.Hook("npcgtele",npcgtele)