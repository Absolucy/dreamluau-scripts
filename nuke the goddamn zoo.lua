local SS13 = require("SS13")

-- set to true to actually delete the mobs.
-- otherwise it'll just print how many mobs it found
local actually_delete = true

-- list of mob typepaths to target
local target_mobs = {
	"/mob/living/basic/chicken",
	"/mob/living/basic/chick"
}

-- list of area typepaths to target
local target_areas = {
	"/area/station/service/hydroponics"
}

local function is_one_of_type(thing, type_list)
	if not SS13.is_valid(thing) then
		return false
	end
	for _, typepath in pairs(type_list) do
		if SS13.istype(thing, typepath) then
			return true
		end
	end
	return false
end

local function should_delete(mob)
	if not (SS13.is_valid(mob) and SS13.is_valid(mob.loc) and SS13.is_valid(mob.loc.loc)) then
		return false
	end
	if mob.ckey ~= nil or mob.client ~= nil then
		return false
	end
	if not is_one_of_type(mob, target_mobs) then
		return false
	end
	if not is_one_of_type(mob.loc.loc, target_areas) then
		return false
	end
	return true
end

local total = 0

for _, mob in dm.global_vars.GLOB.mob_living_list do
	SS13.check_tick(true)
	if should_delete(mob) then
		total += 1
		if actually_delete then
			SS13.qdel(mob)
		end
	end
end

print("found " .. tostring(total))
