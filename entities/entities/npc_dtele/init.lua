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
	
	umsg.Start("npcdtele",ply)
	umsg.String(self:GetNWString("dungeon"))
	umsg.Short(self:GetNWString("dir"))
	umsg.End()
	
	end
	
end

function DTeleport(ply)

	for k,v in pairs(ents.FindInSphere(ply:GetPos(),150)) do
	
		if (v:GetClass() == "npc_dtele") then
		ent = v	
		ply:SetPos(ent:GetNWVector("target"))
		ply.data.cbzone = ent:GetNWInt("dir")
		
			if (ent:GetNWInt("dir") == 2) then 
			
			ply:SetCollisionGroup(COLLISION_GROUP_NPC)
			
			else
			
			ply:SetCollisionGroup(COLLISION_GROUP_WORLD)
			
			end
		
		end
	
	end

	

end
concommand.Add("DA_DTele",DTeleport)

function ENT:KeyValue(key, value)

	if (key == "model") then

		self:SetModel(value)

	end
	
	if (key == "target") then

		local target = string.Explode(" ",value)
		self:SetNWVector("target",Vector(target[1],target[2],target[3]))
		
	end
	
	if (key == "direction") then
	
		if (value == "in") then self:SetNWInt("dir",2) else self:SetNWInt("dir",0) end		

	end	
	
	
	if (key == "dungeon") then

		self:SetNWVector("dungeon",value)
		
	end
	
	if (key == "name") then
	
		self:SetNWString("name",value)
		
	end

end