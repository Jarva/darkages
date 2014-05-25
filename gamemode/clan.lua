if (file.Exists("darkages/clans.txt","DATA")) then

	clans = util.KeyValuesToTable(file.Read("darkages/clans.txt","DATA"))

else

	clans = {}

end

for k,v in pairs(clans) do
	
		if (clans[k].bank == nil) then clans[k].bank = {} end
	
end

for k,v in pairs(clans) do

	local weight = 0
	for x,y in pairs(clans[k].bank) do	
		weight = weight + GetIWeight(x) * y	
	end	
	clans[k].bankweight = weight

end

function DA_CreateClan(ply,cmd,args)

	local name = args[1]
	local color = args[2]
	
	local id = string.lower(name)

	local x = {}
	x = string.Explode(",",color)

	local r = x[1]
	local g = x[2]
	local b = x[3]

	if (clans[id] != nil) then return end

	clans[id] = {}
	clans[id].color = r .. "," .. g .. "," .. b
	clans[id].name = name
	
	clans[id]["members"] = {}
	
	clans[id]["members"][ply:UniqueID()] = {}
	clans[id]["members"][ply:UniqueID()].name = ply:Nick()
	clans[id]["members"][ply:UniqueID()].rank = "leader"
	
	clans[id]["ranks"] = {}
	clans[id]["ranks"]["rookie"] = 0
	clans[id]["ranks"]["leader"] = 5

	clans[id]["bank"] = {}
	clans[id]["bankmax"] = 10
	clans[id]["bankweight"] = 0
	
	clans[id]["tax"] = "nothing"

	clans[id]["upgrades"] = {}
	
	ClanSave()
	
	ply.data.clan = id
	ply:SetNWString("clan",id)
	ply:SetNWBool("inclan",true)	
	GiveRes(ply,"gold",-2000)

end
concommand.Add("DA_CreateClan",DA_CreateClan)

function InviteToClan(ply,cmd,args)

	local id = ply:GetNWString("clan")
	local target = findBySteamID(args[2])

	umsg.Start("claninvite",target)
	umsg.String(id)
	umsg.End()

end
concommand.Add("InviteToClan",InviteToClan)

function ClanAccept(ply,cmd,args)

	local id = args[1]

	ply.data.clan = id

	clans[id]["members"][ply:UniqueID()] = {}
	clans[id]["members"][ply:UniqueID()].name = ply:Nick()
	clans[id]["members"][ply:UniqueID()].rank = "rookie"
	
	ply:SetNWString("clan",id)
	ply:SetNWBool("inclan",true)
	
	ClanSave()

end
concommand.Add("ClanAccept",ClanAccept)

function ClanDelete(ply,cmd,args)

	local id = ply:GetNWString("clan")

	for k,v in pairs(player.GetAll()) do
	
		if (id == v:GetNWString("clan")) then
	
		v.data.clan = nil
		ply:SetNWString("clan","")
		ply:SetNWBool("inclan",false)
		
		end
	
	end
	
	clans[id] = nil
	
	ClanSave()

end
concommand.Add("ClanDelete",ClanDelete)

function ClanLeave(ply,cmd,args)

	local clan = ply:GetNWString("clan")
	
	if (table.Count(clans[clan].members) == 1) then
	
		clans[clan] = nil
	
	else
	
		clans[clan].members[ply:UniqueID()] = nil
	
	end
	
	ClanSave()

	ply.data.clan = nil
	ply:SetNWString("clan","")
	ply:SetNWBool("inclan",false)

end
concommand.Add("ClanLeave",ClanLeave)

function ClanKick(ply,cmd,args)

	local clan = ply:GetNWString("clan")
	local member = args[1]
	local entmember = findPlayerByID(member)
	
	if (table.Count(clans[clan].members) == 1) then
	
		clans[clan] = nil
	
	else
	
		clans[clan].members[member] = nil
	
	end
	
	ClanSave()

	entmember.data.clan = nil
	entmember:SetNWString("clan","")
	entmember:SetNWBool("inclan",false)

