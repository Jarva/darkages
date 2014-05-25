function ClanInvite(data)

local id = data:ReadString()

local name = clans[id].name

local Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 2 - 200,ScrH() / 2 - 100)
Menu:SetSize(400, 100)
Menu:SetTitle("Clan Invitation - " .. name)
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

local Accept = vgui.Create("DButton", Menu)
Accept:SetPos(50,40)
Accept:SetSize(100,40)
Accept:SetText("Accept")
Accept.DoClick = function()

RunConsoleCommand("ClanAccept",id)
Menu:Close()

end

local Decline = vgui.Create("DButton", Menu)
Decline:SetPos(250,40)
Decline:SetSize(100,40)
Decline:SetText("Decline")
Decline.DoClick = function()

Menu:Close()

end


end
usermessage.Hook("claninvite",ClanInvite)

function Cl_ClanCreate()

	Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW() / 2 - 250,ScrH() / 2 - 200)
	Menu:SetSize(250, 400)
	Menu:SetTitle("Clan Master")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(true)
	Menu:SetVisible(true)
	Menu:MakePopup()

	Text = vgui.Create("DTextEntry", Menu)
	Text:SetText("Name - Maximum 30 characters")
	Text:SetPos(25,40)
	Text:SetSize(200,20)
	Text.OnTextChanged = function()

		local x = GetLength(Text:GetValue())
				
		if (x >= 30) then
			Text:SetText(string.sub(Text:GetValue(),1,30))
		end

	end
	
	local ClanColor = vgui.Create( "DColorMixer", Menu )
	ClanColor:SetPos( 25, 80 )
	ClanColor:SetSize( 200, 200 )
	
	Create = vgui.Create("DButton", Menu)
	Create:SetPos(15,330)
	Create:SetSize(210,20)
	Create:SetText("Create Clan - 2000 Gold")
	Create.DoClick = function()
	
	local y = ClanColor:GetColor()	
	local x = y.r .. "," .. y.g .. "," .. y.b
	
	RunConsoleCommand("DA_CreateClan",Text:GetValue(),x)
	Menu:Close()
	
	end
	
	if (plydata.inventory["gold"] < 2000) then
	Create:SetDisabled(true)
	end
	
end
usermessage.Hook("cl_createclan",Cl_ClanCreate)

function Cl_ClanEdit()

	local self = LocalPlayer()
	local id = LocalPlayer():GetNWString("clan")

	Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW() / 2 - 300,ScrH() / 2 - 200)
	Menu:SetSize(600, 400)
	Menu:SetTitle("Clan Master")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(true)
	Menu:SetVisible(true)
	Menu:MakePopup()

	local CList = vgui.Create( "DPanelList",Menu )
	CList:EnableVerticalScrollbar( true )
	CList:EnableHorizontal( false )
	CList:SetSpacing( 5 )
	CList:SetPadding( 5 )
	CList:SetPos(10,40)
	CList:SetSize(320,340)
		
		for k,v in pairs(clans[id]["members"]) do
		
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
			CButton:SetPos(170,20)
			CButton:SetSize(60,20)
			CButton:SetText("Functions")
			CButton.DoClick = function()
			
				local cmenu = DermaMenu()
				
				if (IsPlayerOnline(k)) then
				
					cmenu:AddOption("Add " .. v["name"] .. " as friend",function()

						RunConsoleCommand("MenuAddFriend",IsPlayerOnline(k):SteamID())

					end )
				
				end
				
				if (self:GetNWBool("inclan") == true and clans[id]["ranks"][clans[id]["members"][self:UniqueID()]["rank"]] > 1) then
				
					cmenu:AddOption("Kick " .. v["name"],function()
		
						if (clans[id]["ranks"][clans[id]["members"][self:UniqueID()]["rank"]] >= clans[id]["ranks"][clans[id]["members"][k]["rank"]]) then
							RunConsoleCommand("ClanKick",k)
						else HudPrint("You can't kick your superior") end
						

					end )
					
				end
				
				cmenu:Open()
			
			end
			
			if (clans[id]["ranks"][clans[id]["members"][self:UniqueID()]["rank"]] > 2) then
				
				local CPromote = vgui.Create("DButton", ClanMember)
				CPromote:SetPos(240,20)
				CPromote:SetSize(60,20)
				CPromote:SetText("Promote")
				CPromote.DoClick = function()
				
					local cmenu = DermaMenu()
				
					if (IsPlayerOnline(k)) then
					
						for x,y in pairs(clans[id]["ranks"]) do
					
							if (clans[id]["ranks"][clans[id]["members"][self:UniqueID()]["rank"]] >= y) then
		
								cmenu:AddOption("Promote " .. v["name"] .. " to " .. x,function()
								
									RunConsoleCommand("ClanPromote",id,k,x)

								end )
							
							end
						
						end
					
					end
				
					cmenu:Open()
				
				end
			
			end
					
			CList:AddItem(ClanMember)		
		
		end	
		
		if (clans[id]["ranks"][clans[id]["members"][self:UniqueID()]["rank"]] > 4) then
		
			local CRankName = vgui.Create("DTextEntry", Menu)
			CRankName:SetMultiline(false)
			CRankName:SetSize(250,20) 
			CRankName:SetPos(340,40)
			
			local ranktype = 0
			
			local CRankType = vgui.Create( "DComboBox", Menu)
			CRankType:SetPos(340,70)
			CRankType:SetSize( 150, 20 )
			CRankType:AddChoice("Nothing")
			CRankType:AddChoice("Invite")
			CRankType:AddChoice("Invite,Kick")
			CRankType:AddChoice("Invite,Kick,Promote")
			CRankType:AddChoice("Invite,Kick,Promote,Tax")
			CRankType:AddChoice("Leader")
			CRankType:ChooseOptionID( 1 )
			function CRankType:OnSelect(index,value,data) 
				ranktype = index - 1
			end
			
			local CRankAdd = vgui.Create("DButton", Menu)
			CRankAdd:SetPos(500,70)
			CRankAdd:SetSize(90,20)
			CRankAdd:SetText("Add Rank")
			CRankAdd.DoClick = function()
			
				RunConsoleCommand("AddClanRank",id,CRankName:GetValue(),ranktype)
				
			end		
		
		end
		
		local CUpgradeAdd = vgui.Create("DButton", Menu)
		CUpgradeAdd:SetPos(340,125)
		CUpgradeAdd:SetSize(250,30)
		CUpgradeAdd:SetText("Buy Upgrades")
		CUpgradeAdd.DoClick = function()
		
			Cl_ClanUpgrades(id)
			
		end
		
		if (clans[id]["ranks"][clans[id]["members"][self:UniqueID()]["rank"]] > 3) then
			
			local CTax = vgui.Create("DTextEntry", Menu)
			CTax:SetMultiline(false)
			CTax:SetSize(250,20) 
			CTax:SetPos(340,180)
			CTax:SetValue(clans[id]["tax"])
			
			local CTaxAdd = vgui.Create("DButton", Menu)
			CTaxAdd:SetPos(500,210)
			CTaxAdd:SetSize(90,20)
			CTaxAdd:SetText("Set Tax")
			CTaxAdd.DoClick = function()
			
				RunConsoleCommand("ClanTax",id,CTax:GetValue())
				
			end
		
		end
		
		local CBankSlot = vgui.Create( "DNumSlider", Menu )
		CBankSlot:SetPos( 340,250 )
		CBankSlot:SetSize( 250 , 40 )
		CBankSlot:SetText( "Bank slots" )
		CBankSlot:SetMin( 0 )
		CBankSlot:SetMax( (plydata.inventory["gold"] - plydata.inventory["gold"]%200) / 200)
		CBankSlot:SetValue( 0 )
		CBankSlot:SetDecimals( 0 ) 
		
		local CBankAdd = vgui.Create("DButton", Menu)
		CBankAdd:SetPos(500,300)
		CBankAdd:SetSize(90,20)
		CBankAdd:SetText("Buy Bank Slots")
		CBankAdd.DoClick = function()
		
			if (CBankSlot:GetValue() > 0) then
				if (CBankSlot:GetValue() * 200 < plydata.inventory["gold"]) then
					RunConsoleCommand("ClanBankSlot",id,CBankSlot:GetValue()) 
					CBankSlot:SetMax( ((plydata.inventory["gold"] - plydata.inventory["gold"]%200) / 200) - CBankSlot:GetValue() )
					CBankSlot:SetValue( 0 )
				else
					HudPrint("You haven't got enough money")
				end
			else
				HudPrint("You can't buy any bank slot")
			end
			
		end		 
		
		if (clans[id]["ranks"][clans[id]["members"][self:UniqueID()]["rank"]] > 4) then
			
			Delete = vgui.Create("DButton", Menu)
			Delete:SetPos(380,360)
			Delete:SetSize(170,20)
			Delete:SetText("Delete Clan")
			Delete.DoClick = function()
			
				RunConsoleCommand("ClanDelete")
				Menu:Remove()
			
			end
		
		end
	
