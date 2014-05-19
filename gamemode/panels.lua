Frame = {}

function Frame:Init()

end

function Frame:Paint()

	width = self:GetWide()
	height = self:GetTall()

	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect( 0 , 0, width, height )
	
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(1, 1, width - 2, height - 2)

end
vgui.Register("GFrame",Frame,"DFrame")

Button = {}

function Button:Init()

end

function Button:Paint()

	width = self:GetWide()
	height = self:GetTall()

	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect( 0 , 0, width, height )
	
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(1, 1, width - 2, height - 2)

end
vgui.Register("GButton",Button,"DButton")

Panel = {}

function Panel:Init()

end

function Panel:Paint()

	width = self:GetWide()
	height = self:GetTall()

	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect( 0 , 0, width, height )
	
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(1, 1, width - 2, height - 2)

end
vgui.Register("GPanel",Panel,"DPanel")

PanelList = {}

function PanelList:Init()

end

function PanelList:Paint()

	width = self:GetWide()
	height = self:GetTall()

	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect( 0 , 0, width, height )
	
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(1, 1, width - 2, height - 2)

end
vgui.Register("GPanelList",PanelList,"DPanelList")

Bar = {}

function Bar:Init()

end

function Bar:Paint()

	width = self:GetWide()
	height = self:GetTall()
	color = self.barcolor
	percent = self.percent
	text = self.text

	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect( 0 , 0, width, height )
	
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(1, 1, width - 2, height - 2)
	
	surface.SetDrawColor(color)
	surface.DrawRect(1, 1, (width - 2) * (percent/100) , height - 2)
	
	draw.SimpleText(text,"Default",width/2,height/2,Color(255,255,255,255),1,1)

end

function Bar:SetBarColor(r,g,b,a)

self.barcolor = Color(r,g,b,a)

end

function Bar:SetText(text)

self.text = text

end

function Bar:SetPercent(percent)

self.percent = percent

end

vgui.Register("GBar",Bar)

Text = {}

function Text:Init()

self.align = 0
self.valign = 0
self.font = "default"
self.text = ""

end

function Text:Paint()

draw.SimpleText(self.text,self.font,0,0,Color(255,255,255,255),self.align,self.valign)

end

function Text:SetFont(font)

self.font = font

end

function Text:SetText(text)

self.text = text
self:SetSize(500,500)

end

vgui.Register("GText",Text)

TextBox = {}

function TextBox:Init()

end

function TextBox:Paint()

width = self:GetWide()
height = self:GetTall()

surface.SetDrawColor(0,0,0,255)
surface.DrawOutlinedRect( 0 , 0, width, height )

surface.SetDrawColor(200, 200, 200, 200)
surface.DrawRect(1, 1, width - 2, height - 2)

end
vgui.Register("GTextBox",TextBox,"DTextEntry")

CFrame = {}

function CFrame:Init()

self.border = 1

end

function CFrame:Paint()

	width = self:GetWide()
	height = self:GetTall()

	for i=0,self.border do
	
	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect( 0 + i , 0 + i, width - i*2, height - i*2 )
	
	end
	
	surface.SetDrawColor(32, 32, 32, 255)
	surface.DrawRect(self.border, self.border, width - self.border * 2, height - self.border * 2)

end

function CFrame:SetBorder(b)

	self.border = b

end
vgui.Register("CFrame",CFrame,"DFrame")

CPanel = {}

function CPanel:Init()

end

function CPanel:Paint()

	width = self:GetWide()
	height = self:GetTall()

	for i=0,10 do
	
	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect( 0 - i , 0 - i, width + i*2, height + i*2 )
	
	end
	
	surface.SetDrawColor(176, 176, 176, 255)
	surface.DrawRect(1, 1, width - 2, height - 2)

end
vgui.Register("CPanel",CPanel,"DPanel")

Itemicon = {}

function Itemicon:Init()

self.Amount = 5

end

function Itemicon:PaintOver()

local w,h = self:GetSize()
 
draw.SimpleText(self.Amount,"Default",w-2,h-2,Color(255,255,255,255),2,4)

end

function Itemicon:SetAmount(amount)

self.Amount = amount

end

-- function Itemicon:Paint()

	-- local mx, my = gui.MousePos()
	-- local px, py = GetPanelPos(self)
	-- local pw = self:GetWide()
	-- local ph = self:GetTall()

	-- if (mx >= px and my >= py and mx <= px+pw and my <= py+ph ) then

		-- print(mx .. " " .. my .. " " .. px .. " " .. py .. " " .. pw .. " " .. ph)	

		-- showdesc = true
		
	-- else
	
		-- showdesc = false
		
	-- end

-- end
vgui.Register("Itemicon",Itemicon,"Spawnicon")

-- function GetPanelPos(panel)

	-- c = panel:GetParent()
	-- fx, fy = panel:GetPos()
	-- while (c != nil) do

		-- x, y = c:GetPos()
		-- fx = fx + x
		-- fy = fy + y
		-- c = c:GetParent()

	-- end
	-- return fx, fy

-- end