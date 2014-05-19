function SetBaseStance(ply)

ply:SetNWString("stance","attack")

end
hook.Add("PlayerSpawn","SetBaseStance",SetBaseStance)

function SetStance(ply,cmd,args)

local stance = args[1]
ply:SetNWString("stance",stance)

end
concommand.Add("SetStance",SetStance)

function StanceMenu(ply,key)

	if (key == IN_RELOAD) then

		umsg.Start("stancemenu",ply)
		umsg.End()

	end

end
hook.Add("KeyPress","StanceMenu",StanceMenu)

function DA_Damage(ent,attacker,dmg,dtype)

	local xptype = ""
	local dmgvar = 0

	if (dtype == "meele") then
		xptype = attacker:GetNWString("stance") 		
		if (attacker:GetNWString("stance") == "attack") then
			dmgvar = 2
		end	
		if (attacker:GetNWString("stance") == "strength") then
			dmgvar = 3
		end	
		if (attacker:GetNWString("stance") == "defense") then
			dmgvar = 4
		end			
	end
	
	if (dtype == "ranged") then
		xptype = "ranged"
		dmgvar = 2
	end
	
	if (dtype == "magic") then
		xptype = "intellect"
		dmgvar = 2
	end
	
	if (ent:IsNPC() and MobInfo[ent:GetNWString("name")] != nil or Bosses[ent:GetNWString("name")] != nil) then

		if (ent:Disposition(attacker) == D_NU) then ent:AddRelationship("player D_HT 999") end
	
		local damage = dmg + math.Round(attacker.data.skills[xptype] / 2)
		local crit = math.random(1,100)
		local lvl = ent:GetNWInt("level")
		local color = "255,200,50"
		local critc = attacker.data.skills.strength
		
		if (dtype == "magic") then critc = math.Round(attacker.data.skills.intellect / 2) end
		if (dtype == "ranged") then critc = math.Round(attacker.data.skills.ranged / 2) end
		
		if (attacker:GetNWString("stance") == "strength") then critc = critc + 5 end
		if (PlayerHasClanUpgrade(attacker,"5crit")) then critc = critc + 5 end
		
			if (crit < critc) then 
					
				damage = damage * 2 
				color = "255,100,0"
			
			end
			
		local defense = 0
			
		if (ent:GetNWBool("isboss")) then			
			defense = Bosses[ent:GetNWString("name")].defense
		else
			defense = MobInfo[ent:GetNWString("name")].defense
		end
		
		
		local damage = math.floor(damage - damage * ((defense + lvl) / 100))
		if (PlayerHasClanUpgrade(attacker,"5dmg")) then damage = math.Round(damage * 1.05) end
			
		AddToStat(attacker,"damage",damage)
			
		ent:TakeDamage(damage,attacker,ent)
		ent:SetNWInt("health",ent:GetNWInt("health") - damage)
		
		if (ent.givexp == nil) then ent.givexp = {} end
		if (ent.givexp[attacker] == nil) then ent.givexp[attacker] = {} end
		
		if (ent.givexp[attacker][xptype] == nil) then
		ent.givexp[attacker][xptype] = math.ceil(damage/6) 
		else		
		ent.givexp[attacker][xptype] = ent.givexp[attacker][xptype] + math.ceil(damage/6)
		end
		
		umsg.Start("damage",attacker)
			umsg.Entity(ent)
			umsg.Short(damage)
			umsg.String(color)
		umsg.End()
	
	end

	if (ent:IsPlayer()) then
		
		local damage = dmg + math.Round(attacker.data.skills[xptype] / 2)
		local crit = math.random(1,100)
		local lvl = ent:GetNWInt("level")
		local color = "255,200,50"		
		local critc = attacker.data.skills.strength

		if (dtype == "magic") then critc = math.Round(attacker.data.skills.intellect / 2) end
		if (dtype == "ranged") then critc = math.Round(attacker.data.skills.ranged / 2) end
		
		if (attacker:GetNWString("stance") == "strength") then critc = critc + 5 end
		if (PlayerHasClanUpgrade(attacker,"5crit")) then critc = critc + 5 end
		
			if (crit < attacker.data.skills.strength) then 
					
				damage = damage * 2 
				color = "255,100,0"
			
			end
			
			local defense = ent.data.skills.defense
			
		if (ent:GetNWString("stance") == "defense") then defense = defense + math.random(0,5) end
			
		local damage = math.floor(damage - damage * (defense / 100))
		if (PlayerHasClanUpgrade(attacker,"5dmg")) then damage = math.Round(damage * 1.05) end
		
		AddToStat(attacker,"damage",damage)

		ent:TakeDamage(damage,attacker,ent)
		ent:SetNWInt("health",ent:GetNWInt("health") - damage)
		
		umsg.Start("damage",attacker)
			umsg.Entity(ent)
			umsg.Short(damage)
			umsg.String(color)
		umsg.End()
	
	end

end