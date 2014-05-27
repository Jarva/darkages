GM.Name = "Dark Ages"
GM.Author = "Jarva and the Dark Ages team"

team.SetUp(2,"Adventurers",Color(130,80,50,255) )

--Basic Arrays

Trees = {}

function AddTree(entity,lvl,res,trunk,time)

Trees[entity] = {}
Trees[entity].lvl = lvl
Trees[entity].res = res
Trees[entity].trunk = trunk
Trees[entity].time = time

end

Ores = {}

function AddOre(entity,lvl,res,skin,skind,time)

Ores[entity] = {}
Ores[entity].level = lvl
Ores[entity].res = res 
Ores[entity].skin = skin
Ores[entity].skind = skind
Ores[entity].time = time

end

OreModels = {}
OreModels[1] = "models/PG_props/pg_forest/pg_ore_all.mdl"
OreModels[2] = "models/PG_props/pg_forest/pg_ore_all02.mdl"
OreModels[3] = "models/PG_props/pg_forest/pg_ore_all03.mdl"
OreModels[4] = "models/PG_props/pg_forest/pg_ore_all04.mdl"

LevelXP = {}
BackXP = {}

for I = 1,99 do

	for E = 1,I do
	
	if (E > 1) then
	BackXP[E] = BackXP[E-1] + (E-1) * (15+(E-1))
	else
	BackXP[E] = (E-1) * (15+(E-1))
	end
	
	
	end
	
LevelXP[I] = BackXP[I] + (I * (15+I))
	
end

Fishes = {}

function AddFish(id,weapon,lvl)

Fishes[id] = {}
Fishes[id].weapon = weapon
Fishes[id].level = lvl

end

Smithing = {}
SmithingLvL = {}

function AddSmith(material,res,lvl)

	Smithing[material] = {}
	SmithingLvL[material] = lvl
	
	for i = 1,table.Count(res) / 2 do

		Smithing[material][res[i*2-1]] = res[i*2]

	end

end

Crafting = {}

function AddCraft(item,lvl,res)

	Crafting[item] = {}
	Crafting[item].lvl = lvl
	Crafting[item].res = {}
	
	for i = 1,table.Count(res) / 2 do

		Crafting[item].res[res[i*2-1]] = res[i*2]

	end

end

Runes = {}

function AddRune(id,orb,lvl,multi)

Runes[id] = {}
Runes[id].orb = orb
Runes[id].level = lvl
Runes[id].multi = {}

for i=1,table.Count(multi) do

	Runes[id].multi[multi[i]] = i

end

end

Forging =  {}

function AddForge(material,item,lvl,res)
	
	if (Forging[material] == nil) then Forging[material] = {} end
	Forging[material][item] = {}
	Forging[material][item].lvl = lvl
	Forging[material][item].res = {}

	for i = 1,table.Count(res) / 2 do

		Forging[material][item].res[res[i*2-1]] = res[i*2]

	end

end

Potions = {}

function AddPotion(id,lvl,time,res)

	Potions[id] = {}
	Potions[id].lvl = lvl
	Potions[id].time = time
	Potions[id].res = {}

	for i=1,table.Count(res)/2 do

		Potions[id].res[res[i*2-1]] = res[i*2]

	end

end

resources = {}

function AddItem(item,name,sell,buy,weight)

		resources[item] = {}
		resources[item].name = name
		resources[item].sell = sell
		resources[item].buy = sell*12
		resources[item].weight = weight
end

Fireable = {}

function AddFireable(item,time,lvl)

Fireable[item] = {}
Fireable[item].time = time
Fireable[item].lvl = lvl

end

Plantable = {}
Plants = {}

function AddPlant(seed,plant,model)

Plantable[seed] = plant
Plants[plant] = {}
Plants[plant].seed = seed
Plants[plant].model = model

end

Eatable = {}

function AddEatable(food,hunger,health)

Eatable[food] = {}
Eatable[food].hunger = hunger
Eatable[food].health = health

end

Cook = {}

