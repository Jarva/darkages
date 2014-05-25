AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	self:SetModel( "models/PG_props/pg_weapons/pg_arrow/pg_arrow_metal.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS ) 
	self:SetUseType( SIMPLE_USE )
	--self:SetCollisionGroup( COLLISION_GROUP_WORLD )

	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:PhysicsCollide(data,phys)

	if (data.HitEntity:IsWorld()) then

		self:SetMoveType( MOVETYPE_NONE )
		self:SetPos(self:GetPos() + self:GetAngles():Forward()*12)
	
	end

end

function ENT:AcceptInput( Name, Activator, ply )	


	
end

