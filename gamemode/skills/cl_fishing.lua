local NextPart = 0

function DrawFSpots()

	if (NextPart > CurTime()) then return end

	for k,v in pairs(ents.FindByClass("da_fishingspot")) do

		local center = v:GetPos() - Vector(0,0,20) + Vector(math.random(4,8),math.random(4,8),0)
		local em = ParticleEmitter(center)
		local part = em:Add("effects/bubble",center)
		if part then
			part:SetColor(255,255,255,255)
			part:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),1)*math.random(5,12))
			part:SetDieTime(2.5)
			part:SetLifeTime(0)
			part:SetStartSize(math.random(2,3))
			part:SetEndSize(1)
		end

		em:Finish()		

	end
	
	NextPart = CurTime() + 0.1

end
hook.Add("HUDPaint","DrawFSpots",DrawFSpots)