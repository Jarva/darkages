function DrinkPotion(ply,cmd,args)

local potion = args[1]

GiveRes(ply,potion,-1)
potions[potion](ply)

end
concommand.Add("DrinkPotion",DrinkPotion)

potions = {}

function potions.lhppotion(ply)

	timer.Create("hp_" .. math.random(1,1000000),1,5,function()
	
	RestoreHealth(ply,3)

	end)

end

function potions.hppotion(ply)

	timer.Create("hp_" .. math.random(1,1000000),1,5,function()
	
	RestoreHealth(ply,5)

	end)

end