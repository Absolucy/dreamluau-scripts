local SS13 = require("SS13")

local SSair = dm.global_vars.SSair

local areas = {}

SSair.can_fire = false
--local total = 0
--local a = SS13.type("/turf/open/space")
for _, tile in SSair.active_turfs do
	local area = SS13.get_area(tile)
	local name = tostring(area.name)
	if not areas[name] then
		areas[name] = 0
	end
	areas[name] = areas[name] + 1
	SS13.check_tick(true)
end
for name, total in pairs(areas) do
	print(name .. ": " .. tostring(total) .. " active turfs")
end
SSair.can_fire = true
