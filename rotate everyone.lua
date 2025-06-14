local SS13 = require("SS13")

local user = SS13.get_runner_client()
local angle = SS13.await(
	SS13.global_proc,
	"tgui_input_number",
	user,
	"How many degrees do you want to rotate all players by?",
	"He then proceeded to tilt every painting he passed on the way here.",
	0,
	360,
	-360
)
if angle == nil or angle == 0 then
	print("not rotating players")
	return
end

local player_list = list.to_table(dm.global_vars.GLOB.player_list)

local rotated = 0
for _, player in pairs(player_list) do
	if SS13.is_valid(player) then
		local transform = player.transform
		player.transform = transform:Turn(angle)
		dm.global_procs.to_chat(player, "<span class='warning'>You feel slightly... <i>tilted?</i></span>")
		rotated = rotated + 1
	end
	SS13.check_tick(true)
end

print("rotated " .. tostring(rotated) .. " players by " .. tostring(angle) .. " degrees")
