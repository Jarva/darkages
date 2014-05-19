AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	local item = self:GetNWString("item")
	local model = ""
		
	if (DropModels[item] == nil) then
		model = "models/medieval/sack.mdl"
	else
		model = DropModels[item]
	end

	self:SetModel( model )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()

	timer.Simple(120,function()
	
	self:Remove()
	
	end)
	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	

	if (ply.data.inventory.amount < ply.data.inventory.capacity) then

	DA_TakeUpDrop(ply,self)
	
	else
	
	HudText(ply,"Your inventory is full")
	
	end
	
end


