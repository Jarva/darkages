function Plant(ply, cmd, args)

	if (args == nil) then return end

	ply.Plant = args[1]

	ply:Freeze(true)

	umsg.Start("Action",ply)

		umsg.Short(math.random(2,4))
		umsg.String("planting")
		umsg.String("Plant_End")

	umsg.End()

	

end

concommand.Add("Plant",Plant)

function Plant_End(ply)


Hitpos = ply:GetEyeTrace().HitPos

if (ply:GetPos():Distance(Hitpos) <= 200) then

	Seed = ents.Create("da_seed")
	Seed:SetPos(Hitpos)
	
	Seed:SetNWString("plant",ply.Plant)
	
	Seed:Spawn()
	

end

ply:Freeze(false)

GiveRes(ply,ply.Plant,-1)
GiveXP(ply,"farming",math.random(2,12))

HudText(ply,"You have planted a(n) "..ply.Plant)	

end

concommand.Add("Plant_End",Plant_End)

function Harvest_End(ply)

ply:Freeze(false)

ply.Entity:Remove()

local plantparent = ply.Entity:GetNWEntity("parent")
plantparent:Remove()

local random = math.random(1,100)

GiveXP(ply,"farming",math.random(2,12))
GiveRes(ply,ply.Plant,1)

end

concommand.Add("Harvest_End",Harvest_End)