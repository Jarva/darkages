util.AddNetworkString( "da_deposit" )
util.AddNetworkString( "da_widthdraw" )

function DA_BDeposit(len, ply)

local item = net.ReadString()
local amount = net.ReadDouble()

GiveRes(ply,item,-amount)
GiveBank(ply,item,amount)

end


function DA_BWidthdraw(len, ply)

local item = net.ReadString()
local amount = net.ReadDouble()

GiveRes(ply,item,amount,false)
GiveBank(ply,item,-amount)

end

net.Receive("da_deposit",DA_BDeposit)
net.Receive("da_widthdraw",DA_BWidthdraw)