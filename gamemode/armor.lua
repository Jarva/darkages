function SpawnArmor(ply)

CreateArmor(ply,"bronze_medhelm")
CreateArmor(ply,"z")
CreateArmor(ply,"y")
CreateArmor(ply,"x")
CreateArmor(ply,"a")

end
hook.Add("PlayerSpawn","SpawnArmor",SpawnArmor)

function CreateArmor(ply,armor)

	local x = ents.Create("da_armor")
	x:SetNWEntity("owner",ply)
	x:SetNWString("armor",armor)
	x:Spawn()
	x:SetNWBool("dual",false)

	if (ArmorBones[Armors[armor].armor].dual) then

		local y = ents.Create("da_armor")
		y:SetNWEntity("owner",ply)
		y:SetNWString("armor",armor)
		y:Spawn()

		x:SetNWBool("dual",true)
		y:SetNWBool("dual",true)

		x:SetNWInt("bone",1)
		y:SetNWInt("bone",2)

	end

end

function DeathArmor(ply)

DeleteArmor(ply)

end
hook.Add("PlayerDeath","DeathArmor",DeathArmor)

function DCArmor(ply)

DeleteArmor(ply)

end
hook.Add("PlayerDisconnected","DCArmor",DCArmor)

function DeleteArmor(ply)

	for k,v in pairs(ents.GetAll()) do

		if (v:GetClass() == "da_armor") then
		
			if (v:GetNWEntity("owner") == ply) then
			
				v:Remove()
			
			end
		
		end

	end

end