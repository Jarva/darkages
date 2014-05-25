function StandMenu()

	timer.Create("standrange",0.1,0,function() 

		local em = ParticleEmitter(StandCenter)

		for i=1,10 do

			local temp = math.random(1,360)

			local part = em:Add("sprites/light_glow02_add",StandCenter+Vector( math.sin(math.rad(temp)) * 128,math.cos(math.rad(temp)) * 128,10) )

			if part then
				part:SetColor(255,255,255,255)
				part:SetVelocity(Vector(0,0,math.random(1,3)))
				part:SetDieTime(2)
				part:SetLifeTime(0)
				part:SetStartSize(4)
				part:SetEndSize(1)
			end

		end			

		em:Finish()	

	end)
	timer.Stop("standrange")

	inventory = {}
	stand = {}
	icon = {}
	price = {}

	for k,v in pairs(plydata.inventory) do

	inventory[k] = v

	end

	for k,v in pairs(inventory) do

	stand[k] = 0

	end
	
	for k,v in pairs(inventory) do

	price[k] = 0

	end
	
	local function AddStand(k,v)

	local model = GetIModel(k)
	local skin = GetISkin(k)

	icon["stand_" .. k] = vgui.Create( "SpawnIcon" )
	icon["stand_" .. k]:SetModel( model,skin )
	icon["stand_" .. k]:SetSize(50,50)
	icon["stand_" .. k]:SetPos(0,0)
	icon["stand_" .. k]:SetToolTip(v .. " "..GetIName(k) .. " - Price : " .. price[k])
	icon["stand_" .. k].DoClick = function()

	local itemmenu = DermaMenu()
	
	for x,y in pairs(Amounts) do
			
			if (y == "All") then y = stand[k] end
		
			if (y <= stand[k]) then
		
			itemmenu:AddOption("Remove " .. y .. " " .. GetIName(k),function()  
							
				if (y == stand[k]) then			
					Stand:RemoveItem(icon["stand_" .. k])				
				else				
					icon["stand_" .. k]:SetToolTip(stand[k] - y .. " " .. GetIName(k))				
				end
				
				stand[k] = stand[k] - y
				
				if (inventory[k] > 0) then				
					icon["inv_" .. k]:SetToolTip(inventory[k] + y .. " " .. GetIName(k))	
				else				
					AddInventory(k,y)				
				end
				
				inventory[k] = inventory[k] + y

			end )
			
		end
	
	end
	
	itemmenu:Open()
	
	end
	
	Stand:AddItem(icon["stand_" .. k])
	
end
	
local function SetPrice(k,v)

	local PriceM = vgui.Create("DFrame")
	PriceM:SetPos(ScrW()/2 - 120,ScrH()/2 - 100)
	PriceM:SetSize(240, 200)
	PriceM:SetTitle("Set price of " .. GetIName(k))
	PriceM:SetDraggable(true)
	PriceM:ShowCloseButton(true)
	PriceM:SetVisible(true)
	PriceM:MakePopup()

	local Amount = vgui.Create( "DNumSlider", PriceM )
	Amount:SetPos( 20,40 )
	Amount:SetWide( 200 )
	Amount:SetText( "Amount" )
	Amount:SetMin( 1 )
	Amount:SetValue( 1 )
	Amount:SetMax( v )
	Amount:SetDecimals( 0 )
	
	local PriceL = vgui.Create("DLabel" , PriceM)
	PriceL:SetPos(20,80)
	PriceL:SetText("Price")
	PriceL:SetFont("BudgetLabel")
	PriceL:SizeToContents()

	local Price = vgui.Create("DTextEntry", PriceM)
	Price:SetText(1)
	Price:SetPos(20,100)
	Price:SetSize(200,20)

	Add = vgui.Create("DButton", PriceM)
	Add:SetPos(40,140)
	Add:SetSize(160,25)
	Add:SetText("Add " .. GetIName(k))
	Add.DoClick = function()

		local iprice = tonumber(Price:GetValue())
		local y = Amount:GetValue()
	
		if (iprice == nil or iprice == 0) then iprice = 1 end
	
		price[k] = iprice
		
		if (y == inventory[k]) then			
			Inventory:RemoveItem(icon["inv_" .. k])				
		else				
			icon["inv_" .. k]:SetToolTip(inventory[k] - y .. " " .. GetIName(k))				
		end
		
		inventory[k] = inventory[k] - y
		
		if (stand[k] > 0) then				
			icon["stand_" .. k]:SetToolTip(stand[k] + y .. " " .. GetIName(k) .. " - Price : " .. iprice)	
		else				
			AddStand(k,y)				
		end
		
		stand[k] = stand[k] + y
		
		PriceM:Close()
	
	end

end

net.Receive("standbuild",StandMenu)
	
