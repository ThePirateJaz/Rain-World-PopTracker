function gateandkarma(gate,karma,n)
    if gate == "Gate_Wall-Metropolis" or karma == "drone" then
        return ((Tracker:FindObjectForCode(gate).Active) and (Tracker:FindObjectForCode(karma).Active))
    end
    return ((Tracker:FindObjectForCode(gate).Active) and (Tracker:FindObjectForCode(karma).CurrentStage >= (n-1)))
end
function gateorkarma(gate,karma,n)
    if gate == "Gate_Wall-Metropolis" or karma == "drone" then
        return ((Tracker:FindObjectForCode(gate).Active) or (Tracker:FindObjectForCode(karma).Active))
    end
    return ((Tracker:FindObjectForCode(gate).Active) or (Tracker:FindObjectForCode(karma).CurrentStage >= (n-1)))
end
function onlygate(gate,karma,n)
    return Tracker:FindObjectForCode(gate).Active
end
function onlykarma(gate,karma,n)
    if karma == "drone" then
        return Tracker:FindObjectForCode(karma).Active
    end
    return Tracker:FindObjectForCode(karma).CurrentStage >= (n-1)
end
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
    if gatelogic("Gate_Outskirts-Industrial","Karma",2) and has_industrial_access() then
        visited["outskirts"] = false 
        Tracker:FindObjectForCode("Outskirts").Active = true
        return true
    end
    if gatelogic("Gate_Outskirts-Farm_Arrays","Karma",2) and has_farm_arrays_access() then 
        visited["outskirts"] = false 
        Tracker:FindObjectForCode("Outskirts").Active = true
        return true
    end
    if gatelogic("Gate_Outskirts-Drainage","Karma",2) and has_drainage_access() then 
        visited["outskirts"] = false 
        Tracker:FindObjectForCode("Outskirts").Active = true
        return true
    end
    if gatelogic("Gate_Outer_Expanse-Outskirts","Karma",1) and has_outer_expanse_access() then
        visited["outskirts"] = false 
        Tracker:FindObjectForCode("Outskirts").Active = true
        Tracker:FindObjectForCode("early").Active = true
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
    if gatelogic("Gate_Outskirts-Industrial","Karma",3) and has_outskirts_access() then
        visited["industrial"] = false 
        Tracker:FindObjectForCode("Industrial").Active = true
        return true
    end
    if gatelogic("Gate_Industrial-Pipeyard","Karma",2) and has_pipeyard_access() then
        visited["industrial"] = false 
        Tracker:FindObjectForCode("Industrial").Active = true
        return true
    end
    if gatelogic("Gate_Industrial-Chimney","Karma",3) and has_chimney_access() then
        visited["industrial"] = false 
        Tracker:FindObjectForCode("Industrial").Active = true
        return true
    end
    if gatelogic("Gate_Industrial-Shaded","Karma",1).Active and (has_shaded_access() or has_silent_access()) then
        visited["industrial"] = false 
        Tracker:FindObjectForCode("Industrial").Active = true
        return true
    end
    if gatelogic("Gate_Industrial-Garbage","Karma",2) and has_garbage_access() then
        visited["industrial"] = false 
        Tracker:FindObjectForCode("Industrial").Active = true
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
    if gatelogic("Gate_Industrial-Chimney","Karma",3) and has_industrial_access() then
        visited["chimney"] = false 
        Tracker:FindObjectForCode("Chimney").Active = true
        return true
    end
    if gatelogic("Gate_Drainage-Chimney","Karma",5) and has_drainage_access() and Tracker:FindObjectForCode("MSC").Active then
        visited["chimney"] = false 
        Tracker:FindObjectForCode("Chimney").Active = true
        return true
    end
    if gatelogic("Gate_Chimney-Exterior","Karma",1) and has_exterior_access() and Tracker:FindObjectForCode("west").Active then
        visited["chimney"] = false 
        Tracker:FindObjectForCode("Chimney").Active = true
        return true
    end
    if gatelogic("Gate_Chimney-Sky_Islands","Karma",3) and has_sky_islands_access() then
        visited["chimney"] = false 
        Tracker:FindObjectForCode("Chimney").Active = true
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
    if gatelogic("Gate_Outskirts-Farm_Arrays","Karma",5) and has_outskirts_access() then
        visited["farm"] = false 
        Tracker:FindObjectForCode("Farm").Active = true
        return true
    end
    if gatelogic("Gate_Farm_Arrays-Sky_Islands","Karma",3) and has_sky_islands_access() then
        visited["farm"] = false 
        Tracker:FindObjectForCode("Farm").Active = true
        return true
    end
    if gatelogic("Gate_Farm_Arrays-Subterranean","Karma",5) and has_subterranean_access() and Tracker:FindObjectForCode("saint") then
        visited["farm"] = false
        Tracker:FindObjectForCode("Farm").Active = true
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
    if gatelogic("Gate_Farm_Arrays-Subterranean","Karma",4) and has_farm_arrays_access() then
        visited["subterranean"] = false 
        Tracker:FindObjectForCode("Subterranean").Active = true
        return true
    end
    if gatelogic("Gate_Subterranean-Outer_Expanse","Karma",5) and has_outer_expanse_access() then
        visited["subterranean"] = false 
        Tracker:FindObjectForCode("Subterranean").Active = true
        return true
    end
    if gatelogic("Gate_Pipeyard-Subterranean","Karma",5) and has_pipeyard_access() then
        visited["subterranean"] = false 
        Tracker:FindObjectForCode("Subterranean").Active = true
        return true
    end
    if gatelogic("Gate_Subterranean-Shoreline","Karma",5) and (has_shoreline_access() or has_waterfront_access()) then
        visited["subterranean"] = false 
        Tracker:FindObjectForCode("Subterranean").Active = true
        return true
    end
    if gatelogic("Gate_Subterranean-Drainage","Karma",4) and has_drainage_access() then
        visited["subterranean"] = false 
        Tracker:FindObjectForCode("Subterranean").Active = true
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
    if gatelogic("Gate_Subterranean-Outer_Expanse","Karma",2) and has_subterranean_access() then
        visited["outer"] = false 
        Tracker:FindObjectForCode("Outer").Active = true
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
    if gatelogic("Gate_Outskirts-Drainage","Karma",4) and has_outskirts_access() then
        visited["drainage"] = false 
        Tracker:FindObjectForCode("Drainage").Active = true
        return true
    end
    if gatelogic("Gate_Subterranean-Drainage","Karma",1) and has_subterranean_access() then 
        visited["drainage"] = false
        Tracker:FindObjectForCode("Drainage").Active = true
        return true
    end
    if gatelogic("Gate_Drainage-Garbage","Karma",3) and has_garbage_access() then
        visited["drainage"] = false 
        Tracker:FindObjectForCode("Drainage").Active = true
        return true
    end
    if gatelogic("Gate_Drainage-Chimney","Karma",3) and Tracker:FindObjectForCode("MSC").Active and has_chimney_access() then
        visited["drainage"] = false
        Tracker:FindObjectForCode("Drainage").Active = true
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
    if gatelogic("Gate_Industrial-Garbage","Karma",2) and has_industrial_access() then
        visited["garbage"] = false 
        Tracker:FindObjectForCode("Garbage").Active = true
        return true
    end
    if gatelogic("Gate_Drainage-Garbage","Karma",1) and has_drainage_access() then
        visited["garbage"] = false 
        Tracker:FindObjectForCode("Garbage").Active = true
        return true
    end
    if gatelogic("Gate_Garbage-Shoreline","Karma",2) and (has_shoreline_access() or has_waterfront_access()) then
        visited["garbage"] = false 
        Tracker:FindObjectForCode("Garbage").Active = true
        return true
    end
    if gatelogic("Gate_Garbage-Shaded","Karma",2) and ((Tracker:FindObjectForCode("MSC").Active and has_shaded_access()) or has_silent_access()) then
        visited["garbage"] = false 
        Tracker:FindObjectForCode("Garbage").Active = true
        return true
    end
    visited["garbage"] = false
    return false
