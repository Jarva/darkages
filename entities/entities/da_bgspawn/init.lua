AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )

	local id = self:GetNWString("battleground")

	Battleground[id].players[self:GetNWString("team")] = {}
	
	for i=1,Battleground[id].ppt do
	
	Battleground[id].players[self:GetNWString("team")][i] = ""
	
	end
	
	Battleground[id].score[self:GetNWString("team")] = 0
	
end

function ENT:KeyValue(key, value)

	if (key == "battleground") then

		self:SetNWString("battleground",value)

	end
	
	if (key == "team") then

		self:SetNWString("team",value)

	end
	
	if (key == "range") then

		self:SetNWInt("range",value)

	end

end