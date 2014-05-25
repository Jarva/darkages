function DA_ShopSell(ply,cmd,args)

local item = args[1]
local amount = tonumber(args[2])

local price = amount * GetIPrice(item,"sell")

GiveRes(ply,"gold",price,false)
GiveRes(ply,item,-amount)

if (ply.data.buyback == nil) then ply.data.buyback = {} end

ply.data.buyback.item = item
ply.data.buyback.amount = amount

end

function DA_ShopBuy(ply,cmd,args)

local item = args[1]
local amount = tonumber(args[2])

local price = amount * GetIPrice(item,"buy")

GiveRes(ply,"gold",-price)
GiveRes(ply,item,amount,false)

end

function DA_ShopBuyBack(ply,cmd,args)

local item = ply.data.buyback.item
local amount = ply.data.buyback.amount

local price = amount * GetIPrice(item,"buy")

GiveRes(ply,"gold",-price)
GiveRes(ply,item,amount,false)

ply.data.buyback = nil

end

concommand.Add("DA_ShopSell",DA_ShopSell)
concommand.Add("DA_ShopBuy",DA_ShopBuy)
concommand.Add("DA_ShopBuyBack",DA_ShopBuyBack)

