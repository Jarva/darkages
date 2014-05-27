AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "char.lua" )
AddCSLuaFile( "hud.lua" )
AddCSLuaFile( "skillhud.lua" )
AddCSLuaFile( "mainmenu.lua" )
AddCSLuaFile( "cl_shop.lua" )
AddCSLuaFile( "cl_bank.lua" )
AddCSLuaFile( "skills/cl_smithing.lua" )
AddCSLuaFile( "skills/cl_cooking.lua" )
AddCSLuaFile( "skills/cl_alchemy.lua" )
AddCSLuaFile( "skills/cl_crafting.lua" )
AddCSLuaFile( "skills/cl_fishing.lua" )
AddCSLuaFile( "skills/cl_runecrafting.lua" )
AddCSLuaFile( "trade/cl_trade.lua" )
AddCSLuaFile( "cl_chat.lua" )
AddCSLuaFile( "cl_society.lua" )
AddCSLuaFile( "bghud.lua" )
AddCSLuaFile( "cl_stand.lua" )
AddCSLuaFile( "cl_clan.lua" )
AddCSLuaFile( "cl_magic.lua" )
AddCSLuaFile( "cl_stance.lua" )
AddCSLuaFile( "cl_magicmenu.lua" )
AddCSLuaFile( "admin/cl_init.lua" )
AddCSLuaFile( "help/cl_init.lua" )
AddCSLuaFile( "panels.lua" )
AddCSLuaFile( "menus/cl_menu.lua" )
AddCSLuaFile( "magic/cl_magichud.lua" )

include( 'shared.lua' )
include( 'skills.lua' )
include( 'resources.lua' )
include( 'stamina.lua' )
include( 'shops.lua' )
include( 'bank.lua' )
include( 'npcs.lua' )
include( 'society.lua' )
include( 'skills/smithing.lua' )
include( 'skills/cooking.lua' )
include( 'skills/farming.lua' )
include( 'skills/mining.lua' )
include( 'skills/woodcutting.lua' )
include( 'skills/alchemy.lua' )
include( 'skills/crafting.lua' )
include( 'skills/fishing.lua' )
include( 'skills/runecrafting.lua' )
include( 'skills/firemaking.lua' )
include( 'trade/trade.lua' )
include( 'drop.lua' )
include( "stand.lua" )
include( "clan.lua" )
include( "magic.lua" )
include( "buffs.lua" )
include( "potions.lua" )
include( "damage.lua" )
include( "admin/init.lua" )
include( "help/init.lua" )
include( "menus/menu.lua")

include( "map/map.lua" )

resource.AddFile( "resource/fonts/fairydustb.ttf" )
resource.AddFile( "resource/fonts/blackcastle.ttf" )
resource.AddFile( "resource/fonts/plain black.ttf" )
resource.AddFile( "resource/fonts/blackletter.ttf" )
resource.AddFile( "resource/fonts/zenda.ttf" )
resource.AddFile( "resource/fonts/dungeon.ttf" )

util.AddNetworkString( "huddata" ) 
util.AddNetworkString( "helptexts" ) 
util.AddNetworkString( "mainmenu" ) 
util.AddNetworkString( "questtalk" )
util.AddNetworkString( "tvendor" )
util.AddNetworkString( "questmenu" )
util.AddNetworkString( "magicmenu" )
util.AddNetworkString( "magictrainer" )
util.AddNetworkString( "clanbank" )
util.AddNetworkString( "bank" )
util.AddNetworkString( "questtasks" )
util.AddNetworkString( "bgdata" )
util.AddNetworkString( "magicmenu" )
util.AddNetworkString( "inventory" )
util.AddNetworkString( "skill" )
util.AddNetworkString( "quest" )
util.AddNetworkString( "clans" )
util.AddNetworkString( "friends" )
util.AddNetworkString( "standbuy" )

util.AddNetworkString( "standsetup" )
util.AddNetworkString( "spawnstandprop" )
util.AddNetworkString( "da_dropitem" )
util.AddNetworkString( "tradefinish" )

-- function AddFiles(dir)

-- local directories = {}
-- directories = file.FindDir("../models/" .. dir .. "/*")

	-- if (table.Count(directories) > 0) then

		-- for k,v in pairs(directories) do
		
		-- AddFiles(dir .. "/" .. k)
		
		-- end

	-- end
	
	-- for k,v in pairs(file.Find("../models/" .. dir .. "/*.mdl")) do
	
	-- print("models/" .. dir .. "/" .. v)
	-- resource.AddFile("models/" .. dir .. "/" .. v)

	-- end
		
