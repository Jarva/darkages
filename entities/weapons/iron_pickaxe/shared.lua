AddCSLuaFile( "shared.lua" )

SWEP.Author			= "Dark Ages"
SWEP.Contact			= ""
SWEP.Purpose			= ""
SWEP.Instructions		= "Left click to mine some stone"

SWEP.PrintName        = "Iron Pickaxe"			
SWEP.Slot		= 1
SWEP.SlotPos		= 1
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
 
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
 
SWEP.ViewModel			= "models/PG_props/pg_weapons/pg_pickaxe_viewmodel.mdl"
SWEP.WorldModel		= "models/PG_props/pg_weapons/pg_pickaxe_worldmodel.mdl"
 
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

function SWEP:Deploy()

self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_DRAW)

self.Owner:GetViewModel():SetSkin(2)
self:SetSkin(2)

end

function SWEP:Initialize()

self:SetWeaponHoldType( "melee" )

end

SWEP.CanFire = 0

function SWEP:SecondaryAttack()
  
end

function SWEP:PrimaryAttack()

	if SERVER then

		if self.CanFire > CurTime() then return end
	 
		ore = self.Owner:GetEyeTrace().Entity
		eyetrace = self.Owner:GetEyeTrace().HitPos
		self:GetOwner():DoAttackEvent()		
		
		for k,v in pairs(Ores) do
		
			if (ore:GetClass() == k) then
				
				if (self.Owner:GetPos():Distance(eyetrace ) > 125 ) then return end
					
				local actname = "mining"
				local acttime = 2
				local skin = ore:GetSkin()
				
				if (Ores[ore:GetClass()].level > self.Owner.data.skills[actname]) then 
					HudText(self.Owner,"You need level "..Ores[ore:GetClass()].level .." mining to mine this")
					return 
				end
				
				if (skin != Ores[ore:GetClass()].skind) then
					
					DA_Mining(self.Owner,actname,acttime,skin,ore)
				
				end
		
			end
		
		end
	
	end

	self.CanFire = CurTime() + 1
end