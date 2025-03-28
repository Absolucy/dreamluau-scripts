
local SS13 = require("SS13")

-- set to true to actually delete the mobs.
-- otherwise it'll just print how many mobs it found
local actually_delete = false

-- you probably want this set to true if you're using this bc too much of something is lagging the server
local high_priority = true

local function typecacheof(string_types)
	local types = {}
	for _, path in pairs(string_types) do
		if path == nil then
			continue
		elseif dm.global_procs._ispath(path) == 1 then
			table.insert(types, path)
		else
			table.insert(types, SS13.type(path))
		end
	end
	return dm.global_procs.typecacheof(types)
end

-- typecache of things to delete
local delete_typecache = typecacheof({
	"/mob/living/basic/mouse",
	"/mob/living/carbon/human/species/monkey"
})

-- typecache of areas to target
local area_typecache = typecacheof({
	"/area/station/commons/storage/primary"
})

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

local function should_delete(thing)
	if not SS13.is_valid(thing) then
		return false
	end
	if SS13.istype(thing, "/mob") and (dm.is_valid_ref(thing.mind) or thing.ckey ~= nil) then -- don't delete any players!!
		return false
	end
	if not dm.global_procs._is_type_in_typecache(thing, delete_typecache) then
		return false
	end
	if not dm.global_procs._is_type_in_typecache(get_area(thing), area_typecache) then
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
