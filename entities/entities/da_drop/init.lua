AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	local item = self:GetNWString("item")
	local model = ""
		
	if (DropModels[item] == nil) then
		model = "models/medieval/sack.mdl"
		dskin = 0
	else
		model = DropModels[item]
		dskin =  DropSkins[item]
	end
	
	self:SetModel( model )
	self:SetSkin( dskin )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS ) 
	self:SetUseType( SIMPLE_USE )

	timer.Simple(120,function()
	
		if (self:IsValid()) then
		
		self:Remove()
		
		end
	
	end)
	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	

	
	local item = self:GetNWString("item")
	local amount = self:GetNWInt("amount")

	if (GetIWeight(item) * amount < ply.data.icapacity - ply.data.iweight) then

	DA_TakeUpDrop(ply,self)
	
	else
	
	HudText(ply,"Your inventory is full")
	
	end
	
end


