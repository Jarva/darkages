function DA_Fishing(ply,ent)

	local fishes = {}
	fishes = string.Explode(",",ent:GetNWString("fishes"))

	local text = ""
	local canfish = false
	local fishables = {}

	for k,v in pairs(fishes) do

		if (Fishes[v].weapon == ply.data.weapon) then
		
		fishables[table.Count(fishables)] = v
		canfish = true
		
		end

	end
	
	if (!canfish) then
		HudText(ply,"You don't have the right equipment to fish for " .. string.Implode(",",fishes))
		return
	end
	
	for k,v in pairs(fishes) do
	
		if (Fishes[v].level <= ply.data.skills.fishing) then
		
		fishables[table.Count(fishables)] = v
		canfish = true
		
		end
	
	end
	
	if (!canfish) then 
		HudText(ply,"You fishing is too low to fish here for " .. string.Implode(",",fishes)) 
		return
	end

	local fish = fishables[math.random(0,table.Count(fishables)-1)]
	ply.fish = fish

	if (ply.data.iweight + GetIWeight(fish) > ply.data.icapacity) then
	
	HudText(ply,"Your inventory is full")
	return

	end
	
	local time = Fishes[fish].level/2
	if (PlayerHasClanUpgrade(ply,"10fishing")) then time = time * 0.9 end
	if (time < 1) then time = 1 end

	umsg.Start("Action",ply)

		umsg.Short(time)
		umsg.String("Fishing")
		umsg.String("DA_FishingEnd")

	umsg.End()

	ply:Freeze(true)

	ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_THROW)
		
	timer.Simple(0.80,function()

		ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_IDLE_LOWERED)

	end)

end

function DA_FishingEnd( ply )

	local fish = ply.fish

	GiveXP(ply,"fishing",math.ceil(Fishes[fish].level/2) + math.random(0,Fishes[fish].level))
	GiveRes(ply,fish,1)
	
	AddToStat(ply,"fishes",1)

	ply:Freeze(false)
	
	ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_PULLBACK)

end
concommand.Add("DA_FishingEnd",DA_FishingEnd)