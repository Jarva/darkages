function npcstele(data)

Main = vgui.Create("DFrame")
Main:SetPos(ScrW() / 4,ScrH() / 4)
Main:SetSize(ScrW() / 2, ScrH() / 5)
Main:SetTitle("Main Menu")
Main:SetDraggable(true)
Main:ShowCloseButton(true)
Main:SetVisible(true)
Main:MakePopup()

Question = vgui.Create("DLabel",Main)
Question:SetText(data:ReadString())
Question:SetPos(20,40)
Question:SizeToContents()
Question:SetWidth(ScrW() / 2)

Yes = vgui.Create("DButton", Main)
Yes:SetPos(50,75)
Yes:SetSize(50,25)
Yes:SetText("Yes")
Yes.DoClick = function()

	RunConsoleCommand("DA_STele")		
	Main:Close()

end

No = vgui.Create("DButton", Main)
No:SetPos(ScrW()/2-100,75)
No:SetSize(50,25)
No:SetText("No")
No.DoClick = function()
		
	Main:Close()

end



end

usermessage.Hook("npcstele",npcstele)