end
concommand.Add("ClanKick",ClanKick)

function ClanSave()

	file.Write("darkages/clans.txt",util.TableToKeyValues(clans) )

	net.Start("clans")
		net.WriteTable(clans)
	net.Broadcast()

end

function AddClanRank(ply,cmd,args)

	local id = args[1]
	local rank = args[2]
	local right = tonumber(args[3])

	clans[id]["ranks"][rank] = right

	ClanSave()

end
concommand.Add("AddClanRank",AddClanRank)

function ClanPromote(ply,cmd,args)

	local id = args[1]
	local target = args[2]
	local rank = args[3]

	clans[id]["members"][target]["rank"] = rank
	
	ClanSave()

end
concommand.Add("ClanPromote",ClanPromote)

function ClanTax(ply,cmd,args)

	local id = args[1]
	local tax = args[2]

	clans[id]["tax"] = tax
	
	ClanSave()

end
concommand.Add("ClanTax",ClanTax)

function ClanBankSlot(ply,cmd,args)

	local id = args[1]
	local slot = args[2]
	
	GiveRes(ply,"gold",-200*slot)
	clans[id]["bankmax"] = clans[id]["bankmax"] + slot
	
	ClanSave()

end
concommand.Add("ClanBankSlot",ClanBankSlot)

//CLANBANK

function EditClanBank(ply,cmd,args)

	local id = ply:GetNWString("clan")
	local item = tostring(args[1])
	local amount = tonumber(args[2])

	if (clans[id].bank == nil) then clans[id].bank = {} end
	if (clans[id].bank[item] == nil) then clans[id].bank[item] = 0 end
	clans[id].bank[item] = clans[id].bank[item] + amount
	
	clans[id].bankweight = math.Round(clans[id].bankweight + (GetIWeight(item) * amount))

	for k,v in pairs(player.GetAll()) do
		
		if (v:GetNWString("clan") != nil and v:GetNWString("clan") == id) then
		
			if (v:GetNWBool("clanbank") != nil and v:GetNWBool("clanbank") == true) then
			
				umsg.Start("cbankedit",v)
				umsg.String(item)
				umsg.Short(amount)
				umsg.End()
			
			end
		
		end

	end
	
	ClanSave()
	
	GiveRes(ply,item,-amount,false)
	
end
concommand.Add("EditClanBank",EditClanBank)

function ClanChat(ply,text)

	if (string.sub(text,0,5) == "/clan") then
	
		if (ply:GetNWBool("inclan") == true) then
	
			for k,v in pairs(clans[ply:GetNWString("clan")].members) do
			
				if (findPlayerByID(k) != false) then
			
				umsg.Start("clanchat",findPlayerByID(k))
				umsg.String(ply:Nick())
				umsg.String(string.sub(text,6,string.len(text)))
				umsg.End()
				
				end
		
			end
		
		end
		
		return false
	
	end

end
hook.Add("PlayerSay","ClanChat",ClanChat)

function ClanBuyUpgrade(ply,cmd,args)

local id = ply:GetNWString("clan")
local upgrade = args[1]
local cost = ClanUpgrades[upgrade].cost

if (ply.data.inventory.gold < cost) then
	HudText(ply,"You don't have enough gold")
	return
end

GiveRes(ply,"gold",-cost)
HudText(ply,"You have bought a clan upgrade [ " .. ClanUpgrades[upgrade].name .. " ] for " .. cost .. " gold")

if (clans[id]["upgrades"] == nil) then clans[id]["upgrades"] = {} end

clans[id]["upgrades"][upgrade] = upgrade
ClanSave()

end
concommand.Add("ClanBuyUpgrade",ClanBuyUpgrade)

function PlayerHasClanUpgrade(ply,upgrade)

if (!ply:GetNWBool("inclan")) then return false end

local clan = ply:GetNWString("clan")

if (clans[clan]["upgrades"] != nil and clans[clan]["upgrades"][upgrade] != nil) then return true else return false end

end