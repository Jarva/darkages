function DA_LoadSkills(ply)

	ply.data = {}
	ply.data.skills = {}
	ply.data.inventory = {}
	ply.data.bank = {}
	ply.data.friends = {}
	ply.data.quests = {}
	ply.data.tokens = {}
	ply.data.stats = {}
	ply.data.achievements = {}

	ply.Action_Time = 0
	ply.Action_Name = "name"
	
	if (file.Exists("darkages/Save/"..ply:UniqueID()..".txt","DATA") ) then

		local plydata = {}
		plydata = util.KeyValuesToTable(file.Read("darkages/Save/"..ply:UniqueID()..".txt","DATA"))  

		ply.data = plydata

		ply.data.icapacity = 20 + ply.data.skills["strength"]

	else

		for k,v in pairs(Skills) do

			ply.data.skills[v] = 1
			ply.data.skills[v .. "xp"] = 1

		end 
		
		for k,v in pairs(Stats) do
		
			ply.data.stats[k] = 0
		
		end

		ply.data.iweight = 1.55
		ply.data.icapacity = 20 + ply.data.skills["strength"]
		ply.data.inventory.gold = 100
		ply.data.inventory["stone_pickaxe"] = 1
		ply.data.inventory["stone_axe"] = 1

		ply.data.weapon = "stone_pickaxe"

		ply.data.bweight = 0
		ply.data.bcapacity = 100

		file.Write("darkages/Save/"..ply:UniqueID()..".txt",util.TableToKeyValues(ply.data) )

	end
	
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

	net.Start("huddata")
		net.WriteTable(ply.data)
	net.Send(ply)

	net.Start("clans")
		net.WriteTable(clans)
	net.Send(ply)

	if (ply.data.clan != nil and ply.data.clan != "" and clans[ply.data.clan] != nil) then

		ply:SetNWString("clan",ply.data.clan)
		ply:SetNWBool("inclan",true)

	else

		ply:SetNWBool("inclan",false)

	end
	
	ply.data.name = ply:Nick()
	
	timer.Create("save_" .. ply:UniqueID(),20,0,function()
	
		if (ply.data != nil) then
	
		file.Write("darkages/Save/"..ply:UniqueID()..".txt",util.TableToKeyValues(ply.data) )
		
		end
	
	end)

end

hook.Add("PlayerInitialSpawn","DA_LoadSkills",DA_LoadSkills)

function WeightSetup(ply)

	local weight = 0

	for k,v in pairs(ply.data.inventory) do

		weight = weight + GetIWeight(k)*v

	end
	
	ply.data.iweight = weight
	
	if (ply.data.bank == nil) then ply.data.bank = {} end
		
		local bweight = 0

		for k,v in pairs(ply.data.bank) do

			bweight = math.round(tonumber(bweight) + tonumber(GetIWeight(k))*tonumber(v),5)

		end
		
		ply.data.bweight = tonumber(bweight)
	
	ply.data.icapacity = 25
	ply.data.bcapacity = 100
	
	ply:SetWalkSpeed(210 - ply.data.iweight * 2)
	ply:SetCollisionGroup(COLLISION_GROUP_WORLD)

end
hook.Add("PlayerSpawn","WeightSetup",WeightSetup)

function GM:PlayerSpawn(ply)

	if (ply.data.model == nil) then
		
		umsg.Start("character",ply)
		umsg.End()
	
	else

		ply:SetModel(ply.data.model)

	end

end

function DA_UseSwep(ply, cmd, args)

	local swep = args[1]
	
	local skill = Sweps[swep].skill
	local lvl = Sweps[swep].lvl
	
	if (ply.data.skills[skill] >= Sweps[swep].lvl) then
	
		ply:StripWeapons()
		ply:Give(swep)	
		ply.data.weapon = swep
	
	else
	
		HudText(ply,"You haven't got enough skill for this item. [You need lvl " .. Sweps[swep].lvl .. " " ..Sweps[swep].skill .. "]")
	
	end

end

concommand.Add("DA_UseSwep",DA_UseSwep)

function DA_Unfreeze(ply)

	ply:Freeze(false)

end

function DA_Freeze(ply)

	ply:Freeze(true)

end

concommand.Add("DA_Action",DA_Action)
concommand.Add("DA_StopAction",DA_StopAction)
concommand.Add("DA_Unfreeze",DA_Unfreeze)
concommand.Add("DA_Freeze",DA_Freeze)

function Hitpoints(  ent, dmginfo )

	local attacker = dmginfo:GetAttacker()
	local amount = dmginfo:GetDamage()

	dmginfo:SetDamage(0)

	if (ent:IsPlayer() ) then
	
		if (ent.Thirst == 0 or ent.Hunger == 0 or ent.Oxygen == 0) then dmginfo:SetDamage(amount) return end
	
			if (dmginfo:IsFallDamage() ) then 
			
				dmginfo:SetDamage(ent:GetVelocity():Length() / 20)
				return
				
			end

		if (ent.spawnprotection == 1) then
		
			dmginfo:SetDamage(0)
			return 
		
		end
		
		if (attacker:IsPlayer()) then
		
			dmginfo:SetDamage(amount)
		
		end
			
		if (attacker:IsNPC()) then
		
		local lvl = attacker:GetNWInt("level")
		local strength = 0
		damage = 0
		local crit = math.random(1,100)
		
		if (attacker:GetNWString("isboss") == true) then

		damage = Bosses[attacker:GetNWString("name")].attack + lvl
		strength = Bosses[attacker:GetNWString("name")].strength + lvl

		else
		
		strength = MobInfo[attacker:GetNWString("name")].strength + lvl
		damage = MobInfo[attacker:GetNWString("name")].attack + lvl
		
			if (attacker:GetNWString("extra") == "elite") then

				damage = damage * 2

			end
		
		end
		
		
		if (crit < strength) then damage = damage * 2 end
		
			local defense = ent.data.skills.defense
			
			if (ent:GetNWString("stance") == "defense") then defense = defense + math.random(0,5) end
		
			dmginfo:SetDamage(math.floor(damage - damage * (defense / 100)))
		
		end
				
	end
	
	if (ent:IsNPC()) then
	
		if (attacker:IsPlayer()) then
	
			dmginfo:SetDamage(amount)

		end
	
	end
		
		

end

hook.Add("EntityTakeDamage","Hitpoints",Hitpoints)

function DA_InvEat(ply, cmd, args)

local food = args[1]

local hunger = Eatable[food].hunger
local health = Eatable[food].health

RestoreHunger(ply,hunger)
RestoreHealth(ply,health)

	GiveRes(ply,food,-1)

end
concommand.Add("DA_InvEat",DA_InvEat)

function LvlUP(ply, skill)

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
		ply.data.skills[skill] = ply.data.skills[skill] + 1
		
		ply:SetNWInt("cblevel",ply.data.cblevel)
		ply:SetNWInt("totallevel",ply.data.totallevel)
		
		HudText(ply,"Level UP - your "..skill.." is now lvl "..ply.data.skills[skill])
		
		if (skill == "hitpoints") then ply:SetNWInt("hitpoints",ply.data.skills.hitpoints*10) end
		
		AddToStat(ply,"lvl",1)

end

function GM:PlayerSwitchFlashlight(ply, SwitchOn)

	SwitchOn = false
	
end