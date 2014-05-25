AddCSLuaFile( "cl_init.lua" ) -- This means the client will download these files
AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.


function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.
	
	self:SetHullType( HULL_HUMAN ) -- Sets the hull type, used for movement calculations amongst other things.
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX ) -- This entity uses a solid bounding box for collisions.
	self:CapabilitiesAdd( CAP_ANIMATEDFACE or CAP_TURN_HEAD ) -- Adds what the NPC is allowed to do ( It cannot move in this case ).
	self:SetUseType( SIMPLE_USE ) -- Makes the ENT.Use hook only get called once at every use.
	
	self:SetMaxYawSpeed( 90 ) --Sets the angle by which an NPC can rotate at once.
	
end

function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	

	if Name == "Use" and ply:IsPlayer() then
		
	local quests = self:GetNWString("quests")
	local data = {}
	
	if (ply.data.quests == nil) then ply.data.quests = {} end

	data.quests = quests
	data.ply = ply.data.quests
		
	net.Start("questmenu")
		net.WriteTable(data)
	net.Send(ply)
	
	end
	
end

function ENT:KeyValue(key, value)

	if (key == "Model") then

	self:SetModel(value)

	end
	
	if (key == "quests") then
	
	self:SetNWString("quests",value)
	
	end
	
	if (key == "name") then
	
		self:SetNWString("name",value)
		
	end
	
end

