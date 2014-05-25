include( 'shared.lua' )
include( 'char.lua' )
include( 'hud.lua' )
include( 'skillhud.lua' )
include( 'mainmenu.lua' )
include( 'cl_shop.lua' )
include( 'cl_bank.lua' )
include( 'cl_chat.lua' )
include( 'cl_society.lua' )
include( 'skills/cl_smithing.lua' )
include( 'skills/cl_cooking.lua' )
include( 'skills/cl_alchemy.lua' )
include( 'skills/cl_crafting.lua' )
include( 'skills/cl_fishing.lua' )
include( 'skills/cl_runecrafting.lua' )
include( 'trade/cl_trade.lua' )
include( 'bghud.lua' )
include( "cl_stand.lua" )
include( "cl_clan.lua" )
include( "cl_magic.lua" )
include( "cl_stance.lua" )
include( "cl_magicmenu.lua" )
include( "admin/cl_init.lua" )
include( "help/cl_init.lua" )
include( "panels.lua" )
include( "menus/cl_menu.lua" )
include( "magic/cl_magichud.lua" )

include('map/cl_map.lua')

Exist = {}

function findBySteamID(steam)

	for k,v in pairs(player.GetAll()) do
		
		if (v:SteamID() == steam) then
		
			return v
		
		end
	
	end

end

ChatBoxShow = false

function ChatOpen(TeamSay)
ChatBoxShow = true
end
hook.Add("StartChat", "ChatOpen", ChatOpen)

function ChatClose()
ChatBoxShow = false
end
hook.Add("FinishChat", "ChatClose", ChatClose)

function GetIModel(item)

	if (DropModels[item] == nil) then
	model = "models/medieval/sack.mdl"
	else
		model = DropModels[item]
	end
	
	return model

end

function GetISkin(item)

	skin = 0

	if (DropSkins[item] != nil) then
	skin = DropSkins[item]
	end
	
	return skin

end

function GM:Think()

	if (input.IsKeyDown( KEY_F ) and ChatBoxShow == false) then

	if (IsTorchOn == nil or IsTorchOn == false) then
		IsTorchOn = true 
		RunConsoleCommand("DA_Torch",1)
	end
	
	local dlight = DynamicLight(LocalPlayer():EntIndex())
	dlight.Pos = LocalPlayer():GetPos()+Vector(0,0,60)+(LocalPlayer():GetForward()*10)
	dlight.r = 225
	dlight.g = 90
	dlight.b = 0
	dlight.Brightness = 1
	dlight.Decay = 2000
	dlight.Size = math.random(255,265)
	dlight.DieTime = CurTime() + 1
	
	else
	
		if (IsTorchOn == nil or IsTorchOn == true) then
			IsTorchOn = false 
			RunConsoleCommand("DA_Torch",0)		
		end
		
		for k,v in pairs(player.GetAll()) do
		
			if (v != LocalPlayer() and v:GetNWBool("torch")) then
			
				local dlight = DynamicLight(v:EntIndex())
				dlight.Pos = v:GetPos()+Vector(0,0,60)+(v:GetForward()*10)
				dlight.r = 225
				dlight.g = 90
				dlight.b = 0
				dlight.Brightness = 1
				dlight.Decay = 2000
				dlight.Size = math.random(255,265)
				dlight.DieTime = CurTime() + 1
			
			end
		
		end
	
	end

end

function ClanData()

local data = net.ReadTable()

clans = {}
clans = data

end
net.Receive("clans",ClanData)

function InventoryData()

local data = net.ReadTable()

plydata.iweight = data.weight
plydata.inventory = data.inventory

end
net.Receive("inventory",InventoryData)

function SkillData()

local data = net.ReadTable()

plydata.skills = data

end
net.Receive("skill",SkillData)


-- function GM:PostPlayerDraw(ply)

	-- for k,self in pairs(ents.GetAll()) do

		-- if (self:GetClass() == "da_armor") then
			-- local owner = self:GetNWEntity("clowner")

			-- if owner == LocalPlayer() then return end
			-- if self:GetNWString("armor") == nil then return end

			-- local abone = ArmorBones[Armors[self:GetNWString("armor")]["armor"]]
			-- local bone = owner:GetBoneMatrix(owner:LookupBone(abone))

			-- self:SetPos(bone:GetTranslation()+Vector(0,0,Armors[self:GetNWString("armor")]["z"]))
			-- self:SetRenderOrigin(bone:GetTranslation()+Vector(0,0,Armors[self:GetNWString("armor")]["z"]))
			-- self:SetRenderAngles(bone:GetAngle())
			-- self:DrawModel()

		-- end

	-- end

-- end

function Cl_LinkItem(data)

local name = data:ReadString()
local item = data:ReadString()
local amount = tonumber(data:ReadShort())

chat.AddText(Color(0,128,255),"[LINK]" .. name .. " : " .. amount .. " " .. GetIName(item))

end
usermessage.Hook("linkitem",Cl_LinkItem)

function ClanChat(data)

	local name = data:ReadString()
	local text = data:ReadString()

	chat.AddText(Color(0,200,0),"[Clan]" .. name .. " : " .. text )

end
usermessage.Hook("clanchat",ClanChat)

function Cl_TradeRequest(data)

chat.AddText(Color(160,100,255),data:ReadString() )

end
usermessage.Hook("traderequest",Cl_TradeRequest)

function Cl_Reset(data)

local Main = vgui.Create("DFrame")
Main:SetPos(ScrW() / 2-200,ScrH() / 2-50)
Main:SetSize(400,100)
Main:SetTitle("Main Menu")
Main:SetDraggable(true)
Main:ShowCloseButton(true)
Main:SetVisible(true)
Main:MakePopup()

local Question = vgui.Create("DLabel",Main)
Question:SetText("Would you like to delete your character")
Question:SetPos(20,40)
Question:SizeToContents()
Question:SetFont("Default")

local Yes = vgui.Create("DButton", Main)
Yes:SetPos(50,70)
Yes:SetSize(100,20)
Yes:SetText("Yes")
Yes.DoClick = function()

	RunConsoleCommand("DA_ResetCharacter")		
	Main:Close()
	
	qtracks = {}
	stracks = {}
	
	local x = {}
	x.qtracks = qtracks
	x.stracks = stracks

	file.Write("darkages/settings.txt",util.TableToKeyValues(x))

end

local No = vgui.Create("DButton", Main)
No:SetPos(250,70)
No:SetSize(100,20)
No:SetText("No")
No.DoClick = function()
		
	Main:Close()

end


end
usermessage.Hook("reset",Cl_Reset)

function Cl_PrivMSG(data)

	local name = data:ReadString()
	local text = data:ReadString()
	
	chat.AddText(Color(160,160,220,255),name .. " : " .. text)

end
usermessage.Hook("privmsg",Cl_PrivMSG)

function Cl_PrivSent(data)

local name = data:ReadString()
local text = data:ReadString()

chat.AddText(Color(160,160,220,255),"PM To : " .. name .. " : " .. text)

end
usermessage.Hook("privsent",Cl_PrivSent)

-- InvIcon = {}

-- function InvIcon:PaintOver()

-- draw.SimpleText(self.Amount, "Default", 48, 48, Color(255, 255, 255, 255),2,2)

-- end

-- function InvIcon:SetAmount(amount)

-- self.Amount = amount

-- end
-- vgui.Register("InvIcon", InvIcon, "SpawnIcon")