function AddCookable(food,lvl,res)

	Cook[food] = {}
	Cook[food].res = {}
	Cook[food].lvl = lvl

	for i = 1,table.Count(res) / 2 do

		Cook[food].res[res[i*2-1]] = res[i*2]

	end

end

Sweps = {}

function AddSwep(item,skill,lvl)

Sweps[item] = {}
Sweps[item].skill = skill
Sweps[item].lvl = lvl

end

Shops = {}

function AddShop(id,name,goods)

	Shops[id] = {}
	Shops[id].name = name
	Shops[id].goods = {}

	for i=1,table.Count(goods) do
	
		Shops[id].goods[i] = goods[i]
	
	end

end

Skills = {}
Skills[1] = "mining"
Skills[2] = "fishing"
Skills[3] = "woodcutting"
Skills[4] = "cooking"
Skills[5] = "firemaking"
Skills[6] = "runecrafting"
Skills[7] = "smithing"
Skills[8] = "prayer"
Skills[9] = "farming"
Skills[10] = "hitpoints"
Skills[11] = "strength"
Skills[12] = "defense"
Skills[13] = "alchemy"
Skills[14] = "attack"
Skills[15] = "crafting"
Skills[16] = "intellect"

CBSkills = {}
CBSkills[1] = "hitpoints"
CBSkills[2] = "strength"
CBSkills[3] = "defense"
CBSkills[4] = "attack"

Amounts = {}
Amounts[1] = 1
Amounts[2] = 5
Amounts[3] = 10
Amounts[4] = 20
Amounts[5] = 50
Amounts[6] = 100
Amounts[7] = "All"

DropModels = {}
DropSkins = {}

function AddDropModel(item,model,skin)

if (skin == nil) then skin = 0 end

DropModels[item] = model
DropSkins[item] = skin

end

MobInfo = {}

function SetMobInfo(mob,mtype,name,attack,strength,defense,health,drops,color,aggro)

MobInfo[mob] = {}
MobInfo[mob].mob = mtype
MobInfo[mob].attack = attack
MobInfo[mob].strength = strength
MobInfo[mob].defense = defense
MobInfo[mob].health = health
MobInfo[mob].name = name

MobInfo[mob].drops = drops

if (color == nil) then color = Color(255,255,255,255) end
MobInfo[mob].color = color

if (aggro == nil) then aggro = false end
MobInfo[mob].aggressive = aggro

end

Bosses = {}

function AddBoss(mob,mtype,name,attack,strength,defense,health,drops,token,tamount)

Bosses[mob] = {}
Bosses[mob].mob = mtype
Bosses[mob].attack = attack
Bosses[mob].strength = strength
Bosses[mob].defense = defense
Bosses[mob].health = health
Bosses[mob].name = name

Bosses[mob].drops = drops
Bosses[mob].token = token
Bosses[mob].tamount = tamount

end

Dungeons = {}

function AddDungeon(id,name,lvl)

Dungeons[id] = {}
Dungeons[id].name = name
Dungeons[id].lvl = lvl

end

Arena = {}

function AddArena(id,name,token)

Arena[id] = {}

if SERVER then

Arena[id].players = {}
Arena[id].players[1] = ""
Arena[id].players[2] = ""

end

Arena[id].name = name
Arena[id].status = "Queue"
Arena[id].token = token

end

Battleground = {}

function AddBattleground(id,name,ppt,sct,gm,token)

Battleground[id] = {}
Battleground[id].name = name
Battleground[id].ppt = ppt
Battleground[id].sct = sct
Battleground[id].gm = gm
Battleground[id].time = 0
Battleground[id].kills = {}
Battleground[id].deaths = {}
Battleground[id].score = {}
Battleground[id].status = "Queue"
Battleground[id].token = token

if SERVER then Battleground[id].players = {} end

end

BGTeams = {}

function AddBGTeam(id,name,color)

BGTeams[id] = {}
BGTeams[id].name = name
BGTeams[id].color = color

end