end
function has_shaded_access()
    if Tracker:FindObjectForCode("saint").Active then
        return false
    end
    if visited["shaded"] then
        return false
    end
    visited["shaded"] = true
    if Tracker:FindObjectForCode("Shaded").Active then
        visited["shaded"] = false
        return true
    end
    if gatelogic("Gate_Industrial-Shaded","Karma",5) and has_industrial_access() then
        visited["shaded"] = false 
        Tracker:FindObjectForCode("Shaded").Active = true
        return true
    end
    if gatelogic("Gate_Garbage-Shaded","Karma",4) and Tracker:FindObjectForCode("MSC").Active and has_garbage_access() then
        visited["shaded"] = false 
        Tracker:FindObjectForCode("Shaded").Active = true
        return true
    end
    if gatelogic("Gate_Shaded-Shoreline","Karma",2) and (has_shoreline_access() or has_waterfront_access()) then
        visited["shaded"] = false 
        Tracker:FindObjectForCode("Shaded").Active = true
        return true
    end
    if gatelogic("Gate_Shaded-Exterior").Active and has_exterior_access() and Tracker:FindObjectForCode("east").Active then 
        visited["shaded"] = false
        Tracker:FindObjectForCode("Shaded").Active = true
        return true
    end
    visited["shaded"] = false
    return false
