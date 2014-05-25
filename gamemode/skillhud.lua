function SkillHud()

	local i = 0

	if (stracks == nil) then return end
	if (plydata == nil or plydata.skills == nil) then return end
	
	for k,v in pairs(stracks) do
	
		draw.RoundedBox(4,10,100+i*50,25,25,Color(0,0,0,128))
		draw.RoundedBox(4,10,100+i*50+25,120,20,Color(0,0,0,200))
		draw.RoundedBox(4,12,100+i*50+27,plydata.skills[k.."xp"]/LevelXP[plydata.skills[k]]*116,16,Color(20,70,200,128))
		
		draw.SimpleText( plydata.skills[k], "KnightM", 22, 100+i*50+12, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( k, "Knight", 130, 100+i*50+5, Color(255,255,255,255), TEXT_ALIGN_RIGHT )
		draw.SimpleText( math.Round(plydata.skills[k.."xp"]) .. " / " .. LevelXP[plydata.skills[k]], "Default", 60, 100+i*50+28, Color(255,255,255,255), TEXT_ALIGN_CENTER )
		
		i = i + 1
		
	end

end
hook.Add("HUDPaint","SHud",SkillHud)