-- end

-- for k,v in pairs(file.FindDir("../models/*")) do

-- AddFiles(v)

-- end


file.CreateDir("darkages")
file.CreateDir("darkages/Save")

CreateConVar( "da_rates", 1 )

function char_set(ply, cmd, args)

	local model = args[1]

	ply.data.model = model

	file.Write("darkages/Save/"..ply:UniqueID()..".txt",util.TableToKeyValues(ply.data))
	
	ply:Spawn()

end

function WeaponSpawn(ply)

	if (ply.data.inventory[ply.data.weapon] > 0) then

		ply:Give(ply.data.weapon)
		ply:GetActiveWeapon():SetNWEntity("owner",ply)
		
	else
	
		ply:Give("hands")
	
	end
	
end
hook.Add("PlayerSpawn","WeaponSpawn",WeaponSpawn)

function CBSpawn(ply)

		if (IsOnBG(ply)) then
		
		ply.data.cbzone = 1
		
		else
		
		ply.data.cbzone = 0
		
		end

end
hook.Add("PlayerSpawn","CBSpawn",CBSpawn)

function Spawn(ply)

ply:SetHealth(ply.data.skills.hitpoints*10)
ply:SetNWInt("hitpoints",ply.data.skills.hitpoints*10)

end
hook.Add("PlayerSpawn","Spawn",Spawn)

function GM:PlayerDeath(ply)

	timer.Stop(ply:UniqueID().."healthdown")
	timer.Stop(ply:UniqueID().."thirst")
	timer.Stop(ply:UniqueID().."hunger")
	timer.Stop(ply:UniqueID().."stathp")
	timer.Stop(ply:UniqueID().."stamina_down")
	timer.Stop(ply:UniqueID().."stamina_up")
	timer.Stop(ply:UniqueID().."oxygen")
	
end

function GM:PlayerDisconnected(ply)

	timer.Stop(ply:UniqueID().."healthdown")
	timer.Stop(ply:UniqueID().."thirst")
	timer.Stop(ply:UniqueID().."hunger")
	timer.Stop(ply:UniqueID().."stathp")
	timer.Stop(ply:UniqueID().."stamina_down")
	timer.Stop(ply:UniqueID().."stamina_up")
	timer.Stop(ply:UniqueID().."oxygen")
	timer.Stop("save_" .. ply:UniqueID())
	
	file.Write("darkages/Save/"..ply:UniqueID()..".txt",util.TableToKeyValues(ply.data))
	
end

concommand.Add("char_set",char_set)

function SetBaseStats(ply)

	if (ply.data.thirst == nil) then ply.data.thirst = 100 end
	if (ply.data.hunger == nil) then ply.data.hunger = 100 end

	ply:SetNWFloat("thirst",ply.data.thirst)
	ply:SetNWFloat("hunger",ply.data.hunger)
	
end
hook.Add("PlayerSpawn","SetBaseStats",SetBaseStats)

function DeathBaseStats(ply)

if (ply.data.hunger == 0) then ply.data.hunger = 100 end
if (ply.data.thirst == 0) then ply.data.thirst = 100 end

end
hook.Add("PlayerDeath","DeathBaseStats",DeathBaseStats)


function DA_Spawn(ply)

timer.Create(ply:UniqueID().."stathp",1,0,function()

	if (ply.data.thirst == 0 or ply.data.hunger == 0 or ply.Oxygen == 0) then

		local HealthRand = math.random(1,5)

		if (ply:Health()-HealthRand > 0) then
			ply:TakeDamage(HealthRand,ply,ply)
		else
			ply:TakeDamage(ply:Health(),ply,ply)
		end
		
	end

end)
	
	--Thirst
	timer.Create(ply:UniqueID().."thirst",76,0,function()		
		
		local ThirstRand = math.round(math.Rand(0,1),2)
		
		if (ply.data.thirst-ThirstRand > 0) then ply.data.thirst = ply.data.thirst - ThirstRand else ply.data.thirst = 0 end
		ply:SetNWFloat("thirst",ply.data.thirst)
	
	end)	
	timer.Start(ply:UniqueID().."thirst")
	
	--Hunger
	
	timer.Create(ply:UniqueID().."hunger",88,0,function()

		local HungerRand = math.round(math.Rand(0,1),2)
		
		if (ply.data.hunger-HungerRand > 0) then ply.data.hunger = ply.data.hunger - HungerRand else ply.data.hunger = 0 end	
		ply:SetNWFloat("hunger",ply.data.hunger)
	
	end)
	timer.Start(ply:UniqueID().."hunger")
	