end
function has_exterior_access()
    if Tracker:FindObjectForCode("saint").Active then
        return false
    end
    if visited["exterior"] then
        return false
    end
    visited["exterior"] = true
    if Tracker:FindObjectForCode("Exterior").Active then
        visited["exterior"] = false
        return true
    end
    if gatelogic("Gate_Chimney-Exterior","Karma",4) and has_chimney_access() then
        visited["exterior"] = false 
        Tracker:FindObjectForCode("Exterior").Active = true
        if Tracker:FindObjectForCode("riv").Active then
            Tracker:FindObjectForCode("west").Active = true
            Tracker:FindObjectForCode("wall").Active = true
        elseif (Tracker:FindObjectForCode("monk") and vanillagame) or (Tracker:FindObjectForCode("survivor").Active and vanillagame) then
            Tracker:FindObjectForCode("wall").Active = true
        else
            Tracker:FindObjectForCode("west").Active = true
            Tracker:FindObjectForCode("east").Active = true
            Tracker:FindObjectForCode("wall").Active = true
        end
        return true
    end
    if gatelogic("Gate_Wall-Metropolis","Karma",5) and has_metropolis_access() then 
        visited["exterior"] = false
        Tracker:FindObjectForCode("Exterior").Active = true
        if Tracker:FindObjectForCode("riv").Active then
            Tracker:FindObjectForCode("west").Active = true
            Tracker:FindObjectForCode("wall").Active = true
        elseif (Tracker:FindObjectForCode("monk") and vanillagame) or (Tracker:FindObjectForCode("survivor").Active and vanillagame) then
            Tracker:FindObjectForCode("wall").Active = true
        else
            Tracker:FindObjectForCode("west").Active = true
            Tracker:FindObjectForCode("east").Active = true
            Tracker:FindObjectForCode("wall").Active = true
        end
        return true
    end
    if gatelogic("Gate_Wall-Five_Pebbles","Karma",1) and (has_five_pebbles_access() or has_rot_access()) then 
        visited["exterior"] = false
        Tracker:FindObjectForCode("Exterior").Active = true
        if Tracker:FindObjectForCode("riv").Active then
            Tracker:FindObjectForCode("west").Active = true
            Tracker:FindObjectForCode("wall").Active = true
        elseif (Tracker:FindObjectForCode("monk") and vanillagame) or (Tracker:FindObjectForCode("survivor").Active and vanillagame) then
            Tracker:FindObjectForCode("wall").Active = true
        else
            Tracker:FindObjectForCode("west").Active = true
            Tracker:FindObjectForCode("east").Active = true
            Tracker:FindObjectForCode("wall").Active = true
        end
        return true
    end
    if gatelogic("Gate_Underhang-Five_Pebbles","Karma",1) and (has_five_pebbles_access() or has_rot_access()) then 
        visited["exterior"] = false
        Tracker:FindObjectForCode("Exterior").Active = true
        if Tracker:FindObjectForCode("riv").Active then
            Tracker:FindObjectForCode("west").Active = true
            Tracker:FindObjectForCode("wall").Active = true
        else
            Tracker:FindObjectForCode("west").Active = true
            Tracker:FindObjectForCode("east").Active = true
            Tracker:FindObjectForCode("wall").Active = true
        end
        return true
    end
    if gatelogic("Gate_Shaded-Exterior","Karma",1) and has_shaded_access() then 
        visited["exterior"] = false
        Tracker:FindObjectForCode("Exterior").Active = true
        if Tracker:FindObjectForCode("riv").Active then
            Tracker:FindObjectForCode("east").Active = true
        else
            Tracker:FindObjectForCode("west").Active = true
            Tracker:FindObjectForCode("east").Active = true
            Tracker:FindObjectForCode("wall").Active = true
        end
        return true
    end
    if gatelogic("Gate_Exterior-Precipice","Karma",1) and has_waterfront_access() then 
        visited["exterior"] = false
        Tracker:FindObjectForCode("Exterior").Active = true
        Tracker:FindObjectForCode("west").Active = true
        Tracker:FindObjectForCode("east").Active = true
        Tracker:FindObjectForCode("wall").Active = true
        return true
    end
    visited["exterior"] = false
    return false
