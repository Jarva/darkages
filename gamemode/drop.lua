function DA_Drop(len,ply)

	local data = net.ReadTable()

	local item = data[1]
	local amount = data[2]
	
	if (ply:GetActiveWeapon():GetClass() == item and ply.data.inventory[item] == tonumber(amount)) then
	
	ply:StripWeapons()
	ply:Give("hands")
	
	end
	
	if (amount == "All") then amount = ply.data.inventory[item] end
	amount = tonumber(amount)
	if (amount > ply.data.inventory[item]) then amount = ply.data.inventory[item] end

	GiveRes(ply,item,-amount)
	AddToStat(ply,"drops",1)
	
	local drop = ents.Create("da_drop")
	drop:SetNWString("item",item)
	drop:SetNWInt("amount",amount)
	drop:SetPos(ply:GetPos()+ply:GetAngles():Forward()*64+Vector(0,0,64))
	drop:Spawn()
	
	local entphys = drop:GetPhysicsObject()
	entphys:SetVelocity(ply:GetAngles():Forward()*64)
	
	
end
net.Receive("da_dropitem",DA_Drop)

function DA_TakeUpDrop(ply,drop)

	item = drop:GetNWString("item")
	amount = drop:GetNWInt("amount")
	
	GiveRes(ply,item,amount,false)
	
	drop:Remove()

end