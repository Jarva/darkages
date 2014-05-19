AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )

	local time = self:GetNWInt("retime")
	local mobn = self:GetNWString("mob")

		local level = self:GetNWInt("lvl")
		
		local mob = ents.Create(Bosses[mobn].mob)
		mob:SetPos(self:GetPos())
		mob:SetNWEntity("parent",self)
		mob:SetNWInt("level",level)
		mob:SetNWString("name",mobn)
		mob:SetNWBool("ismob",true)
		mob:SetNWBool("isboss",true)
		
		local health = Bosses[mobn].health
		
		mob:SetNWInt("health",health)
		local cblvl = math.Round((Bosses[mobn].attack + Bosses[mobn].strength + Bosses[mobn].defense + level)/3)
		
		mob:SetNWInt("cblvl",cblvl)
		mob:SetNWString("extra",self:GetNWString("extra"))
		mob:Spawn()		
		mob:SetHealth(health)

end

function ENT:KeyValue(key, value)

	if (key == "mob") then

		self:SetNWString("mob",value)

	end
	if (key == "retime") then
	
		self:SetNWInt("retime",value)
	
	end
	if (key == "lvl") then
	
		self:SetNWInt("lvl",value)
	
	end


end

function SpawnBoss(ent)

local time = ent:GetNWInt("retime")
local mobn = ent:GetNWString("mob")
local level = ent:GetNWInt("lvl")

timer.Simple(time,function()

local mob = ents.Create(Bosses[mobn].mob)
mob:SetPos(ent:GetPos())
mob:SetNWEntity("parent",ent)
mob:SetNWInt("level",level)
mob:SetNWString("name",mobn)
mob:SetNWBool("ismob",true)
mob:SetNWBool("isboss",true)

local health = Bosses[mobn].health

mob:SetNWInt("health",health)

local cblvl = math.Round((Bosses[mobn].attack + Bosses[mobn].strength + Bosses[mobn].defense + level))

mob:SetNWInt("cblvl",cblvl)
mob:SetNWString("extra",ent:GetNWString("extra"))
mob:Spawn()
mob:SetHealth(health)

end)


end