end

hook.Add("PlayerSpawn","Spawnhook",DA_Spawn)

function DA_Underwater()

	for k,ply in pairs(player.GetAll()) do

		if (ply:WaterLevel() == 3) then
		
			if (ply.Oxygen == 100) then
			
				ply.Oxygen = 99
				ply:SetNWInt("oxygen",99)
			
				timer.Create(ply:UniqueID().."oxygen",0.5,0,function()

					if (ply.Oxygen > 0) then ply.Oxygen = ply.Oxygen - 1 else ply.Oxygen = 0 end					
					ply:SetNWInt("oxygen",ply.Oxygen)
				
				end)				
				timer.Start(ply:UniqueID().."oxygen")
			
			end
		
		else
			
			if (ply.Oxygen != nil and ply.Oxygen < 100) then
			
			ply.Oxygen = 100
			ply:SetNWInt("oxygen",100)
			timer.Stop(ply:UniqueID().."oxygen")
			
			end
		
		end

	end

end
hook.Add("Think","DA_Underwater",DA_Underwater)

function GiveXP(ply,skill,xp)

local rate = GetConVarNumber( "da_rates" )
local exp = math.Round(xp * rate)

	

	if (ply.data.skills[skill .. "xp"] == nil) then
		print("Error : non existed skill : " .. skill)
		return
	end
	
	if (ply.data.skills[skill .. "xp"] + exp > LevelXP[99]) then
		ply.data.skills[skill .. "xp"] = LevelXP[99]
		return 
	end

	if (PlayerHasClanUpgrade(ply,"10xp")) then exp = math.Round(exp * 1.1) end
	
	ply.data.skills[skill .. "xp"] = ply.data.skills[skill .. "xp"] + exp
	AddToStat(ply,"xp",exp)

	while (ply.data.skills[skill .. "xp"] >= LevelXP[ply.data.skills[skill]]) do

		if (ply.data.skills[skill] < 99) then
	
		LvlUP(ply,skill)
		
		end
	
	end
	net.Start("skill")
		net.WriteTable(ply.data.skills)
	net.Send(ply)

if (exp > 1) then HudText(ply,"You have gained " .. xp .. " " .. skill .. " xp") end

end

function GiveRes(ply,item,amount,show)

	local amount = tonumber(amount)

	if (ply.data.inventory[item] == nil) then ply.data.inventory[item] = 0 end

	if (amount < 0 and ply.data.inventory[item] + amount == 0 and item == ply.data.weapon) then 
	
		ply:StripWeapons()
		ply:Give("hands")
	
	end

	ply.data.inventory[item] = ply.data.inventory[item] + amount
	
	ply.data.iweight = tonumber(ply.data.iweight + GetIWeight(item)*amount)
	
	ply:SetWalkSpeed(210 - ply.data.iweight * 2)

	local data = {}
	data.weight = ply.data.iweight
	data.inventory = ply.data.inventory

	net.Start("inventory")
		net.WriteTable(data)
	net.Send(ply)

	if (show == nil) then show = true end
	
	if (amount > 0 and show == true) then

		HudText(ply,"You have earned " .. amount .. " " .. GetIName(item))

	end

end

function GiveBank(ply,item,amount)

	if (ply.data.bank[item] == nil) then	
		ply.data.bank[item] = amount	
	else
		ply.data.bank[item] = ply.data.bank[item] + amount
	end

	ply.data.bweight = math.round(tonumber(ply.data.bweight) + tonumber(GetIWeight(item))*tonumber(amount),5)
		
end

function GiveToken(ply,token,amount)

if (ply.data.tokens == nil) then ply.data.tokens = {} end
if (ply.data.tokens[token] == nil) then ply.data.tokens[token] = 0 end

ply.data.tokens[token] = ply.data.tokens[token] + amount

end

function IsInventoryFull(ply)

