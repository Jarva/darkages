function findPlayerByName(name)

	for k,v in pairs(player.GetAll()) do

		local Ply = v
		local PlyN = Ply:Nick()

		local Y = string.find(PlyN,name)
	
		if (Y != nil) then
		
			if (Y > 0) then
				return Ply
			else
			
			end		
			
		end
	
	end
	
	return 0
	
end

function AddFriend(ply,fply)

if (ply.data.friends == nil) then ply.data.friends = {} end

	if (ply.data.friends[string.lower(fply:SteamID())] == nil) then

		ply.data.friends[fply:UniqueID()] = {}
		ply.data.friends[fply:UniqueID()].name = fply:Nick()
		ply.data.friends[fply:UniqueID()].id = fply:SteamID()
		ply.data.friends[fply:UniqueID()].last = os.date("%m/%d/%Y  %H:%M:%S")
		
		file.Write("darkages/Save/"..ply:UniqueID()..".txt",util.TableToKeyValues(ply.data))
		
		HudText(ply,fply:Nick() .. " has been added to your firendlist")
		
	else

		HudText(ply,fply:Nick().." is already your friend")

	end

end

function RefreshFriends(ply)

	for k,v in pairs(player.GetAll()) do

		if (v != ply and v.data.friends != nil) then
		
			for x,y in pairs(v.data.friends) do
			
				if (k == ply:UniqueID()) then
					
					v.data.friends[x].name = ply:Nick()
					v.data.friends[x].last = os.date("%m/%d/%Y  %H:%M:%S")
					
				end
			
			end
		
		end

	end

end
hook.Add("PlayerInitialSpawn","RefreshFriends",RefreshFriends)

function MenuAddFriend(ply,cmd,args)

local fply = findBySteamID(args[1])

AddFriend(ply,fply)

end
concommand.Add("MenuAddFriend",MenuAddFriend)

function RemoveFriend(ply,cmd,args)

local id = args[1]

ply.data.friends[id] = nil
file.Write("darkages/Save/"..ply:UniqueID()..".txt",util.TableToKeyValues(ply.data))

end
concommand.Add("RemoveFriend",RemoveFriend)

function F4Menu(ply)

if (ply.data.friends == nil) then ply.data.friends = {} end

net.Start("friends")
	net.WriteTable(ply.data.friends)
net.Send(ply)	

end
hook.Add("ShowSpare2","F4Menu",F4Menu)
