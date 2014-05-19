function Cl_Trade(name)

function AddTrade(k,v)


		print("don't!")

		local model = GetIModel(k)
		local skin = GetISkin(k)

		icon["trade_" .. k] = vgui.Create( "SpawnIcon" )
		icon["trade_" .. k]:SetModel( model,skin )
		icon["trade_" .. k]:SetSize(50,50)
		icon["trade_" .. k]:SetPos(0,0)
		icon["trade_" .. k]:SetToolTip(v .. " "..GetIName(k))
		icon["trade_" .. k].DoClick = function()
				
			local itemmenu = DermaMenu()
				
			for x,y in pairs(Amounts) do
					
						if (y == "All") then y = trade[k] end
					
						if (y <= trade[k]) then
					
						itemmenu:AddOption("Remove " .. y .. " " .. GetIName(k),function()  
							
							if (y == trade[k]) then			
								Trade:RemoveItem(icon["trade_" .. k])				
							else				
								icon["trade_" .. k]:SetToolTip(trade[k] - y .. " " .. GetIName(k))				
							end
							
							trade[k] = trade[k] - y
							
							if (inventory[k] > 0) then				
								icon["invt_" .. k]:SetToolTip((inventory[k] + y) .. " " .. GetIName(k))	
							else				
								AddInventory(k,y)				
							end
							
							inventory[k] = inventory[k] + y
							
							DeAccept()
							CheckTradeSlot()
							
							RunConsoleCommand("DA_TradeChange",k,-y)

						end )
						
					end
				
				end

			itemmenu:Open()

		end

		print("no idea!")
		PrintTable(icon)

		Trade:AddItem(icon["trade_" .. k])


end

function AddMate(k,v)

		local model = GetIModel(k)
		local skin = GetISkin(k)

		icon["mate_" .. k] = vgui.Create( "SpawnIcon" )
		icon["mate_" .. k]:SetModel( model,skin )
		icon["mate_" .. k]:SetSize(50,50)
		icon["mate_" .. k]:SetPos(0,0)
		icon["mate_" .. k]:SetToolTip(v .. " "..GetIName(k))

		Mate:AddItem(icon["mate_" .. k])

	end

function DeAccept()

Accepted:SetText(LocalPlayer():Nick() .. " :")
Accepted:SizeToContents()
accepted = 0

MAccepted:SetText(matename .. " :")
MAccepted:SizeToContents()
maccepted = 0

AcceptB:SetDisabled(false)

end

function CheckTradeSlot()

	local x = 0
	local y = 0

	for k,v in pairs(trade) do

		x = x + GetIWeight(k) * v

	end

	for k,v in pairs(mate) do

		y = y + GetIWeight(k) * v

	end

	if (plydata.iweight - x + y > plydata.icapacity) then
		AcceptB:SetDisabled(true)
	else
		AcceptB:SetDisabled(false)
	end

end

function TradeFinish()

	local data = {}
	data.trade = {}
	data.mate = {}

	for k,v in pairs(trade) do

		data.trade[k] = v

	end

	for k,v in pairs(mate) do

		data.mate[k] = v

	end
	
	net.Start("tradefinish")
		net.WriteTable(data)
	net.SendToServer()
	
	chat.AddText(Color(0,255,0),"The trade has been accepted")
	
	print("DE REMOVAL OF THE MENU SHOULD BE HERE")

	Menu:Remove()

end

function Cl_TradeChange(data)

	local k = data:ReadString()
	local v = data:ReadShort()

	if (mate[k] == nil) then mate[k] = 0 end

		if (v < 0) then

			if (mate[k] + v == 0) then
			
			-- print("-----------------------------\n")
			-- print("--MATE SHIT--")
			-- print(Mate)
			-- print("--MATE_K--")
			-- print("mate_" .. k)
			-- print("--ICON TABLE--")
			-- PrintTable(icon)
			-- print("---------------")
			-- print("--ICON OF MATE_K--")
			-- print(icon["mate_" .. k])
			-- print("-----------------------------\n")
			Mate:RemoveItem(icon["mate_" .. k])
			icon["mate_" .. k] = nil
			
			end

		else

			if (mate[k] == 0) then
			
				AddMate(k,v)
				
			else
			
				icon["mate_" .. k]:SetToolTip(mate[k] + v .. " "..GetIName(k))
				
			end
		
		end
		
	DeAccept()
	CheckTradeSlot()

	mate[k] = mate[k] + v

end
usermessage.Hook("tradechange",Cl_TradeChange)
function MateAccepted()

	maccepted = 1

	print(accepted)

	if (accepted == 1) then 
		TradeFinish() 
		print("SEE? ACCEPTED")
	end

	if (accepted == 0) then

		MAccepted:SetText(matename .. " : Accepted")
		MAccepted:SetTextColor(Color(0,255,0,255))
		MAccepted:SizeToContents()

	end

end
usermessage.Hook("mateaccepted",MateAccepted)
function TradeDeclined()

chat.AddText(Color(255,0,0),"The trade has been declined")
Menu:Remove()

end
usermessage.Hook("tradedeclined",TradeDeclined)

function AddInventory(k,v)

local model = GetIModel(k)
local skin = GetISkin(k)