if (ply.data.icapacity == ply.data.iweight) then return true else return false end

end

function RestoreHealth(ply,amount)

local max = ply.data.skills.hitpoints * 10

if (ply:Health() + amount > max) then ply:SetHealth(max) else ply:SetHealth(ply:Health() + amount) end

end

function RestoreHunger(ply,amount)

if (ply.data.hunger + amount > 100) then ply.data.hunger = 100 else ply.data.hunger = ply.data.hunger + amount end

ply:SetNWFloat("hunger",ply.data.hunger)

end

function RestoreThirst(ply,amount)

if (ply.data.thirst + amount > 100) then ply.data.thirst = 100 else ply.data.thirst = ply.data.thirst + amount end

ply:SetNWFloat("thirst",ply.data.thirst)

end

function WaterSlow()

	for k,ply in pairs(player.GetAll()) do

		if (ply:WaterLevel() > 0) then

			ply:SetWalkSpeed( 210 - ply:WaterLevel() * 40 - ply.data.iweight * 2) 
			ply:SetRunSpeed( 290 - ply:WaterLevel() * 40 - ply.data.iweight * 2) 
			
			WBack = 1
			
		else
		
			if (WBack == 1) then
			
				ply:SetWalkSpeed( 210 - ply.data.iweight * 2) 
				ply:SetRunSpeed( 290 - ply.data.iweight * 2) 
				WBack = 0
				
			end

		end		

	end

end
hook.Add("Think","WSlow",WaterSlow)

function SetBaseOxygen(ply)

	local oxygen = 100

	ply.Oxygen = oxygen

	ply:SetNWInt("oxygen",oxygen)

end
hook.Add("PlayerSpawn","SetBaseOxygen",SetBaseOxygen)

--/////////////////
--Drinking & Eating
--/////////////////

function Drinking(ply,key)

	if (key == IN_USE ) then
			
		if (ply:WaterLevel() > 0 and ply:WaterLevel() < 3) then			
			
			ply:EmitSound("player/pl_scout_dodge_can_drink_fast.wav",300,65)
			
			local Drink = math.Rand(13,22)
			
			RestoreThirst(ply,Drink)
			
			ply:Freeze(true)
			
			umsg.Start("Action",ply)
			
			umsg.Short(1)
			umsg.String("Drinking")
			umsg.String("DA_Unfreeze")
		
			umsg.End()
			
			
			
		end
		
	end
	
end

hook.Add("KeyPress","Drinking",Drinking)

function HudText(ply, text)

	if (text != nil) then

	umsg.Start("hudtext",ply)
	umsg.String(text)
	umsg.End()

	end

end

function findBySteamID(steam)

	for k,v in pairs(player.GetAll()) do
		
		if (v:SteamID() == steam) then
		
			return v
		
		end
	
	end

end

function EnterArena(ply,cmd,args)

	local id = args[1]

	if (Arena[id].players[1] == "") then 

		Arena[id].players[1] = ply:SteamID()

	else

		Arena[id].players[2] = ply:SteamID()
		ArenaStart(id)

	end

end
concommand.Add("EnterArena",EnterArena)

function LeaveArena(ply,cmd,args)

	local id = args[1]
	
	if (Arena[id].players[1] == ply:SteamID()) then
		
		Arena[id].players[1] = ""		
		
	end

end
concommand.Add("LeaveArena",LeaveArena)

function ArenaStart(id)

	local spawners = {}

	for k,v in pairs(ents.GetAll()) do

		if (v:GetClass() == "da_arenaspawn") then

			if (v:GetNWString("arena") == id) then
			
			spawners[table.Count(spawners) + 1] = v
			
			end

		end

	end
	
	local i = 1
	
	for k,v in pairs(player.GetAll()) do
		
		for x,y in pairs(Arena[id].players) do
		
			if (v:SteamID() == y) then
			
				v:SetPos(spawners[i]:GetPos())
				v:SetAngles(spawners[i]:GetAngles())
				v.data.cbzone = 1
				v:SetCollisionGroup(COLLISION_GROUP_PLAYER)
				
				i = i + 1
			
			end
			
		end
	
	end
	
	Arena[id].status = "Action"

end

