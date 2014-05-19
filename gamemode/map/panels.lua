local MapFrame = {}

function MapFrame:Init()

	gui.EnableScreenClicker( true )

end

function MapFrame:DrawCloseButton()

	local w,h = self:GetSize()

	local exit = vgui.Create("MapEditorE",self)
	exit:SetPos(w-32,0)
	exit:SetSize(32,16)
	exit:SetCursor("hand")

end

function MapFrame:Paint()

	local w,h = self:GetSize()

	surface.SetDrawColor(220,200,0,255)
	surface.DrawOutlinedRect( 0,0, w,h )

	surface.SetDrawColor(220,200,0,16)
	surface.DrawRect( 0, 0, w, h )

end

vgui.Register("MapEditor",MapFrame)

MapFrameE = {}

function MapFrameE:Init()
end

function MapFrameE:OnMousePressed()
	self:GetParent():Remove()
	gui.EnableScreenClicker( false )
end

function MapFrameE:Paint()

	local w,h = self:GetSize()

	surface.SetDrawColor(220,200,0,255)
	surface.DrawOutlinedRect( 0,0, w,h )

	surface.SetDrawColor(220,200,0,200)
	surface.DrawRect( 0, 0, w, h )

	surface.SetTexture(surface.GetTextureID("gui/close"))
	surface.DrawTexturedRect( w / 4, 0, 16, 16 )

end
vgui.Register("MapEditorE",MapFrameE)

local MapButton = {}

function MapButton:Init()

	self.Text = "Test"
	self.Icon = "gui/skull"
	self.MouseOver = false
	self.IconSize = 24
	self.Option = ""

end

function MapButton:SetText(text)

	self.Text = text

end

function MapButton:SetIcon(icon)


	self.Icon = icon

end

function MapButton:SetOption(option)

self.Option = option

end

function MapButton:Paint()

	local w,h = self:GetSize()
	local text = self.Text
	local icon = self.Icon

	surface.SetDrawColor(220,200,0,255)
	surface.DrawOutlinedRect( 0,0, w,h )

	if (self.MouseOver) then surface.SetDrawColor(245,225,0,160) else surface.SetDrawColor(220,200,0,128) end
	
	surface.DrawRect( 0, 0, w, h )

	surface.SetDrawColor(255,255,255,255)

	surface.SetTexture(surface.GetTextureID(self.Icon))
	surface.DrawTexturedRect( (24 - self.IconSize) / 2, (24 - self.IconSize) / 2, self.IconSize, self.IconSize )

	surface.SetTextColor(255,255,255,255)
	if (self.MouseOver) then
		surface.SetFont("FairyM") 
		surface.SetTextPos(30,0)
	else
		surface.SetFont("Fairy")
		surface.SetTextPos(30,3)
	end
	
	surface.DrawText(self.Text)	

end

function MapButton:OnCursorEntered()

	self.MouseOver = true

end

function MapButton:OnCursorExited()

	self.MouseOver = false

end

function MapButton:OnMousePressed()

	self.IconSize = 16
	MAPEDITOR.DrawMode = self.Option


end

function MapButton:Think()

	if (self.IconSize < 24) then self.IconSize = self.IconSize + (8/0.2)*FrameTime() end

end

vgui.Register("MapEditorButton",MapButton)

local DrawArea = {}

function DrawArea:Init()



end

function DrawArea:Paint()

	local w,h = self:GetSize()

	surface.SetDrawColor(220,200,0,255)
	surface.DrawOutlinedRect( 0,0, w,h )

	surface.SetDrawColor(240,220,0,96)
	surface.DrawRect( 0, 0, w, h )

	for k,v in pairs(MAPEDITOR.DrawList) do

		for a,b in pairs(MAPEDITOR.DrawList[k]) do
		
		MDraw[k](MAPEDITOR.DrawList[k][a].data,MAPEDITOR.DrawList[k][a].options)

		end

	end

	x,y = self:CursorPos()

	if(x < 0 or y < 0 or x > 600 or y > 480) then return end

	if(x < 300 and y < 240) then
		draw.SimpleText("[" .. x .. "|" .. y .. "]","Fairy",x,y,Color(255,255,255,255),0,3)
	elseif(x > 300 and y < 240) then
		draw.SimpleText("[" .. x .. "|" .. y .. "]","Fairy",x,y,Color(255,255,255,255),2,3)
	elseif(x < 300 and y > 240) then
		draw.SimpleText("[" .. x .. "|" .. y .. "]","Fairy",x,y,Color(255,255,255,255),0,4)
	elseif(x > 300 and y > 240) then
		draw.SimpleText("[" .. x .. "|" .. y .. "]","Fairy",x,y,Color(255,255,255,255),2,4)
	end

end

function DrawArea:OnMousePressed(mouse)

	if (mouse == MOUSE_LEFT) then

		x,y = self:CursorPos()

		if(x < 300 and y < 240) then

		end

		MAPEDITOR.Clicks = MAPEDITOR.Clicks + 1
		MEDraw[MAPEDITOR.DrawMode](x,y,MAPEDITOR.Clicks)

	end

	if (mouse == MOUSE_RIGHT) then

		if (MAPEDITOR.Clicks  > 0) then

			MAPEDITOR.Clicks = 0

			local i = table.Count(MAPEDITOR.DrawList[MAPEDITOR.LastStarted])
			MAPEDITOR.DrawList[MAPEDITOR.LastStarted][i] = nil

		end

	end

end

function DrawArea:OnKeyCodePressed(key)

print(key)

end

vgui.Register("DrawArea",DrawArea)
