AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	self:SetModel( "models/darkages/rune_ess_altar.mdl" )
	self:SetSolid(  SOLID_VPHYSICS)
	self:SetUseType( SIMPLE_USE )
	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	

	if Name == "Use" and ply:IsPlayer() then
		
		umsg.Start("Cl_Runecrafting",ply)
		umsg.End()
		
	end
	
end