function ArenaDeath(ply)

	local id = ""
	local winner = ""
	local deathinarena = 0

	for k,v in pairs(Arena) do

		for x,y in pairs(v.players) do
		
			if (ply:SteamID() == y) then
			
			id = k
			if (x == 1) then winner = 2 else winner = 1 end
			
			deathinarena = 1
			
			end
		
		end

	end

	if (deathinarena == 0) then return end
	
	winner = findBySteamID(Arena[id].players[winner])
	
	GiveToken(winner,Arena[id].token,5)
	
	for k,v in pairs(ents.GetAll()) do
	
		if (v:GetClass() == "da_arenaend") then
			
			if (v:GetNWString("arena") == id) then
			
				winner:SetPos(v:GetPos())
				winner:SetCollisionGroup(COLLISION_GROUP_WORLD)
				winner.data.cbzone = 0
			
			end
		
		end
	
	end
	
	Arena[id].players[1] = ""	
	Arena[id].players[2] = ""
	Arena[id].status = "Queue"

end
hook.Add("PlayerDeath","ArenaDeath",ArenaDeath)

function DA_LinkItem(ply,cmd,args)

	local item = args[1]
	local amount = tonumber(args[2])

	for k,v in pairs(player.GetAll()) do

	umsg.Start("linkitem",v)
	umsg.String(ply:Nick())
	umsg.String(item)
	umsg.Short(amount)
	umsg.End()
	
	end

end
concommand.Add("DA_LinkItem",DA_LinkItem)

function IsInArena(ply)

	for k,v in pairs(Arena) do

		for x,y in pairs(v.players) do

			if (ply:SteamID() == y) then
			
				return true
				
			end

		end

	end
	
	return false

end

function IsOnBG(ply)

	for k,v in pairs(Battleground) do

		for x,y in pairs(v.players) do

			for a,b in pairs(y) do

				if (ply:SteamID() == b) then
				
					if (v.status == "Action") then return true end

				end
			
			end

		end

	end
	
	return false

end

function IsQueued(ply,bg)

	for x,y in pairs(Battleground[bg].players) do

		for a,b in pairs(y) do

			if (ply:SteamID() == b) then return true end
		
		end

	end
	
end

function GetBG(ply)

	for k,v in pairs(Battleground) do

		for x,y in pairs(v.players) do

			for a,b in pairs(y) do

				if (ply:SteamID() == b) then return k end
			
			end

		end

	end

end

function GetBGTeam(ply)

	for k,v in pairs(Battleground) do

		for x,y in pairs(v.players) do

			for a,b in pairs(y) do

				if (ply:SteamID() == b) then return x end
			
			end

		end

	end

end

function EnterBG(ply,cmd,args)

	local id = args[1]
	local a = ""
	
	for k,v in pairs(Battleground[id].players) do
		
		for x,y in pairs(v) do
	
			if (y == "") then
			
				a = ply:SteamID()
			
				Battleground[id].players[k][x] = a
				
				break
			
			end
		
		end
		
		if (a != "") then break end
	
	end	
	
	local full = 1
	
	for k,v in pairs(Battleground[id].players) do
		
		for x,y in pairs(v) do
	
			if (y == "") then
			
				full = 0
				break
			
			end
		
		end
		
		if (full == 0) then break end
	
	end	
	
	if (full == 1) then StartBG(id) end

end
concommand.Add("EnterBG",EnterBG)

function LeaveBG(ply,cmd,args)

	local id = args[1]
	local a = ply:SteamID()
	
	for k,v in pairs(Battleground[id].players) do
		
		for x,y in pairs(v) do
	
			if (y == a) then
			
				y = ""
				a = y
				
				Battleground[id].players[k][x] = y
				
				
				
				break
			
			end
		
		end
		
		if (a == "") then break end
	
	end	

end
concommand.Add("LeaveBG",LeaveBG)

