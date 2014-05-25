AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )

	
	
end

function ENT:KeyValue(key, value)

	if (key == "arena") then

		self:SetNWString("arena",value)

	end

end