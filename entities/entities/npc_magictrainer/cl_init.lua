function Cl_MagicMenu()

local data = net.ReadTable()

if (data == nil) then data = {} end

plydata.magics = data

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 2 - 300,ScrH() / 2 - 300)
Menu:SetSize(600, 400)
Menu:SetTitle("Magic Trainer")
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()

local Magics = vgui.Create( "DPanelList",Menu )
Magics:EnableVerticalScrollbar( true )
Magics:EnableHorizontal( false )
Magics:SetSpacing( 5 )
Magics:SetPadding( 5 )
Magics:SetPos(10,30)
Magics:SetSize(580,360)

local function ListMagics()

local magiclist = {}
local i = 1

for k,v in pairs(Magic) do

	for l = 1,table.Count(Magic[k].lvls) do

		if (plydata.magics[k] == nil or plydata.magics[k] < l ) then
		
			magiclist[i] = l .. "," .. k
			
			i = i + 1

		end
	
	end

end

for x = 1,table.Count(magiclist) - 1 do

	for y = 1,table.Count(magiclist) - 1 do

	local m1 = string.Explode(",",magiclist[y])
	local m2 = string.Explode(",",magiclist[y+1])
	
	local magic1 = m1[2]
	local magic2 = m2[2]
	local lvl1 = tonumber(m1[1])
	local lvl2 = tonumber(m2[1])
	
	if (Magic[magic1].lvls[lvl1] > Magic[magic2].lvls[lvl2]) then
	
		local z = magiclist[y]
		magiclist[y] = magiclist[y+1]
		magiclist[y+1] = z
		
		end

	end

end

	for i = 1,table.Count(magiclist) do

		local m = string.Explode(",",magiclist[i])
		local magic = m[2]
		local lvl = tonumber(m[1])

		local Panel = vgui.Create("DPanel")
		Panel:SetSize(570,80)

		local Name = vgui.Create("DLabel",Panel)
		Name:SetPos(10,5)
		Name:SetText( Magic[magic].name .. " lvl " .. lvl .. " - Intellect : " .. Magic[magic].lvls[lvl] .. " | CD : " .. Magic[magic].cd[lvl])
		Name:SetWidth(550)
		Name:SetTall(20)
		Name:SetFont("ChatFont")

		local gicon = vgui.Create( "SpawnIcon", Panel )
		gicon:SetModel( GetIModel("gold") )
		gicon:SetSize(50,50)
		gicon:SetPos(10,25)
		gicon:SetToolTip( Magic[magic].gold[lvl] .. " Gold" )

		local gold = vgui.Create( "DLabel" , Panel )
		gold:SetText( Magic[magic].gold[lvl] .. " Gold" )
		gold:SetPos(70,25)
		gold:SetFont("BudgetLabel")
		gold:SetWidth(200)
		gold:SetTall(50)
		
		local p = 0
		
		for x,y in pairs(Magic[magic].runes) do		
		
		local ricon = vgui.Create( "SpawnIcon", Panel )
		ricon:SetModel( GetIModel(x),GetISkin(x) )
		ricon:SetSize(50,50)
		ricon:SetPos(200 + p,25)
		ricon:SetToolTip( y .. " " .. GetIName(x) )
		
		p = p + 50
		
		end
	
		Learn = vgui.Create("DButton", Panel)
		Learn:SetPos(450,35)
		Learn:SetSize(100,25)
		Learn:SetText("Learn")
		Learn.DoClick = function()
				
		RunConsoleCommand("LearnMagic",magic,lvl)
		plydata.magics[magic] = lvl 
		plydata.inventory.gold = plydata.inventory.gold - Magic[magic].gold[lvl]
		Magics:Clear()
		ListMagics()
		
		end
		
		if (Magic[magic].gold[lvl] > plydata.inventory.gold or plydata.skills.intellect < Magic[magic].lvls[lvl]) then
				
		Learn:SetDisabled(true)
		
		end
		
		Magics:AddItem(Panel)

	end
	
end

ListMagics()

end
net.Receive("magictrainer",Cl_MagicMenu)

