function GM:OnPlayerChat( player, text, TeamOnly, PlayerIsDead )
	
	local tab = {}
	
	table.insert( tab, Color( 255, 255, 255 ) )
	table.insert( tab, "["..os.date("%H:%M").."]" )
	
	if ( PlayerIsDead ) then
		table.insert( tab, Color( 255, 30, 40 ) )
		table.insert( tab, "[DEAD]" )
	end
	
	if ( TeamOnly ) then
		table.insert( tab, team.GetColor(player:Team() ) )
		table.insert( tab, "["..team.GetName(player:Team()).."] " )
	end
	
	if ( IsValid( player ) ) then
		table.insert( tab, player )
	else
		table.insert( tab, "Console" )
	end
	
	table.insert( tab, Color( 255, 255, 255 ) )
	table.insert( tab, " : "..text )
	
	chat.AddText( unpack(tab) )

	return true
	
end

function ClanCreation(data)

	ClanN = data:ReadString()
	ClanNb = data:ReadShort()
	ClanCR = data:ReadShort()
	ClanCG = data:ReadShort()
	ClanCB = data:ReadShort()
	
	team.SetUp(ClanNb,ClanN,Color(ClanCR,ClanCG,ClanCB,255))	
			
end

usermessage.Hook("Clan", ClanCreation)