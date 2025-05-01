-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:
local visited = {}
function has_outskirts_access()
    if visited["outskirts"] then
        return false
    end
    visited["outskirts"] = true
    if Tracker:FindObjectForCode("Outskirts").Active then
        visited["outskirts"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Outskirts-Industrial").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and has_industrial_access() then
        visited["outskirts"] = false 
        return true
    end
    if (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and has_farm_arrays_access() and Tracker:FindObjectForCode("Gate_Outskirts-Farm_arrays").Active then 
        visited["outskirts"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Outskirts-Drainage").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and has_drainage_access() then 
        visited["outskirts"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Outer_Expanse-Outskirts").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and has_outer_expanse_access() then
        visited["outskirts"] = false 
        return true
    end
    visited["outskirts"] = false
    return false
end
function has_industrial_access()
    if visited["industrial"] then
        return false
    end
    visited["industrial"] = true
    if Tracker:FindObjectForCode("Industrial").Active then
        visited["industrial"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Outskirts-Industrial").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and has_outskirts_access() then
        visited["industrial"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Industrial-Pipeyard").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and has_pipeyard_access() then
        visited["industrial"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Industrial-Chimney").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and has_chimney_access() then
        visited["industrial"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Industrial-Shaded").Active and (has_shaded_access() or has_silent_access()) then
        visited["industrial"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Industrial-Garbage").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and has_garbage_access() then
        visited["industrial"] = false 
        return true
    end
    visited["industrial"] = false
    return false
end
function has_chimney_access()
    if visited["chimney"] then
        return false
    end
    visited["chimney"] = true
    if Tracker:FindObjectForCode("Chimney").Active then
        visited["chimney"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Industrial-Chimney").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and has_industrial_access() then
        visited["chimney"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Drainage-Chimney").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and has_drainage_access() and Tracker:FindObjectForCode("MSC") then
        visited["chimney"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Chimney-Exterior").Active and has_exterior_access() then
        visited["chimney"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Chimney-Sky_Islands").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and has_sky_islands_access() then
        visited["chimney"] = false 
        return true
    end
    visited["chimney"] = false
    return false
end
function has_farm_arrays_access()
    if visited["farm"] then
        return false
    end
    visited["farm"] = true
    if Tracker:FindObjectForCode("Farm").Active then
        visited["farm"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Outskirts-Farm_Arrays").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and has_outskirts_access() then
        visited["farm"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Farm_Arrays-Sky_Islands").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and has_sky_islands_access() then
        visited["farm"] = false 
        return true
    end
    visited["farm"] = false
    return false
end
function has_subterranean_access()
    if visited["subterranean"] then
        return false
    end
    visited["subterranean"] = true
    if Tracker:FindObjectForCode("Subterranean").Active then
        visited["subterranean"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Farm_Arrays-Subterranean").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 3) and has_farm_arrays_access() then
        visited["subterranean"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Subterranean-Outer_Expanse").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and has_outer_expanse_access() then
        visited["subterranean"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Pipeyard-Subterranean").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and has_pipeyard_access() then
        visited["subterranean"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Subterranean-Shoreline").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and (has_shoreline_access() or has_waterfront_access()) then
        visited["subterranean"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Subterranean-Drainage").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 3) and has_drainage_access() then
        visited["subterranean"] = false 
        return true
    end
    visited["subterranean"] = false
    return false
end
function has_outer_expanse_access()
    if visited["outer"] then
        return false
    end
    visited["outer"] = true
    if Tracker:FindObjectForCode("Outer").Active then
        visited["outer"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Subterranean-Outer_Expanse").Active and has_subterranean_access() then
        visited["outer"] = false 
        return true
    end
    visited["outer"] = false
    return false
end
function has_drainage_access()
    if visited["drainage"] then
        return false
    end
    visited["drainage"] = true
    if Tracker:FindObjectForCode("Drainage").Active then
        visited["drainage"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Outskirts-Drainage").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 3) and has_outskirts_access() then
        visited["drainage"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Subterranean-Drainage").Active and has_subterranean_access() then 
        visited["drainage"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Drainage-Garbage").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and has_garbage_access() then
        visited["drainage"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Drainage-Chimney").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and Tracker:FindObjectForCode("MSC").Active and has_chimney_access() then
        visited["drainage"] = false
        return true
    end
    visited["drainage"] = false
    return false
end
function has_garbage_access()
    if visited["garbage"] then
        return false
    end
    visited["garbage"] = true
    if Tracker:FindObjectForCode("Garbage").Active then
        visited["garbage"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Industrial-Garbage").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and has_industrial_access() then
        visited["garbage"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Drainage-Garbage").Active and has_drainage_access() then
        visited["garbage"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Garbage-Shoreline").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and (has_shoreline_access() or has_waterfront_access()) then
        visited["garbage"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Garbage-Shaded").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and Tracker:FindObjectForCode("MSC").Active and (has_shaded_access() or has_silent_access()) then
        visited["garbage"] = false 
        return true
    end
    visited["garbage"] = false
    return false
end
function has_shaded_access()
    if visited["shaded"] then
        return false
    end
    visited["shaded"] = true
    if Tracker:FindObjectForCode("Shaded").Active then
        visited["shaded"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Industrial-Shaded").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and has_industrial_access() and (Tracker:FindObjectForCode("saint").Active == false) then
        visited["shaded"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Garbage-Shaded").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 3) and Tracker:FindObjectForCode("MSC").Active and has_garbage_access() and (Tracker:FindObjectForCode("saint").Active == false) then
        visited["shaded"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Shaded-Shoreline").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and (has_shoreline_access() or has_waterfront_access()) and (Tracker:FindObjectForCode("saint").Active == false) then
        visited["shaded"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Shaded-Exterior").Active and has_exterior_access() and (Tracker:FindObjectForCode("saint").Active == false) then 
        visited["shaded"] = false
        return true
    end
    visited["shaded"] = false
    return false
end
function has_exterior_access()
    if visited["exterior"] then
        return false
    end
    visited["exterior"] = true
    if Tracker:FindObjectForCode("Exterior").Active then
        visited["exterior"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Chimney-Exterior").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 3) and has_chimney_access() and (Tracker:FindObjectForCode("saint").Active == false) then
        visited["exterior"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Wall-Metropolis").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and has_metropolis_access() and (Tracker:FindObjectForCode("saint").Active == false) then 
        visited["exterior"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Wall-Five_Pebbles").Active and (has_five_pebbles_access() or (has_rot_access() and Tracker:FindObjectForCode("riv"))) and (Tracker:FindObjectForCode("saint").Active == false) then 
        visited["exterior"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Underhang-Five_Pebbles").Active and (has_five_pebbles_access() or (has_rot_access() and Tracker:FindObjectForCode("riv"))) and (Tracker:FindObjectForCode("saint").Active == false) then 
        visited["exterior"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Shaded-Exterior").Active and has_shaded_access() and (Tracker:FindObjectForCode("saint").Active == false) then 
        visited["exterior"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Exterior-Precipice").Active and has_waterfront_access() then 
        visited["exterior"] = false
        return true
    end
    visited["exterior"] = false
    return false
end
function has_five_pebbles_access()
    if visited["5p"] then
        return false
    end
    visited["5p"] = true
    if Tracker:FindObjectForCode("5P").Active then
        visited["5p"] = false
        return true
    end
    if (Tracker:FindObjectForCode("Gate_Wall-Five_Pebbles").Active and has_exterior_access()) or (Tracker:FindObjectForCode("Gate_Underhang-Five_Pebbles").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and has_exterior_access()) and (Tracker:FindObjectForCode("riv").Active == false) and (Tracker:FindObjectForCode("saint").Active == false) then 
        visited["5p"] = false
        return true
    end
    visited["5p"] = false
    return false
end
function has_pipeyard_access()
    if visited["pipes"] then
        return false
    end
    visited["pipes"] = true
    if Tracker:FindObjectForCode("Pipeyard").Active then
        visited["pipes"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Industrial-Pipeyard").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 3) and has_industrial_access() then
        visited["pipes"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Pipeyard-Subterranean").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and has_subterranean_access() then 
        visited["pipes"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Pipeyard-Sky_Islands").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and has_sky_islands_access() then 
        visited["pipes"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Pipeyard-Shoreline").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and (has_shoreline_access() or has_waterfront_access()) then 
        visited["pipes"] = false
        return true
    end
    visited["pipes"] = false
    return false
end
function has_sky_islands_access()
    if visited["sky"] then
        return false
    end
    visited["sky"] = true
    if Tracker:FindObjectForCode("Sky").Active then
        visited["sky"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Chimney-Sky_Islands").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and has_chimney_access() then 
        visited["sky"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Pipeyard-Sky_Islands").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 3) and has_pipeyard_access() then
        visited["sky"] = false 
        return true
    end
    if Tracker:FindObjectForCode("Gate_Farm_Arrays-Sky_Islands").Active and ((Tracker:FindObjectForCode("Karma").CurrentStage >= 2)) and has_farm_arrays_access() then 
        visited["sky"] = false
        return true
    end
    visited["sky"] = false
    return false
end
function has_shoreline_access()
    if visited["shoreline"] then
        return false
    end
    visited["shoreline"] = true
    if Tracker:FindObjectForCode("Shoreline").Active then
        visited["shoreline"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Garbage-Shoreline").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and has_garbage_access() and (Tracker:FindObjectForCode("arti").Active == false) and (Tracker:FindObjectForCode("spearmaster").Active == false) then 
        visited["shoreline"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Pipeyard-Shoreline").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and has_pipeyard_access() and (Tracker:FindObjectForCode("arti").Active == false) and (Tracker:FindObjectForCode("spearmaster").Active == false) then 
        visited["shoreline"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Subterranean-Shoreline").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and has_subterranean_access() and (Tracker:FindObjectForCode("arti").Active == false) and (Tracker:FindObjectForCode("spearmaster").Active == false) then 
        visited["shoreline"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Shaded-Shoreline").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and has_shaded_access() and (Tracker:FindObjectForCode("arti").Active == false) and (Tracker:FindObjectForCode("spearmaster").Active == false) then 
        visited["shoreline"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Shoreline-Submerged_Superstructure").Active and has_submerged_access() then 
        visited["shoreline"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Bitter_Aerie-Shoreline").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and has_submerged_access() then 
        visited["shoreline"] = false
        return true
    end
    if has_silent_access() and Tracker:FindObjectForCode("Gate_Shoreline-Silent_Construct").Active then
        visited["shoreline"] = false
        return true
    end
    visited["shoreline"] = false
    return false
end
function has_submerged_access()
    if visited["submerged"] then
        return false
    end
    visited["submerged"] = true
    if Tracker:FindObjectForCode("Submerged").Active then
        visited["submerged"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Shoreline-Submerged_Superstructure").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and has_shoreline_access() then
        visited["submerged"] = false 
        return true
    end
    visited["submerged"] = false
    return false
end
function has_waterfront_access()
    if visited["water"] then
        return false
    end
    visited["water"] = true
    if Tracker:FindObjectForCode("Waterfront").Active then
        visited["water"] = false
        return true
    end
    if has_exterior_access() and Tracker:FindObjectForCode("Gate_Exterior-Precipice").Active and (Tracker:FindObjectForCode("arti").Active or Tracker:FindObjectForCode("spearmaster").Active) then 
        visited["water"] = false
        return true
    end
    if has_garbage_access() and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and Tracker:FindObjectForCode("Gate_Garbage-Shoreline").Active and (Tracker:FindObjectForCode("arti").Active or Tracker:FindObjectForCode("spearmaster").Active) then 
        visited["water"] = false
        return true
    end
    if has_shaded_access() and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and Tracker:FindObjectForCode("Gate_Shaded-Shoreline").Active and (Tracker:FindObjectForCode("arti").Active or Tracker:FindObjectForCode("spearmaster").Active) then 
        visited["water"] = false
        return true
    end
    if has_subterranean_access() and (Tracker:FindObjectForCode("Karma").CurrentStage >= 1) and Tracker:FindObjectForCode("Gate_Subterranean-Shoreline").Active and (Tracker:FindObjectForCode("arti").Active or Tracker:FindObjectForCode("spearmaster").Active) then 
        visited["water"] = false
        return true
    end
    if has_pipeyard_access() and (Tracker:FindObjectForCode("Karma").CurrentStage >= 2) and Tracker:FindObjectForCode("Gate_Pipeyard-Shoreline").Active and (Tracker:FindObjectForCode("arti").Active or Tracker:FindObjectForCode("spearmaster").Active) then 
        visited["water"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Struts-Waterfront").Active and Tracker:FindObjectForCode("spearmaster").Active and has_lttm_access() then 
        visited["water"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Precipice-LTTM").Active and Tracker:FindObjectForCode("spearmaster").Active and has_lttm_access() then 
        visited["water"] = false
        return true
    end
    visited["water"] = false
    return false
end
function has_metro_access()
    if visited["metro"] then
        return false
    end
    visited["metro"] = true
    if Tracker:FindObjectForCode("Metro").Active then
        visited["metro"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Wall-Metropolis").Active and Tracker:FindObjectForCode("drone").Active and Tracker:FindObjectForCode("arti").Active and has_exterior_access() then 
        visited["metro"] = false
        return true
    end
    visited["metro"] = false
    return false
end
function has_rot_access()
    if visited["rot"] then
        return false
    end
    visited["rot"] = true
    if Tracker:FindObjectForCode("Rot").Active then
        visited["rot"] = false
        return true
    end
    if has_exterior_access() and (Tracker:FindObjectForCode("Gate_Wall-Five_Pebbles").Active or Tracker:FindObjectForCode("Gate_Underhang-Five_Pebbles")) and Tracker:FindObjectForCode("riv").Active then 
        visited["rot"] = false
        return true
    end
    visited["rot"] = false
    return false
end
function has_lttm_access()
    if visited["moon"] then
        return false
    end
    visited["moon"] = true
    if Tracker:FindObjectForCode("Moon").Active then
        visited["moon"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Struts-Waterfront") and has_waterfront_access() then 
        visited["moon"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Precipice-LTTM") and has_waterfront_access() then 
        visited["moon"] = false
        return true
    end
    visited["moon"] = false
    return false
end
function has_silent_access()
    if visited["silent"] then
        return false
    end
    visited["silent"] = true
    if Tracker:FindObjectForCode("Silent").Active then
        visited["silent"] = false
        return true
    end
    if has_shoreline_access() and Tracker:FindObjectForCode("Gate_Shoreline-Silent_Construct").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and Tracker:FindObjectForCode("saint").Active then 
        visited["silent"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Industrial-Shaded").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 4) and Tracker:FindObjectForCode("saint").Active and has_industrial_access() then 
        visited["silent"] = false
        return true
    end
    if Tracker:FindObjectForCode("Gate_Garbage-Shaded").Active and (Tracker:FindObjectForCode("Karma").CurrentStage >= 3) and Tracker:FindObjectForCode("saint").Active and has_garbage_access() then 
        visited["silent"] = false
        return true
    end
    visited["silent"] = false
    return false
end
function has_rubicon_access()
    if has_subterranean_access() and Tracker:FindObjectForCode("Karma10").Active and Tracker:FindObjectForCode("saint") then 
        return true
    end
    return false
end

function wanderer_pips(n)
    local pip = 0
    if has_chimney_access() then
        pip = pip + 1
    end
    if has_outskirts_access() then
        pip = pip + 1
    end
    if has_industrial_access() then
        pip = pip + 1
    end
    if has_farm_arrays_access() then
        pip = pip + 1
    end
    if has_subterranean_access() then
        pip = pip + 1
    end
    if has_outer_expanse_access() then
        pip = pip + 1
    end
    if has_drainage_access() then
        pip = pip + 1
    end
    if has_garbage_access() then
        pip = pip + 1
    end
    if has_shaded_access() then
        pip = pip + 1
    end
    if has_exterior_access() then
        pip = pip + 1
    end
    if has_pipeyard_access() then
        pip = pip + 1
    end
    if has_sky_islands_access() then
        pip = pip + 1
    end
    if has_shoreline_access() then
        pip = pip + 1
    end
    if has_five_pebbles_access() then
        pip = pip + 1
    end
    if has_metro_access() then
        pip = pip + 1
    end
    if has_submerged_access() then
        pip = pip + 1
    end
    if has_silent_access() then
        pip = pip + 1
    end
    if has_rot_access() then
        pip = pip + 1
    end
    if has_waterfront_access() then
        pip = pip + 1
    end
    local counter = (pip >= tonumber(n))
    if counter then
        return true
    end
    return false
end

function has_no_msc()
    if slot_data["is_msc_enabled"] == 0 then
        return true
    end
    return false
end

function sheltersanity()
    if slot_data["checks_sheltersanity"] == 1 then
        return true
    end
    return false
end