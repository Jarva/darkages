magics = {}

function magics.holy_light(data)

	local ply = data:ReadEntity()

	local center = ply:GetPos() + Vector(0,0,50)
	local em = ParticleEmitter(center)
	for i=1,600 do
		 local part = em:Add("sprites/light_glow02_add",center + ply:GetAimVector()*i)
		 if part then
			  part:SetColor(255,255,255,255)
			  part:SetVelocity(ply:GetAimVector() * 1000 + Vector(math.sin(i)-math.Rand(0,0.3),0,math.cos(i)-math.Rand(0,0.3)) * ((600-i)/200))
			  part:SetDieTime(3)
			  part:SetLifeTime(0)
			  part:SetStartSize(6)
			  part:SetEndSize(3)
		 end
	end
	em:Finish()	

end

function magics.heal(data)

	local ply = data:ReadEntity()
	local target = data:ReadEntity()
	
	local center = target:GetPos()
	local em = ParticleEmitter(center)
	for i=1,360 do
		 local part = em:Add("sprites/light_glow02_add",center)
		 if part then
			  part:SetColor(0,200,0,255)
			  part:SetVelocity(Vector(math.sin(i),math.cos(i),math.Rand(0,4)) * 5)
			  part:SetDieTime(4)
			  part:SetLifeTime(0)
			  part:SetStartSize(6)
			  part:SetEndSize(3)
		 end
	end
	em:Finish()	

end

function magics.gheal(data)

	local ply = data:ReadEntity()
	local target = data:ReadEntity()
	
	local center = target:GetPos()
	local em = ParticleEmitter(center)
	for i=1,720 do
		 local part = em:Add("sprites/light_glow02_add",center)
		 if part then
			  part:SetColor(0,200,0,255)
			  part:SetVelocity(Vector(math.sin(i),math.cos(i),math.Rand(0,8)) * 5)
			  part:SetDieTime(3)
			  part:SetLifeTime(0)
			  part:SetStartSize(7)
			  part:SetEndSize(3)
		 end
	end
	em:Finish()	

end

function magics.groupheal(data)

	local ply = data:ReadEntity()

	for k,target in pairs(ents.FindInSphere(ply:GetPos(),200)) do
	
		if (target:IsPlayer()) then
			
			local center = target:GetPos()
			local em = ParticleEmitter(center)
			for i=1,360 do
				 local part = em:Add("sprites/light_glow02_add",center)
				 if part then
					  part:SetColor(0,200,0,255)
					  part:SetVelocity(Vector(math.sin(i),math.cos(i),math.Rand(0,4)) * 5)
					  part:SetDieTime(4)
					  part:SetLifeTime(0)
					  part:SetStartSize(6)
					  part:SetEndSize(3)
				 end
			end
			em:Finish()	
		
		end
	
	end

end

function magics.holy_blast(data)

	local ply = data:ReadEntity()

		local center = ply:GetPos()
		local em = ParticleEmitter(center)
		for i=1,720 do
			 local part = em:Add("sprites/light_glow02_add",center+Vector(0,0,20))
			 if part then
				  part:SetColor(255,255,255,255)
				  part:SetVelocity(Vector(math.sin(i),math.cos(i),math.Rand(0,1)) * math.random(20,70))
				  part:SetDieTime(2.5)
				  part:SetLifeTime(0)
				  part:SetStartSize(6)
				  part:SetEndSize(3)
			 end
		end
		
		em:Finish()	

end


function magics.fire_circle(data)

	local ply = data:ReadEntity()

		local center = ply:GetPos()
		local em = ParticleEmitter(center)
		for i=1,30 do
			for x=1,2 do
				local part = em:Add("particles/flamelet" .. math.random(1,5),center+Vector(math.sin(i*6),math.cos(i*6),0.2) * 80)
				if part then
					part:SetColor(255,255,255,255)
					part:SetVelocity(Vector(math.sin(i*6)*-12,math.cos(i*6)*-12,math.random(0,5)))
					part:SetDieTime(3)
					part:SetLifeTime(0)
					part:SetStartSize(16)
					part:SetEndSize(4)
				end
			end
		end
		
		em:Finish()	

end

