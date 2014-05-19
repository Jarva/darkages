function SkillMenu()

	if (plydata == nil) then plydata = {} end

	plydata.skills = net.ReadTable()

	Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW() / 2-300,ScrH() / 2-250)
	Menu:SetSize(600, 500)
	Menu:SetTitle("Skills")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(true)
	Menu:SetVisible(true)
	Menu:MakePopup()

	  
	local SkillList = vgui.Create( "DPanelList", Menu )
	SkillList:EnableVerticalScrollbar( true )
	SkillList:EnableHorizontal( false )
	SkillList:SetSpacing( 5 )
	SkillList:SetPadding( 10 )
	SkillList:SetPos(10,30)
	SkillList:SetSize(580,450)

	local SkillP = {}
	local SkillT = {}
	  
	for k,v in pairs(Skills) do

	SkillP[v] = vgui.Create("DPanel")
	SkillP[v]:SetSize(200,50)
	SkillP[v]:SetBackgroundColor(Color(60,60,60,255))

	SkillN = vgui.Create("DLabel",SkillP[v])
	SkillN:SetPos(5,5)
	SkillN:SetText(GetIName(v) .. " - Level : " ..plydata.skills[v])
	SkillN:SetFont("DungeonS")
	SkillN:SizeToContents()

	SkillN = vgui.Create("DLabel",SkillP[v])
	SkillN:SetPos(5,25)
	SkillN:SetText(plydata.skills[v.."xp"] .. " / " .. LevelXP[plydata.skills[v]])
	SkillN:SetFont("Adventure")
	SkillN:SizeToContents()

	SkillT[v] = vgui.Create("DButton", SkillP[v])
	SkillT[v]:SetPos(ScrW()/4,5)
	SkillT[v]:SetSize(60,40)

	if (stracks != nil and stracks[v] != nil) then
		SkillT[v]:SetText("Untrack")
	else
		SkillT[v]:SetText("Track")
	end

	SkillT[v].DoClick = function()

		if (stracks == nil) then stracks = {} end
		
		if (stracks[v] == nil) then
			SkillT[v]:SetText("Untrack")
			stracks[v] = "Tracks"
		else
			SkillT[v]:SetText("Track")
			stracks[v] = nil
		end
		
		ClQuestSave()

	end

	SkillList:AddItem(SkillP[v])

	end

end
net.Receive("skillmenu",SkillMenu)
