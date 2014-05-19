AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize( )

	local owner = self:GetNWEntity("owner")
	local armor = self:GetNWString("armor")
	
	self:SetParent(owner)
	self:SetModel(Armors[armor]["model"])
	self:SetSkin(Armors[armor]["skin"])
	self:SetPos(owner:GetPos())
	
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	self:SetCollisionGroup( COLLISION_GROUP_NONE )
	self:DrawShadow( false )
	
end