local function AddInventory(k,v)

	local model = GetIModel(k)
	local skin = GetISkin(k)

	icon["inv_" .. k] = vgui.Create( "SpawnIcon" )
	icon["inv_" .. k]:SetModel( model,skin )
	icon["inv_" .. k]:SetSize(50,50)
	icon["inv_" .. k]:SetPos(0,0)
	icon["inv_" .. k]:SetToolTip(v .. " "..GetIName(k))
	icon["inv_" .. k].DoClick = function()

	local itemmenu = DermaMenu()
	
	itemmenu:AddOption("Add " .. GetIName(k),function()  
						
	SetPrice(k,inventory[k])

	end )
	
	itemmenu:Open()
	
	end

	Inventory:AddItem(icon["inv_" .. k])	
	
end

Menu = vgui.Create("DFrame")
Menu:SetPos(ScrW()/2 - 250,ScrH()/2 - 200)
Menu:SetSize(500, 400)
Menu:SetTitle("Stand Set Menu")
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
Inventory:SetSize(235,300)

Stand = vgui.Create( "DPanelList" , Menu)
Stand:EnableVerticalScrollbar( true ) 
Stand:EnableHorizontal( true ) 
Stand:SetSpacing( 5 ) 
Stand:SetPadding( 5 )
Stand:SetPos(255,30)
Stand:SetSize(235,300)

Text = vgui.Create("DTextEntry", Menu)
Text:SetText("Selling goods")
Text:SetPos(10,340)
Text:SetSize(480,20)
Text.OnTextChanged = function()

	local x = GetLength(Text:GetValue())
			
	if (x >= 100) then
		Text:SetText(string.sub(Text:GetValue(),1,100))
	end

end

Next = vgui.Create("DButton", Menu)
Next:SetPos(190,370)
Next:SetSize(120,20)
Next:SetText("Next")
Next.DoClick = function()
	
	local data = {}
	data.stand = {}
	data.price = {}
	data.text = Text:GetValue()

	for k,v in pairs(stand) do

		if (v > 0) then
			data.stand[k] = v
		end

	end

	for k,v in pairs(price) do
		if (v > 0) then
			data.price[k] = v
		end
	end

	
	StandBuildMenu(data)
	Menu:Close()

end

for k,v in pairs(inventory) do

	if (v > 0) then


	AddInventory(k,v)
		
	
	end

end	

end

function StandBuildMenu(data)

	local builds = {}

	if (file.Exists("darkages/standbuilds.txt","DATA")) then

		builds = util.KeyValuesToTable(file.Read("darkages/standbuilds.txt","DATA"))

	end

	BMenu = vgui.Create("DFrame")
	BMenu:SetPos(ScrW()/2 - 250,ScrH()/2 - 200)
	BMenu:SetSize(500, 400)
	BMenu:SetTitle("Build stand")
	BMenu:SetDraggable(true)
	BMenu:ShowCloseButton(true)
	BMenu:SetVisible(true)
	BMenu:MakePopup()


	BuildList = vgui.Create( "DPanelList", BMenu )
	BuildList:SetPos( 310,30 )
	BuildList:SetSize( 180, 360 )
	BuildList:SetPadding( 5 ) 
	BuildList:SetSpacing( 5 ) 
	BuildList:EnableHorizontal( false )
	BuildList:EnableVerticalScrollbar( true )

	for k,v in pairs(builds) do
	
		local BuildPanel = vgui.Create( "DPanel" )
		BuildPanel:SetSize( 170, 30 )

		local BName = vgui.Create("DLabel", BuildPanel)
		BName:SetPos(10,10)
		BName:SetFont("DungeonS")
		BName:SetText(builds[k].name)
		BName:SizeToContents()

		local BLoad = vgui.Create( "DButton", BuildPanel )
		BLoad:SetSize( 60, 20 )
		BLoad:SetPos( 110, 5 )
		BLoad:SetText( "Load" )
		BLoad.DoClick = function()

			StandLoadBuilding = true
			StandLoadBuild = k
			StandData = data	
			StandLoadBuilds = builds

			for b = 1,4 do

				b = tostring(b)

				StandCLModels[b] = ClientsideModel(builds[k].models[b].model,RENDERGROUP_BOTH)

			end

			StandCenter = LocalPlayer():GetPos()
			BMenu:Close()		

			timer.Start("standrange")

		end

		BuildList:AddItem(BuildPanel)
	
	end

	local BBuild = vgui.Create( "DButton", BMenu )
	BBuild:SetSize( 200, 25 )
	BBuild:SetPos( 50, 365 )
	BBuild:SetText( "Create Buildup" )
	BBuild.DoClick = function()

		BMenu:Close()
		StandIsBuilding = true
		StandCenter = LocalPlayer():GetPos()
		StandData = data

		timer.Start("standrange")
		
	end

	local BExample = vgui.Create( "DModelPanel", BMenu )
	BExample:SetModel( "models/darkages/scenery/marketstand01.mdl" )
	BExample:SetPos( 10, 65 )
	BExample:SetSize( 290, 290 )
	BExample:SetCamPos( Vector( 130, 130, 80 ) )
	BExample:SetLookAt( Vector( 0, 0, 0 ) )

	local BLabel = vgui.Create("DLabel", BMenu)
	BLabel:SetPos(10,30)
	BLabel:SetColor(Color(255,255,255,255))
	BLabel:SetFont("Default")
	BLabel:SetText("This is just an example")
	BLabel:SizeToContents()

