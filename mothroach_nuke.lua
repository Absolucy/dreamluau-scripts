local SS13 = require("SS13")

SS13.register_signal(dm.global_vars.SSdcs, "!mob_created", function(_source, mob)
	if SS13.istype(mob, "/mob/living/basic/mothroach") then
		--mob:visible_message("<span class='danger'>" .. tostring(mob.name) .. " evaporates due to the Anti-Mothroach Defense System!</span>")
		--mob:dust()
		mob.ai_controller:set_ai_status("ai_off")
	end
end)
