AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	self:SetModel( "models/medieval/seedling.mdl" )
	self:SetSolid(  SOLID_BBOX )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	
	self.Plant = self:GetNWString("plant")
	RandTime = math.random(5,15)
	
	timer.Simple(RandTime,function()
	
	self:SetModel( "models/props_foliage/bush2.mdl" )  
	self:SetSolid( SOLID_NONE )
	
	timer.Simple(RandTime,function()
	
	Grow = ents.Create("da_plant")
	
	local X = math.random(1,12)
	local Y = math.random(1,12)
	local Z = math.random(5,12)
	
	Grow:SetPos(self:GetPos()+Vector(X,Y,Z))
	Grow:SetNWString("plant",Plantable[self.Plant])
	Grow:SetNWEntity("parent",self)
	
	Grow:Spawn()
	
	end)
	
	end)
	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	

end


