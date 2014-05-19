AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	self:SetModel( "models/daisuke/furnace.mdl" )
	self:SetSolid(  SOLID_BBOX )
	self:SetUseType( SIMPLE_USE )
	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	

	if Name == "Use" and ply:IsPlayer() then
		
		ply:ConCommand("Cl_Smithing")
		
	end
	
end


