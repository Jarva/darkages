AddCSLuaFile( "shared.lua" )


SWEP.Author			= "Dark Ages"
SWEP.Contact			= ""
SWEP.Purpose			= ""
SWEP.Instructions		= "Left click to chop some wood"

SWEP.PrintName        = "Mithril Axe"			
SWEP.Slot		= 2
SWEP.SlotPos		= 1
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
 
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
 
SWEP.ViewModel			= "models/PG_props/pg_weapons/pg_axe_viewmodel.mdl"
SWEP.WorldModel		= "models/PG_props/pg_weapons/pg_axe_worldmodel.mdl"
 
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
 
local ShootSound = Sound( "Metal.SawbladeStick" )
 
function SWEP:Deploy()

self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_DRAW)

self.Owner:GetViewModel():SetSkin(4)
self:SetSkin(4)

end

function SWEP:Initialize()

self:SetWeaponHoldType( "melee" )

end

SWEP.CanFire = 0

function SWEP:PrimaryAttack()
 
	if self.CanFire > CurTime() then return end

	if SERVER then
		
		local owner = self.Owner
		local tree = owner:GetEyeTrace().Entity
		local dist = owner:GetPos():Distance( owner:GetEyeTrace().HitPos )
		
		owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_DRYFIRE)
		
		if (Trees[tree:GetClass()] == nil) then return end
		
		owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self:GetOwner():DoAttackEvent()		
		
		timer.Simple(0.3,function()
		
			owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_IDLE)
		
		end)
		
		if (IsInventoryFull(self.Owner)) then return end
		
		if (tree:GetModel() == "models/props_foliage/tree_stump01.mdl") then
		
			HudText(owner,"This tree is already chopped out.")		
			return
		
		end

		if (dist > 125) then return end
		
		if (Trees[tree:GetClass()].lvl > owner.data.skills["woodcutting"]) then

		HudText(owner,"You need level " .. Trees[tree:GetClass()].lvl .. " woodcutting to chop this tree out")
		return

		end
		
		local acttime = 3
		
		Woodcutting(owner,acttime,tree)
		
		self.CanFire = CurTime() + 1
	
	end
	
end