function StartBG(id)

	for k,v in pairs(Battleground[id].players) do

		local spawn = findBGSpawn(id,k)
		
		for x,y in pairs(v) do
			
			local ply = findBySteamID(y)
			
			local range = spawn:GetNWInt("range") / 2
			local x = math.random(-range,range)
			local y = math.random(-range,range)
			
			ply:SetPos(spawn:GetPos() + Vector(x,y,0))
			ply:SetColor(BGTeams[GetBGTeam(ply)].color)
			ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)
			ply.data.cbzone = 1
			ply.respawntime = 0
			
		end
		
		local flag = ents.Create("da_flag")
		flag:SetNWString("team",k)
		flag:SetNWString("bg",id)
		flag:SetPos(spawn:GetPos())
		flag:Spawn()
	
	end
	
	local teams = ""
	
	for k,v in pairs(Battleground[id].players) do
	
	teams = teams .. k .. " "
	
	end
	
	for k,v in pairs(Battleground[id].players) do
	
		for x,y in pairs(v) do
		
		Battleground[id].kills[y] = 0
		Battleground[id].deaths[y] = 0
		
		local ply = findBySteamID(y)
		
		umsg.Start("bgteams",ply)
		umsg.String(teams)
		umsg.End()
		
		local data = {}
		
		data.kills = Battleground[id].kills
		data.deaths = Battleground[id].deaths
		data.players = Battleground[id].players
		
		net.Start("bgdata")
			net.WriteTable(data)
		net.Send(ply)
		
		end
		
	end
	
	timer.Create(id .. "_time",1,0,function()
	
	Battleground[id].time = Battleground[id].time + 1
	
		for k,v in pairs(Battleground[id].players) do
		
			for x,y in pairs(v) do
				
				local ply = findBySteamID(y)
				
				umsg.Start("bgtime",ply)
				umsg.Short(Battleground[id].time)
				umsg.String(id)
				umsg.End()
			
			end
		
		end
	
	end)
	
	Battleground[id].status = "Action"

end

function findBGSpawn(id,tid)

	for k,v in pairs(ents.GetAll()) do

		if (v:GetClass() == "da_bgspawn") then
		
			if (v:GetNWString("battleground") == id and v:GetNWString("team") == tid) then
			
			return v
			
			end
		
		end

	end

end

function GM:PlayerDeathThink(ply)

	if (IsOnBG(ply)) then
	
	if (ply.respawntime <= 0) then 
	
	ply:Spawn()
	
	end

	else

		if ( ply:KeyPressed( IN_ATTACK ) || ply:KeyPressed( IN_ATTACK2 )) then
		
			ply:Spawn()
			
		end

	end

end

function PlayerBGDeath(ply,ent,killer)

	if (IsOnBG(ply)) then

		local bg = GetBG(ply)

		ply.respawntime = 10

		timer.Create(ply:UniqueID() .. "respawn",1,0,function()

		ply.respawntime = ply.respawntime - 1
		umsg.Start("respawn",ply)
		umsg.Short(ply.respawntime)
		umsg.End()

		end)

		local bgteam = GetBGTeam(killer)
		
		Battleground[bg].kills[killer:SteamID()] = Battleground[bg].kills[killer:SteamID()] + 1		
		Battleground[bg].deaths[ply:SteamID()] = Battleground[bg].deaths[ply:SteamID()] + 1		
		
		
		for k,v in pairs(Battleground[bg].players) do
		
			for x,y in pairs(v) do
				
				local ply = findBySteamID(y)
				
				local data = {}
				
				data.kills = Battleground[bg].kills
				data.deaths = Battleground[bg].deaths
				data.players = Battleground[bg].players
				
				net.Start("bgdata")
					net.WriteTable(data)
				net.Send(ply)
			
			end
		
		end
		
		if (Battleground[bg].score[bgteam] == 50) then
		
		BGEnd(bg,bgteam)
		
		end
		
	end

end
hook.Add("PlayerDeath","PlayerBGDeath",PlayerBGDeath)

function PlayerBGSpawn(ply)

	if (IsOnBG(ply)) then

		local bg = GetBG(ply)
		local bgteam = GetBGTeam(ply)
		
		local spawn = findBGSpawn(bg,bgteam)
		local range = spawn:GetNWInt("range") / 2
		local x = math.random(-range,range)
		local y = math.random(-range,range)
		
		ply:SetPos(spawn:GetPos() + Vector(x,y,0))
		ply:SetColor(BGTeams[bgteam].color)
		ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)
		
		ply.spawnprotection = 1
		
		timer.Simple(1,function()
		ply.data.cbzone = 1
		end)
		
		timer.Simple(5,function()
		ply.spawnprotection = 0
		end)
			
	end
	
	timer.Stop(ply:UniqueID() .. "respawn")

end
hook.Add("PlayerSpawn","PlayerBGSpawn",PlayerBGSpawn)

