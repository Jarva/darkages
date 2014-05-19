AddCSLuaFile( "shared.lua" )


SWEP.Author			= "Dark Ages"
SWEP.Contact			= ""
SWEP.Purpose			= ""
SWEP.Instructions		= "Left click to catch some fish"

SWEP.PrintName        = "Fishing Cage"			
SWEP.Slot		= 3
SWEP.SlotPos		= 1
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
 
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
 
SWEP.ViewModel			= "models/PG_props/pg_weapons/pg_fishing_rod_v.mdl"
SWEP.WorldModel		= "models/PG_props/pg_weapons/pg_fishing_rod_w.mdl"
 
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
 
local ShootSound = Sound( "Metal.SawbladeStick" )
 
/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()
end
 
/*---------------------------------------------------------
  Think does nothing
---------------------------------------------------------*/
function SWEP:Think()	



end
 
function SWEP:Initialize()

self:SetWeaponHoldType( "melee" )
self:SetSkin(1)
self.CanFire = 0

end
 
function SWEP:PrimaryAttack()
	
	if SERVER then
		if self.CanFire > CurTime() then return end
	 
		target = self.Owner:GetEyeTrace().Entity
		eyetrace = self.Owner:GetEyeTrace().HitPos
		local spots = ents.FindInSphere(self.Owner:GetPos(),200)
		local fspots = {}
		
		for k,v in pairs(spots) do
		
			if (v:GetClass() == "da_fishingspot") then

				fspots[table.Count(fspots)] = v

			end
		
		end
		
		if (table.Count(fspots) > 0) then

			DA_Fishing(self.Owner,fspots[0])
			
		end
		
		self.CanFire = CurTime() + 1
	end
	
end

function SWEP:SecondaryAttack()
 

 
end