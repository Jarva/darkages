function AchiMenu()

	data = net.ReadTable()

	plydata.stats = data.stats	
	plydata.achievements = data.achievements

	Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW() / 2-300,ScrH() / 2-250)
	Menu:SetSize(600, 500)
	Menu:SetTitle("Stats and Achievements")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(true)
	Menu:SetVisible(true)
	Menu:MakePopup()

	StatP = vgui.Create("DPanel")
	StatP:SetSize(580,360)
	StatP:SetPos(20,10)
	StatP:SetBackgroundColor(Color(60,60,60,255))

	local StatMenu = vgui.Create( "DPanelList", StatP)
	StatMenu:EnableVerticalScrollbar( true )
	StatMenu:EnableHorizontal( false )
	StatMenu:SetSpacing( 5 )
	StatMenu:SetPadding( 10 )
	StatMenu:SetSize(580,360)

	if (plydata.stats == nil) then plydata.stats = {} end

	for k,v in pairs(plydata.stats) do

		if (Stats[k] != nil) then

			StatL = vgui.Create("DLabel")
			StatL:SetPos(10,10)
			StatL:SetText(Stats[k] .. " : " .. v)
			StatL:SetFont("Adventure")
			StatL:SizeToContents()

			StatMenu:AddItem(StatL)

		end

	end

	local AchiMenu = vgui.Create( "DPanelList" )
	AchiMenu:EnableVerticalScrollbar( true )
	AchiMenu:EnableHorizontal( false )
	AchiMenu:SetSpacing( 5 )
	AchiMenu:SetPadding( 0 )
	AchiMenu:SetPos(10,10)
	AchiMenu:SetSize(580,360)

	if (plydata.achievements == nil) then plydata.achievements = {} end

	for k,v in pairs(Achievements) do

		local stat = 0	
		if (plydata.stats[Achievements[k].stat] != nil) then stat = plydata.stats[Achievements[k].stat] end

		local AcMenu = vgui.Create("DPanel")
		AcMenu:SetSize(560,60)
		AcMenu:SetBackgroundColor(Color(60,60,60,255))
		
		AcName = vgui.Create("DLabel",AcMenu)
		AcName:SetPos(10,10)
		if (plydata.achievements[k] == nil) then AcName:SetText(Achievements[k].name) else AcName:SetText(Achievements[k].name .. " [COMPLETED]") end
		AcName:SetFont("Dungeon")
		AcName:SizeToContents()

		if (stat > Achievements[k].amount) then
			AcMenu:SetBackgroundColor(Color(40,64,40,255))
		else
			if(stat > 0) then
				AcMenu:SetBackgroundColor(Color(120,120,80,255))
			end
		end

		AcProg = vgui.Create("DLabel",AcMenu)
		AcProg:SetPos(10,30)
		AcProg:SetText(Stats[Achievements[k].stat] .. " : " .. stat .. " / " .. Achievements[k].amount)
		AcProg:SetFont("Adventure")
		AcProg:SizeToContents()
		
		AchiMenu:AddItem(AcMenu)

	end

	MenuSheet = vgui.Create( "DPropertySheet" )
	MenuSheet:SetParent( Menu )
	MenuSheet:SetPos(0,25)
	MenuSheet:SetSize(600,475)

	MenuSheet:AddSheet( "Stats",StatP,"gui/silkicons/user",false,false,"Stats")
	MenuSheet:AddSheet( "Achievements",AchiMenu,"gui/silkicons/user",false,false,"Achievements")

end
net.Receive("achimenu",AchiMenu)