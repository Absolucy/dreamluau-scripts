SS13 = require("SS13")
local goosemancer = dm.global_vars.GLOB.directory["target"].mob
local goose_crimes = SS13.new("/datum/action/cooldown/spell/conjure")
goose_crimes.summon_type = {SS13.type("/mob/living/simple_animal/hostile/retaliate/goose/vomit")}
goose_crimes.invocation = "THE GOOSE IS LOOSE"
goose_crimes.invocation_type = "shout"
goose_crimes.cooldown_time = 3000
goose_crimes.summon_amount = 5
goose_crimes.summon_radius = 3
goose_crimes.summon_respects_density = 1
goose_crimes.name = "Bring Forth The Geese"
goose_crimes.desc = "Exactly what it says on the tin. Try not to get caught in the crossfire."
goose_crimes.spell_requirements = 0
goose_crimes:Grant(goosemancer)
