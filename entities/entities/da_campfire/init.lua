AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	self:SetModel( "models/botondmodels/campfire.mdl" )
	self:SetSolid(  SOLID_BBOX )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	
	local Time = 0
	Time = self:GetNWInt("ignite_time")
	
	self:Ignite(Time)
	
	timer.Simple(Time+1,function()
	
	self:Remove()
	
	end)
	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	

	if Name == "Use" and ply:IsPlayer() then
		
		umsg.Start("cl_cooking",ply)
		umsg.End()
		
		ply:SetNWEntity("campfire",self)
		
	end
	
end


