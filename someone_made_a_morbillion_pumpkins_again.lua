SS13 = require("SS13")

local limit = 50
local base_areas_to_check = {
	"/area/shuttle/escape",
}

local deleted = 0
for _, base_area in base_areas_to_check do
	SS13.check_tick()
	local area_type = SS13.type(base_area)
	for _, turf in dm.global_procs.get_area_turfs(area_type, 0, true) do
		SS13.check_tick()
		local found = {}
		for _, thingy in turf.contents do
			SS13.check_tick()
			if SS13.istype(thingy, "/obj/item/food/grown") or SS13.istype(thingy, "/obj/item/seeds") then
				table.insert(found, thingy)
			end
		end
		if #found > limit then
			local coord = tostring(turf:Admin_Coordinates_Readable(true))
			print("deleting " .. tostring(#found) .. " plants/seeds at " .. coord)
			for _, thingy in found do
				SS13.check_tick()
				if SS13.qdel(thingy) then
					deleted = deleted + 1
				end
			end
		end
	end
end

print("deleted a total of " .. tostring(deleted) .. " plants")