end
function has_five_pebbles_access()
    if Tracker:FindObjectForCode("riv").Active or Tracker:FindObjectForCode("saint").Active then
        return false
    end
    if visited["5p"] then
        return false
    end
    visited["5p"] = true
    if Tracker:FindObjectForCode("5P").Active then
        visited["5p"] = false
        return true
    end
    if gatelogic("Gate_Wall-Five_Pebbles","Karma",1) and has_exterior_access() and Tracker:FindObjectForCode("wall").Active then 
        visited["5p"] = false
        Tracker:FindObjectForCode("puppet").Active = true
        return true
    end
    if gatelogic("Gate_Underhang-Five_Pebbles","Karma",5).Active and Tracker:FindObjectForCode("west").Active then
        visited["5p"] = false
        Tracker:FindObjectForCode("5P").Active = true
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
    if gatelogic("Gate_Industrial-Pipeyard","Karma",4) and has_industrial_access() then
        visited["pipes"] = false 
        Tracker:FindObjectForCode("Pipeyard").Active = true
        return true
    end
    if gatelogic("Gate_Pipeyard-Subterranean","Karma",3) and has_subterranean_access() then 
        visited["pipes"] = false
        Tracker:FindObjectForCode("Pipeyard").Active = true
        return true
    end
    if gatelogic("Gate_Pipeyard-Sky_Islands","Karma",3) and has_sky_islands_access() then 
        visited["pipes"] = false
        Tracker:FindObjectForCode("Pipeyard").Active = true
        return true
    end
    if gatelogic("Gate_Pipeyard-Shoreline","Karma",3) and (has_shoreline_access() or has_waterfront_access()) and (Tracker:FindObjectForCode("arti").Active == false) then 
        visited["pipes"] = false
        Tracker:FindObjectForCode("Pipeyard").Active = true
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
    if gatelogic("Gate_Chimney-Sky_Islands","Karma",2) and has_chimney_access() then 
        visited["sky"] = false
        Tracker:FindObjectForCode("Sky").Active = true
        return true
    end
    if gatelogic("Gate_Pipeyard-Sky_Islands","Karma",4) and has_pipeyard_access() then
        visited["sky"] = false 
        Tracker:FindObjectForCode("Sky").Active = true
        return true
    end
    if gatelogic("Gate_Farm_Arrays-Sky_Islands","Karma",3) and has_farm_arrays_access() then 
        visited["sky"] = false
        Tracker:FindObjectForCode("Sky").Active = true
        return true
    end
    visited["sky"] = false
    return false
