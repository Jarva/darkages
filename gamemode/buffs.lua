function SetBuff(ply,tar,id)

	timer.Create(id .. "_" .. tar:UniqueID(),Buffs[id].time / Buffs[id].times,Buffs[id].times,function()
	
		if(ply:IsValid() and tar:IsValid()) then
		
			buffs[id](ply,tar)
			
		end
	
	end)

end

buffs = {}

function buffs.regrow(ply,tar)

	local effect = Magic["regrow"].effect[ply.data.magics["regrow"]]
	MagicHeal(ply,tar,"regrow")

end