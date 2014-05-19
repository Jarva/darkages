function Smith(ply, cmd, args)

	if (args == nil) then return end

	if (ply:GetNWBool("InAction") == true) then return end

	ply.Material = args[1]
	ply.Amount = tonumber(args[2])

	local material = args[1]

	if (SmithingLvL[material] > ply.data.skills.smithing) then 

		HudText(ply,"Your smithing level is too low")
		return

	end

	for k,v in pairs(Smithing[ply.Material]) do

		if (ply.data.inventory[k] == 0 || ply.data.inventory[k] == nil) then
		
			HudText(ply,"You don't have enough materials to smelt this bar")
			
			return
		
		end

		if (ply.data.inventory[k] < ply.Amount * v) then

			ply.Amount = math.floor(ply.data.inventory[k] / v)

		end

	end

	umsg.Start("Action",ply)
			
		umsg.Short(ply.Amount*0.5)
		umsg.String("Smelting")
		umsg.String("Smith_End")
			
	umsg.End()


	ply:SetNWBool("InAction",true)
	ply:Freeze(true)
		

end

function Smith_End(ply)

	local resxp = 0

	for k,v in pairs(Smithing[ply.Material]) do
	
		GiveRes(ply,k,-ply.Amount * v)
		resxp = resxp + v
	
	end
	
	local xp = SmithingLvL[ply.Material] + resxp * ply.Amount
	
	GiveRes(ply,ply.Material.." bar",ply.Amount)
	GiveXP(ply,"smithing",xp)

	ply:Freeze(false)
	ply:SetNWBool("InAction",false)

end



function Forge(ply, cmd, args)

	if (ply:GetNWBool("InAction") == true) then return end

	ply.Mat = args[1]
	ply.Item = args[2]

	local material = args[1]
	local item = args[2]
	
	if (SmithingLvL[material] + Forging[material][item].lvl > ply.data.skills["smithing"]) then
	
	HudText(ply,"Your smithing level is too low")
	return
	
	end
	
	for k,v in pairs(Forging[material][item].res) do
	
		if ply.data.inventory[k] == nil or ply.data.inventory[k] < v then
		
			HudText(ply,"You don't have enough resources")
			
			return 
		
		end
	
	end
	
	ply:SetNWBool("InAction",true)
	ply:Freeze(true)
	
	umsg.Start("Action",ply)
		
	umsg.Short(SmithingLvL[material])
	umsg.String("Forging")
	umsg.String("Forge_End")
		
	umsg.End()

	
	
	
	
	
	
end

function Forge_End(ply)

	local resxp = 0

	for k,v in pairs(Forging[ply.Mat][ply.Item].res) do
	
		GiveRes(ply,k,-v)
		resxp = resxp + v
	
	end
	
	GiveRes(ply,ply.Mat.."_"..ply.Item,1)
	
	local material = ply.Mat
	
	SmithXPRand = (math.random(SmithingLvL[material],SmithingLvL[material]*2) + math.random(resxp,resxp*2)) * 2
	GiveXP(ply,"smithing",SmithXPRand)	

	ply:Freeze(false)
	ply:SetNWBool("InAction",false)

end

concommand.Add("Forge_End",Forge_End)
concommand.Add("Smith",Smith)
concommand.Add("Smith_End",Smith_End)
concommand.Add("Forge",Forge)