end
function has_shoreline_access()
    if Tracker:FindObjectForCode("spearmaster").Active or Tracker:FindObjectForCode("arti").Active then
        return false
    end
    if visited["shoreline"] then
        return false
    end
    visited["shoreline"] = true
    if Tracker:FindObjectForCode("Shoreline").Active then
        visited["shoreline"] = false
        return true
    end
    if gatelogic("Gate_Garbage-Shoreline","Karma",3) and has_garbage_access() then 
        visited["shoreline"] = false
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if gattelogic("Gate_Pipeyard-Shoreline","Karma",3) and has_pipeyard_access() then 
        visited["shoreline"] = false
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if gatelogic("Gate_Subterranean-Shoreline","Karma",2) and has_subterranean_access() then 
        visited["shoreline"] = false
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if gatelogic("Gate_Shaded-Shoreline","Karma",3) and has_shaded_access() then 
        visited["shoreline"] = false
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if gatelogic("Gate_Shoreline-Submerged_Superstructure","Karma",1) and has_submerged_access() then 
        visited["shoreline"] = false
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if gatelogic("Gate_Bitter_Aerie-Shoreline","Karma",5) and has_submerged_access() and Tracker:FindObjectForCode("riv").Active then 
        visited["shoreline"] = false
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if has_silent_access() and gatelogic("Gate_Shoreline-Silent_Construct","Karma",1) then
        visited["shoreline"] = false
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    visited["shoreline"] = false
    return false
end
function has_submerged_access()
    if Tracker:FindObjectForCode("spearmaster").Active or Tracker:FindObjectForCode("arti").Active then
        retturn false
    end
    if visited["submerged"] then
        return false
    end
    visited["submerged"] = true
    if Tracker:FindObjectForCode("Submerged").Active then
        visited["submerged"] = false
        return true
    end
    if gatelogic("Gate_Shoreline-Submerged_Superstructure","Karma",5) and has_shoreline_access() then
        visited["submerged"] = false 
        Tracker:FindObjectForCode("Submerged").Active = true
        return true
    end
    visited["submerged"] = false
    return false
end
function has_waterfront_access()
    if Tracker:FindObjectForCode("spearmaster").Active or Tracker:FindObjectForCode("arti").Active then
        if visited["water"] then
            return false
        end
        visited["water"] = true
        if Tracker:FindObjectForCode("Waterfront").Active then
            visited["water"] = false
            return true
        end
        if has_exterior_access() and gatelogic("Gate_Exterior-Precipice","Karma",1) then 
            visited["water"] = false
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if has_garbage_access() gatelogic("Gate_Garbage-Shoreline","Karma",3) then 
            visited["water"] = false
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if has_shaded_access() and gatelogic("Gate_Shaded-Shoreline","Karma",3) then 
            visited["water"] = false
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if has_subterranean_access() and gatelogic("Gate_Subterranean-Shoreline","Karma",2) then 
            visited["water"] = false
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if has_pipeyard_access() and gatelogic("Gate_Pipeyard-Shoreline","Karma",3) and (Tracker:FindObjectForCode("arti").Active == false) then 
            visited["water"] = false
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if gatelogic("Gate_Struts-Waterfront","Karma",1) and Tracker:FindObjectForCode("spearmaster").Active and has_lttm_access() then 
            visited["water"] = false
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if gatelogic("Gate_Precipice-LTTM","Karma",1) and Tracker:FindObjectForCode("spearmaster").Active and has_lttm_access() then 
            visited["water"] = false
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        visited["water"] = false
        return false
    else
        return false
    end
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
    if gatelogic("Gate_Wall-Metropolis","drone",0) and Tracker:FindObjectForCode("arti").Active and has_exterior_access() then 
        visited["metro"] = false
        Tracker:FindObjectForCode("Metro").Active = true
        return true
    end
    visited["metro"] = false
    return false
