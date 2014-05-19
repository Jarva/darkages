include( 'shared.lua' ) 

function Cl_TVendor()

local data = net.ReadTable()

if (data.tokens == nil) then data.tokens = {} end

plydata.tokens = {}
for k,v in pairs(data.tokens) do
	plydata.tokens[k] = v
end

local id = data.id

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 2 - 300,ScrH() / 2 - 200)
Menu:SetSize(600,400)
Menu:SetTitle(TVendors[id]["name"])
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

Goods = vgui.Create( "DPanelList" , Menu)
Goods:EnableVerticalScrollbar( true ) 
Goods:EnableHorizontal( true ) 
Goods:SetSpacing( 5 ) 
Goods:SetPadding( 5 )
Goods:SetPos(25,50)
Goods:SetSize(550,300)

	for k,v in pairs(TVendors[id]["goods"]) do

	local model = GetIModel(k)
	local skin = GetISkin(k)

	local token = TVendors[id]["goods"][k]["token"]
	local price = TVendors[id]["goods"][k]["price"]
	local plytoken = 0
	
	if (plydata.tokens[token] != nil) then plytoken = plydata.tokens[token] end
	
	icon = vgui.Create( "SpawnIcon" )
	icon:SetModel( model,skin )
	icon:SetSize(50,50)
	icon:SetPos(0,0)
	icon:SetToolTip(GetIName(k) .. " - " .. price .. " " .. Tokens[token])
	icon.DoClick = function()

		if (plytoken >= price) then
	
		plydata.tokens[token] = plydata.tokens[token] - price
		RunConsoleCommand("DA_BuyTVendor",token,price,k)
		
		end
	
	end
	
	Goods:AddItem(icon)

	end

end
net.Receive("tvendor",Cl_TVendor)