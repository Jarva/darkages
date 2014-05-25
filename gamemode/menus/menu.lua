AddCSLuaFile("cl_skills.lua")
AddCSLuaFile("cl_inventory.lua")
AddCSLuaFile("cl_achievements.lua")
AddCSLuaFile("cl_quests.lua")
AddCSLuaFile("cl_spellbook.lua")
AddCSLuaFile("panels.lua")

util.AddNetworkString( "menu_inventory" )
util.AddNetworkString( "menu_map" )
util.AddNetworkString( "menu_skills" )
util.AddNetworkString( "menu_achi" )
util.AddNetworkString( "menu_stand" )
util.AddNetworkString( "menu_quest" )
util.AddNetworkString( "menu_spell" )

util.AddNetworkString( "skillmenu" )
util.AddNetworkString( "inventorymenu" )
util.AddNetworkString( "standbuild" )
util.AddNetworkString( "achimenu" )
util.AddNetworkString( "questmenu2" )
util.AddNetworkString( "spellmenu" )

function Menu_Inventory(len,ply)

	local data = {}

	data = ply.data.inventory

	net.Start("inventorymenu")
		net.WriteTable(data)
	net.Send(ply)

end
net.Receive("menu_inventory",Menu_Inventory)

function Menu_Skills(len,ply)

	local data = {}

	data = ply.data.skills

	net.Start("skillmenu")
		net.WriteTable(data)
	net.Send(ply)

end
net.Receive("menu_skills",Menu_Skills)

function Menu_Quests(len,ply)

	local data = {}
	if (ply.data.quests == nil) then ply.data.quests = {} end

	data = ply.data.quests

	net.Start("questmenu2")
		net.WriteTable(data)
	net.Send(ply)

end
net.Receive("menu_quest",Menu_Quests)

function Menu_Achi(len,ply)

	local data = {}

	data.stats = ply.data.stats
	data.achievements = ply.data.achievements

	net.Start("achimenu")
		net.WriteTable(data)
	net.Send(ply)

end
net.Receive("menu_achi",Menu_Achi)

function Menu_Stand(len,ply)

	net.Start("standbuild")
	net.Send(ply)

end
net.Receive("menu_stand",Menu_Stand)

function Menu_Spellbook(len,ply)

	if (ply.data.spellbar == nil) then ply.data.spellbar = {} end

	local data = {}
	data.spellbar = ply.data.spellbar
	data.magics = ply.data.magics

	net.Start("spellmenu")
		net.WriteTable(data)
	net.Send(ply)

end
net.Receive("menu_spell",Menu_Spellbook)