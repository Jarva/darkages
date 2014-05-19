function DA_Crafting(ply,cmd,args)

	if (args == nil) then return end
	if (ply:GetNWBool("InAction") == true) then return end

	local item = args[1]
	local resok = 1
	
	ply.craftitem = item

	for k,v in pairs(Crafting[item].res) do

		if (ply.data.inventory[k] == nil or ply.data.inventory[k] < v) then
			
			HudText(ply,"You haven't got enought resources to craft this item")
			resok = 0
			break
					
		end

	end
	
	if (Crafting[item].lvl > ply.data.skills.crafting) then
		HudText(ply,"You need level " .. Crafting[item].lvl .. " crafting to craft this item")
		return
	end
	
	if (resok == 1) then
	
		local time = Crafting[item].lvl - ply.data.skills["crafting"]
		
		if (time < 1) then
			
			time = 1
		
		end
	
		ply:SetNWBool("InAction",true)

		umsg.Start("Action",ply)
		
			umsg.Short(time)
			umsg.String("Crafting")
			umsg.String("CraftingEnd")
		
		umsg.End()
		
		ply:Freeze(true)
	
	end
	
	

end
concommand.Add("DA_Crafting",DA_Crafting)



function CraftingEnd(ply,cmd,args)

	local item = ply.craftitem

	for k,v in pairs(Crafting[item].res) do

		GiveRes(ply,k,-v)

	end
	
	local resxp = 0
	
	for k,v in pairs(Crafting[item].res) do
	
	resxp = resxp + v
	
	end
	
	local xp = math.random(Crafting[item].lvl,Crafting[item].lvl*2 + resxp)
	
	GiveRes(ply,item,1)
	GiveXP(ply,"crafting",xp)
	
	ply:Freeze(false)
	ply:SetNWBool("InAction",false)

end
concommand.Add("CraftingEnd",CraftingEnd)