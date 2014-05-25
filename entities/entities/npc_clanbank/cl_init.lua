function Cl_CBank()

	local data = net.ReadTable()

	local id = LocalPlayer():GetNWString("clan")

	local inventory = {}
	local cbank = {}
	local icon = {}

	for k,v in pairs(plydata.inventory) do inventory[k] = v end

	cbank = data
	
	local function AddInv(k,v)
	
		local model = GetIModel(k)
		local skin = GetISkin(k)
	
		icon["inv_" .. k] = vgui.Create( "SpawnIcon" )
		icon["inv_" .. k]:SetModel( model,skin )
		icon["inv_" .. k]:SetSize(50,50)
		icon["inv_" .. k]:SetPos(0,0)
		icon["inv_" .. k]:SetToolTip(v .. " "..GetIName(k))
		icon["inv_" .. k].DoClick = function()
		
			local itemmenu = DermaMenu()
				
			for x,y in pairs(Amounts) do
					
				if (y == "All") then y = plydata.inventory[k] end
				
				if (y <= plydata.inventory[k]) then
				
					itemmenu:AddOption("Deposit " .. y .. " " .. GetIName(k),function()  
					
						if (GetIWeight(k) * y + clans[id].bankweight < clans[id].bankmax) then
						
							if (cbank[k] == nil) then cbank[k] = 0 end
							if (y == plydata.inventory[k]) then
								icon["inv_" .. k]:Remove()
							else
								icon["inv_" .. k]:SetToolTip(plydata.inventory[k] - y .. " "..GetIName(k))					
							end
							
							-- if (cbank[k] == 0) then
								-- AddCBank(k,y)
							-- else
								-- icon["cbank_" .. k]:SetToolTip(cbank[k] + y .. " "..GetIName(k))				
							-- end
							
							plydata.inventory[k] = plydata.inventory[k] - y
							--cbank[k] = cbank[k] + y
							
							RunConsoleCommand("EditClanBank",k,y)
							
						end
					
					end)
				
				end
				
			end
			
			itemmenu:Open()
		
		end
		
		Inventory:AddItem(icon["inv_" .. k])
	
	end
	
	local function AddCBank(k,v)
	
		local model = GetIModel(k)
		local skin = GetISkin(k)
	
		icon["cbank_" .. k] = vgui.Create( "SpawnIcon" )
		icon["cbank_" .. k]:SetModel( model,skin )
		icon["cbank_" .. k]:SetSize(50,50)
		icon["cbank_" .. k]:SetPos(0,0)
		icon["cbank_" .. k]:SetToolTip(v .. " "..GetIName(k))
		icon["cbank_" .. k].DoClick = function()
		
			local itemmenu = DermaMenu()
				
			for x,y in pairs(Amounts) do
					
				if (y == "All") then y = cbank[k] end
				
				if (y <= cbank[k]) then
				
					itemmenu:AddOption("Widthdraw " .. y .. " " .. GetIName(k),function()  
					
						if (GetIWeight(k) * y + plydata.iweight < plydata.icapacity) then
					
							if (plydata.inventory[k] == nil) then plydata.inventory[k] = 0 end
							-- if (y == cbank[k]) then
								-- icon["cbank_" .. k]:Remove()
							-- else
								-- icon["cbank_" .. k]:SetToolTip(cbank[k] - y .. " "..GetIName(k))					
							-- end
							
							if (plydata.inventory[k] == 0) then
								AddInv(k,y)
							else
								icon["inv_" .. k]:SetToolTip(plydata.inventory[k] + y .. " "..GetIName(k))				
							end
							
							plydata.inventory[k] = plydata.inventory[k] + y
							--cbank[k] = cbank[k] - y
							
							RunConsoleCommand("EditClanBank",k,-y)
						
						end
					
					end)
				
				end
				
			end
			
			itemmenu:Open()
		
		end
		
		CBank:AddItem(icon["cbank_" .. k])
	
	end
	
	local function ChangeBank(data)
	
		local x = data:ReadString()
		local y = data:ReadShort()
		if (cbank[x] == nil) then cbank[x] = 0 end
		
		if (cbank[x] + y == 0) then		
			icon["cbank_" .. x]:Remove()
		else
			if (cbank[x] == 0) then
				AddCBank(x,y)
			else
				icon["cbank_" .. x]:SetToolTip(cbank[x] + y .. " "..GetIName(x))
			end
		end
		
		cbank[x] = cbank[x] + y
		clans[id].bankweight = clans[id].bankweight + GetIWeight(x) * y
		capacity:SetText( clans[id].bankweight .. " / " .. clans[id].bankmax )
	
	end
	usermessage.Hook("cbankedit",ChangeBank)
	
	Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW()/2 - 250,ScrH()/2 - 200)
	Menu:SetSize(500, 400)
	Menu:SetTitle("CBank")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(true)
	Menu:SetVisible(true)
	Menu:MakePopup()

	Inventory = vgui.Create( "DPanelList" , Menu)
	Inventory:EnableVerticalScrollbar( true ) 
	Inventory:EnableHorizontal( true ) 
	Inventory:SetSpacing( 5 ) 
	Inventory:SetPadding( 5 )
	Inventory:SetPos(10,30)
	Inventory:SetSize(235,320)

	CBank = vgui.Create( "DPanelList" , Menu)
	CBank:EnableVerticalScrollbar( true ) 
	CBank:EnableHorizontal( true ) 
	CBank:SetSpacing( 5 ) 
	CBank:SetPadding( 5 )
	CBank:SetPos(255,30)
	CBank:SetSize(235,320)
	
	capacity = vgui.Create( "DLabel" , Menu )
	capacity:SetText( clans[id].bankweight .. " / " .. clans[id].bankmax )
	capacity:SetPos(10,365)
	capacity:SetFont("ChatFont")
	capacity:SetWidth(480)
	
	for k,v in pairs(inventory) do
	
		if (v > 0) then
	
		AddInv(k,v)
		
		end
	
	end
	
	for k,v in pairs(cbank) do
	
		if (v > 0) then
	
		AddCBank(k,v)
		
		end
	
	end

end
net.Receive("clanbank",Cl_CBank)