function DA_QuestTalk(quest,state,qtask,qitem)

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 4,ScrH() / 4)
Menu:SetSize(ScrW() / 2, ScrH() / 2)
Menu:SetTitle("Quest Start")
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

Title = vgui.Create("DLabel",Menu)
Title:SetPos(5,30)
Title:SetText( Quest[quest].title )
Title:SizeToContents()

Task = vgui.Create("DLabel",Menu)
Task:SetPos(5,50)
Task:SetText( qtask )
Task:SizeToContents()


Item = vgui.Create("DButton", Menu)
Item:SetPos(ScrW()/8,ScrH()/2-40)
Item:SetSize(ScrW()/8,30)
Item:SetText("Continue")
Item.DoClick = function()

	RunConsoleCommand("QuestItem",quest,qitem)
	Menu:Close()

end

end

function QuestTInfo()

local data = net.ReadTable()

local QName = data.quest
local QState = data.qstate
local QTask = data.task
local QItem = data.item

if (QState != "Completed") then
DA_QuestTalk(QName,QState,QTask,QItem)
else
DA_TQuestThx(QItem)
end

end
net.Receive("questtalk",QuestTInfo)

function DA_TQuestThx(qitem)

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
Name:SetText( "I have already give the " .. GetIName(qitem) .. "to you"  )
Name:SizeToContents()

end

