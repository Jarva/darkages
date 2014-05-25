function SetUp(len,ply)

	local data = net.ReadTable()

	ply.stand = {}
	ply.stand.stand = {}
	ply.stand.price = {}

	for k,v in pairs(data.stand) do

		ply.stand.stand[k] = v

	end

	for k,v in pairs(data.price) do
	
		ply.stand.price[k] = v

	end
	
	for k,v in pairs(data.stand) do

		GiveRes(ply,k,-v)

	end

	ply:SetNWString("title",data.text)
	ply:SetNWBool("stand",true)
	-- ply:Freeze(true)

	-- umsg.Start("standremovemenu",ply)
	-- umsg.End()


end
net.Receive("standsetup",SetUp)

function SpawnStandProp(len,ply)

	local data = net.ReadTable()

	local ent = ents.Create("da_marketprop")
	ent:SetNWEntity("owner",ply)
	ent:SetModel(data.model)
	ent:SetPos(data.pos)
	ent:SetAngles(data.ang)
	ent:Spawn()

end
net.Receive("spawnstandprop",SpawnStandProp)

function BuyStand(ply,cmd,args)

local item = args[1]
local amount = args[2]

local owner = ply:GetNWEntity("standbuy")

owner.stand.stand[item] = owner.stand.stand[item] - amount

local soldeverything = true

for k,v in pairs() do

	if (owner.stand.stand[item] > 0) then soldeverything = false end

end

GiveRes(owner,"gold",amount * owner.stand.price[item])
GiveRes(ply,"gold",-(amount * owner.stand.price[item]))
GiveRes(ply,item,amount)

end
concommand.Add("BuyStand",BuyStand)

function RemoveStandMenu(ply,cmd,args)

	for k,v in pairs(ply.stand.stand) do

		GiveRes(ply,k,v)

	end

	ply:SetNWBool("stand",false)
	ply:Freeze(false)
	
	for k,v in pairs(ents.GetAll()) do

		if (v:GetClass() == "da_marketprop") then
		
			if (v:GetNWEntity("owner") == ply) then
			
			v:Remove()
			
			end
		
		end
	
	end

end
concommand.Add("RemoveStandMenu",RemoveStandMenu)

function OpenStand(ply,key)

	if (key == IN_USE) then

		if (!ply:GetEyeTrace().Entity:IsPlayer()) then return end
		if (ply:GetEyeTrace().Entity:GetPos():Distance(ply:GetPos()) > 128) then return end		
		if (ply:GetEyeTrace().Entity:GetNWBool("stand") != true) then return end

		local seller = ply:GetEyeTrace().Entity

		local data = {}
		data.stand = {}
		data.price = {}
		data.name = seller:Nick()

		for k,v in pairs(seller.stand.stand) do

			if (v > 0) then
				data.stand[k] = v
			end

		end

		for k,v in pairs(seller.stand.price) do
			if (v > 0) then
				data.price[k] = v
			end
		end
		
		net.Start("standbuy")
			net.WriteTable(data)
		net.Send(ply)
		
		ply:SetNWEntity("standbuy",seller)

	end

end
hook.Add("KeyPress","OpenStand",OpenStand)
