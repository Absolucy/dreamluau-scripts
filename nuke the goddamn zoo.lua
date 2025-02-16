local SS13 = require("SS13")

-- set to true to actually delete the mobs.
-- otherwise it'll just print how many mobs it found
local actually_delete = false

local function should_delete(mob)
	if not SS13.is_valid(mob) then
		return false
	end
	if not (SS13.istype(mob, "/mob/living/basic") or SS13.istype(mob, "/mob/living/simple_animal")) then
		return false
	end
	if mob.ckey ~= nil or mob.client ~= nil then
		return false
	end
	if not SS13.istype(mob.loc.loc, "/area/station/hallway/primary/fore") then
		return false
	end
	return true
end

local total = 0

for _, mob in dm.global_vars.GLOB.mob_living_list do
	SS13.check_tick()
	if should_delete(mob) then
		total += 1
		if actually_delete then
			SS13.qdel(mob)
		end
	end
end

print("found " .. tostring(total))
