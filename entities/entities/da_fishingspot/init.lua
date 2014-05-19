AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include('shared.lua')


function ENT:Initialize( )

local fishes = string.Explode(",",self:GetNWString("fishes"))

end

function ENT:KeyValue(key, value)

	if (key == "fishes") then

		self:SetNWString("fishes",value)

	end

end