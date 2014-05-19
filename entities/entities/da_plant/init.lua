AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	self.Plant = self:GetNWString("plant")
	self.Parent = self:GetNWEntity("parent")
	
	self:SetModel( Plants[self.Plant].model )

	self:SetSolid(  SOLID_BBOX )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	

	if Name == "Use" and ply:IsPlayer() then
	
		if (GetIWeight(self:GetNWString("plant")) < ply.data.icapacity - ply.data.iweight) then
		
			ply:Freeze(true)
			
			ply.Plant = self:GetNWString("plant")
			ply.Entity = self
			
			umsg.Start("Action",ply)
				
			umsg.Short(math.random(2,4))
			umsg.String("harvesting")
			umsg.String("Harvest_End")
				
			umsg.End()

		else
		
			ply:ChatPrint("Your inventory is full!")
		
		end
		
	end

end


