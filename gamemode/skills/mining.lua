function DA_Mining(ply, actname, acttime, skin, ore)

	local res = Ores[ore:GetClass()].res

	if (GetIWeight(res) < ply.data.icapacity - ply.data.iweight) then
	
	ply.Ore = ore
	ply.Action_Name = actname
	ply.Skin = skin
	ply.Action_Time = Ores[ore:GetClass()].level / acttime - ply.data.skills[actname]/10
	
	if (PlayerHasClanUpgrade(ply,"10mining")) then ply.Action_Time = ply.Action_Time * 0.9 end
	
	local animtime = 1
	
	if (math.floor(ply.Action_Time) == 0) then 
	
		animtime = 1
	
	else
	
		animtime = math.floor(ply.Action_Time)
	
	end
	
	timer.Create("mininganim",1,animtime,function()
	
	ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	
		timer.Simple(0.3,function()
		
		ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_IDLE)
		
		end)
	
	end)
	
	if (ply.Action_Time < 0.5) then

		ply.Action_Time = 0.5

	end

	ply:Freeze(true)
			
	umsg.Start("Action",ply)
		
			umsg.Short(ply.Action_Time)
			umsg.String(ply.Action_Name)
			umsg.String("DA_MiningEnd")
		
	umsg.End()

	else
	
	HudText(ply,"Your inventory is full")
	
	end

end

function DA_MiningEnd(ply)
	
	timer.Stop("mininganim")
	
	ply:Freeze(false)
	
	if(ply.Ore:GetSkin() == Ores[ply.Ore:GetClass()].skind) then 
	
	HudText(ply,"Somebody have already mined this")
	return
	
	end
	
	Ore(ply.Ore, ply.Skin)

	AddToStat(ply,"ores",1)

	local xp = math.random(Ores[ply.Ore:GetClass()].level,Ores[ply.Ore:GetClass()].level*2)	
	local Resource = Ores[ply.Ore:GetClass()].res
						
	GiveRes(ply,Resource,1)
	GiveXP(ply,ply.Action_Name,xp)

end
concommand.Add("DA_MiningEnd",DA_MiningEnd)

function Ore(ent,skin)

	ent:SetSkin(Ores[ent:GetClass()].skind)

	timer.Simple(Ores[ent:GetClass()].time,function() ent:SetSkin(Ores[ent:GetClass()].skin) end)

end