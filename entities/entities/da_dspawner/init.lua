AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )

	local time = self:GetNWInt("retime")
	local mobn = self:GetNWString("mob")
	local range = self:GetNWInt("range")
	local maxmob = self:GetNWInt("maxmob") 
	
	self.id = math.random(1,200000)
	
	for I = 1,maxmob do
		
		local x = math.random(0,range)
		local y = math.random(0,range)
		local z = 0
		local level = math.random(self:GetNWInt("minlvl") ,self:GetNWInt("maxlvl") )
		
		local mob = ents.Create(MobInfo[mobn].mob)
		mob:SetPos(self:GetPos()+Vector(x,y,z))
		mob:SetNWEntity("parent",self)
		mob:SetNWInt("level",level)
		mob:SetNWString("name",mobn)
		mob:SetNWBool("ismob",true)
		mob:SetNWBool("isboss",false)
		local health = MobInfo[mobn].health + level

		if (self:GetNWString("extra") == "elite") then

		health = (MobInfo[mobn].health + level) * 2

		end
		
		mob:SetNWInt("health",health)
		local cblvl = math.Round((MobInfo[mobn].attack + MobInfo[mobn].strength + MobInfo[mobn].defense + (level * 3)) / 3)
		
		mob:SetNWInt("cblvl",cblvl)
		mob:SetNWString("extra",self:GetNWString("extra"))
		if (!MobInfo[mobn].aggressive) then
		mob:AddRelationship("player D_NU 999")
		else
		mob:AddRelationship("player D_HT 999")
		end
		mob:Spawn()		
		mob:SetHealth(health)
		mob:SetColor(MobInfo[mobn].color)

	end

end

function ENT:KeyValue(key, value)

	if (key == "mob") then

		self:SetNWString("mob",value)

	end
	
	if (key == "range") then
	
		self:SetNWInt("range",value)
	
	end
	
	if (key == "retime") then
	
		self:SetNWInt("retime",value)
	
	end
	if (key == "minlvl") then
	
		self:SetNWInt("minlvl",value)
	
	end
	if (key == "maxlvl") then
	
		self:SetNWInt("maxlvl",value)
	
	end
	if (key == "maxmob") then
	
		self:SetNWInt("maxmob",value)
	
	end
	if (key == "extra") then
	
		self:SetNWString("extra",value)
	
	end

end

function SpawnMob(ent)

local time = ent:GetNWInt("retime")
local mobn = ent:GetNWString("mob")
local range = ent:GetNWInt("range")
local level = math.random(ent:GetNWInt("minlvl") ,ent:GetNWInt("maxlvl") )

local x = math.random(0,range)
local y = math.random(0,range)
local z = 0
local health = MobInfo[mobn].health + level

timer.Simple(time,function()

local mob = ents.Create(MobInfo[mobn].mob)
mob:SetPos(ent:GetPos()+Vector(x,y,z))
mob:SetNWEntity("parent",ent)
mob:SetNWInt("level",level)
mob:SetNWString("name",mobn)
mob:SetNWBool("ismob",true)
mob:SetNWBool("isboss",false)

if (ent:GetNWString("extra") == "elite") then

health = (MobInfo[mobn].health + level) * 2

end

mob:SetNWInt("health",health)

local cblvl = math.Round((MobInfo[mobn].attack + MobInfo[mobn].strength + MobInfo[mobn].defense + (level * 3)) / 3)

if (!MobInfo[mobn].aggressive) then
mob:AddRelationship("player D_NU 999")
else
mob:AddRelationship("player D_HT 999")
end

mob:SetNWInt("cblvl",cblvl)
mob:SetNWString("extra",ent:GetNWString("extra"))
mob:Spawn()
mob:SetHealth(health)
mob:SetColor(MobInfo[mobn].color)
mob:AddRelationship("npc_dtele D_NU 999")

end)


end