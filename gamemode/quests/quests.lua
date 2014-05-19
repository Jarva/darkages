Quests = {}function AddQuest(id,name,quests,skills,items,requirements)Quests[id] = {}Quests[id].title = nameQuests[id].quests = questsQuests[id].xprewards = {}Quests[id].rewards = {}Quests[id].requirements = {}	for i = 1,table.Count(skills)/2 do	Quests[id].xprewards[skills[i*2-1]] = skills[i*2]	end		for i = 1,table.Count(items)/2 do	Quests[id].rewards[items[i*2-1]] = items[i*2]	end		for i = 1,table.Count(requirements)/2 do	Quests[id].requirements[requirements[i*2-1]] = requirements[i*2]	endend//Quests AddQuest("id","name","required quests",{xp rewards},{rewards},{required items})AddQuest("findingthecure","Finding the cure",{},{"alchemy",128},{"gold",256},{"zombie_venom",4})AddQuest("medicinesfortheweak","Medicines for the weak",{},{"alchemy",500},{"gold",100},{"hppotion",8})AddQuest("foodfortheweak","Food for the weak",{},{},{"gold",100},{"apple",2,"melon",2,"banana",2})AddQuest("disinfectingtheequipment","Disinfecting the equipment",{},{"firemaking",75},{"gold",50},{"tinderbox",1})AddQuest("mine5stone","The collapsed wall",{},{"mining",50},{"gold",25},{"stone",5})AddQuest("5bronze","In need of bronze",{},{"mining",100,"smithing",100},{"gold",50},{"bronze bar",5})AddQuest("bronzebars","A blacksmith's request",{},{"mining",175,"smithing",100},{"gold",75},{"bronze bar",5})AddQuest("daughterspresent","A present for my daughter",{},{"woodcutting",200},{"gold",200},{"birch",10,"willow",10,"pine",10,"teak",10,"yew",10})AddQuest("firewood","Keeping the city warm",{},{"woodcutting",450},{"gold",500},{"birch",40})AddQuest("fishcook","Fish for the cook",{},{"fishing",50,"cooking",50},{"gold",50},{"salmon",8})AddQuest("toomanysardines","Too many sardines",{},{"fishing",250},{"gold",100},{"sardine",25})AddQuest("weaponrequest","Weapons for our troops",{},{"smithing",250},{"gold",200},{"bronze_longsword",5,"iron_2hsword",3,"steel_longsword",2})AddQuest("showmeyourskills","A warrior's test",{},{"smithing",2000,"mining",500},{"gold",1000,"mithril_2hsword",1},{"mithril_2hsword",1})AddQuest("zombieinfection","The infection has spread",{},{"attack",100,"stregth",100,"defense",100},{"gold",100,"iron_longsword"},{"zombie_venom",15})AddQuest("cookinglesson","Royal cooking",{},{"cooking",125},{"gold",100},{"c_sardine",3})AddQuest("fisherman","The old fisherman",{},{"fishing",128},{"gold",64,"c_pike",2},{"pike",5,"salmon",5})AddQuest("supply","Supplies",{},{"mining",256,"woodcutting",256,"fishing",256},{"gold",128},{"birch",3,"teak",3,"iron ore",3,"pike",3})AddQuest("gifts","Gifts",{},{"mining",256},{"gold",128},{"copper ore",5,"tin ore",5,"sandstone",5})AddQuest("castlerepair","Castle wall repairing",{},{"mining",300},{"gold",300},{"sandstone",15})if SERVER then	AddCSLuaFile("cl_quest.lua" )	AddCSLuaFile("questhud.lua" )		include("quest.lua")	for k,v in pairs(Quests) do			Quests[k].task = file.Read("data/DarkAges/quests/" .. k .. ".txt","GAME")	end	endif CLIENT then	include("cl_quest.lua")	include("questhud.lua")end