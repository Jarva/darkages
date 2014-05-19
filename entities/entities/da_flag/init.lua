AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )
	
	self:SetModel( "models/medieval/ctflag.mdl" )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	
	if (self:GetNWString("team") == "blue") then self:SetSkin(1) end
	
end

function ENT:Touch(ent)

	if (ent:IsPlayer()) then

	local bgteam = GetBGTeam(ent)

		if (self:GetNWString("team") != bgteam) then

		self:SetParent(ent)
		ent:SetNWEntity("flag",self)
		ent:SetNWBool("hasflag",true)
		ent:SetWalkSpeed(140)
		ent:SetRunSpeed(190)
		self:SetPos(ent:GetPos()+ent:GetAngles():Forward() * 32 * -1)
		self:SetAngles(Angle(0,0,0))
		self:SetSolid(SOLID_NONE)
		
		else
		
			if (ent:GetNWBool("hasflag")) then
			
				local spawn = findBGSpawn(self:GetNWString("bg"),self:GetNWString("team"))
			
				if (spawn:GetPos():Distance(self:GetPos()) > 65) then
				
					ReturnFlag(self,self:GetNWString("team"),self:GetNWString("bg"))
				
				else
				
					ReturnFlag(ent:GetNWEntity("flag"),ent:GetNWEntity("flag"):GetNWString("team"),self:GetNWString("bg")) 				
					BGScore(self:GetNWString("bg"),self:GetNWString("team"),1)
					
				end
			
			else
			
				local spawn = findBGSpawn(self:GetNWString("bg"),self:GetNWString("team"))
			
				if (spawn:GetPos():Distance(self:GetPos()) > 65) then
				
					ReturnFlag(self,self:GetNWString("team"),self:GetNWString("bg"))
				
				end
			
			end
			
		end

	end

end



function ENT:OnTakeDamage()
	return false -- This NPC won't take damage from anything.
end 

function ENT:AcceptInput( Name, Activator, ply )	


	
end

function ReturnFlag(ent,bgteam,bg)

	for k,v in pairs(ents.GetAll()) do

		if (v:GetClass() == "da_bgspawn") then

			if (v:GetNWString("battleground") == bg) then

				if (v:GetNWString("team") == bgteam) then
				
				ent:SetPos(v:GetPos())
				ent:SetSolid(SOLID_VPHYSICS)
				ent:DropToFloor()
				ent:SetAngles(Angle(0,0,0))
				local ply = ent:GetParent()
				
				ply:SetNWEntity("flag",nil)
				ply:SetNWBool("hasflag",false)
				ent:SetParent(nil)
					
				end

			end

		end

	end

end

function FlagDrop(ply,ent,killer)

	if (IsOnBG(ply)) then

		if (ply:GetNWEntity("flag") != nil) then

		ply:GetNWEntity("flag"):SetParent(nil)
		ply:GetNWEntity("flag"):DropToFloor()
		ply:GetNWEntity("flag"):SetAngles(Angle(0,0,0))
		ply:GetNWEntity("flag"):SetSolid(SOLID_VPHYSICS)
		ply:SetNWEntity("flag",nil)

		end

	end

end
hook.Add("PlayerDeath","FlagDrop",FlagDrop)


