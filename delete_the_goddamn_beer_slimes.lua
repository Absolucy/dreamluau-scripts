local SS13 = require("SS13")
local slime_path = SS13.type("/mob/living/basic/slime")
local slime_trait_path = SS13.type("/datum/slime_trait/beer_slime")

-- set to true to actually delete the slimes.
-- otherwise it'll just print how many slimes it found
local actually_delete_the_slimes = false

local function should_delete_slime(slime)
	if not (SS13.is_valid(datum) and SS13.istype(slime, slime_path)) then
		return false
	end
	for _, trait in slime.slime_traits do
		SS13.check_tick()
		if SS13.istype(trait, slime_trait_path) then
			return true
		end
	end
	return false
end

local total_slimes = 0
local slimes_by_area = {}

local trait_obj = SS13.new(slime_trait_path)
print("Searching for slimes with the " .. tostring(trait_obj.name) .. " trait.")
SS13.qdel(trait_obj)

for _, mob in dm.global_vars.GLOB.mob_living_list do
	SS13.check_tick()
	if should_delete_slime(mob) then
		total_slimes += 1
		local slime_area = dm.global_procs.get_area_name(mob)
		slimes_by_area[slime_area] = (slimes_by_area[slime_area] or 0) + 1
		if actually_delete_the_slimes then
			SS13.qdel(mob)
		end
	end
end

if total_slimes > 0 then
	print((if actually_delete_the_slimes then "Deleted " else "Found ") .. tostring(total_slimes) .. " total slimes.")
	for area, count in pairs(slimes_by_area) do
		print(tostring(area) .. ": " .. tostring(count))
	end
else
	print("Did not find any eligible slimes!")
end


