AddCSLuaFile( "shared.lua" )

SWEP.Author			= "Dark Ages"
SWEP.Contact			= ""
SWEP.Purpose			= ""
SWEP.Instructions		= ""

SWEP.PrintName        = "Hands"			
SWEP.Slot		= 3
SWEP.SlotPos		= 2
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
 
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
 
SWEP.ViewModel			= "models/weapons/v_hands.mdl"
--SWEP.WorldModel		= "models/weapons/v_hands.mdl"
 
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
SWEP.Primary.Damage = 25
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
 
/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()
end
 
/*---------------------------------------------------------
  Think does nothing
---------------------------------------------------------*/
function SWEP:Think()	

	if SERVER then

	self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_IDLE)

	end

end
 
function SWEP:SecondaryAttack()
 
end

function SWEP:Deploy()

end

function SWEP:PrimaryAttack()


end