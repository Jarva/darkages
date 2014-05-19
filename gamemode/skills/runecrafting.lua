function DA_Runecrafting(ply,cmd,args)

	if (args == nil) then return end
	if (ply:GetNWBool("InAction") == true) then return end

	local rune = args[1]
	local amount = tonumber(args[2])
	if (ply.data.inventory[Runes[rune].orb] == nil or ply.data.inventory[Runes[rune].orb] < 1) then
		HudText(ply,"You need " .. GetIName(Runes[rune].orb) .. " to craft this rune")
		return 		
	end
	
	local multi = 1
	
	for k,v in pairs(Runes[rune].multi) do
		if (ply.data.skills.runecrafting >= k) then multi = v end
	end
	
	if (ply.data.iweight + GetIWeight(rune)*amount*multi > ply.data.icapacity) then
		HudText(ply,"You inventory is full")
		return		
	end
	
	if (ply.data.inventory["rune_essence"] == nil or ply.data.inventory["rune_essence"] == 0) then
		HudText(ply,"You need rune essence to craft runes")
		return
	end
	
	if (ply.data.inventory["rune_essence"] < amount) then amount = ply.data.inventory["rune_essence"] end
	
	ply.rune = rune
	ply.runeamount = amount
	ply.multi = multi
	
		local time = math.ceil(Runes[rune].level/2)
		
		umsg.Start("Action",ply)
		
			umsg.Short(time)
			umsg.String("Crafting rune")
			umsg.String("RunecraftingEnd")
		
		umsg.End()
		
	ply:Freeze(true)
	ply:SetNWBool("InAction",true)

end
concommand.Add("DA_Runecrafting",DA_Runecrafting)



function RunecraftingEnd(ply,cmd,args)

	local rune = ply.rune
	local amount = ply.runeamount
	local multi = ply.multi
	local xp = amount*multi + math.ceil(Runes[rune].level/2)

	GiveRes(ply,"rune_essence",-amount)
	GiveRes(ply,rune,amount*multi)
	GiveXP(ply,"runecrafting",xp)
	ply:Freeze(false)
	ply:SetNWBool("InAction",false)

end
concommand.Add("RunecraftingEnd",RunecraftingEnd)