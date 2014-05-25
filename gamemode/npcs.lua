function GM:OnNPCKilled( victim, killer, weapon )

	local ent = victim:GetNWEntity("parent")   
	local name = ""
	local drops = {}
	
	if (victim:GetNWBool("isboss")) then
		name = victim:GetNWString("name")
		drops = Bosses[name].drops
	else 
		name = victim:GetNWString("name")
		drops = MobInfo[name].drops
	end
   
  
	if (victim:GetNWBool("isboss")) then AddToStat(killer,"bosses",1) else 
		if (victim:GetNWString("extra") == "elite") then AddToStat(killer,"elites",1) else AddToStat(killer,"mobs",1) end
	end
	
	local hitpointsxp = {}
	
	for k,v in pairs(victim.givexp) do
	
		hitpointsxp[k] = 0
	
		for x,y in pairs(victim.givexp[k]) do
		
		GiveXP(k,x,y)
		
		hitpointsxp[k] = hitpointsxp[k] + y
		
		end
		
		GiveXP(k,"hitpoints",math.Round(hitpointsxp[k]/2))
			
	end	
   
	for I = 1,table.Count(drops)/4 do
	
	local item = ""
	local amount = 0
	local chance = 0
	
	if (victim:GetNWBool("isboss")) then
	
		item = Bosses[name].drops[I*4-3]
		amount = math.random(Bosses[name].drops[I*4-2],Bosses[name].drops[I*4-1])
		chance = Bosses[name].drops[I*4]
	
	else
		
		item = MobInfo[name].drops[I*4-3]
		amount = math.random(MobInfo[name].drops[I*4-2],MobInfo[name].drops[I*4-1])
		chance = MobInfo[name].drops[I*4]
		
	end
	
	if (PlayerHasClanUpgrade(killer,"10gold")) then amount = math.Round(amount * 1.1) end
	
	local random = math.random(1,100)
	
		if (chance > random) then
			
			local drop = ents.Create("da_drop")
			drop:SetNWString("item",item)
			drop:SetNWInt("amount",amount)
			drop:SetPos(victim:GetPos()+Vector(0,0,64))
			drop:Spawn()

			local entphys = drop:GetPhysicsObject()
			entphys:SetVelocity(victim:GetAngles():Forward()*64)
		
		end
	
	end	
	
	if (victim:GetNWBool("isboss")) then
	
		SpawnBoss(ent)
	
	else
		
		SpawnMob(ent)
		
	end
	
	if (victim:GetNWBool("isboss")) then
		
		for k,v in pairs(ents.FindInSphere(victim:GetPos(),500)) do
			
			if (v:IsPlayer()) then
			
			GiveToken(v,Bosses[name].token,Bosses[name].tamount)
			
			end
		
		end
	
	end
   
end