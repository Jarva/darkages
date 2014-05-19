function DA_Alchemy(ply,cmd,args)

	if (ply:GetNWBool("InAction") == true) then return end

	local potion = args[1]
	local resok = 1
	
	ply.potion = potion

	for k,v in pairs(Potions[potion].res) do

		if (ply.data.inventory[k] == nil or ply.data.inventory[k] < v) then
			
			HudText(ply,"You haven't got enought resources to make this potion")
			return
					
		end

	end
	
	local time = math.ceil(Potions[potion].time - Potions[potion].time * ply.data.skills["alchemy"] / 100)
		
	if (time < 1) then
		
		time = 1
	
	end

	umsg.Start("Action",ply)
	
		umsg.Short(time)
		umsg.String("Making potion")
		umsg.String("AlchemyEnd")
	
	umsg.End()

	ply:Freeze(true)
	ply:SetNWBool("InAction",true)

end
concommand.Add("DA_Alchemy",DA_Alchemy)



function AlchemyEnd(ply,cmd,args)

	local resamount = 0

	for k,v in pairs(Potions[ply.potion].res) do

		GiveRes(ply,k,-v)
		
		resamount = resamount + v

	end
	
	local xp = math.random(Potions[ply.potion].lvl + resamount,Potions[ply.potion].lvl + resamount + Potions[ply.potion].time)
	
	GiveRes(ply,ply.potion,1)
	GiveXP(ply,"alchemy",xp)
	
	ply:Freeze(false)
	ply:SetNWBool("InAction",false)

end
concommand.Add("AlchemyEnd",AlchemyEnd)