function magics.bubble_blast(data)
		
		local ply = data:ReadEntity()

		local center = ply:GetPos() + Vector(0,0,50)
		local em = ParticleEmitter(center)
		for i=1,360 do
			 local part = em:Add("effects/bubble",center)
			 if part then
				  part:SetColor(math.random(200,255),math.random(200,255),math.random(200,255),math.random(200,255))
				  local x = ply:GetAimVector().x			  
				  local y = ply:GetAimVector().y			  
				  local z = ply:GetAimVector().z			  
				  part:SetVelocity(Vector(x+math.Rand(-0.5,0.5),y+math.Rand(-0.5,0.5),z+math.Rand(-0.5,0.5))*math.random(15,30))
				  part:SetDieTime(3)
				  part:SetLifeTime(0)
				  part:SetStartSize(math.random(1,3))
				  part:SetEndSize(1)
			 end
		end
		em:Finish()

end

for k,v in pairs(magics) do

usermessage.Hook(k,magics[k])

end

function SetCD(data)

local magic = data:ReadString()
local cd = data:ReadShort()
local weapon = LocalPlayer():GetActiveWeapon()
weapon.Cooldowns[magic] = CurTime() + cd

end
usermessage.Hook("setcd",SetCD)

function MagicHud()

	if (LocalPlayer():GetActiveWeapon().Magic != nil and plydata != nil and plydata.spellbar != nil and table.Count(plydata.spellbar) > 0) then
 
		local hudmagics = plydata.spellbar
		local hudmagic = plydata.spellbar[tostring(LocalPlayer():GetActiveWeapon().Magic)]

		for i=1,table.Count(hudmagics) do
		
			local n = tostring(i)
			
			if (hudmagics[n] == hudmagic) then
			
			draw.RoundedBox(4,ScrW() - 350,100 + i*25,100,20,Color(100,100,200,100))
			draw.SimpleText(Magic[hudmagics[n]].name,"ChatFont",ScrW() - 300,100 + i*25 + 10,Color(255,255,255,255),1,1)
			
			else
			
			draw.RoundedBox(4,ScrW() - 350,100 + i*25,100,20,Color(100,100,100,100))
			draw.SimpleText(Magic[hudmagics[n]].name,"ChatFont",ScrW() - 300,100 + i*25 + 10,Color(255,255,255,255),1,1)
			
			end
			
			local rmax = GetMaxRunes(hudmagics[n])
			
			draw.RoundedBox(4,ScrW() - 400,100 + i*25,40,20,Color(100,100,100,100))
			draw.SimpleText(rmax,"ChatFont",ScrW() - 380,100 + i*25 + 10,Color(255,255,255,255),1,1)
			
			local cd = LocalPlayer():GetActiveWeapon().Cooldowns[hudmagics[n]]
			
			if (cd != nil and cd > CurTime()) then
			
				if (cd-CurTime() < Magic[hudmagics[n]].cd[plydata.magics[hudmagics[n]]]) then
				
				draw.RoundedBox(4,ScrW() - 350,100 + i*25,100 * ((cd - CurTime()) / Magic[hudmagics[n]].cd[plydata.magics[hudmagics[n]]] ),20,Color(200,100,100,100))
				draw.SimpleText(math.round(cd - CurTime(),1),"ChatFont",ScrW() - 230,100 + i*25 + 10,Color(255,255,255,255),1,1)
				
				end
			
			end
		
		end

	end

end
hook.Add("HUDPaint","MagicHud",MagicHud)

local max = {}
local rune = {}

function GetMaxRunes(magic)

for k,v in pairs(Magic[magic].runes) do

	if (plydata.inventory[k] == nil) then max[magic] = 0 break end
	
	local a = plydata.inventory[k] % v
	local b = (plydata.inventory[k] - a) / v	
	
	if (max[magic] == nil) then
		max[magic] = b 
		rune[magic] = k
	end	
	
	if (max[magic] > b) then
		max[magic] = b
		rune[magic] = k
	end
	
	if (plydata.inventory[rune[magic]] != nil and plydata.inventory[rune[magic]] > max[magic]) then

	local a = plydata.inventory[k] % v
	local b = (plydata.inventory[k] - a) / v
	
	max[magic] = b
	
	end

end

return max[magic]

end