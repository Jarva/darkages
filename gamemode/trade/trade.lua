function WantTrade(ply,cmd,args)

	if (!ply:GetEyeTrace().Entity:IsPlayer()) then return end
	if (ply:GetEyeTrace().Entity:GetPos():Distance(ply:GetPos()) > 128) then return end		

	local mate = ply:GetEyeTrace().Entity
	
	if (mate:GetNWEntity("trade") == nil or mate:GetNWEntity("trade") != ply) then
	
	ply:SetNWEntity("trade",mate)
	umsg.Start("traderequest",mate)
	umsg.String(ply:Nick() .. " wants to trade with you")
	umsg.End()

	print(ply:Nick() .. " has requested the trade with : " .. ply:GetNWEntity("trade"):Nick())
	
	else
	
	ply:SetNWEntity("trade",mate)
					
	print(ply:Nick() .. " has requested the trade with : " .. ply:GetNWEntity("trade"):Nick())


	umsg.Start("tradestart",ply)
	umsg.Entity(mate)
	umsg.End()
	
	umsg.Start("tradestart",mate)
	umsg.Entity(ply)
	umsg.End()
				
	end

end
concommand.Add("invitetotrade",WantTrade)

function DA_TradeChange(ply,cmd,args)

	local item = args[1]
	local amount = args[2]

	umsg.Start("tradechange",ply:GetNWEntity("trade"))
		umsg.String(item)
		umsg.Short(amount)
	umsg.End()

end
concommand.Add("da_tradechange",DA_TradeChange)

function DA_TradeDeclined(ply,cmd,args)

	umsg.Start("tradedeclined",ply:GetNWEntity("trade"))
	umsg.End()

	local mate = GetTradeMate(ply)
	mate:SetNWEntity("trade",mate)
	ply:SetNWEntity("trade",ply)

end
concommand.Add("tradedeclined",DA_TradeDeclined)

function GetTradeMate(ply)

	return ply:GetNWEntity("trade")

end

function DA_TradeAccepted(ply,cmd,args)

print(ply:Nick() .. " has accepted the trade with : " .. ply:GetNWEntity("trade"):Nick())

umsg.Start("mateaccepted",ply:GetNWEntity("trade"))
umsg.End()

end
concommand.Add("tradeaccepted",DA_TradeAccepted)

function TradeFinish(len,ply)

	local data = net.ReadTable()

	for k,v in pairs(data.trade) do

		GiveRes(ply,k,-v)
	
	end
	
	for k,v in pairs(data.mate) do

		if (ply.data.inventory[k] == nil) then ply.data.inventory[k] = 0 end
	
		GiveRes(ply,k,v)
	
	end
	
	timer.Simple(1,function() ply:SetNWEntity("trade",ply) end)
	
end
net.Receive("tradefinish",TradeFinish)