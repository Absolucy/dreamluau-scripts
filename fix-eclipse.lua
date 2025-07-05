local SS13 = require("SS13")

local default_atmos = "o2=22;n2=82;TEMP=293.15"
local base_mix = dm.global_vars.SSair:parse_gas_string(default_atmos)

local a = dm.global_procs._locate(65, 191, 6)
local b = dm.global_procs._locate(191, 65, 7)

local block = dm.global_procs._block(a, b)

local fixed = 0
dm.global_vars.SSair.can_fire = false
for _, tile in block do
	tile.initial_gas_mix = default_atmos
	if tile.blocks_air ~= 1 then
		tile:copy_air(base_mix:copy())
		fixed = fixed + 1
	end
	SS13.check_tick()
end
dm.global_vars.SSair.can_fire = true

print("fixed air on " .. tostring(fixed) .. " tiles")