end


function StandUmsg()

	StandMenu()

end
usermessage.Hook("standmenu",StandUmsg)

function StandRemoveMenu()

	local Menu = vgui.Create("DFrame")
	Menu:SetPos(ScrW()/2 - 150,ScrH() - 200)
	Menu:SetSize(300, 80)
	Menu:SetTitle("")
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(false)
	Menu:SetVisible(true)
	Menu:MakePopup()
	
	local Remove = vgui.Create("DButton", Menu)
	Remove:SetPos(40,40)
	Remove:SetSize(220,20)
	Remove:SetText("Remove Stand")
	Remove.DoClick = function()
	
		Menu:Remove()
		RunConsoleCommand("RemoveStandMenu")
	
	end

end
usermessage.Hook("standremovemenu",StandRemoveMenu)

StandIsBuilding = false
StandActivePart = 1
StandLClicked = false
StandLMouse = false
StandRClicked = false
StandRMouse = false
StandCenter = Vector(0,0,0)
StandData = {}
StandBModel = 1
StandCLModels = {}

function StandMouseSetup()

	if (input.IsMouseDown(MOUSE_LEFT) and !StandLMouse) then StandLMouse = true end
	if (input.IsMouseDown(MOUSE_RIGHT) and !StandRMouse) then StandRMouse = true end

	if (!input.IsMouseDown(MOUSE_LEFT) and StandLMouse) then StandLMouse = false StandLClicked = false end
	if (!input.IsMouseDown(MOUSE_RIGHT) and StandRMouse) then StandRMouse = false StandRClicked = false end

end
hook.Add("Think","StandMouseSetup",StandMouseSetup)

function StandBuilding()

if (!StandIsBuilding) then return end

self = LocalPlayer()


if (table.Count(StandCLModels) < StandActivePart) then 

	StandCLModels[StandActivePart] = ClientsideModel(StandParts[StandBModel].model,RENDERGROUP_BOTH)

end

local dist = self:GetEyeTrace().HitPos:Distance(StandCenter)

print(dist)

print(StandCLModels[StandActivePart])

if (dist < 128) then StandCLModels[StandActivePart]:SetColor(255,255,255,220);print("we are good"); else print("can't") end

StandCLModels[StandActivePart]:SetPos(self:GetEyeTrace().HitPos)
StandCLModels[StandActivePart]:SetAngles(Angle(0,self:GetAngles().y,0))

if (StandRMouse) then
	if (!StandRClicked) then

		if (StandBModel < table.Count(StandParts)) then StandBModel = StandBModel + 1 else StandBModel = 1 end
		StandCLModels[StandActivePart]:SetModel(StandParts[StandBModel].model)
		StandRClicked = true

	end
end

if (StandLMouse) then
	if (!StandLClicked) then

		local dist = self:GetEyeTrace().HitPos:Distance(StandCenter)

		if (dist < 128) then 

			local data = {}
			data.model = StandParts[StandBModel].model
			data.pos = self:GetEyeTrace().HitPos
			data.ang = Angle(0,self:GetAngles().y,0)

			net.Start("spawnstandprop")
				net.WriteTable(data)
			net.SendToServer()


			StandActivePart = StandActivePart + 1

		else

			HudPrint("Can't spawn here")

		end

		StandLClicked = true

	end
end

