local SS13 = require("SS13")

local cat_type = "/mob/living/simple_animal/pet/cat/void"
local name = "cat...?"
local desc = "<span class='hypnophrase big'>I wanna see what happens, mrow~</span>"

local user_client = SS13.get_runner_client()
local pos = SS13.get_turf(user_client.mob)

local cat = SS13.new(cat_type, pos)
cat.name = name
cat.real_name = name
cat.desc = desc
cat:mind_initialize()
cat.mind.name = name
cat:add_traits({"godmode", "xray_vision", "true_night_vision", "good_hearing", "xray_hearing", "noflash"}, "meow")
cat:update_sight()

local mirror_walk = SS13.new("/datum/action/cooldown/spell/jaunt/mirror_walk", cat)
mirror_walk:Grant(cat)

local bloodcrawl = SS13.new("/datum/action/cooldown/spell/jaunt/bloodcrawl", cat)
bloodcrawl:Grant(cat)

cat:PossessByPlayer(user_client.key)
