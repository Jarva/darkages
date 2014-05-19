AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:StartTouch( ent )

	if ( ent:IsValid() and ent:IsPlayer() ) then
		
		if (ent.data.cbzone != nil) then
		
			ent.data.cbzone = tonumber(self:GetNWInt("type"))
		
			umsg.Start("territory",ent)
			umsg.String(self:GetNWString("name"))
			umsg.Short(self:GetNWInt("type"))
			umsg.End()
		
		end
		
	end
end

function ENT:KeyValue(key, value)

	if (key == "type") then self:SetNWInt("type",value) end
	if (key == "name") then self:SetNWString("name",value) end

end