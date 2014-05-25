function Cl_Shop(data)

	local id = data:ReadString()
	local name = Shops[id].name
	local goods = Shops[id].goods
	local inventory = {}
	local icon = {}
	
	for k,v in pairs(plydata.inventory) do
		
		if (v > 0 and k != "gold") then
		
			inventory[k] = v
		
		end
	
	end
	
	function SetShopIcon(icon,k,y)

		if (y == inventory[k]) then			
			Inventory:RemoveItem(icon)				
		else				
			icon:SetToolTip(inventory[k] - y .. " " .. GetIName(k) .. " - Price : " .. GetIPrice(k,"sell"))				
		end

		inventory[k] = inventory[k] - y
	
	end
	
	function SetShopSIcon(k,y)
	
		if (inventory[k] == 0 or inventory[k] == nil) then		
			inventory[k] = y
			AddShopInvIcon(k,y)				
		else	
			inventory[k] = inventory[k] + y
			icon[k]:SetToolTip(inventory[k] .. " " .. GetIName(k) .. " - Price : " .. GetIPrice(k,"sell"))				
		end
			
	end
	
	local function AddBuyBack(k,v)
	
		if (plydata.buyback == nil) then plydata.buyback = {} end		
		plydata.buyback.item = k
		plydata.buyback.amount = v
	
		bicon = vgui.Create( "SpawnIcon", Menu )
		bicon:SetModel( GetIModel(k), GetISkin(k))
		bicon:SetSize(40,40)
		bicon:SetPos(450,355)
		bicon:SetToolTip( v .. " " .. GetIName(k) )
		bicon.DoClick = function()
		
		if (GetIPrice(k,"buy") * v <= plydata.inventory.gold) then
		
		if (inventory[k] == nil) then inventory[k] = 0 end
		
		if (inventory[k] > 0) then

			inventory[k] = inventory[k] + v
			icon[k]:SetToolTip(inventory[k] .. " " .. GetIName(k) .. " - Price : " .. GetIPrice(k,"sell"))
		
		else
		
			inventory[k] = inventory[k] + v
			AddShopInvIcon(k,v)
		
		end
		
		RunConsoleCommand("DA_ShopBuyBack")
		plydata.buyback = nil
		bicon:Remove()
		
		plydata.inventory.gold = plydata.inventory.gold + GetIPrice(k,"buy") * v			
		gold:SetText( plydata.inventory.gold .. " Gold" )
		gicon:SetToolTip( plydata.inventory.gold .. " Gold" )
		
		end
		
		end
	
	end
	
	function AddShopInvIcon(k,v)
	
	local model = GetIModel(k)
	local skin = GetISkin(k)	
	
	icon[k] = vgui.Create( "SpawnIcon" )
	icon[k]:SetModel( model,skin )

	icon[k]:SetSize(50,50)
	icon[k]:SetPos(0,0)
	icon[k]:SetToolTip(inventory[k] .. " " .. GetIName(k) .. " - Price : " .. GetIPrice(k,"sell"))
	icon[k].DoClick = function()
		
		local itemmenu = DermaMenu()
		
		for x,y in pairs(Amounts) do

				if (y == "All") then
					y = inventory[k] 
					if (y == 0) then break end
				end
			
				if (y <= inventory[k]) then
			
				itemmenu:AddOption("Sell " .. y .. " " .. GetIName(k),function()  

					plydata.inventory.gold = plydata.inventory.gold + GetIPrice(k,"sell") * y	
					
					gold:SetText( plydata.inventory.gold .. " Gold" )
					gicon:SetToolTip( plydata.inventory.gold .. " Gold" )
					
					AddBuyBack(k,y)
				
					SetShopIcon(icon[k],k,y)
				
					RunConsoleCommand("DA_ShopSell",k,y)

				end )
					
			end
		
		end
	
		itemmenu:Open()

	end

	Inventory:AddItem(icon[k])
	
	end

	Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW()/2 - 250,ScrH()/2 - 200)
	Menu:SetSize(500, 400)
	Menu:SetTitle(name)
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

	Shop = vgui.Create( "DPanelList" , Menu)
	Shop:EnableVerticalScrollbar( true ) 
	Shop:EnableHorizontal( true ) 
	Shop:SetSpacing( 5 ) 
	Shop:SetPadding( 5 )
	Shop:SetPos(255,30)
	Shop:SetSize(235,320)

	gicon = vgui.Create( "SpawnIcon", Menu )
	gicon:SetModel( GetIModel("gold") )
	gicon:SetSize(40,40)
	gicon:SetPos(10,355)
	gicon:SetToolTip( plydata.inventory.gold .. " Gold" )

	gold = vgui.Create( "DLabel" , Menu )
	gold:SetText( plydata.inventory.gold .. " Gold" )
	gold:SetPos(60,365)
	gold:SetFont("BudgetLabel")
	gold:SetWidth(190)
	
	if (plydata.buyback != nil) then
	
		AddBuyBack(plydata.buyback.item,plydata.buyback.amount)
	
	end

	for k,v in pairs(goods) do

		local model = GetIModel(v)
		local skin = GetISkin(v)	
		
		icon[v .. "shop"] = vgui.Create( "SpawnIcon" )
		icon[v .. "shop"]:SetModel( model,skin )
		icon[v .. "shop"]:SetSize(50,50)
		icon[v .. "shop"]:SetPos(0,0)
		icon[v .. "shop"]:SetToolTip(GetIName(v) .. " - Price : " .. GetIPrice(v,"buy"))
		icon[v .. "shop"].DoClick = function()
			
			local itemmenu = DermaMenu()
			
			for x,y in pairs(Amounts) do
					
					if (y == "All") then
						y = math.floor( plydata.inventory.gold / GetIPrice(v,"buy")) 
						if (y == 0) then break end
					end
					
						if (GetIWeight(k) * y <= plydata.icapacity - plydata.iweight and GetIPrice(v,"buy") * y <= plydata.inventory.gold) then
					
						itemmenu:AddOption("Buy " .. y .. " " .. GetIName(v),function()  

							plydata.inventory.gold = plydata.inventory.gold - GetIPrice(v,"buy") * y
						
							gold:SetText( plydata.inventory.gold .. " Gold" )
							gicon:SetToolTip( plydata.inventory.gold .. " Gold" )
							SetShopSIcon(v,y)
						
							RunConsoleCommand("DA_ShopBuy",v,y)

						end )
					
				end
			
			end
			
			itemmenu:Open()
		
		end
		
		Shop:AddItem(icon[v .. "shop"])

	end
	
	for k,v in pairs(inventory) do

		AddShopInvIcon(k,v)

	end

end
usermessage.Hook("shop",Cl_Shop)

