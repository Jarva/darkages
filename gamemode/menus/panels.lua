MenuIcon = {}

function MenuIcon:Init()

	self.MouseOver = false
	self.Texture = ""

end

function MenuIcon:Paint()

	local w,h = self:GetSize()

	if (self.MouseOver) then surface.SetDrawColor(Color(255,255,255,255)) else surface.SetDrawColor(Color(255,255,255,200)) end

	surface.SetTexture(surface.GetTextureID("gui/menu/background"))
	surface.DrawTexturedRect(0,0,w,h)

	surface.SetTexture(surface.GetTextureID(self.Texture))
	if (self.MouseOver) then surface.DrawTexturedRect(0,0,w,h) else surface.DrawTexturedRect(4,4,w-8,h-8) end

end

function MenuIcon:OnCursorEntered()

	self.MouseOver = true

end

function MenuIcon:OnCursorExited()

	self.MouseOver = false

end

function MenuIcon:SetTexture(text)

	self.Texture = text

end

function MenuIcon:SetFunc(func)

	self.Function = func

	end

function MenuIcon:OnMousePressed()

	net.Start(self.Function)
	net.SendToServer()

end
vgui.Register("MenuIcon",MenuIcon)

local MIcons = {}

QMenuIcon = {}

function QMenuIcon:Init()

	self.MouseOver = false
	self.Name = ""

end

function QMenuIcon:Paint()

	local w,h = self:GetSize()

	surface.SetTexture(surface.GetTextureID("gui/menu/quickmenu_background"))
	surface.SetDrawColor(Color(255,255,255,255))
	surface.DrawTexturedRect(0,0,w,h)

	draw.SimpleText(self.Name , "AdventureM", 100, 12, Color(255,255,255,255), 1, 1 ) 

end

function QMenuIcon:OnCursorEntered()

	self.MouseOver = true

end

function QMenuIcon:OnCursorExited()

	self.MouseOver = false

end
function QMenuIcon:SetFunc(func)

	self.Function = func

	end

function QMenuIcon:OnMousePressed()

	self.Function()

end
function QMenuIcon:SetName(name)

	self.Name = name

end
vgui.Register("QMenuIcon",QMenuIcon)
