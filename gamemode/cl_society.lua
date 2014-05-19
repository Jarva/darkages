function FriendsMenu()

	local data = net.ReadTable()

	local self = LocalPlayer()
	local clanid = nil
	
	if (self:GetNWBool("inclan") == true) then
	
		clanid = self:GetNWString("clan")
		
	end

	plydata.friends = {}
	plydata.friends = data

	local Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW() / 2 - 300,ScrH() / 2 - 200)
	Menu:SetSize(600, 400)
	Menu:SetTitle("Society")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(true)
	Menu:SetVisible(true)
	Menu:MakePopup()

	local FList = vgui.Create( "DPanelList",Menu )
	FList:EnableVerticalScrollbar( true )
	FList:EnableHorizontal( false )
	FList:SetSpacing( 5 )
	FList:SetPadding( 10 )
	FList:SetPos(20,40)
	FList:SetSize(560,320)

	for k,v in pairs(plydata.friends) do
	
		local FPanel = vgui.Create( "DPanel" )
		FPanel:SetSize( 540, 100 )
		
		local Name = vgui.Create("DLabel",FPanel)
		Name:SetText(plydata.friends[k].name .. " [" .. plydata.friends[k].id .. "] ")
		Name:SetFont("TargetIDSmall")
		Name:SetPos(10,10)
		Name:SizeToContents()
		
		local Last = vgui.Create("DLabel",FPanel)
		Last:SetText("Last Join : " .. plydata.friends[k].last)
		Last:SetFont("Default")
		Last:SetPos(10,30)
		Last:SizeToContents()
		
		local status = "Offline"		
		for x,y in pairs(player.GetAll()) do if(y:UniqueID() == k) then status = "Online" end end
		
		local Status = vgui.Create("DLabel",FPanel)
		Status:SetText(status)
		Status:SetFont("Default")
		Status:SetPos(10,50)
		Status:SizeToContents()
		
		local Remove = vgui.Create("DButton", FPanel)
		Remove:SetPos(10,70)
		Remove:SetSize(120,20)
		Remove:SetText("Remove friend")
		Remove.DoClick = function()
		
			RunConsoleCommand("RemoveFriend",k)
			FPanel:Remove()
			
		end	
		
		FList:AddItem(FPanel)
	
	end
	
	--CLAN--
	
	if (self:GetNWBool("inclan") == true) then
	
		local clanid = self:GetNWString("clan")
	
		ClanMenu = vgui.Create( "DPanel", Menu )
		ClanMenu:SetPos( 20, 40 )
		ClanMenu:SetSize( 560, 320 )
		ClanMenu:SetBackgroundColor(Color(40,40,40,255))

		
		local CList = vgui.Create( "DPanelList",ClanMenu )
		CList:EnableVerticalScrollbar( true )
		CList:EnableHorizontal( false )
		CList:SetSpacing( 5 )
		CList:SetPadding( 5 )
		CList:SetPos(10,10)
		CList:SetSize(250,290)
		
		local Name = vgui.Create("DLabel",ClanMenu)
		Name:SetText("Name : " .. clans[self:GetNWString("clan")].name)
		Name:SetFont("AdventureM")
		Name:SetPos(270,10)
		Name:SizeToContents()
		
		local Members = vgui.Create("DLabel",ClanMenu)
	    Members:SetText("Members : " .. table.Count(clans[self:GetNWString("clan")].members))
		Members:SetFont("AdventureM")
		Members:SetPos(270,40)
		Members:SizeToContents()
		
		local Tax = vgui.Create("DLabel",ClanMenu)
		Tax:SetText("Tax : " .. clans[self:GetNWString("clan")].tax)
		Tax:SetFont("AdventureM")
		Tax:SetPos(270,70)
		Tax:SizeToContents()
		
		local BankSlots = vgui.Create("DLabel",ClanMenu)
		BankSlots:SetText("Capacity of bank : " .. clans[self:GetNWString("clan")].bankmax)
		BankSlots:SetFont("AdventureM")
		BankSlots:SetPos(270,100)
		BankSlots:SizeToContents()
		
		local CLeave = vgui.Create("DButton", ClanMenu)
		CLeave:SetPos(355,260)
		CLeave:SetSize(120,20)
		CLeave:SetText("Leave Clan")
		CLeave.DoClick = function()
		
			RunConsoleCommand("ClanLeave")
			Menu:Remove()
			
		end	
		
		for k,v in pairs(clans[clanid]["members"]) do
		
			local ClanMember = vgui.Create( "DPanel")
			ClanMember:SetSize(240,60)
			ClanMember:SetBackgroundColor(Color(80,80,80,255))
			
			local CMember = vgui.Create("DLabel",ClanMember)
			CMember:SetText(v["name"])
			CMember:SetFont("KnightM")
			CMember:SetPos(10,5)
			CMember:SizeToContents()

			local CRang = vgui.Create("DLabel",ClanMember)
			CRang:SetText(v["rank"])
			CRang:SetFont("DungeonS")
			CRang:SetPos(10,35)
			CRang:SizeToContents()
					
			local CButton = vgui.Create("DButton", ClanMember)
			CButton:SetPos(150,20)
			CButton:SetSize(80,20)
			CButton:SetText("Functions")
			CButton.DoClick = function()
			
				local cmenu = DermaMenu()
				
				if (IsPlayerOnline(k)) then
				
					cmenu:AddOption("Add " .. v["name"] .. " as friend",function()

						RunConsoleCommand("MenuAddFriend",IsPlayerOnline(k):SteamID())

					end )
				
				end
				
				cmenu:Open()
			
			end
					
			CList:AddItem(ClanMember)		
		
		end
	
	end
	
	--GLOBAL--
	
	local GlobalMenu = vgui.Create( "DPanel", Menu )
	GlobalMenu:SetPos( 20, 40 )
	GlobalMenu:SetSize( 560, 320 )
	
	local GList = vgui.Create( "DPanelList",GlobalMenu )
	GList:EnableVerticalScrollbar( true )
	GList:EnableHorizontal( false )
	GList:SetSpacing( 5 )
	GList:SetPadding( 5 )
	GList:SetPos(5,5)
	GList:SetSize(360,300)
	
	for k,v in pairs(player.GetAll()) do
	
		local GPlayer = vgui.Create( "DPanel")
		GPlayer:SetSize(350,40)
		
		local Test = vgui.Create("DLabel",GPlayer)
		Test:SetText(v:Nick())
		Test:SetFont("ChatFont")
		Test:SetPos(10,10)
		Test:SizeToContents()		
		
		local GButton = vgui.Create("DButton", GPlayer)
		GButton:SetPos(250,10)
		GButton:SetSize(80,20)
		GButton:SetText("Functions")
		GButton.DoClick = function()
		
			local gmenu = DermaMenu()
			
			gmenu:AddOption("Add " .. v:Nick() .. " as friend",function()

				RunConsoleCommand("MenuAddFriend",v:SteamID())

			end )

			if (self:GetNWBool("inclan") == true and clans[clanid]["ranks"][clans[clanid]["members"][self:UniqueID()]["rank"]] > 0) then
			
				gmenu:AddOption("Invite " .. v:Nick() .. " to clan",function()

					if (v:GetNWBool("inclan") != true and v:GetNWString("clan") != self:GetNWString("clan")) then
					
					
						RunConsoleCommand("InviteToClan",v:GetNWString("clan"),v:SteamID())

					else
				
						chat.AddText(Color(255,128,32),v:Nick() .. " is already in a clan [" .. clans[v:GetNWString("clan")].name .. "]")
					
					end
					
				end )
			
			end
				
			
			
			gmenu:AddOption("PM to " .. v:Nick(),function()

				

			end )
			
			gmenu:Open()
		
		end
				
		GList:AddItem(GPlayer)		
	
	end
	
	--SHEET--
	
	MenuSheet = vgui.Create( "DPropertySheet" )
	MenuSheet:SetParent( Menu )
	MenuSheet:SetPos(10,40)
	MenuSheet:SetSize(580,340)

	MenuSheet:AddSheet("Friends",FList,"gui/silkicons/user",false,false,"Friend List")
	
	if (self:GetNWString("clan") != nil and self:GetNWString("clan") != "") then
	
		MenuSheet:AddSheet("Clan",ClanMenu,"gui/silkicons/group",false,false,"Clan")
	
	end
	
	MenuSheet:AddSheet("Global",GlobalMenu,"gui/silkicons/group",false,false,"Global")

end
net.Receive("friends", FriendsMenu)

function IsPlayerOnline(clanid)

	for k,v in pairs(player.GetAll()) do

		if (v:UniqueID() == clanid) then return v end

	end

	return false

end

		