end
function has_rot_access()
    if Tracker:FindObjectForCode("riv").Active then
        if visited["rot"] then
            return false
        end
        visited["rot"] = true
        if Tracker:FindObjectForCode("Rot").Active then
            visited["rot"] = false
            return true
        end
        if has_exterior_access() and Tracker:FindObjectForCode("west").Active and (gatelogic("Gate_Wall-Five_Pebbles","Karma",1) or gatelogic("Gate_Underhang-Five_Pebbles","Karma",5)) then 
            visited["rot"] = false
            Tracker:FindObjectForCode("Rot").Active = true
            return true
        end
        visited["rot"] = false
        return false
    else
        return false
    end
end
function has_lttm_access()
    if Tracker:FindObjectForCode("spearmaster").Active then
        if visited["moon"] then
            return false
        end
        visited["moon"] = true
        if Tracker:FindObjectForCode("Moon").Active then
            visited["moon"] = false
            return true
        end
        if gatelogic("Gate_Struts-Waterfront","Karma",1) and has_waterfront_access() then 
            visited["moon"] = false
            Tracker:FindObjectForCode("Moon").Active = true
            return true
        end
        if gatelogic("Gate_Precipice-LTTM","Karma",5) and has_waterfront_access() then 
            visited["moon"] = false
            Tracker:FindObjectForCode("Moon").Active = true
            return true
        end
        visited["moon"] = false
        return false
    else
        return false
    end
end
function has_silent_access()
    if Tracker:FindObjectForCode("saint").Active then
        if visited["silent"] then
            return false
        end
        visited["silent"] = true
        if Tracker:FindObjectForCode("Silent").Active then
            visited["silent"] = false
            return true
        end
        if has_shoreline_access() and gatelogic("Gate_Shoreline-Silent_Construct","Karma",5) then 
            visited["silent"] = false
            Tracker:FindObjectForCode("Silent").Active = true
            return true
        end
        if gatelogic("Gate_Industrial-Shaded","Karma",5) and has_industrial_access() then 
            visited["silent"] = false
            Tracker:FindObjectForCode("Silent").Active = true
            return true
        end
        if gatelogic("Gate_Garbage-Shaded","Karma",4) and has_garbage_access() then 
            visited["silent"] = false
            Tracker:FindObjectForCode("Silent").Active = true
            return true
        end
        visited["silent"] = false
        return false
    else
        return false
    end
end
function has_rubicon_access()
    if has_subterranean_access() and (Tracker:FindObjectForCode("Karma").CurrentStage == 8) and Tracker:FindObjectForCode("saint").Active and Tracker:FindObjectForCode("glow").Active then 
        Tracker:FindObjectForCode("Rubicon").Active = true
        return true
    end
    return false
end

function wanderer_pips(n)
    local pip = 0
    if has_outskirts_access() then
        pip = pip + 1
    end
    if has_industrial_access() then
        pip = pip + 1
    end
    if has_chimney_access() then
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
    if has_five_pebbles_access() then
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
    if has_lttm_access() then
        pip = pip + 1
    end
    if has_silent_access() then
        pip = pip + 1
    end
    if has_rubicon_access() then
        pip = pip + 1
    end
    local counter = (pip >= tonumber(n))
    if counter then
        return true
    end
    return false
end

