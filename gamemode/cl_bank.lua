function Cl_Bank()

	local data = net.ReadTable()

	local inventory = {}
	local bank = {}
	local icon = {}

	for k,v in pairs(plydata.inventory) do
		
		if (k != "amount" and k != "capacity") then
		
			inventory[k] = v
		
		end

	end
	
	bank = data
	
	Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW()/2 - 250,ScrH()/2 - 200)
	Menu:SetSize(500, 400)
	Menu:SetTitle("Bank")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(true)
	Menu:SetVisible(true)
	Menu:MakePopup()

	InvPanel = vgui.Create( "DPanel" , Menu)
	InvPanel:SetPos(10,30)
	InvPanel:SetSize(235,320)
	InvPanel:SetBackgroundColor(Color(60,60,60,255))

	Inventory = vgui.Create( "DPanelList" , Menu)
	Inventory:EnableVerticalScrollbar( true ) 
	Inventory:EnableHorizontal( true ) 
	Inventory:SetSpacing( 5 ) 
	Inventory:SetPadding( 5 )
	Inventory:SetPos(10,30)
	Inventory:SetSize(235,320)

	BankPanel = vgui.Create( "DPanel" , Menu)
	BankPanel:SetPos(255,30)
	BankPanel:SetSize(235,320)
	BankPanel:SetBackgroundColor(Color(60,60,60,255))

	Bank = vgui.Create( "DPanelList" , Menu)
	Bank:EnableVerticalScrollbar( true ) 
	Bank:EnableHorizontal( true ) 
	Bank:SetSpacing( 5 ) 
	Bank:SetPadding( 5 )
	Bank:SetPos(255,30)
	Bank:SetSize(235,320)
	
	capacity = vgui.Create( "DLabel" , Menu )
	capacity:SetText( plydata.bweight .. " / " .. plydata.bcapacity )
	capacity:SetPos(10,365)
	capacity:SetFont("ChatFont")
	capacity:SetWidth(480)
	
	function AddBBank(k,v)
	
		local model = GetIModel(k)
		local skin = GetISkin(k)
	
		icon[k .. "bank"] = vgui.Create( "SpawnIcon" )
		icon[k .. "bank"]:SetModel( model,skin )
		icon[k .. "bank"]:SetSize(50,50)
		icon[k .. "bank"]:SetPos(0,0)
		icon[k .. "bank"]:SetToolTip(v .. " " .. GetIName(k))
		icon[k .. "bank"].DoClick = function()
		
		local itemmenu = DermaMenu()
			
			for x,y in pairs(Amounts) do
					
					if (y == "All") then
						y = bank[k]
						if (y == 0) then break end
					end
					
						if (y <= bank[k] and GetIWeight(k) * y <= plydata.icapacity - plydata.iweight) then
					
							itemmenu:AddOption("Widthdraw " .. y .. " " .. GetIName(k),function()  

							SetBBank(k,y)						
							net.Start( "da_widthdraw" )
							    net.WriteString( k )
							    net.WriteDouble( y )
							net.SendToServer()

						end )
					
				end
			
			end
			
			itemmenu:Open()
		
		end
		
		Bank:AddItem(icon[k .. "bank"])
	
	end
	
	function AddBInv(k,v)
	
		local model = GetIModel(k)
		local skin = GetISkin(k)
	
		icon[k .. "inv"] = vgui.Create( "SpawnIcon" )
		icon[k .. "inv"]:SetModel( model,skin )
		icon[k .. "inv"]:SetSize(50,50)
		icon[k .. "inv"]:SetPos(0,0)
		icon[k .. "inv"]:SetToolTip(v .. " " .. GetIName(k))
		icon[k .. "inv"].DoClick = function()
		
		local itemmenu = DermaMenu()
			
			for x,y in pairs(Amounts) do
					
					if (y == "All") then
						y = inventory[k]
						if (y == 0) then break end
					end
					
						if (y <= inventory[k] and GetIWeight(k) * y <= plydata.bcapacity - plydata.bweight) then
					
							itemmenu:AddOption("Deposit " .. y .. " " .. GetIName(k),function()  

							SetBInv(k,y)						
							net.Start( "da_deposit" )
							    net.WriteString( k )
							    net.WriteDouble( y )
							net.SendToServer()

						end )
					
				end
			
			end
			
			itemmenu:Open()
		
		end
		
		Inventory:AddItem(icon[k .. "inv"])
	
	end
	
	function SetBBank(k,v)
	
		if (bank[k] == v) then 
			Bank:RemoveItem(icon[k .. "bank"])
			icon[k .. "bank"]:Remove()
			bank[k] = 0
		else			
			bank[k] = bank[k] - v
			icon[k .. "bank"]:SetToolTip(bank[k] .. " " .. GetIName(k))		
		end
		
		plydata.bweight = math.round(tonumber(plydata.bweight) - tonumber(GetIWeight(k))*tonumber(v),5)
		capacity:SetText( plydata.bweight .. " / " .. plydata.bcapacity )
		
		if (inventory[k] == nil or inventory[k] == 0) then
			AddBInv(k,v)
			inventory[k] = v
		else
			inventory[k] = inventory[k] + v
			icon[k .. "inv"]:SetToolTip(inventory[k] .. " " .. GetIName(k))
		end
	
	end
	
	function SetBInv(k,v)
	
		if (inventory[k] == v) then 
			Bank:RemoveItem(icon[k .. "inv"])
			icon[k .. "inv"]:Remove()
			inventory[k] = 0
		else			
			inventory[k] = inventory[k] - v
			icon[k .. "inv"]:SetToolTip(inventory[k] .. " " .. GetIName(k))		
		end
		
		plydata.bweight = math.round(tonumber(plydata.bweight) + tonumber(GetIWeight(k))*tonumber(v),5)
		capacity:SetText( plydata.bweight .. " / " .. plydata.bcapacity )
		
		if (bank[k] == nil or bank[k] == 0) then
			AddBBank(k,v)
			bank[k] = v	
		else
			bank[k] = bank[k] + v
			icon[k .. "bank"]:SetToolTip(bank[k] .. " " .. GetIName(k))						
		end
	
	end
	
	for k,v in pairs(bank) do
	
		if (v > 0 and k != "amount" and k != "capacity") then
		
			AddBBank(k,v)
		
		end	
	
	end
	
	for k,v in pairs(inventory) do
	
		if (v > 0) then
		
			AddBInv(k,v)
		
		end	
	
	end

end
net.Receive("bank",Cl_Bank)