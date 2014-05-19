AddCSLuaFile( "shared.lua" )

SWEP.Author			= "Dark Ages"
SWEP.Contact			= ""
SWEP.Purpose			= ""
SWEP.Instructions		= ""

SWEP.PrintName        = "Staff"			
SWEP.Slot		= 3
SWEP.SlotPos		= 2
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
 
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
 
SWEP.ViewModel			= "models/pg_props/pg_weapons/pg_beginner_staff_v.mdl"
SWEP.WorldModel		= "models/pg_props/pg_weapons/pg_beginner_staff_w.mdl"
 
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
SWEP.Primary.Damage = 25
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Magic = 1
SWEP.Cooldowns = {}

SWEP.Element = "air"
SWEP.CanChange = 0


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

function SWEP:Deploy()

	self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_DRAW)

	self.Owner:GetViewModel():SetSkin(0)
	self:SetSkin(0)

	if SERVER then

		for k,v in pairs(self.Owner.data.spellbar) do
		
			self.Cooldowns[v] = CurTime()
		
		end
	
	end

end

function SWEP:PrimaryAttack()

	if SERVER then

		local magics = {}
		magics = self.Owner.data.spellbar

		if (self.Cooldowns[magics[tostring(self.Magic)]] > CurTime()) then return end
		
		DoMagic(self.Owner,magics[tostring(self.Magic)])
	
	end

end

function SWEP:SecondaryAttack()

	local magics = {}

	if SERVER then magics = self.Owner.data.spellbar else magics = plydata.spellbar end
	if (self.CanChange > CurTime()) then return end
	self.CanChange = CurTime() + 0.2
	
	if (self.Magic == table.Count(magics)) then self.Magic = 1 else self.Magic = self.Magic + 1 end

end