Tokens = {}

function AddToken(token,name)

Tokens[token] = name

end

function GetLength(text)

	local array = {}
	array = string.Explode("",text)

	local length = 0

	for k,v in pairs(array) do

		length = length + 1

	end
	
	return length


end

ArmorBones = {}

function AddArmorBone(armor,bone,bone2)

	ArmorBones[armor] = {}

	ArmorBones[armor].dual = false
	ArmorBones[armor].bone1 = bone

	if (bone2 != nil) then
		ArmorBones[armor].bone2 = bone2
		ArmorBones[armor].dual = true
	end

end

Armors = {}

function AddArmor(name,armor,model,skin,z,skill,lvl,up,forward,right)

Armors[name] = {}
Armors[name]["armor"] = armor
Armors[name]["skin"] = skin
Armors[name]["model"] = model
Armors[name]["skill"] = skill
Armors[name]["lvl"] = lvl
Armors[name]["z"] = z

Armors[name]["up"] = up
Armors[name]["forward"] = forward
Armors[name]["right"] = right

end

ArmorMenu = {}

function AddArmorMenu(type,name,x,y)

ArmorMenu[type] = {}
ArmorMenu[type].name = name
ArmorMenu[type].x = tonumber(x)
ArmorMenu[type].y = tonumber(y)

end

TVendors = {}

function AddTVendor(vendor,name,goods)

	TVendors[vendor] = {}
	TVendors[vendor]["name"] = name
	TVendors[vendor]["goods"] = {}

	for i=1,table.Count(goods) / 3 do

		local item = goods[i*3-2]
		local token = goods[i*3-1]
		local price = goods[i*3]
		
		

		TVendors[vendor]["goods"][item] = {}
		TVendors[vendor]["goods"][item]["token"] = token
		TVendors[vendor]["goods"][item]["price"] = price

	end


end

function AddTVItem(vendor,item,token,price)

	if (TVendors[vendor] == nil) then

		TVendors[vendor] = {}
		TVendors[vendor]["name"] = "Unnamed"
		TVendors[vendor]["goods"] = {}

	end

	TVendors[vendor]["goods"][item] = {}
	TVendors[vendor]["goods"][item]["token"] = token
	TVendors[vendor]["goods"][item]["price"] = price

end

Magic = {}

function AddMagic(id,name,element,lvls,cd,effect,gold,runes,cbzone)

Magic[id] = {}
Magic[id].name = name
Magic[id].element = element

Magic[id].lvls = {}
Magic[id].cd = {}
Magic[id].effect = {}
Magic[id].gold = {}
Magic[id].runes = {}

	for i=1,table.Count(lvls) do

	Magic[id].lvls[i] = lvls[i]
	Magic[id].cd[i] = cd[i]
	Magic[id].effect[i] = effect[i]
	Magic[id].gold[i] = gold[i]

	end
	
	for i=1,table.Count(runes) / 2 do

		local rune = runes[i*2-1]
		local amount = runes[i*2]
		
		Magic[id].runes[rune] = amount

	end
	
Magic[id].cbzone = cbzone

end

Buffs = {}

function AddBuff(id,time,times)

Buffs[id] = {}
Buffs[id].time = time
Buffs[id].times = times

end

HudEntities = {}

function AddHudEntity(entity,name,height,around)

HudEntities[entity] = {}
HudEntities[entity].name = name
HudEntities[entity].around = around
HudEntities[entity].height = height

end

ClanUpgrades = {}

function AddClanUpgrade(id,name,cost)

ClanUpgrades[id] = {}
ClanUpgrades[id].name = name
ClanUpgrades[id].cost = cost

end

Stats = {}
Achievements = {}

function AddStat(id,name)

Stats[id] = name

end

function AddAchievement(id,name,stat,amount)

Achievements[id] = {}
Achievements[id].name = name
Achievements[id].stat = stat
Achievements[id].amount = amount

end

StandParts = {}

