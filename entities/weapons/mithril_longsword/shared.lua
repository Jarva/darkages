AddCSLuaFile( "shared.lua" )

SWEP.Author			= "Dark Ages"
SWEP.Contact			= ""
SWEP.Purpose			= ""
SWEP.Instructions		= ""

SWEP.PrintName        = "Mithril Longsword"			
SWEP.Slot		= 3
SWEP.SlotPos		= 2
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
 
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
 
SWEP.ViewModel			= "models/PG_props/pg_weapons/pg_bastard_sword_v.mdl"
SWEP.WorldModel		= "models/PG_props/pg_weapons/pg_bastard_sword_w.mdl"
 
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
SWEP.AtkDamage = 12
SWEP.Range = 48
 
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

self.Owner:GetViewModel():SetSkin(3)
self:SetSkin(3)

end

function SWEP:Initialize()

self:SetWeaponHoldType( "melee2" )

end

function SWEP:PrimaryAttack()

	if self.CanFire > CurTime() then return end
	self.CanFire = CurTime()+self.AtkSpeed

	if SERVER then

		local anim = ACT_VM_HITCENTER
		local random = math.random(0,2)
	
		if (random == 1) then
		anim = ACT_VM_HITLEFT
		elseif (random == 2) then
		anim = ACT_VM_HITRIGHT 
		end
	
		self.Owner:GetActiveWeapon():SendWeaponAnim(anim)
		self:GetOwner():DoAttackEvent()		
		
		timer.Simple(self.AtkSpeed - 0.3,function()
		
		self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_IDLE)
		
		end)
		
		if (self.Owner.data.cbzone == 0) then return end
		
		for k,v in pairs(ents.FindInSphere(self.Owner:GetPos()+self.Owner:GetAimVector()*self.Range,self.Range)) do
			
			if (v != self.Owner) then 
			
				if (v:IsPlayer() or v:IsNPC()) then
					
				self.Damage = self.AtkDamage + math.random(self.Owner.data.skills.strength,self.Owner.data.skills.strength)
				
				if (IsOnBG(self.Owner)) then 
				
				local oteam = GetBGTeam(self.Owner)
				local eteam = GetBGTeam(v) 
				
				if (oteam == eteam) then return end

				end
				
				DA_Damage(v,self.Owner,self.Damage,"meele")
				
				end
			
			end
		
		end

	end

end