function MainMenu( )

local data = net.ReadTable()

plydata = data
  
if (plydata.tokens == nil) then plydata.tokens = {} end 
 
Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW() / 2-300,ScrH() / 2-250)
Menu:SetSize(600, 500)
Menu:SetTitle("Main Menu")
Menu:SetDraggable(true)
Menu:ShowCloseButton(true)
Menu:SetVisible(true)
Menu:MakePopup()
  
local Menu2 = vgui.Create( "DPanelList" )
Menu2:EnableVerticalScrollbar( true )
Menu2:EnableHorizontal( false )
Menu2:SetSpacing( 5 )
Menu2:SetPadding( 10 )
Menu2:SetPos(10,10)
Menu2:SetSize(200,ScrH() / 2-50)
  
local Menu3 = vgui.Create( "DPanelList" )
Menu3:EnableVerticalScrollbar( true )
Menu3:EnableHorizontal( true )
Menu3:SetSpacing( 5 )
Menu3:SetPadding( 10 )
Menu3:SetPos(10,10)
Menu3:SetSize(200,ScrH() / 2-50)

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
	
	Menu3:AddItem(icon)
	  
	end
	
end

function SetIcon(icon,k,v)

	if (plydata.inventory[k] > v) then
	  
	plydata.inventory[k] = plydata.inventory[k] - v
	plydata.iweight = plydata.iweight - GetIWeight(k) * v
	icon:SetToolTip(plydata.inventory[k] .. " " .. GetIName(k))

	else

	Menu3:RemoveItem(icon) 
	
	end

end

local SkillP = {}
local SkillT = {}
  
for k,v in pairs(Skills) do

SkillP[v] = vgui.Create("DPanel")
SkillP[v]:SetSize(200,50)

SkillN = vgui.Create("DLabel",SkillP[v])
SkillN:SetPos(5,5)
SkillN:SetText(GetIName(v) .. " - Level : " ..plydata.skills[v])
SkillN:SetFont("Default")
SkillN:SizeToContents()

SkillN = vgui.Create("DLabel",SkillP[v])
SkillN:SetPos(5,25)
SkillN:SetText(plydata.skills[v.."xp"] .. " / " .. LevelXP[plydata.skills[v]])
SkillN:SetFont("TargetIDSmall")
SkillN:SizeToContents()

SkillT[v] = vgui.Create("DButton", SkillP[v])
SkillT[v]:SetPos(ScrW()/4,5)
SkillT[v]:SetSize(60,40)

if (stracks != nil and stracks[v] != nil) then
	SkillT[v]:SetText("Untrack")
else
	SkillT[v]:SetText("Track")
end

SkillT[v].DoClick = function()

	if (stracks == nil) then stracks = {} end
	
	if (stracks[v] == nil) then
		SkillT[v]:SetText("Untrack")
		stracks[v] = "Tracks"
	else
		SkillT[v]:SetText("Track")
		stracks[v] = nil
	end
	
	ClQuestSave()

end



Menu2:AddItem(SkillP[v])

end

local TokenMenu = vgui.Create( "DPanelList" )
TokenMenu:EnableVerticalScrollbar( true )
TokenMenu:EnableHorizontal( false )
TokenMenu:SetSpacing( 5 )
TokenMenu:SetPadding( 10 )
TokenMenu:SetPos(10,10)
TokenMenu:SetSize(580,360)

for k,v in pairs(plydata.tokens) do

	local TPanel = vgui.Create("DPanel")
	TPanel:SetSize(560,60)
	
	TName = vgui.Create("DLabel",TPanel)
	TName:SetPos(10,10)
	TName:SetText(Tokens[k])
	TName:SetFont("Default")
	TName:SizeToContents()

	TAmount = vgui.Create("DLabel",TPanel)
	TAmount:SetPos(10,30)
	TAmount:SetText("Amount : " .. v)
	TAmount:SetFont("TargetIDSmall")
	TAmount:SizeToContents()
	
	TokenMenu:AddItem(TPanel)

end

local StatMenu = vgui.Create( "DPanelList" )
StatMenu:EnableVerticalScrollbar( true )
StatMenu:EnableHorizontal( false )
StatMenu:SetSpacing( 5 )
StatMenu:SetPadding( 10 )
StatMenu:SetPos(10,10)
StatMenu:SetSize(580,360)

if (plydata.stats == nil) then plydata.stats = {} end

for k,v in pairs(plydata.stats) do

	if (Stats[k] != nil) then

		StatL = vgui.Create("DLabel")
		StatL:SetPos(10,10)
		StatL:SetText(Stats[k] .. " : " .. v)
		StatL:SetFont("TargetID")
		StatL:SizeToContents()

		StatMenu:AddItem(StatL)

	end

end

local AchiMenu = vgui.Create( "DPanelList" )
AchiMenu:EnableVerticalScrollbar( true )
AchiMenu:EnableHorizontal( false )
AchiMenu:SetSpacing( 5 )
AchiMenu:SetPadding( 10 )
AchiMenu:SetPos(10,10)
AchiMenu:SetSize(580,360)

if (plydata.achievements == nil) then plydata.achievements = {} end

for k,v in pairs(Achievements) do

	local stat = 0	
	if (plydata.stats[Achievements[k].stat] != nil) then stat = plydata.stats[Achievements[k].stat] end

	local AcMenu = vgui.Create("DPanel")
	AcMenu:SetSize(560,60)
	AcMenu:SetBackgroundColor(Color(60,60,60,255))
	
	AcName = vgui.Create("DLabel",AcMenu)
	AcName:SetPos(10,10)
	if (plydata.achievements[k] == nil) then AcName:SetText(Achievements[k].name) else AcName:SetText(Achievements[k].name .. " [COMPLETED]") end
	AcName:SetFont("Default")
	AcName:SizeToContents()

	AcProg = vgui.Create("DLabel",AcMenu)
	AcProg:SetPos(10,30)
	AcProg:SetText(Stats[Achievements[k].stat] .. " : " .. stat .. " / " .. Achievements[k].amount)
	AcProg:SetFont("TargetIDSmall")
	AcProg:SizeToContents()
	
	AchiMenu:AddItem(AcMenu)

end
  
MenuSheet = vgui.Create( "DPropertySheet" )
MenuSheet:SetParent( Menu )
MenuSheet:SetPos(10,25)
MenuSheet:SetSize(600,500)

MenuSheet:AddSheet( "Inventory",Menu3,"gui/silkicons/user",false,false,"Inventory")
MenuSheet:AddSheet( "Skills",Menu2,"gui/silkicons/user",false,false,"Skills")
MenuSheet:AddSheet( "Tokens",TokenMenu,"gui/silkicons/user",false,false,"Tokens")
MenuSheet:AddSheet( "Stats",StatMenu,"gui/silkicons/user",false,false,"Stats")
MenuSheet:AddSheet( "Achievements",AchiMenu,"gui/silkicons/user",false,false,"Achievements")

end  
net.Receive("mainmenu",MainMenu)