icon["invt_" .. k] = vgui.Create( "SpawnIcon" )
icon["invt_" .. k]:SetModel( model,skin )
icon["invt_" .. k]:SetSize(50,50)
icon["invt_" .. k]:SetPos(0,0)
icon["invt_" .. k]:SetToolTip(v .. " "..GetIName(k))
icon["invt_" .. k].DoClick = function()
	
	local itemmenu = DermaMenu()
	
	for x,y in pairs(Amounts) do
			
			if (y == "All") then y = inventory[k] end
		
			if (y <= inventory[k]) then
		
			itemmenu:AddOption("Add " .. y .. " " .. GetIName(k),function()  
							
				if (y == inventory[k]) then			
					Inventory:RemoveItem(icon["invt_" .. k])				
				else				
					icon["invt_" .. k]:SetToolTip(inventory[k] - y .. " " .. GetIName(k))				
				end
				
				inventory[k] = inventory[k] - y
				
				if (trade[k] > 0) then				
					icon["trade_" .. k]:SetToolTip(trade[k] + y .. " " .. GetIName(k))	
				else				
					AddTrade(k,y)				
				end
				
				trade[k] = trade[k] + y
				
				DeAccept()
				CheckTradeSlot()

				RunConsoleCommand("da_tradechange",k,y)

			end )
			
		end
	
	end
	
	itemmenu:Open()

end

Inventory:AddItem(icon["invt_" .. k])

end

	accepted = 0
	maccepted = 0

	inventory = {}
	trade = {}
	mate = {}
	icon = {}	
	for k,v in pairs(plydata.inventory) do inventory[k] = v	end	
	for k,v in pairs(inventory) do trade[k] = 0	end
	
	Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW() /2 - 300,ScrH() / 2-200)
	Menu:SetSize(600, 400)
	Menu:SetTitle("Trading with " ..  name)
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(false)
	Menu:SetVisible(true)
	Menu:MakePopup()

	InvPanel = vgui.Create("DPanel", Menu)
	InvPanel:SetPos(20,30)
	InvPanel:SetSize(180,280)
	InvPanel:SetBackgroundColor(Color(90,90,90,255))

	TradePanel = vgui.Create("DPanel", Menu)
	TradePanel:SetPos(210,30)
	TradePanel:SetSize(180,280)
	TradePanel:SetBackgroundColor(Color(90,90,90,255))

	MatePanel = vgui.Create("DPanel", Menu)
	MatePanel:SetPos(400,30)
	MatePanel:SetSize(180,280)
	MatePanel:SetBackgroundColor(Color(90,90,90,255))

	Inventory = vgui.Create( "DPanelList", InvPanel )
	Inventory:EnableVerticalScrollbar( true )
	Inventory:EnableHorizontal( true )
	Inventory:SetSpacing( 5 )
	Inventory:SetPadding( 5 )
	Inventory:SetPos(0,0)
	Inventory:SetSize(180,280)

	Trade = vgui.Create( "DPanelList", TradePanel )
	Trade:EnableVerticalScrollbar( true )
	Trade:EnableHorizontal( true )
	Trade:SetSpacing( 5 )
	Trade:SetPadding( 5 )
	Trade:SetPos(210,30)
	Trade:SetSize(180,280)

	Mate = vgui.Create( "DPanelList", MatePanel )
	Mate:EnableVerticalScrollbar( true )
	Mate:EnableHorizontal( true )
	Mate:SetSpacing( 5 )
	Mate:SetPadding( 5 )
	Mate:SetPos(400,30)
	Mate:SetSize(180,280)

	for k,v in pairs(inventory) do

		if (v > 0 and k != "amount" and k != "capacity") then


		AddInventory(k,v)
			
		
		end

	end
	
	AcceptB = vgui.Create("DButton", Menu)
	AcceptB:SetPos(390,330)
	AcceptB:SetSize(90,25)
	AcceptB:SetText("Accept")
	AcceptB.DoClick = function()
	
	Accepted:SetText(LocalPlayer():Nick() .. " : Accepted")
	Accepted:SetTextColor(Color(0,255,0,255))
	Accepted:SizeToContents()
	accepted = 1
	
	AcceptB:SetDisabled(true)
	
	RunConsoleCommand("tradeaccepted")
	if (maccepted == 1 and accepted == 1) then TradeFinish() end
	
	end
	
	DeclineB = vgui.Create("DButton", Menu)
	DeclineB:SetPos(500,330)
	DeclineB:SetSize(90,25)
	DeclineB:SetText("Decline")
	DeclineB.DoClick = function()
	
	Menu:Remove()
	RunConsoleCommand("tradedeclined")
	
	end
	
	Accepted = vgui.Create("DLabel",Menu)
	Accepted:SetPos(20,330)
	Accepted:SetText(LocalPlayer():Nick() .. " :")
	Accepted:SetFont("AdventureM")
	Accepted:SizeToContents()
	
	MAccepted = vgui.Create("DLabel",Menu)
	MAccepted:SetPos(20,360)
	MAccepted:SetText(name .. " :")
	MAccepted:SetFont("AdventureM")
	MAccepted:SizeToContents()


end

function Cl_TradeStart(data)

matename = data:ReadEntity():Nick()
Cl_Trade(matename)

end
usermessage.Hook("tradestart",Cl_TradeStart)