function BGScore(bg,bgteam,score)

	Battleground[bg].score[bgteam] = Battleground[bg].score[bgteam] + score

	for k,v in pairs(Battleground[bg].players) do
			
		for x,y in pairs(v) do
			
			local ply = findBySteamID(y)
			
			umsg.Start("bgscore",ply)
			umsg.String(bgteam)
			umsg.End()

		end

	end

	if (Battleground[bg].score[bgteam] == Battleground[bg].sct) then BGEnd(bg,bgteam) end

end

function BGEnd(id,winner)

	for k,v in pairs(Battleground[id].players) do
	
		for x,y in pairs(v) do
		
		local ply = findBySteamID(y)
		Battleground[id].players[k][x] = ""
		Battleground[id].status = "Queue"
		
		ply:SetColor(Color(255,255,255,255))
		ply:Spawn()
		ply:SetCollisionGroup(COLLISION_GROUP_WORLD)
		ply.data.cbzone = 0
		
		umsg.Start("bgend",ply)
		umsg.End()
		
			if (v == winner) then
			
				GiveToken(ply,Battleground[id].token,10)
			
			else
			
				GiveToken(ply,Battleground[id].token,5)
			
			end
		
		end
	
	end

end

function DA_BuyTVendor(ply,cmd,args)

local token = args[1]
local price = tonumber(args[2])
local item = args[3]

	if (ply.data.tokens[token] >= price) then

		GiveRes(ply,item,1)
		GiveToken(ply,token,-price)
	
	end

end
concommand.Add("DA_BuyTVendor",DA_BuyTVendor)

function DropItemsOnDie(ply)

	if (IsOnBG(ply) or IsInArena(ply)) then return end

	local droplist = {}
	local valuelist = {}
	local i = 1

	for k,v in pairs(ply.data.inventory) do

		for a=1,v do
		
			if (k != "gold") then

			droplist[i] = k
			
			i = i + 1	
			
			end
		
		end
	
	end
	
	for x=1,table.Count(droplist) do
	
		for y=1,table.Count(droplist)-1 do
	
			local z = droplist[y]
			
			if (GetIPrice(droplist[y],"buy") < GetIPrice(droplist[y+1],"buy")) then
			
				droplist[y] = droplist[y+1]
				droplist[y+1] = z
			
			end
	
		end
	
	end
		
	local drops = {}
	
	for x=4,table.Count(droplist) do	
		if (drops[droplist[x]] == nil) then	drops[droplist[x]] = 1 else	drops[droplist[x]] = drops[droplist[x]] + 1 end		
	end
	
	for k,v in pairs(drops) do

		local drop = ents.Create("da_drop")
		drop:SetNWString("item",k)
		drop:SetNWInt("amount",v)
		drop:SetPos(ply:GetPos()+Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*16+Vector(0,0,64))
		drop:Spawn()

		local entphys = drop:GetPhysicsObject()
		entphys:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*1024)
	
		GiveRes(ply,k,-v)
	
	end

end

function DA_Torch(ply,cmd,args)

	local state = tonumber(args[1])

	if (state == 1) then

		ply:SetNWBool("torch",true)

	else

		ply:SetNWBool("torch",false)

	end

end
concommand.Add("DA_Torch",DA_Torch)

hook.Add("PlayerDeath","DropItemsOnDie",DropItemsOnDie)

function findPlayerByID(id)

	for k,v in pairs(player.GetAll()) do
	
		if (v:UniqueID() == id) then
		
		return v
		
		end

	end
	
	return false

end

function UnStuck(ply,text)

	if (string.sub(text,0,8) == "/unstuck") then
	
		umsg.Start("Action",ply)
		umsg.Short(20)
		umsg.String("Unstuck")
		umsg.String("UnStuckEnd")
		umsg.End()
	
		ply:Freeze(true)
		return false
	
	end

end

hook.Add("PlayerSay","UnStuck",UnStuck)

function UnStuckEnd(ply,cmd,args)
	
	local spawn = nil
	
	for k,v in pairs(ents.FindByClass("info_player_start")) do
	
		spawn = v:GetPos()
	
	end
	
	ply:SetPos(spawn)
	
	ply:Freeze(false)

end
concommand.Add("UnStuckEnd",UnStuckEnd)

function ResetSay(ply,text)

	if (string.sub(text,0,6) == "/reset") then
	
	umsg.Start("reset",ply)
	umsg.End()
	return false
	
	end

