function InventoryMenu()

	plydata.inventory = net.ReadTable()

	Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW() / 2-300,ScrH() / 2-250)
	Menu:SetSize(600, 500)
	Menu:SetTitle("Inventory")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(true)
	Menu:SetVisible(true)
	Menu:MakePopup()

	ItemList = vgui.Create( "DPanelList", Menu )
	ItemList:EnableVerticalScrollbar( true )
	ItemList:EnableHorizontal( true )
	ItemList:SetSpacing( 5 )
	ItemList:SetPadding( 10 )
	ItemList:SetPos(10,25)
	ItemList:SetSize(580,460)

	for k,v in pairs(plydata.inventory) do

		if (v > 0) then
		  
		local model = GetIModel(k)
		local skin = GetISkin(k)
		  
		local icon = vgui.Create( "SpawnIcon", icon )
		icon:SetModel( model,skin )
		--icon:SetAmount(v)
		icon:SetPos(2,2)
		icon:SetToolTip(v .. " "..GetIName(k))
		icon.DoClick = function()  

		local itemmenu = DermaMenu()
		
			for x,y in pairs(Amounts) do
			
				if (y == "All") then y = plydata.inventory[k] end
			
				if (y <= plydata.inventory[k]) then
				
					itemmenu:AddOption("Drop " .. y .. " " .. GetIName(k),function() 
						
						SetIcon(icon,k,y)					
						net.Start("da_dropitem")
							net.WriteTable({k,y})
						net.SendToServer()

					end )
					
				end
			
			end
			
			if (Eatable[k] != nil) then
		  
				itemmenu:AddOption("Consume " .. GetIName(k),function()

					SetIcon(icon,k,1)				
					RunConsoleCommand("DA_InvEat",k)

				end)
		  
			end 
			
			if (Plantable[k] != nil) then
		  
				itemmenu:AddOption("Plant " .. GetIName(k),function()

					SetIcon(icon,k,1)				
					RunConsoleCommand("Plant",k)

				end)
		  
			end 
			
			if (Fireable[k] != nil) then
		  
				itemmenu:AddOption("Make campfire of " .. GetIName(k),function()

					if ( plydata.inventory["tinderbox"] != nil and plydata.inventory["tinderbox"] > 0) then 
				
					SetIcon(icon,k,1)
					
					end
					
					RunConsoleCommand("DA_Firemaking",k)

				end)
		  
			end
		
			if (Sweps[k] != nil) then
				
				itemmenu:AddOption("Equip " .. GetIName(k),function()

					RunConsoleCommand("DA_UseSwep",k)				
				
				end)
				
			end
			
			if (Potions[k] != nil) then

				itemmenu:AddOption("Drink " .. GetIName(k),function()

					SetIcon(icon,k,1)
					RunConsoleCommand("DrinkPotion",k)				
				
				end)
			
			end		
			
			-- if (Armors[k] != nil) then

				-- itemmenu:AddOption("Wear " .. GetIName(k),function()

					-- SetIcon(icon,k,1)
					-- RunConsoleCommand("WearArmor",k)				
				
				-- end)
			
			-- end	
		
		itemmenu:AddOption("Link " .. GetIName(k),function() RunConsoleCommand("DA_LinkItem",k,plydata.inventory[k]) end )	
		itemmenu:Open()
		
		end
		
		ItemList:AddItem(icon)

	end

end

end

function SetIcon(icon,k,v)

	if (plydata.inventory[k] > v) then
	  
	plydata.inventory[k] = plydata.inventory[k] - v
	plydata.iweight = plydata.iweight - GetIWeight(k) * v
	icon:SetToolTip(plydata.inventory[k] .. " " .. GetIName(k))

	else

	ItemList:RemoveItem(icon) 
	
	end

end
net.Receive("inventorymenu",InventoryMenu)
