function QuestSpawn(ply)

local data = {}

for k,v in pairs(Quests) do

	data[k] = Quests[k].task

end

net.Start("questtasks")
	net.WriteTable(data)
net.Send(ply)

end
hook.Add("PlayerSpawn","QuestSpawn",QuestSpawn)

function QuestAbandon(ply,cmd,args)

	local qname = args[1]

	ply.data.quests[qname] = nil
	
	HudText(ply,"You have just abandoned the quest : " .. Quests[qname].title)
	file.Write("darkages/Save/"..ply:UniqueID()..".txt",util.TableToKeyValues(ply.data) )

end
concommand.Add("QuestAbandon",QuestAbandon)

function QuestEnd(ply,cmd,args)

	local qname = args[1]

	for k,v in pairs(Quests[qname].requirements) do

		GiveRes(ply,k,-v)

	end

	for k,v in pairs(Quests[qname].rewards) do

		GiveRes(ply,k,v)
	
	end

	for k,v in pairs(Quests[qname].xprewards) do

		GiveXP(ply,k,v)

	end
	
	AddToStat(ply,"quests",1)
	
	ply.data.quests[qname] = "Completed"
	HudText(ply,"You have just completed the quest : " .. Quests[qname].title)
	file.Write("darkages/Save/"..ply:UniqueID()..".txt",util.TableToKeyValues(ply.data) )
	

end
concommand.Add("QuestEnd",QuestEnd)

function QuestItem(ply,cmd,args)

	local qname = args[1]
	local qitem = args[2]

	GiveRes(ply,qitem,1)

	file.Write("darkages/Save/"..ply:UniqueID()..".txt",util.TableToKeyValues(ply.data) )
	

end
concommand.Add("QuestItem",QuestItem)

function QuestAccepted(ply,cmd,args)
	
local qname = args[1]

	if (ply.data.quests == nil) then ply.data.quests = {} end
	
	ply.data.quests[qname] = "TIP"

	HudText(ply,"You have accepted the quest : " .. Quests[qname].title)

file.Write("darkages/Save/"..ply:UniqueID()..".txt",util.TableToKeyValues(ply.data) )

end
concommand.Add("QuestAccepted",QuestAccepted)