function AddStandPart(name,model) 

	local x = table.Count(StandParts) + 1 

	StandParts[x] = {}
	StandParts[x].name = name
	StandParts[x].model = model

end

function GetIPrice(item,sellbuy)

	if (resources[item] != nil) then

		return resources[item][sellbuy]

	else

		return 1

	end

end

function GetIWeight(item)

	if (resources[item] != nil) then

		return tonumber(resources[item]["weight"])

	else

		return 0.1

	end

end

function GetIName(item)

	if (resources[item] == nil) then

		local length = string.len(item)		
		local name = string.upper(string.Left(item,1)) .. string.Right(item,length-1)
		name = string.Replace(name,"_"," ")
		return name
	
	else
	
		return resources[item].name
	
	end

end

function SortArray(array,key)

	local i = 1
	local temp = {}

	for k,v in pairs(array) do
	
		temp[i] = k
		i=i+1
	
	end

	if (key == nil) then

		for x = 1,table.Count(temp) do
		
			for y = 1,table.Count(temp) do
			
				local tempv = array[temp[y]]
			
				if (array[temp[y+1]] != nil and array[temp[y]] > array[temp[y+1]]) then
				
					temp[y] = temp[y+1]
					temp[y+1] = tempv
				
				end
			
			end
		
		end

	else

		for x = 1,table.Count(temp) do
		
			for y = 1,table.Count(temp) do
			
				local tempv = temp[y]
			
				if (array[temp[y+1]] != nil and array[temp[y]][key] > array[temp[y+1]][key]) then
				
					temp[y] = temp[y+1]
					temp[y+1] = tempv
				
				end
			
			end
		
		end

	end
	
	return temp

end

function SortArrayABC(array)

	local i = 1
	local temp = {}

	for k,v in pairs(array) do
	
		temp[i] = k
		i=i+1
	
	end

	for x = 1,table.Count(temp) do
	
		for y = 1,table.Count(temp) do
		
			local tempv = temp[y]
		
			if (array[temp[y+1]] != nil and string.byte(temp[y],1) > string.byte(temp[y+1],1)) then
			
				temp[y] = temp[y+1]
				temp[y+1] = tempv
			
			end
		
		end
	
	end
	
	return temp

end

if SERVER then

AddCSLuaFile( 'quests/quests.lua' )
AddCSLuaFile( 'adder.lua' )
AddCSLuaFile( 'dropmodels.lua' )
AddCSLuaFile( 'arena.lua' )
AddCSLuaFile( 'battlegrounds.lua' )

end

include('quests/quests.lua')
include('adder.lua')
include('dropmodels.lua')
include('arena.lua')
include('battlegrounds.lua')

function math.round(int,n)

	local int = tonumber(int)

	return math.Round( ( int*( 10^n ) ) ) / (10^n)

end

function ClanHasUpgrade(clan,upgrade)

if (clans[clan]["upgrades"] != nil and clans[clan]["upgrades"][upgrade] != nil) then return true else return false end

end

function GetPlayerNearPos(pos,range)

	local plys = {}
	
	local i = 1
	
	for k,v in pairs(ents.FindInSphere( pos, range )) do
	
		if (v:IsValid() and v:IsPlayer()) then
		
			plys[i] = v
			i = i + 1
		
		end
	
	end
	
	for x = 1,table.Count(plys) do
	
		for y = 1,table.Count(plys) do
	
			local z = plys[y]
			
			if (plys[y + 1] != nil and plys[y]:GetPos():Distance(pos) > plys[y+1]:GetPos():Distance(pos)) then
			
				plys[y + 1] = plys[y]
				plys[y] = z
			
			end
	
		end
	
	end
	
	return plys[1]

end

function stringToVector(text)

local vectors = string.Explode(" ",text)
return Vector(tonumber(vectors[1]),tonumber(vectors[2]),tonumber(vectors[3]))

end

function stringToAngle(text)

local angles = string.Explode(" ",text)
return Angle(tonumber(angles[1]),tonumber(angles[2]),tonumber(angles[3]))

end