AddCSLuaFile( "cl_init.lua" ) -- This means the client will download these files
AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.


function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.
	
	self:SetModel( self:GetNWString("model") ) -- Sets the model of the NPC.
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
	
	umsg.Start("npcgtele",ply)
	umsg.String(self:GetNWString("ask"))
	umsg.Short(self:GetNWInt("gold"))
	umsg.End()
	
	end
	
end

function GTeleport(ply)

	for k,v in pairs(ents.FindInSphere(ply:GetPos(),300)) do
	
		if (v:GetClass() == "npc_gtele") then
		ent = v	
		
			if (ply.data.inventory.gold < tonumber(ent:GetNWInt("gold"))) then
			
				HudText(ply,"You need "..ent:GetNWInt("gold").." gold to pass through")
			
			else
				
				ply.data.inventory.gold = ply.data.inventory.gold - tonumber(ent:GetNWInt("gold"))
				ply:SetPos(ent:GetNWVector("target"))
			
			end
		end	
	end
end
concommand.Add("DA_GTele",GTeleport)

function ENT:KeyValue(key, value)

	if (key == "Model") then

		self:SetModel(value)

	end
	
	if (key == "Target") then

		local Target = string.Explode(" ",value)
		self:SetNWVector("target",Vector(Target[1],Target[2],Target[3]))
		
	end

	if (key == "gold") then
	
	self:SetNWInt("gold",value)
	
	end
		
	if (key == "ask") then
	
	self:SetNWString("ask",value)
	
	end
	
	if (key == "name") then
	
		self:SetNWString("name",value)
		
	end
	
end

