function DA_Cook(ply, cmd, args)

	if (ply:GetNWBool("InAction") == true) then return end

	ply.Food = args[1]
	local food = args[1] 

	if (ply.data.skills["cooking"] < Cook[food].lvl) then

		HudText(ply,"Your cooking level is too low")
		return 
	 
	end
	
	for k,v in pairs(Cook[food].res) do

		if (ply.data.inventory[k] != nil and ply.data.inventory[k] < v) then

			HudText(ply,"You haven't got enough resource to cook this.")
			return 
		 
		end

	end
	
	if (ply:GetNWEntity("campfire") == nil or !ply:GetNWEntity("campfire"):IsValid()) then
	
		HudText(ply,"Your campfire is gone.")
		return 
	
	end

	ply:Freeze(true)
	ply:SetNWBool("InAction",true)

	umsg.Start("Action",ply)
		
	umsg.Short(Cook[food].lvl)
	umsg.String("cooking")
	umsg.String("Cook_End")
		
	umsg.End()

	

end

function Cook_End(ply)

if (ply:GetNWEntity("campfire") == nil or !ply:GetNWEntity("campfire"):IsValid()) then

	HudText(ply,"Your campfire is gone.")
	ply:Freeze(false)
	return 

end

local food = ply.Food

local x = 0

for k,v in pairs(Cook[food].res) do

x = x + v

end

local fxp = math.random(Cook[food].lvl,Cook[food].lvl^2 + x)

GiveXP(ply,"cooking",fxp)
GiveRes(ply,food,1)

for k,v in pairs(Cook[food].res) do

GiveRes(ply,k,-v)

end

ply:Freeze(false)
ply:SetNWBool("InAction",false)

end


concommand.Add("Cook", DA_Cook)
concommand.Add("Cook_End", Cook_End)
