function DA_Firemaking(ply, cmd, args)

	if (args == nil) then return end

	local Type = args[1]
	local time = Fireable[Type].time
	
	ply.Type = Type

	if ( ply.data.inventory["tinderbox"] == nil or ply.data.inventory["tinderbox"] == 0) then 
		HudText(ply,"You need a tinderbox")
		return
	end
	
	if ( ply.data.inventory[Type] != nil and ply.data.inventory[Type] >= 1) then

		umsg.Start("Action",ply)		
			umsg.Short(math.Round(Fireable[Type].time / 10))
			umsg.String("Setting up campfire")
			umsg.String("DA_FiremakingEnd")		
		umsg.End()
		
		ply:Freeze(true)

	else

	HudText(ply,"You haven't got enough "..Type)

	end

end
concommand.Add("DA_Firemaking",DA_Firemaking)
function DA_FiremakingEnd(ply)

local Type = ply.Type

Wood = ents.Create("da_campfire")
Wood:SetPos(ply:GetPos() + Vector(ply:GetAimVector().x*64,ply:GetAimVector().y*64,0))
Wood:DropToFloor()
Wood:SetAngles(Angle(0,0,0))
Wood:SetNWInt("ignite_time",math.Round(Fireable[Type].time))
Wood:Spawn()

GiveRes(ply,Type,-1)
GiveXP(ply,"firemaking",math.random(math.Round(Fireable[Type].time / 10),math.Round(Fireable[Type].time / 10)*2))
HudText(ply,"You have made a(n) "..Type.." campfire")

ply:Freeze(false)

end
concommand.Add("DA_FiremakingEnd",DA_FiremakingEnd)

