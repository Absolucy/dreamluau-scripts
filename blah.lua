local SS13 = require("SS13")
local target = SS13.get_runner_client().mob

SS13.register_signal(target, "spell_mob_enter_jaunt", function(jaunter, spell, jaunt)
	jaunter:remove_traits({"runechat_hidden"})
end)