end
usermessage.Hook("cl_editclan",Cl_ClanEdit)

function Cl_ClanUpgrades(id)

	local Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW() / 2 - 250,ScrH() / 2 - 200)
	Menu:SetSize(500, 400)
	Menu:SetTitle("Clan upgrades")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(true)
	Menu:SetVisible(true)
	Menu:MakePopup()
	
	local List = vgui.Create( "DPanelList", Menu )
	List:EnableVerticalScrollbar( true )
	List:EnableHorizontal( false )
	List:SetSpacing( 5 )
	List:SetPadding( 10 )
	List:SetPos(10,30)
	List:SetSize(480,360)
	
	local Buy = {}
	
	for k,v in pairs(ClanUpgrades) do
	
		if (!ClanHasUpgrade(id,k)) then
	
		local CUPanel = vgui.Create("DPanel")
		CUPanel:SetSize(460,60)
		
		Name = vgui.Create("DLabel",CUPanel)
		Name:SetPos(10,10)
		Name:SetText("Upgrade : " .. ClanUpgrades[k].name)
		Name:SetFont("Default")
		Name:SetWidth(320)

		Cost = vgui.Create("DLabel",CUPanel)
		Cost:SetPos(10,30)
		Cost:SetText("Cost : " .. ClanUpgrades[k].cost)
		Cost:SetFont("TargetIDSmall")
		Cost:SizeToContents()
		Cost:SetWidth(320)
		
		Buy[k] = vgui.Create("DButton", CUPanel)
		Buy[k]:SetPos(340,20)
		Buy[k]:SetSize(100,20)
		Buy[k]:SetText("Buy")
		Buy[k].DoClick = function()
		
			RunConsoleCommand("ClanBuyUpgrade",k)
			CUPanel:Remove()
			List:Rebuild()
			plydata.inventory.gold = plydata.inventory.gold - ClanUpgrades[k].cost
			
			for x,y in pairs(ClanUpgrades) do
			
				if (!ClanHasUpgrade(id,x)) then
			
					if (plydata.inventory.gold < ClanUpgrades[x].cost) then Buy[x]:SetDisabled(true) end
				
				end
			
			end
		
		end
		
		if (plydata.inventory.gold < ClanUpgrades[k].cost) then Buy[k]:SetDisabled(true) end
		
		List:AddItem(CUPanel)
		
		end
		
	end  

end