local SS13 = require("SS13")

-- set to true to actually delete the mobs.
-- otherwise it'll just print how many mobs it found
local actually_delete = true

-- you probably want this set to true if you're using this bc too much of something is lagging the server
local high_priority = true

-- list of typepaths to target
local types_to_delete = {
	"/mob/living/basic/chicken",
	"/mob/living/basic/chick"
}

-- list of area typepaths to target
local area_whitelist = {
	"/area/station/service/hydroponics"
}

local function get_turf(thing)
	return dm.global_procs._get_step(thing, 0)
end

local function get_area(thing)
	if SS13.istype(thing, "/area") then
		return thing
	else
		local turf = get_turf(thing)
		-- don't bother with SS13.is_valid, turfs don't get destroyed
		if dm.is_valid_ref(turf) then
			return turf.loc
		end
	end
	return nil
end

local function is_one_of_type(thing, type_list)
	if not dm.is_valid_ref(thing) then
		return false
	end
	for _, typepath in pairs(type_list) do
		if SS13.istype(thing, typepath) then
			return true
		end
	end
	return false
end

local function should_delete(thing)
	if not SS13.is_valid(thing) then
		return false
	end
	if SS13.istype(thing, "/mob") and (dm.is_valid_ref(thing.mind) or thing.ckey ~= nil) then -- don't delete any players!!
		return false
	end
	if not is_one_of_type(thing, types_to_delete) then
		return false
	end
	if not is_one_of_type(get_area(thing), area_whitelist) then
		return false
	end
	return true
end

local total = 0

local living_mobs = list.to_table(dm.global_vars.GLOB.mob_living_list)
for _, mob in pairs(living_mobs) do
	SS13.check_tick(high_priority)
	if should_delete(mob) then
		total += 1
		if actually_delete then
			SS13.qdel(mob)
		end
	end
end

print("found " .. tostring(total))
