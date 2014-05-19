AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize( )

	local time = self:GetNWInt("time")
	local item = self:GetNWString("item")
	local range = self:GetNWInt("range")
	local sid = math.random(1,200000)

	print(time)
	print(item)
	print(range)
	print(sid)
	
	-- timer.Create("ispawn" .. sid,time,0,function()
	
	-- 	local grow = ents.Create("da_drop")
		
	-- 	local x = math.random(-range,range)
	-- 	local y = math.random(-range,range)
	-- 	local z = self:GetPos().z+20
		
	-- 	grow:SetPos(self:GetPos()+Vector(x,y,z))
	-- 	grow:SetNWString("item",item)
	-- 	grow:SetNWInt("amount",1)
	-- 	grow:Spawn()
		
	-- 	local entphys = grow:GetPhysicsObject();	
	-- 	entphys:SetVelocity(Vector(0,0,-10))

	-- 	timer.Simple(time,function()
		
	-- 		if (grow:IsValid()) then
			
	-- 		grow:Remove()
			
	-- 		end
		
	-- 	end)	
	
	-- end)
	
end

function ENT:KeyValue(key, value)

	if (key == "item") then

		self:SetNWString("item",value)

	end
	
	if (key == "range") then
	
		self:SetNWInt("range",value)
	
	end
	
	if (key == "time") then
	
		self:SetNWInt("time",value)
	
	end

end