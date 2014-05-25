function Woodcutting(ply,acttime,tree)

	ply.acttime = acttime
	ply.tree = tree
	
	local time = Trees[tree:GetClass()].lvl/acttime - (ply.data.skills.woodcutting * 0.1)
	if (PlayerHasClanUpgrade(ply,"10woodc")) then time = time * 0.9 end
	
	if (time < 1) then actime = 1 else actime = time end
	if (ply.data.iweight + GetIWeight(Trees[tree:GetClass()].res) > ply.data.icapacity) then
	
		HudText(ply,"Your inventory is full")
		return
	
	end

	umsg.Start("Action",ply)
		
			umsg.Short(actime)
			umsg.String("woodcutting")
			umsg.String("WoodcuttingEnd")
		
	umsg.End()
	
	if (math.floor(time) < 1) then animtime = 1 else animtime = math.floor(time) end
	
	timer.Create("wcanim",1,animtime,function()
	
	ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	
	timer.Simple(0.3,function()
	
	ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_IDLE)
	
	end)
	
	end)
	
	ply:Freeze(true)

end

function WoodcuttingEnd(ply,cmd,args)

	if (ply.tree:GetModel() == Trees[ply.tree:GetClass()].trunk) then
	
		HudText("Somebody have already chopped out this tree")
	
	else

		local xp = math.random(Trees[ply.tree:GetClass()].lvl,Trees[ply.tree:GetClass()].lvl*2)
		local res = Trees[ply.tree:GetClass()].res
		
		GiveXP(ply,"woodcutting",xp)
		GiveRes(ply,res,1)
		
		SetTree(ply.tree)
		
		AddToStat(ply,"trees",1)
	
	end
	
	ply:Freeze(false)

end
concommand.Add("WoodcuttingEnd",WoodcuttingEnd)

function SetTree(tree)

local model = tree:GetModel()

tree:SetModel(Trees[tree:GetClass()].trunk)

timer.Simple(Trees[tree:GetClass()].time,function() tree:SetModel(model) end)

end