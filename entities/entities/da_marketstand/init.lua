AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	self:SetModel( "models/jakemodels/jk_marketstand.mdl" )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	

	if Name == "Use" and ply:IsPlayer() then
		
		local data = {}
		data.stand = {}
		data.price = {}
		data.name = self:GetNWEntity("owner"):Nick()
		
		local owner = self:GetNWEntity("owner")

		for k,v in pairs(owner.stand.stand) do

			if (v > 0) then
				data.stand[k] = v
			end

		end

		for k,v in pairs(owner.stand.price) do
			if (v > 0) then
				data.price[k] = v
			end
		end
		
		net.Start("standbuy")
			net.WriteTable(data)
		net.Send(ply)
		
		ply:SetNWEntity("standbuy",self)
		
	end
	
end