end
hook.Add("PlayerSay","ResetSay",ResetSay)

function DA_ResetCharacter(ply,cmd,args)

	ply.data = {}
	ply.data.skills = {}
	ply.data.inventory = {}
	ply.data.bank = {}
	ply.data.friends = {}
	ply.data.quests = {}
	ply.data.tokens = {}
	ply.data.stats = {}
	ply.data.achievements = {}
	
	for k,v in pairs(Skills) do

		ply.data.skills[v] = 1
		ply.data.skills[v .. "xp"] = 1

	end 
	
	for k,v in pairs(Stats) do
		
		ply.data.stats[k] = 0
		
	end

	ply.data.iweight = 1.55
	ply.data.icapacity = 25
	ply.data.inventory.gold = 100
	ply.data.inventory["stone_pickaxe"] = 1
	ply.data.inventory["stone_axe"] = 1

	ply.data.weapon = "stone_pickaxe"

	ply.data.bweight = 0
	ply.data.bcapacity = 100

	file.Write("darkages/Save/"..ply:UniqueID()..".txt",util.TableToKeyValues(ply.data) )
	
	local totallevel = 0
	local cblevel = 0
	
	for k,v in pairs(ply.data.skills) do

		if (string.Right(k,2) != "xp") then
		
			totallevel = totallevel + v
		
		end

	end
	
	ply.data.totallevel = totallevel
	
	for k,v in pairs(CBSkills) do
	
		cblevel = cblevel + ply.data.skills[v]
	
	end	
	ply.data.cblevel = math.Round(cblevel / 4)
	
	ply:SetNWInt("cblevel",ply.data.cblevel)
	ply:SetNWInt("totallevel",ply.data.totallevel)
	ply:SetNWInt("hitpoints",10)
	ply:SetHealth(10)

	net.Start("huddata")
		net.WriteTable(ply.data)
	net.Send(ply)
	
	umsg.Start("character",ply)
	umsg.End()

end
concommand.Add("DA_ResetCharacter",DA_ResetCharacter)

function PrivMSG(ply,text)

	local texta = string.Explode(" ",text)

	if (texta[1] == "/pm") then
	
		local target = nil
		local count = 0
		
		for k,v in pairs(player.GetAll()) do
		
			if ( string.find( string.lower( v:Nick() ),string.lower( texta[2] ) ) ) then
				target = v
				count = count + 1
			end
		
		end
		
		if (count > 0) then
		
			local text = {}
			
			for i=3,table.Count(texta) do
			
				text[i-2] = texta[i]
			
			end
			
			text = string.Implode(" ",text)
		
			umsg.Start("privmsg",target)
			umsg.String(ply:Nick())
			umsg.String(text)
			umsg.End()
			
			umsg.Start("privsent",ply)
			umsg.String(target:Nick())
			umsg.String(text)
			umsg.End()			
			
		else
			HudText(ply,"No player found")
		end
	
	
	//string.sub(text,4,string.len(text))
	
	return false
	
	end

end
hook.Add("PlayerSay","PrivMSG",PrivMSG)

function PlyKillStat(ply,x,killer)

if (ply == killer) then return end

AddToStat(killer,"plkill",1)

end
hook.Add("PlayerDeath","PlyKillStat",PlyKillStat)

function AddToStat(ply,stat,amount)

	if (ply.data.stats == nil) then ply.data.stats = {} end
	if (ply.data.stats[stat] == nil) then ply.data.stats[stat] = 0 end

	ply.data.stats[stat] = ply.data.stats[stat] + amount

	CheckAchievement(ply,stat)
	
end

function CheckAchievement(ply,stat)

	if (ply.data.achievements == nil) then ply.data.achievements = {} end
	
	for k,v in pairs(Achievements) do
	
		if (Achievements[k].stat == stat) then
		
			if (ply.data.stats[Achievements[k].stat] != nil and ply.data.stats[Achievements[k].stat] >= Achievements[k].amount) then

				if (ply.data.achievements[k] == nil) then
			
					GiveAchievement(ply,k)
					HudText(ply,"You have completed an achievement : " .. Achievements[k].name)
				
				end
			
			end
		
		end		
	
	end

end

function GiveAchievement(ply,achi)

ply.data.achievements[achi] = "Completed"

end
