AddDropModel("king letter","models/jakemodels/jk_scroll.mdl",0)
AddDropModel("hppotion","models/darkages/da_potionbig.mdl",0)
AddDropModel("lhppotion","models/darkages/da_potionsmall.mdl",0)
AddDropModel("red_mushroom","models/medieval/mushm_static.mdl",0)
AddDropModel("gold","models/darkages/coin.mdl",0)
AddDropModel("tinderbox","models/darkages/tinderbox.mdl",0)

AddDropModel("fishing_rod","models/PG_props/pg_weapons/pg_fishing_rod_w.mdl",0)

AddDropModel("test_bow","models/PG_props/pg_weapons/pg_short_bow_w.mdl",0)

AddDropModel("melon","models/props_junk/watermelon01.mdl",0)
AddDropModel("banana","models/props/cs_italy/bananna.mdl",0)
AddDropModel("apple","models/jakemodels/jk_apple.mdl",0)

AddDropModel("birch","models/pg_props/pg_forest/pg_trunk_piece.mdl",0)
AddDropModel("willow","models/pg_props/pg_forest/pg_trunk_piece.mdl",1)
AddDropModel("pine","models/pg_props/pg_forest/pg_trunk_piece.mdl",2)
AddDropModel("teak","models/pg_props/pg_forest/pg_trunk_piece.mdl",3)
AddDropModel("yew","models/pg_props/pg_forest/pg_trunk_piece.mdl",4)

AddDropModel("fire_rune","models/darkages/runes_all.mdl",2)
AddDropModel("water_rune","models/darkages/runes_all.mdl",1)
AddDropModel("nature_rune","models/darkages/runes_all.mdl",3)
AddDropModel("solar_rune","models/darkages/runes_all.mdl",0)
AddDropModel("air_rune","models/darkages/runes_all.mdl",4)
AddDropModel("moon_rune","models/darkages/runes_all.mdl",5)
AddDropModel("rune_essence","models/darkages/rune_ess_mined.mdl",0)



AddDropModel("orb_of_water","models/darkages/orb.mdl",3)

AddDropModel("crystal_staff","models/pg_props/pg_weapons/pg_nature_stuff_w.mdl",0)
AddDropModel("master_staff","models/pg_props/pg_weapons/pg_light_staff_w.mdl",0)
AddDropModel("staff_of_fire","models/pg_props/pg_weapons/pg_beginner_staff_w.mdl",5)
AddDropModel("staff_of_water","models/pg_props/pg_weapons/pg_beginner_staff_w.mdl",4)
AddDropModel("staff_of_nature","models/pg_props/pg_weapons/pg_beginner_staff_w.mdl",3)
AddDropModel("staff_of_light","models/pg_props/pg_weapons/pg_beginner_staff_w.mdl",1)
AddDropModel("staff_of_air","models/pg_props/pg_weapons/pg_beginner_staff_w.mdl",0)
AddDropModel("staff_of_moon","models/pg_props/pg_weapons/pg_beginner_staff_w.mdl",2)

AddDropModel("sardine","models/pg_props/pg_obj/pg_fish.mdl",0)
AddDropModel("trout","models/pg_props/pg_obj/pg_fish.mdl",1)
AddDropModel("pike","models/pg_props/pg_obj/pg_fish.mdl",2)
AddDropModel("salmon","models/pg_props/pg_obj/pg_fish.mdl",3)
AddDropModel("bass","models/pg_props/pg_obj/pg_fish.mdl",4)

AddDropModel("c_sardine","models/pg_props/pg_obj/pg_fish.mdl",5)
AddDropModel("c_trout","models/pg_props/pg_obj/pg_fish.mdl",6)
AddDropModel("c_pike","models/pg_props/pg_obj/pg_fish.mdl",7)
AddDropModel("c_salmon","models/pg_props/pg_obj/pg_fish.mdl",8)
AddDropModel("c_bass","models/pg_props/pg_obj/pg_fish.mdl",9)

local WeaponSkins = {}
WeaponSkins["stone"] = 0
WeaponSkins["bronze"] = 1
WeaponSkins["iron"] = 2
WeaponSkins["steel"] = 3
WeaponSkins["mithril"] = 4

for k,v in pairs(WeaponSkins) do

AddDropModel(k .. "_pickaxe","models/PG_props/pg_weapons/pg_pickaxe_worldmodel.mdl",v)
AddDropModel(k .. "_axe","models/PG_props/pg_weapons/pg_axe_worldmodel.mdl",v)
AddDropModel(k .. "_longsword","models/PG_props/pg_weapons/pg_bastard_sword_w.mdl",v-1)
AddDropModel(k .. "_2hsword","models/PG_props/pg_weapons/pg_tumblr_sword_w.mdl",v-1)
AddDropModel(k .. "_scimitar","models/PG_props/pg_weapons/pg_scimitar_sword_w.mdl",v-1)

end

local SmithingSkins = {"bronze","iron","steel","mithril"}

for k,v in pairs(SmithingSkins) do

AddDropModel(v .. " bar","models/PG_props/pg_obj/bar.mdl",k-1)

end

local OreSkins = {"stone","tin ore","copper ore","coal","iron ore","mithril ore","sandstone"}

for k,v in pairs(OreSkins) do

AddDropModel(v,"models/PG_props/pg_obj/pg_ore_piece.mdl",k-1)

end 







