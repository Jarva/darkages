include('shared.lua')

function StandBuy(header,id,encoded,data)

local ply = data.name

stand = data.stand
price = data.price

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW()/2 - 250,ScrH()/2 - 150)
Menu:SetSize(500, 300)
Menu:SetTitle(ply .. "'s Stand")
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

Stand = vgui.Create( "DPanelList" , Menu)
Stand:EnableVerticalScrollbar( true ) 
Stand:EnableHorizontal( true ) 
Stand:SetSpacing( 5 ) 
Stand:SetPadding( 5 )
Stand:SetPos(20,40)
Stand:SetSize(460,220)

	for k,v in pairs(stand) do

	local model = GetIModel(k)
	local skin = GetISkin(k)	
	
	local icon = vgui.Create( "SpawnIcon" )
	icon:SetModel( model,skin )
	icon:SetIconSize( 50, 50 )
	icon:SetSize(50,50)
	icon:SetPos(0,0)
	icon:SetToolTip(v .. " "..GetIName(k) .. " - Price : " .. price[k])
	icon.DoClick = function()
		
		local itemmenu = DermaMenu()
		
		for x,y in pairs(Amounts) do
				
				if (y == "All") then y = stand[k] end
			
				if (y <= stand[k] and plydata.iweight + GetIWeight(k) * y <= plydata.icapacity and price[k] * y <= plydata.inventory.gold) then
			
				itemmenu:AddOption("Buy " .. y .. " " .. GetIName(k),function()  
								
					SetSIcon(icon,k,y)
					RunConsoleCommand("BuyStand",k,y)

				end )
				
			end
		
		end
		
		itemmenu:Open()
	
	end
	
	Stand:AddItem(icon)

end
	
end
net.Receive("standbuy",StandBuy)

function SetSIcon(icon,k,y) 

	if (y == stand[k]) then			
		Stand:RemoveItem(icon)				
	else				
		icon:SetToolTip(stand[k] - y .. " " .. GetIName(k))				
	end

	stand[k] = stand[k] - y
end