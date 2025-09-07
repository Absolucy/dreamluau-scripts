local SS13 = require("SS13")

-- type paths of areas to scan
local base_areas_to_check = {
	"/area/station/cargo/storage",
}

-- typecache of things to delete
local delete_typecache = SS13.typecacheof({
	"/obj/item/grown",
	"/obj/item/seeds"
})

-- if check_tick should be high-priority or not
-- honestly should prolly be true usually, as you're usually running this script when shit is laggy anyways
local high_priority = true

local _mob_type = SS13.type("/mob")

local function should_delete(thing)
	if not SS13.is_valid(thing) then
		return false
	end
	if not SS13.is_type_in_typecache(thing, delete_typecache) then
		return false
	end
	if (dm.global_procs._istype(thing, _mob_type) == 1) and (dm.is_valid_ref(thing.mind) or thing.ckey ~= nil) then -- don't delete any players!!
		return false
	end
	return true
end

local total_deleted = 0
for _, base_area in base_areas_to_check do
	SS13.check_tick(high_priority)
	local area_type = SS13.type(base_area)
	for _, turf in dm.global_procs.get_area_turfs(area_type, 0, true) do
		SS13.check_tick(high_priority)
		local deleted = 0
		for _, thingy in turf.contents do
			SS13.check_tick(high_priority)
			if should_delete(thingy) then
				SS13.qdel(thingy)
				deleted = deleted + 1
			end
		end
		if deleted > 0 then
			local coord = tostring(turf:Admin_Coordinates_Readable(true))
			print("deleted " .. tostring(deleted) .. " items at " .. coord)
			total_deleted = total_deleted + deleted
		end
	end
end

print("deleted a total of " .. tostring(total_deleted) .. " items")
