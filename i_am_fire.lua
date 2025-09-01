-- just adds a permanent fire overlay+examine
-- purely a visual gag.
local SS13 = require("SS13")

local user = SS13.get_runner_client().mob

-- Change to true to UNDO the effects
local remove = false

SS13.unregister_signal(user, "atom_update_overlays")
SS13.unregister_signal(user, "atom_examine")
if not remove then
	SS13.register_signal(user, "atom_update_overlays", function(source, new_overlays)
		local created_overlay = source:get_fire_overlay(2, true)
		if dm.is_valid_ref(created_overlay) then
			list.add(new_overlays, created_overlay)
		end
	end)
	SS13.register_signal(user, "atom_examine", function(source, examiner, examine_text)
		list.add(examine_text, "<span class='boldnotice'>She seems to be covered in flames. The flames do not seem to spread, nor do they seem to harm her.</span>")
	end)
end
user:cut_overlays()
user:regenerate_icons()
