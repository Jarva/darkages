AddCSLuaFile( "shared.lua" )

SWEP.Author			= "Dark Ages"
SWEP.Contact			= ""
SWEP.Purpose			= ""
SWEP.Instructions		= ""

SWEP.PrintName        = "Iron Sword"			
SWEP.Slot		= 3
SWEP.SlotPos		= 2
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
 
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
 
SWEP.ViewModel			= "models/PG_props/pg_weapons/pg_short_bow_v.mdl"
SWEP.WorldModel		= "models/PG_props/pg_weapons/pg_short_bow_w.mdl"
 
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
SWEP.Primary.Damage = 25
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.CanFire = 0
SWEP.AtkSpeed = 1.2
SWEP.AtkDamage = 5
//Power of the arrow Default = 500
SWEP.Range = 1000
SWEP.Arrow = "bronze arrow"
 
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
 
function SWEP:SecondaryAttack()
 
end

function SWEP:Deploy()

self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_DRAW)

self.Owner:GetViewModel():SetSkin(0)
self:SetSkin(0)

end

function SWEP:Initialize()

self:SetWeaponHoldType( "melee2" )

end

function SWEP:PrimaryAttack()

	if self.CanFire > CurTime() then return end
	self.CanFire = CurTime()+self.AtkSpeed

	if SERVER then

		local anim = ACT_VM_PULLPIN
	
		self.Owner:GetActiveWeapon():SendWeaponAnim(anim)
		self:GetOwner():DoAttackEvent()		
		
		timer.Simple(self.AtkSpeed - 0.3,function()
		
		self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		
		local arrow = ents.Create("prop_physics")
		arrow:SetPos( self.Owner:GetPos() + self.Owner:GetAimVector() * 48 + Vector(0,0,64))
		arrow:SetAngles( self.Owner:EyeAngles() + Angle(0,0,math.deg(math.atan(self.Owner:GetAimVector().z))) )
		arrow:SetModel( "models/PG_props/pg_weapons/pg_arrow/pg_arrow_metal.mdl" )		
		arrow:Spawn()
		local tr = self.Owner:GetEyeTrace()
		local entphys = arrow:GetPhysicsObject()
		entphys:ApplyForceCenter(self.Owner:GetAimVector():GetNormalized() *  math.pow(tr.HitPos:Length(), 3))

		
		end)
		
		if (self.Owner.data.cbzone == 0) then return end		
		

	end

end