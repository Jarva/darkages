function Cl_MagicMenu()

	local data = net.ReadTable()

	plydata.spellbar = data.spellbar
	plydata.magics = data.magics
	
	if (plydata.magics == nil) then plydata.magics = {} end
	if (plydata.spellbar == nil) then plydata.spellbar = {} end

	local Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW() / 2 - 300,ScrH() / 2 - 200)
	Menu:SetSize(600, 400)
	Menu:SetTitle("Spellbook")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(true)
	Menu:SetVisible(true)
	Menu:MakePopup()

	local MagicList = vgui.Create( "DPanelList",Menu )
	MagicList:EnableVerticalScrollbar( true )
	MagicList:EnableHorizontal( false )
	MagicList:SetSpacing( 5 )
	MagicList:SetPadding( 5 )
	MagicList:SetPos(10,30)
	MagicList:SetSize(580,320)

	for k,v in pairs(plydata.magics) do
		
		local MPanel = vgui.Create("DPanel")
		MPanel:SetTall(70)
		MPanel:SetBackgroundColor(Color(60,60,60,255))
		
		local Spell = vgui.Create("DLabel",MPanel)
		Spell:SetText("LvL " .. v .. " " .. Magic[k].name)
		Spell:SetFont("KnightM")
		Spell:SetPos(10,5)
		Spell:SetSize(200,20)
		
		local Cooldown = vgui.Create("DLabel",MPanel)
		Cooldown:SetText("Cooldown " .. Magic[k].cd[v])
		Cooldown:SetFont("AdventureS")
		Cooldown:SetPos(10,25)
		Cooldown:SetSize(200,20)
		
		local Amount = vgui.Create("DLabel",MPanel)
		if (Buffs[k] == nil) then
			Amount:SetText("Amount " .. Magic[k].effect[v])
		else
			Amount:SetText("Amount " .. Magic[k].effect[v] .. " x " .. Buffs[k].times)
		end
		Amount:SetFont("AdventureS")
		Amount:SetPos(10,45)
		Amount:SetSize(200,20)
		
		local p = 0
		
		for x,y in pairs(Magic[k].runes) do
		
		local ricon = vgui.Create( "SpawnIcon", MPanel )
		ricon:SetModel( GetIModel(x),GetISkin(x) )
		ricon:SetSize(40,40)
		ricon:SetPos(220 + p,15)
		ricon:SetToolTip( y .. " " .. GetIName(x) )
		
		p = p + 50
		
		end
		
		
		local Function = vgui.Create("DButton",MPanel)
		Function:SetPos(440,20)
		Function:SetSize(100,30)
		Function.DoClick = function()			
		
			if (!table.HasValue(plydata.spellbar,k)) then
				RunConsoleCommand("AddToSpellBar",k)	
				Function:SetText("Remove")
				plydata.spellbar[tostring(table.Count(plydata.spellbar) + 1)] = k
			else
				
				local n = tonumber(GetKey(plydata.spellbar,k))
				
				for i=1,table.Count(plydata.spellbar) do
				
					if (i == n) then plydata.spellbar[tostring(i)] = nil end					
					if (i > n) then
					plydata.spellbar[tostring(i-1)] = plydata.spellbar[tostring(i)]
					plydata.spellbar[tostring(i)] = nil
					end
				
				end
				
				RunConsoleCommand("RemoveFromSpellBar",n)	
				Function:SetText("Add")
				
			end
		
		end	
		

		if (!table.HasValue(plydata.spellbar,k)) then Function:SetText("Add") else Function:SetText("Remove") end

		
		MagicList:AddItem(MPanel)

	end

end
net.Receive("spellmenu",Cl_MagicMenu)

function GetKey(array,value)

	for k,v in pairs(array) do

	if (v == value) then return k end

	end

end