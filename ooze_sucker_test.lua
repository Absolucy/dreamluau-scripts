local SS13 = require("SS13")

local SSfastprocess_type = SS13.type("/datum/controller/subsystem/processing/fastprocess")

for _, sucker in dm.global_vars.SSmachines.get_machines_by_type_and_subtypes(SS13.type("/obj/machinery/plumbing/ooze_sucker")) do
	sucker:end_processing()
	sucker.subsystem_type = SSfastprocess_type
	sucker:begin_processing()
	SS13.check_tick()
end
