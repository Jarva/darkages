bgtime = 0
respawntime = 0
bgscore = {}

function BGHud()

	if (bgtime > 0) then

		draw.RoundedBox(4,ScrW()/2 - 250,0,500,50,Color(0,0,0,128))
		draw.RoundedBox(50,ScrW()/2 - 100,0,200,100,Color(0,0,0,128))

		draw.SimpleText(string.ToMinutesSeconds(bgtime),"Trebuchet24",ScrW() / 2,50,Color(255,255,255,255),1,3)

		if (respawntime != 0) then

			draw.SimpleText(respawntime,"Trebuchet24",ScrW() / 2,75,Color(255,255,255,255),1,3)

		end
		
		draw.SimpleText(draw.SimpleText(BGTeams[teams[1]].name,"HudHintTextLarge",ScrW() / 2 - 150,5,Color(255,255,255,255),1,3))
		draw.SimpleText(draw.SimpleText(BGTeams[teams[2]].name,"HudHintTextLarge",ScrW() / 2 + 150,5,Color(255,255,255,255),1,3))
		
		draw.RoundedBox(2,ScrW()/2 - 240,25,130,20,Color(0,0,0,200))
		draw.RoundedBox(2,ScrW()/2 + 110,25,130,20,Color(0,0,0,200))
		
		draw.RoundedBox(2,ScrW()/2 - 238,27,126 * (bgscore[teams[1]] / Battleground[bgid].sct),16,BGTeams[teams[1]].color)
		draw.RoundedBox(2,ScrW()/2 + 112,27,126 * (bgscore[teams[2]] / Battleground[bgid].sct),16,BGTeams[teams[2]].color)
		
		draw.SimpleText(bgscore[teams[1]] .. " / " .. Battleground[bgid].sct,"HudHintTextLarge",ScrW() / 2 - 150,35,Color(255,255,255,255),1,1)
		draw.SimpleText(bgscore[teams[2]] .. " / " .. Battleground[bgid].sct,"HudHintTextLarge",ScrW() / 2 + 150,35,Color(255,255,255,255),1,1)

	end
end
hook.Add("HUDPaint","BGHud",BGHud)

function BGTime(data)

bgtime = data:ReadShort()
bgid = data:ReadString()

end
usermessage.Hook("bgtime",BGTime)

function RespawnTime(data)

respawntime = data:ReadShort()

end
usermessage.Hook("respawn",RespawnTime)

function Teams(data)

teams = string.Explode(" ",data:ReadString())

for k,v in pairs(teams) do

bgscore[v] = 0

end

end
usermessage.Hook("bgteams",Teams)

function Score(data)

local bgteam = data:ReadString()
bgscore[bgteam] = bgscore[bgteam] + 1

end
usermessage.Hook("bgscore",Score)

function BGEnd()

	for k,v in pairs(bgscore) do

		bgscore[k] = 0
		bgtime = 0
		respawntime = 0

	end

end
usermessage.Hook("bgend",BGEnd)

//ScoreBoard

function BGScoreBoardDraw()

	if (bgtime > 0) then

		if (input.IsKeyDown(KEY_C)) then
		
			if (ChatBoxShow) then return end
		
			draw.RoundedBox(4,ScrW()/2 - 250,120,200,26,Color(0,0,0,200))
			draw.SimpleText(Battleground[bgid].name,"BudgetLabel",ScrW() / 2-150,133,Color(255,255,255,255),1,1)
		
			local i = 1
			for k,v in pairs(bg.players) do
			
				local tc = BGTeams[k].color
			
				draw.RoundedBox(4,ScrW()/2 - 250,120 + i * 30,500,26,Color(tc.r,tc.g,tc.b,200))
				draw.SimpleText(BGTeams[k].name,"CenterPrintText",ScrW() / 2-240,133 + i * 30,Color(255,255,255,255),0,1)
				draw.SimpleText("Dead","CenterPrintText",ScrW() / 2-42,133 + i * 30,Color(255,255,255,255),1,1)
				draw.SimpleText("Kills","CenterPrintText",ScrW() / 2+50,133 + i * 30,Color(255,255,255,255),1,1)
				draw.SimpleText("Deaths","CenterPrintText",ScrW() / 2+150,133 + i * 30,Color(255,255,255,255),1,1)
				
				i = i + 1
			
				for x,y in pairs(v) do
				
				local ply = findBySteamID(y)
				
				draw.RoundedBox(4,ScrW()/2 - 250,120 + i * 30,500,26,Color(0,0,0,200))
				
				local name = ply:Nick()
				
				if (!ply:Alive()) then

				local QuadTable = {}  
				QuadTable.texture 	= surface.GetTextureID( "gui/skull" )
				QuadTable.color		= Color( 10, 10, 10, 120 ) 
			 	QuadTable.x = ScrW() / 2 - 50
				QuadTable.y = 125 + i * 30 
				QuadTable.w = 16
				QuadTable.h = 16
				draw.TexturedQuad( QuadTable )
				
				end
				
				draw.SimpleText(name,"CenterPrintText",ScrW() / 2-240,133 + i * 30,Color(255,255,255,255),0,1)
				draw.SimpleText(bg.kills[y],"CenterPrintText",ScrW() / 2+50,133 + i * 30,Color(255,255,255,255),1,1)
				draw.SimpleText(bg.deaths[y],"CenterPrintText",ScrW() / 2+150,133 + i * 30,Color(255,255,255,255),1,1)
				
				i = i + 1
				
				end
				
				i = i + 1
			
			end

		end

	end

end
hook.Add("HUDPaint","BGScoreBoardDraw",BGScoreBoardDraw)

function BGData()

local data = net.ReadTable()

bg = data

end
net.Receive("bgdata",BGData)
