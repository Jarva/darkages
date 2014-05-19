AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	self:SetSolid(  SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetNWInt("retime",20)
	self:SetModel("models/props_foliage/tree_pine04.mdl")
	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	


	
end

function ENT:KeyValue(key, value)



end