if (StandActivePart > 4) then

	timer.Stop("standrange")

	NMenu = vgui.Create("DFrame")
	NMenu:SetPos(ScrW()/2 - 150,ScrH()/2 - 40)
	NMenu:SetSize(300, 80)
	NMenu:SetTitle("Save as")
	NMenu:SetDraggable(true)
	NMenu:ShowCloseButton(false)
	NMenu:SetVisible(true)
	NMenu:MakePopup()

	local NName = vgui.Create("TextEntry", NMenu)
	NName:SetSize(200,20) 
	NName:SetPos(10,50)

	local NLabel = vgui.Create("DLabel", NMenu)
	NLabel:SetPos(10,30)
	NLabel:SetColor(Color(255,255,255,255))
	NLabel:SetFont("Default")
	NLabel:SetText("Enter a name to save the stand as")
	NLabel:SizeToContents()

	local NSave = vgui.Create( "DButton", NMenu )
	NSave:SetSize( 70, 20 )
	NSave:SetPos( 220, 50 )
	NSave:SetText( "Save" )
	NSave.DoClick = function()


		local builds = {}

		if (file.Exists("darkages/standbuilds.txt","DATA")) then

			builds = util.KeyValuesToTable(file.Read("darkages/standbuilds.txt","DATA"))

		end

		local id = string.gsub(string.lower(NName:GetValue())," ","")

		builds[id] = {}
		builds[id].name = NName:GetValue()
		builds[id].models = {}

		for I=1,4 do
			builds[id].models[I] = {}
			builds[id].models[I].pos = tostring(StandCLModels[I]:GetPos() - LocalPlayer():GetPos())
			builds[id].models[I].ang = tostring(StandCLModels[I]:GetAngles())

			local V1 = StandCLModels[I]:GetPos() - LocalPlayer():GetPos()
			local alpha = math.deg(math.atan2(V1.x,V1.y))

			builds[id].models[I].posang = alpha

			builds[id].models[I].model = StandCLModels[I]:GetModel()

			StandCLModels[I]:Remove()
		end

		file.Write("darkages/standbuilds.txt",util.TableToKeyValues(builds))

		local data = {}
		data = StandData

		net.Start("standsetup")
			net.WriteTable(data)
		net.SendToServer()

		StandCLModels = {}

		NMenu:Close()
		
	end

	StandIsBuilding = false

end

end
hook.Add("Think","StandBuilding",StandBuilding)

function StandBuildingHUD()

if (!StandIsBuilding) then return end

local active = 0

if (StandActivePart < 5) then active = StandActivePart else active = 4 end

draw.RoundedBox(40,ScrW()/2-250,-45,500,90,Color(0,0,0,200))
draw.SimpleText("Left click to SPAWN","Fairy",ScrW()/2-240,10,Color(255,255,255,255),0,0)	
draw.SimpleText("Right click to CHANGE","Fairy",ScrW()/2+240,10,Color(255,255,255,255),2,0)	
draw.SimpleText(StandParts[StandBModel].name,"Fairy",ScrW()/2,5,Color(255,255,255,255),1,0)	
draw.SimpleText("4 / " .. active,"FairyM",ScrW()/2,20,Color(255,255,255,255),1,0)	

end
hook.Add("HUDPaint","StandBuildingHUD",StandBuildingHUD)

StandLoadBuilding = false
StandLoadBuild = ""
StandLoadBuilds = {}

function StandLBuilding()

	if (!StandLoadBuilding) then return end

	local self = LocalPlayer()

	for b = 1,4 do

		b = tostring(b)

		local localpos = stringToVector(StandLoadBuilds[StandLoadBuild].models[b].pos)
		local localang = stringToAngle(StandLoadBuilds[StandLoadBuild].models[b].ang)		
		local posang = StandLoadBuilds[StandLoadBuild].models[b].posang

		local dist = Vector(0,0,0):Distance(localpos)
		local ang =  math.rad(posang)

		local x = math.sin(ang) * dist
		local y = math.cos(ang) * dist

		StandCLModels[b]:SetPos(self:GetPos() + Vector(x,y,0))
		StandCLModels[b]:SetAngles(Angle(0,localang.y,0))

		local disabled = false

		for i=1,4 do
			if (StandCLModels[tostring(i)]:GetPos():Distance(StandCenter) > 128) then
				disabled = true
				break
			end
		end

		if (disabled) then
			-- StandCLModels[b]:SetColor(255,0,0,200)
		else
			StandCLModels[b]:SetColor(255,255,255,200)
		end

	end

	if (StandLMouse) then
		if (!StandLClicked) then

			for s = 1,4 do

				s = tostring(s)

				local data = {}
				data.model = StandLoadBuilds[StandLoadBuild].models[s].model
				data.pos = self:GetPos() + stringToVector(StandLoadBuilds[StandLoadBuild].models[s].pos)
				data.ang = stringToAngle(StandLoadBuilds[StandLoadBuild].models[s].ang)

				net.Start("spawnstandprop")
					net.WriteTable(data)
				net.SendToServer()

				StandCLModels[s]:Remove()
			
			end

				net.Start("standsetup")
					net.WriteTable(StandData)
				net.SendToServer()


			StandLClicked = true

			StandLoadBuilding = false
			StandCLModels = {}
			timer.Stop("standrange")

		end
	end

end
hook.Add("Think","StandLBuilding",StandLBuilding)





//----------------------------------
//STANDBUY
//----------------------------------





function StandBuy()

local data = net.ReadTable()

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
