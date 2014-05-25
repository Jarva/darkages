include("cl_skills.lua")
include("cl_inventory.lua")
include("cl_achievements.lua")
include("cl_quests.lua")
include("cl_spellbook.lua")

include("panels.lua")

QuickMenuShow = false
QuickMenuMouse = false
QuickFuncUsed = false

Quickfuncs = {}

function AddQuickFunc(func,name)

	local x = table.Count(Quickfuncs)+1

	Quickfuncs[x] = {}
	Quickfuncs[x].func = func
	Quickfuncs[x].name = name

end

AddQuickFunc(function() StandMenu() end ,"Market Stand")
AddQuickFunc(function() InviteToTrade() end ,"Trade")

Botfuncs = {}

function AddBotQuickFunc(icon,name,func)

	local x = table.Count(Botfuncs) + 1

	Botfuncs[x] = {}
	Botfuncs[x].func = func
	Botfuncs[x].icon = icon
	Botfuncs[x].name = name

end

AddBotQuickFunc("gui/menu/inventory","Inventory","menu_inventory")
AddBotQuickFunc("gui/menu/map","Map","menu_map")
AddBotQuickFunc("gui/menu/achievement","Achievement","menu_achi")
AddBotQuickFunc("gui/menu/skill","Skill","menu_skills")

AddBotQuickFunc("gui/menu/stand","Stand","menu_stand")
AddBotQuickFunc("gui/menu/quest","Quests","menu_quest")
AddBotQuickFunc("gui/menu/spellbook","Spellbook","menu_spell")
AddBotQuickFunc("gui/menu/skill","Skill","menu_skills")

local icons = table.Count(Botfuncs)

local MIcons = {}
local QIcons = {}

for I=1,icons do

	local width = icons * 64
	local start = width/2

	MIcons[I] = vgui.Create("MenuIcon")
	MIcons[I]:SetSize(64,64)
	MIcons[I]:SetPos(ScrW()/2 - start + ((I-1) * 64),ScrH() - 64)
	MIcons[I]:SetTexture(Botfuncs[I].icon)
	MIcons[I]:SetFunc(Botfuncs[I].func)


end

function InviteToTrade()

	RunConsoleCommand("invitetotrade")
	print("GOING TWICE LOL 2.0")

end


-- hook.Add("HUDPaint","QuickMenu",QuickMenu)


function QuickMenuShowHide()

	if(input.IsKeyDown(KEY_C) and !QuickMenuShow) then
		QuickMenuShow = true 
		gui.EnableScreenClicker( true )

		local icons = table.Count(Quickfuncs)

		for I=1,icons do

			QIcons[I] = vgui.Create("QMenuIcon")
			QIcons[I]:SetSize(200,25)
			QIcons[I]:SetPos(200,100+(I-1)*30)
			QIcons[I]:SetFunc(Quickfuncs[I].func)
			QIcons[I]:SetName(Quickfuncs[I].name)

		end

	end
	
	if (!input.IsKeyDown(KEY_C) and QuickMenuShow) then
		QuickMenuShow = false
		gui.EnableScreenClicker( false )

		local icons = table.Count(Quickfuncs)

		for I=1,icons do

			QIcons[I]:Remove()

		end

	end
	
end
hook.Add("Think","QuickMenuShowHide",QuickMenuShowHide)

-- function QuickMenu()

-- 	if (QuickMenuShow) then

-- 		local x, y = gui.MousePos()
-- 		y = y - 100
-- 		x = x - 200

-- 		for a=1,table.Count(Quickfuncs) do			
		
-- 			if (y > (a-1)*30 and y < (a*30)-5 and x >= 0 and x <= 200) then			

-- 				surface.SetDrawColor(255,255,255,255)					
-- 				surface.SetTexture(surface.GetTextureID("gui/menu/quickmenu_background"))
-- 				surface.DrawTexturedRect(200,100+(a-1)*30,200,25)

-- 				draw.SimpleText(Quickfuncs[a].name,"AdventureM",300,110+(a-1)*30,Color(255,255,255,255),1,1)

-- 				if (!QuickFuncUsed) then

-- 				Quickfuncs[a].func()				
-- 				QuickFuncUsed = true
				
-- 				end	
			
-- 			else
				
-- 				surface.SetDrawColor(255,255,255,200)					
-- 				surface.SetTexture(surface.GetTextureID("gui/menu/quickmenu_background"))
-- 				surface.DrawTexturedRect(200,100+(a-1)*30,200,25)

-- 				draw.SimpleText(Quickfuncs[a].name,"Adventure",300,110+(a-1)*30,Color(255,255,255,255),1,1)	
			
-- 			end
		
-- 		end

-- 	end

-- end