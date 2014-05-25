include('shared.lua')

function ENT:Draw()
local owner = self.Entity:GetNWEntity("owner")

	if (Armors[self.Entity:GetNWString("armor")] == nil) then return end
	if (!owner:IsValid()) then return end
	if (owner == LocalPlayer()) then return end
	
	local bone = "bone1"
	
	if (ArmorBones[Armors[self.Entity:GetNWString("armor")]["armor"]].dual) then 
	bone = "bone" .. self.Entity:GetNWInt("bone")
	end
	
	local boneindex = owner:LookupBone(ArmorBones[Armors[self.Entity:GetNWString("armor")]["armor"]][bone])
	if boneindex then
		local pos, ang = owner:GetBonePosition(boneindex)
		if pos and pos ~= owner:GetPos() then
			ang:RotateAroundAxis(ang:Up(),Armors[self.Entity:GetNWString("armor")]["up"])
			ang:RotateAroundAxis(ang:Forward(),Armors[self.Entity:GetNWString("armor")]["forward"])
			ang:RotateAroundAxis(ang:Right(), Armors[self.Entity:GetNWString("armor")]["right"])
			self.Entity:SetAngles(ang)
			self.Entity:SetPos(pos + ang:Forward()*Armors[self.Entity:GetNWString("armor")]["z"])
			self.Entity:DrawModel()
			return
		end
	
	end
	
end