AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	self:SetSolid(  SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSkin(0)
	self:SetNWInt("retime",25)
	self:SetModel("models/pg_props/pg_forest/pg_sandstone.mdl")
	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	


	
end

function ENT:KeyValue(key, value)


end
