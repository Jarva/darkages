function QuestMenu(qdata)

local Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 2-300,ScrH() / 2-250)
Menu:SetSize(600, 500)
Menu:SetTitle("Quests")
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

local QList = vgui.Create( "DPanelList",Menu )
QList:EnableVerticalScrollbar( true )
QList:EnableHorizontal( false )
QList:SetSpacing( 5 )
QList:SetPadding( 5 )
QList:SetPos(10,30)
QList:SetSize(580,460)

for k,v in pairs(qdata) do

	print(k)

	QPanel = vgui.Create("DPanel")
	QPanel:SetSize(580,30)
	QPanel:SetBackgroundColor(Color(60,60,60,255))
	
	Title = vgui.Create("DLabel",QPanel)
	Title:SetPos(5,2)
	Title:SetText( Quests[k].title )
	Title:SetFont("KnightM")
	Title:SizeToContents()
	
	local state = ""
	local color = Color(20,70,200,255)
	
	if (v == "TIP") then
	state = "Task in Progress"
	color = Color(200,0,0,255)
	else
	state = "Completed"
	color = Color(0,200,0,255)
	end
	
	State = vgui.Create("DLabel",QPanel)
	State:SetPos(320,8)
	State:SetText( state )
	State:SetColor(color)
	State:SetFont("DungeonS")
	State:SizeToContents()
	
	if (state != "Completed") then
	
		local Abandon = vgui.Create("DButton", QPanel)
		Abandon:SetPos(430,5)
		Abandon:SetSize(60,20)
		Abandon:SetText("Abandon")
		Abandon.DoClick = function()
		
		RunConsoleCommand("QuestAbandon",k)
		Menu:Close()
		QRemoveTrack(k)
		
		end
		
		local Track = {}
		Track[k] = vgui.Create("DButton", QPanel)
		Track[k]:SetPos(500,5)
		Track[k]:SetSize(60,20)
		
		if (qtracks == nil) then qtracks = {} end
		
		if (qtracks[k] == nil) then
			Track[k]:SetText("Track")
		else
			Track[k]:SetText("Untrack")
		end
		
		Track[k].DoClick = function()
		
		if (qtracks == nil) then qtracks = {} end
		
			if (qtracks[k] == nil) then
				qtracks[k] = "Track"
				Track[k]:SetText("Untrack")
			else
				QRemoveTrack(k)
				Track[k]:SetText("Track")
			end
			
			ClQuestSave()

		end
	
	end
	
	QList:AddItem(QPanel)

end


end

function QuestData()
   
	local data = net.ReadTable()

	local qdata = {}
	qdata = data

	QuestMenu(qdata)

end
net.Receive("questmenu2", QuestData)

function ClQuestSave()

local x = {}
x.qtracks = qtracks
x.stracks = stracks

file.Write("darkages/settings.txt",util.TableToKeyValues(x))

end

function QRemoveTrack(quest)

	if (qtracks != nil and qtracks[quest] != nil) then

		qtracks[quest] = nil
		ClQuestSave()

	end

end

function GetTasks()

	local data = net.ReadTable()

	for k,v in pairs(data) do

		Quests[k].task = v
		
	end

end
net.Receive("questtasks",GetTasks)