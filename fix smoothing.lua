local SS13 = require("SS13")

local maxz = dm.world.maxz

for z=1, maxz do
	dm.global_procs.smooth_zlevel(z, true)
	SS13.check_tick()
end
