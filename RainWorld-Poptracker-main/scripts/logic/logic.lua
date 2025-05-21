
--debugging info
gatelogicdebug = false
regiondebug = true
function gateprint(...)
    if gatelogicdebug then
        print(...)
    end
end
function regionprint(...)
    if regiondebug then
        print(...)
    end
end

--Gate Logics aare defined here in the case of differing gate logic
function gateandkarma(gate,karma,n)
    if gate == "Gate_Wall-Metropolis" or karma == "drone" then
        gateprint(string.format("Checking Metro Gate with drone"))
        if ((Tracker:FindObjectForCode(gate).Active) and (Tracker:FindObjectForCode(karma).Active)) then
            return true
        else
            return false
        end
    end
    gateprint(string.format("Checking gate %s and %s level %s",gate,karma,n))
    if ((Tracker:FindObjectForCode(gate).Active) and (Tracker:FindObjectForCode(karma).CurrentStage >= (n-1))) then
        return true
    else
        return false
    end
end
function gateorkarma(gate,karma,n)
    if gate == "Gate_Wall-Metropolis" or karma == "drone" then
        gateprint("Checking Metropolis gate")
        if ((Tracker:FindObjectForCode(gate).Active) or (Tracker:FindObjectForCode(karma).Active)) then
            return true
        else
            return false
        end
    end
    gateprint(string.format("Checking gate %s or %s level %s",gate,karma,n))
    return ((Tracker:FindObjectForCode(gate).Active) or (Tracker:FindObjectForCode(karma).CurrentStage >= (n-1)))
end
function onlygate(gate,karma,n)
    gateprint(string.format("Checking gate %s",gate))
    return Tracker:FindObjectForCode(gate).Active
end
function onlykarma(gate,karma,n)
    if karma == "drone" then
        return Tracker:FindObjectForCode(karma).Active
    end
    gateprint(string.format("Checking %s level %s",karma,n))
    return Tracker:FindObjectForCode(karma).CurrentStage >= (n-1)
end

--in case tracker isn't connected to ap, gate logic will be assigned here
gatelogic = function(gate,karma,n)
    return false
end
if Tracker:FindObjectForCode("gateorkarma").Active then
    gatelogic = gateorkarma
elseif Tracker:FindObjectForCode("onlygate").Active then
    gatelogic = onlygate
elseif Tracker:FindObjectForCode("onlykarma").Active then
    gatelogic = onlykarma
elseif Tracker:FindObjectForCode("gateandkarma").Active then
    gatelogic = gateandkarma
end

--for manually settings the current slugcat campaign
if not CURRENT_CAMPAIGN then
    if Tracker:FindObjectForCode("monk").Active then
        Tracker:FindObjectForCode("scug").CurrentStage = 0
    elseif Tracker:FindObjectForCode("survivor").Active then
        Tracker:FindObjectForCode("scug").CurrentStage = 1
    elseif Tracker:FindObjectForCode("hunter").Active then
        Tracker:FindObjectForCode("scug").CurrentStage = 2
    elseif Tracker:FindObjectForCode("gourmand").Active then
        Tracker:FindObjectForCode("scug").CurrentStage = 3
    elseif Tracker:FindObjectForCode("arti").Active then
        Tracker:FindObjectForCode("scug").CurrentStage = 4
    elseif Tracker:FindObjectForCode("riv").Active then
        Tracker:FindObjectForCode("scug").CurrentStage = 5
    elseif Tracker:FindObjectForCode("spearmaster").Active then
        Tracker:FindObjectForCode("scug").CurrentStage = 5
    elseif Tracker:FindObjectForCode("saint").Active then
        Tracker:FindObjectForCode("scug").CurrentStage = 6
    elseif Tracker:FindObjectForCode("inv").Active then
        Tracker:FindObjectForCode("scug").CurrentStage = 7
    end
end


--borderline recursive region access logic
local visited = {}
function has_outskirts_access()
    regionprint("Checking Outskirts access...")
    if visited["outskirts"] then
        regionprint("Already in an outskirts block")
        return false
    end
    visited["outskirts"] = true
    if Tracker:FindObjectForCode("Outskirts").Active then
        visited["outskirts"] = false
        regionprint("Outskirts is active")
        return true
    end
    if gatelogic("Gate_Outskirts-Industrial","Karma",2) and has_industrial_access() then
        visited["outskirts"] = false 
        regionprint("Has Outskirts from Industrial.")
        Tracker:FindObjectForCode("Outskirts").Active = true
        return true
    end
    if gatelogic("Gate_Outskirts-Farm_Arrays","Karma",2) and has_farm_arrays_access() then 
        visited["outskirts"] = false 
        regionprint("Has Outskirts from Farm Arrays")
        Tracker:FindObjectForCode("Outskirts").Active = true
        return true
    end
    if gatelogic("Gate_Outskirts-Drainage","Karma",2) and has_drainage_access() then 
        visited["outskirts"] = false 
        regionprint("Has Outskirts from Drainage.")
        Tracker:FindObjectForCode("Outskirts").Active = true
        return true
    end
    if gatelogic("Gate_Outer_Expanse-Outskirts","Karma",1) and has_outer_expanse_access() then
        visited["outskirts"] = false 
        regionprint("")
        Tracker:FindObjectForCode("Outskirts").Active = true
        Tracker:FindObjectForCode("early").Active = true
        return true
    end
    visited["outskirts"] = false
    regionprint("does NOT have Outskirts access")
    return false
end
function has_industrial_access()
    regionprint("Checking Industrial access...")
    if visited["industrial"] then
        regionprint("Already in an Industrial block")
        return false
    end
    visited["industrial"] = true
    if Tracker:FindObjectForCode("Industrial").Active then
        regionprint("Industrial is Active!")
        visited["industrial"] = false
        return true
    end
    if gatelogic("Gate_Outskirts-Industrial","Karma",3) and has_outskirts_access() then
        visited["industrial"] = false 
        regionprint("Industrial access from Outskirts")
        Tracker:FindObjectForCode("Industrial").Active = true
        return true
    end
    if gatelogic("Gate_Industrial-Pipeyard","Karma",2) and has_pipeyard_access() then
        visited["industrial"] = false
        regionprint("Industrial access from Pipeyard")
        Tracker:FindObjectForCode("Industrial").Active = true
        return true
    end
    if gatelogic("Gate_Industrial-Chimney","Karma",3) and has_chimney_access() then
        visited["industrial"] = false
        regionprint("Industrial access from Chimney")
        Tracker:FindObjectForCode("Industrial").Active = true
        return true
    end
    if gatelogic("Gate_Industrial-Shaded","Karma",1) and (has_shaded_access() or has_silent_access()) then
        visited["industrial"] = false
        regionprint("Industrial access from Shaded")
        Tracker:FindObjectForCode("Industrial").Active = true
        return true
    end
    if gatelogic("Gate_Industrial-Garbage","Karma",2) and has_garbage_access() then
        visited["industrial"] = false
        regionprint("Industrial access from Garbage")
        Tracker:FindObjectForCode("Industrial").Active = true
        return true
    end
    visited["industrial"] = false
    regionprint("Does NOT have industrial access!")
    return false
end
function has_chimney_access()
    regionprint("Checking Chimney access...")
    if visited["chimney"] then
        regionprint("Already in a Chimney block")
        return false
    end
    visited["chimney"] = true
    if Tracker:FindObjectForCode("Chimney").Active then
        visited["chimney"] = false
        regionprint("Chimney is active!")
        return true
    end
    if gatelogic("Gate_Industrial-Chimney","Karma",3) and has_industrial_access() then
        visited["chimney"] = false
        regionprint("Chimney access from Industrial")
        Tracker:FindObjectForCode("Chimney").Active = true
        return true
    end
    if gatelogic("Gate_Drainage-Chimney","Karma",5) and has_drainage_access() and Tracker:FindObjectForCode("MSC").Active then
        visited["chimney"] = false
        regionprint("Chimney access from Drainage")
        Tracker:FindObjectForCode("Chimney").Active = true
        return true
    end
    if gatelogic("Gate_Chimney-Exterior","Karma",1) and has_exterior_access() and Tracker:FindObjectForCode("west").Active then
        visited["chimney"] = false
        regionprint("Chimney access from The Exterior")
        Tracker:FindObjectForCode("Chimney").Active = true
        return true
    end
    if gatelogic("Gate_Chimney-Sky_Islands","Karma",3) and has_sky_islands_access() then
        visited["chimney"] = false
        regionprint("Chimney access from Sky Islands")
        Tracker:FindObjectForCode("Chimney").Active = true
        return true
    end
    visited["chimney"] = false
    regionprint("Does NOT have Chimney access!")
    return false
end
function has_farm_arrays_access()
    regionprint("Checking Farm Arrays access...")
    if visited["farm"] then
        regionprint("Already in a Farm Arrays block!")
        return false
    end
    visited["farm"] = true
    if Tracker:FindObjectForCode("Farm").Active then
        visited["farm"] = false
        regionprint("Farm Arrays is active!")
        return true
    end
    if gatelogic("Gate_Outskirts-Farm_Arrays","Karma",5) and has_outskirts_access() then
        visited["farm"] = false 
        regionprint("Farm Arrays access from Outskirts")
        Tracker:FindObjectForCode("Farm").Active = true
        return true
    end
    if gatelogic("Gate_Farm_Arrays-Sky_Islands","Karma",3) and has_sky_islands_access() then
        visited["farm"] = false
        regionprint("Farm Arrays access from Sky Islands")
        Tracker:FindObjectForCode("Farm").Active = true
        return true
    end
    if gatelogic("Gate_Farm_Arrays-Subterranean","Karma",5) and has_subterranean_access() and Tracker:FindObjectForCode("saint") then
        visited["farm"] = false
        regionprint("Farm Arrays access from Subterranean")
        Tracker:FindObjectForCode("Farm").Active = true
        return true
    end
    visited["farm"] = false
    regionprint("Does NOT have Farm Arrays access!")
    return false
end
function has_subterranean_access()
    regionprint("Checking Subterranean access...")
    if visited["subterranean"] then
        regionprint("Already in a Subterranean block!")
        return false
    end
    visited["subterranean"] = true
    if Tracker:FindObjectForCode("Subterranean").Active then
        visited["subterranean"] = false
        regionprint("Subterranean is active!")
        return true
    end
    if gatelogic("Gate_Farm_Arrays-Subterranean","Karma",4) and has_farm_arrays_access() then
        visited["subterranean"] = false
        regionprint("Subterranean access from Farm Arrays")
        Tracker:FindObjectForCode("Subterranean").Active = true
        return true
    end
    if gatelogic("Gate_Subterranean-Outer_Expanse","Karma",5) and has_outer_expanse_access() then
        visited["subterranean"] = false
        regionprint("Subterranean access from Outer Expanse")
        Tracker:FindObjectForCode("Subterranean").Active = true
        return true
    end
    if gatelogic("Gate_Pipeyard-Subterranean","Karma",5) and has_pipeyard_access() then
        visited["subterranean"] = false
        regionprint("Subterranean access from Pipeyard")
        Tracker:FindObjectForCode("Subterranean").Active = true
        return true
    end
    if gatelogic("Gate_Subterranean-Shoreline","Karma",5) and (has_shoreline_access() or has_waterfront_access()) then
        visited["subterranean"] = false
        regionprint("Subterranean access from Shoreline")
        Tracker:FindObjectForCode("Subterranean").Active = true
        return true
    end
    if gatelogic("Gate_Subterranean-Drainage","Karma",4) and has_drainage_access() then
        visited["subterranean"] = false
        regionprint("Subterranean access from Drainage")
        Tracker:FindObjectForCode("Subterranean").Active = true
        return true
    end
    visited["subterranean"] = false
    regionprint("Does NOT have Subterranean access!")
    return false
end
function has_outer_expanse_access()
    regionprint("Checking Outer Expanse access...")
    if visited["outer"] then
        regionprint("Already in an Outer Expanse block!")
        return false
    end
    visited["outer"] = true
    if Tracker:FindObjectForCode("Outer").Active then
        visited["outer"] = false
        regionprint("Outer Expanse is active!")
        return true
    end
    if gatelogic("Gate_Subterranean-Outer_Expanse","Karma",2) and has_subterranean_access() then
        visited["outer"] = false
        regionprint("Outer Expanse access from Subterranean")
        Tracker:FindObjectForCode("Outer").Active = true
        return true
    end
    visited["outer"] = false
    regionprint("Does NOT have Outer Expanse access")
    return false
end
function has_drainage_access()
    regionprint("Checking Drainage access...")
    if visited["drainage"] then
        regionprint("Already in a Drainage block!")
        return false
    end
    visited["drainage"] = true
    if Tracker:FindObjectForCode("Drainage").Active then
        visited["drainage"] = false
        regionprint("Drainage is active!")
        return true
    end
    if gatelogic("Gate_Outskirts-Drainage","Karma",4) and has_outskirts_access() then
        visited["drainage"] = false
        regionprint("Drainage access from Outskirts")
        Tracker:FindObjectForCode("Drainage").Active = true
        return true
    end
    if gatelogic("Gate_Subterranean-Drainage","Karma",1) and has_subterranean_access() then 
        visited["drainage"] = false
        regionprint("Drainage access from Subterranean")
        Tracker:FindObjectForCode("Drainage").Active = true
        return true
    end
    if gatelogic("Gate_Drainage-Garbage","Karma",3) and has_garbage_access() then
        visited["drainage"] = false
        regionprint("Drainage access from Garbage")
        Tracker:FindObjectForCode("Drainage").Active = true
        return true
    end
    if gatelogic("Gate_Drainage-Chimney","Karma",3) and Tracker:FindObjectForCode("MSC").Active and has_chimney_access() then
        visited["drainage"] = false
        regionprint("Drainage access from Chimney")
        Tracker:FindObjectForCode("Drainage").Active = true
        return true
    end
    visited["drainage"] = false
    regionprint("Does NOT have Drainage access!")
    return false
end
function has_garbage_access()
    regionprint("Checking Garbage access...")
    if visited["garbage"] then
        regionprint("Already in a Garbage block!")
        return false
    end
    visited["garbage"] = true
    if Tracker:FindObjectForCode("Garbage").Active then
        visited["garbage"] = false
        regionprint("Garbage is active!")
        return true
    end
    if gatelogic("Gate_Industrial-Garbage","Karma",2) and has_industrial_access() then
        visited["garbage"] = false
        regionprint("Garbage access from Industrial")
        Tracker:FindObjectForCode("Garbage").Active = true
        return true
    end
    if gatelogic("Gate_Drainage-Garbage","Karma",1) and has_drainage_access() then
        visited["garbage"] = false
        regionprint("Garbage access from Drainage")
        Tracker:FindObjectForCode("Garbage").Active = true
        return true
    end
    if gatelogic("Gate_Garbage-Shoreline","Karma",2) and (has_shoreline_access() or has_waterfront_access()) then
        visited["garbage"] = false
        regionprint("Garbage access from Shoreline")
        Tracker:FindObjectForCode("Garbage").Active = true
        return true
    end
    if gatelogic("Gate_Garbage-Shaded","Karma",2) and ((Tracker:FindObjectForCode("MSC").Active and has_shaded_access()) or has_silent_access()) then
        visited["garbage"] = false
        regionprint("Garbage access from Shaded")
        Tracker:FindObjectForCode("Garbage").Active = true
        return true
    end
    visited["garbage"] = false
    regionprint("Does NOT have Garbage access!")
    return false
end
function has_shaded_access()
    regionprint("Checking Shaded access...")
    if Tracker:FindObjectForCode("saint").Active then
        regionprint("Shaded does not exist for Saint")
        return false
    end
    if visited["shaded"] then
        regionprint("Already in a Shaded block!")
        return false
    end
    visited["shaded"] = true
    if Tracker:FindObjectForCode("Shaded").Active then
        visited["shaded"] = false
        regionprint("Shaded is active!")
        return true
    end
    if gatelogic("Gate_Industrial-Shaded","Karma",5) and has_industrial_access() then
        visited["shaded"] = false
        regionprint("Shaded access from Industrial")
        Tracker:FindObjectForCode("Shaded").Active = true
        return true
    end
    if gatelogic("Gate_Garbage-Shaded","Karma",4) and Tracker:FindObjectForCode("MSC").Active and has_garbage_access() then
        visited["shaded"] = false
        regionprint("Shaded access from Garbage")
        Tracker:FindObjectForCode("Shaded").Active = true
        return true
    end
    if gatelogic("Gate_Shaded-Shoreline","Karma",2) and (has_shoreline_access() or has_waterfront_access()) then
        visited["shaded"] = false
        regionprint("Shaded access from Shoreline")
        Tracker:FindObjectForCode("Shaded").Active = true
        return true
    end
    if gatelogic("Gate_Shaded-Exterior","Karma",1) and has_exterior_access() and Tracker:FindObjectForCode("east").Active then 
        visited["shaded"] = false
        regionprint("Shaded access from The Exterior")
        Tracker:FindObjectForCode("Shaded").Active = true
        return true
    end
    visited["shaded"] = false
    regionprint("Does NOT have Shaded access!")
    return false
end
function has_exterior_access()
    regionprint("Checking Exterior access...")
    if Tracker:FindObjectForCode("saint").Active then
        regionprint("The Exterior does not exist for Saint")
        return false
    end
    if visited["exterior"] then
        regionprint("Already in an exterior block!")
        return false
    end
    visited["exterior"] = true
    if Tracker:FindObjectForCode("Exterior").Active then
        visited["exterior"] = false
        regionprint("Exterior is active!")
        return true
    end
    if gatelogic("Gate_Chimney-Exterior","Karma",4) and has_chimney_access() then
        visited["exterior"] = false
        regionprint("Exterior access from Chimney")
        Tracker:FindObjectForCode("Exterior").Active = true
        if Tracker:FindObjectForCode("riv").Active then
            Tracker:FindObjectForCode("west").Active = true
            Tracker:FindObjectForCode("wall").Active = true
        elseif (Tracker:FindObjectForCode("monk").Active and vanillagame) or (Tracker:FindObjectForCode("survivor").Active and vanillagame) then
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
        regionprint("Exterior access from Metropolis")
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
        regionprint("Wall access from Five Pebbles/The Rot")
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
        regionprint("Underhang access from Five Pebbles/The Rot")
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
        regionprint("Exterior access from Shaded")
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
        regionprint("Exterior access from Waterfront")
        Tracker:FindObjectForCode("Exterior").Active = true
        Tracker:FindObjectForCode("west").Active = true
        Tracker:FindObjectForCode("east").Active = true
        Tracker:FindObjectForCode("wall").Active = true
        return true
    end
    visited["exterior"] = false
    regionprint("Does NOT have Exterior access!")
    return false
end
function has_five_pebbles_access()
    regionprint("Checking Five Pebbles access...")
    if Tracker:FindObjectForCode("riv").Active or Tracker:FindObjectForCode("saint").Active then
        regionprint("Five Pebbles collapsed")
        return false
    end
    if visited["5p"] then
        regionprint("Already in a Five Pebbles block!")
        return false
    end
    visited["5p"] = true
    if Tracker:FindObjectForCode("5P").Active then
        visited["5p"] = false
        regionprint("Five Pebbles is active!")
        return true
    end
    if gatelogic("Gate_Wall-Five_Pebbles","Karma",1) and has_exterior_access() and Tracker:FindObjectForCode("wall").Active then 
        visited["5p"] = false
        regionprint("5P access from The Wall")
        Tracker:FindObjectForCode("puppet").Active = true
        return true
    end
    if gatelogic("Gate_Underhang-Five_Pebbles","Karma",5) and Tracker:FindObjectForCode("west").Active then
        visited["5p"] = false
        regionprint("Five Pebbles access from Underhang")
        Tracker:FindObjectForCode("5P").Active = true
        return true
    end
    visited["5p"] = false
    regionprint("Does NOT have Five Pebbles access!")
    return false
end
function has_pipeyard_access()
    regionprint("Checking Pipeyard access...")
    if visited["pipes"] then
        regionprint("Already in a Pipeyard block!")
        return false
    end
    visited["pipes"] = true
    if Tracker:FindObjectForCode("Pipeyard").Active then
        visited["pipes"] = false
        regionprint("Pipeyard is active!")
        return true
    end
    if gatelogic("Gate_Industrial-Pipeyard","Karma",4) and has_industrial_access() then
        visited["pipes"] = false
        regionprint("Pipeyard access from Industrial")
        Tracker:FindObjectForCode("Pipeyard").Active = true
        return true
    end
    if gatelogic("Gate_Pipeyard-Subterranean","Karma",3) and has_subterranean_access() then 
        visited["pipes"] = false
        regionprint("Pipeyard access from Subterranean")
        Tracker:FindObjectForCode("Pipeyard").Active = true
        return true
    end
    if gatelogic("Gate_Pipeyard-Sky_Islands","Karma",3) and has_sky_islands_access() then 
        visited["pipes"] = false
        regionprint("Pipeyard access from Sky Islands")
        Tracker:FindObjectForCode("Pipeyard").Active = true
        return true
    end
    if gatelogic("Gate_Pipeyard-Shoreline","Karma",3) and (has_shoreline_access() or has_waterfront_access()) and (Tracker:FindObjectForCode("arti").Active == false) then 
        visited["pipes"] = false
        regionprint("Pipeyard access from Shoreline")
        Tracker:FindObjectForCode("Pipeyard").Active = true
        return true
    end
    visited["pipes"] = false
    regionprint("Does NOT have Pipeyard access!")
    return false
end
function has_sky_islands_access()
    regionprint("Checking Sky Islands access...")
    if visited["sky"] then
        regionprint("Already in a Sky Islands block!")
        return false
    end
    visited["sky"] = true
    if Tracker:FindObjectForCode("Sky").Active then
        visited["sky"] = false
        regionprint("Sky Islands is active!")
        return true
    end
    if gatelogic("Gate_Chimney-Sky_Islands","Karma",2) and has_chimney_access() then 
        visited["sky"] = false
        regionprint("Sky Islands access from Chimney")
        Tracker:FindObjectForCode("Sky").Active = true
        return true
    end
    if gatelogic("Gate_Pipeyard-Sky_Islands","Karma",4) and has_pipeyard_access() then
        visited["sky"] = false
        regionprint("Sky Islands access from Pipeyard")
        Tracker:FindObjectForCode("Sky").Active = true
        return true
    end
    if gatelogic("Gate_Farm_Arrays-Sky_Islands","Karma",3) and has_farm_arrays_access() then 
        visited["sky"] = false
        regionprint("Sky Islands access from Farm Arrays")
        Tracker:FindObjectForCode("Sky").Active = true
        return true
    end
    visited["sky"] = false
    regionprint("Does NOT have Sky Islands access!")
    return false
end
function has_shoreline_access()
    regionprint("Checking Shoreline access...")
    if Tracker:FindObjectForCode("spearmaster").Active or Tracker:FindObjectForCode("arti").Active then
        regionprint("Moon hasn't collapsed yet.")
        return false
    end
    if visited["shoreline"] then
        regionprint("Already in a Shoreline block!")
        return false
    end
    visited["shoreline"] = true
    if Tracker:FindObjectForCode("Shoreline").Active then
        visited["shoreline"] = false
        regionprint("Shoreline is active!")
        return true
    end
    if gatelogic("Gate_Garbage-Shoreline","Karma",3) and has_garbage_access() then 
        visited["shoreline"] = false
        regionprint("Shoreline access from Garbage")
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if gatelogic("Gate_Pipeyard-Shoreline","Karma",3) and has_pipeyard_access() then 
        visited["shoreline"] = false
        regionprint("Shoreline access from Pipeyard")
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if gatelogic("Gate_Subterranean-Shoreline","Karma",2) and has_subterranean_access() then 
        visited["shoreline"] = false
        regionprint("Shoreline access from Subterranean")
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if gatelogic("Gate_Shaded-Shoreline","Karma",3) and has_shaded_access() then 
        visited["shoreline"] = false
        regionprint("Shoreline access from Shaded")
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if gatelogic("Gate_Shoreline-Submerged_Superstructure","Karma",1) and has_submerged_access() then 
        visited["shoreline"] = false
        regionprint("Shoreline access from Submerged")
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if gatelogic("Gate_Bitter_Aerie-Shoreline","Karma",5) and has_submerged_access() and Tracker:FindObjectForCode("riv").Active then 
        visited["shoreline"] = false
        regionprint("Shoreline access from Bitter Aerie")
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    if has_silent_access() and gatelogic("Gate_Shoreline-Silent_Construct","Karma",1) and Tracker:FindObjectForCode("saint").Active then
        visited["shoreline"] = false
        regionprint("Shoreline access from Silent")
        Tracker:FindObjectForCode("Shoreline").Active = true
        return true
    end
    visited["shoreline"] = false
    regionprint("Does NOT have Shoreline access!")
    return false
end
function has_submerged_access()
    regionprint("Checking Submerged access...")
    if Tracker:FindObjectForCode("spearmaster").Active or Tracker:FindObjectForCode("arti").Active then
        regionprint("Moon hasn't collapsed")
        return false
    end
    if visited["submerged"] then
        regionprint("Already in a Submerged block!")
        return false
    end
    visited["submerged"] = true
    if Tracker:FindObjectForCode("Submerged").Active then
        visited["submerged"] = false
        regionprint("Submerged is active!")
        return true
    end
    if gatelogic("Gate_Shoreline-Submerged_Superstructure","Karma",5) and has_shoreline_access() then
        visited["submerged"] = false
        regionprint("Submerged access from Shoerline")
        Tracker:FindObjectForCode("Submerged").Active = true
        return true
    end
    visited["submerged"] = false
    regionprint("Does NOT have Submerged access!")
    return false
end
function has_waterfront_access()
    regionprint("Checking Waterfront access...")
    if Tracker:FindObjectForCode("spearmaster").Active or Tracker:FindObjectForCode("arti").Active then
        if visited["water"] then
            regionprint("Already in a Waterfront block!")
            return false
        end
        visited["water"] = true
        if Tracker:FindObjectForCode("Waterfront").Active then
            visited["water"] = false
            regionprint("Waterfront is active!")
            return true
        end
        if has_exterior_access() and gatelogic("Gate_Exterior-Precipice","Karma",1) then 
            visited["water"] = false
            regionprint("Waterfront access from The Exterior")
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if has_garbage_access() and gatelogic("Gate_Garbage-Shoreline","Karma",3) then 
            visited["water"] = false
            regionprint("Waterfront access from Garbage")
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if has_shaded_access() and gatelogic("Gate_Shaded-Shoreline","Karma",3) then 
            visited["water"] = false
            regionprint("Waterfront access from Shaded")
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if has_subterranean_access() and gatelogic("Gate_Subterranean-Shoreline","Karma",2) then 
            visited["water"] = false
            regionprint("Waterfront access from Subterranean")
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if has_pipeyard_access() and gatelogic("Gate_Pipeyard-Shoreline","Karma",3) and (Tracker:FindObjectForCode("arti").Active == false) then 
            visited["water"] = false
            regionprint("Waterfront access from Pipeyard")
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if gatelogic("Gate_Struts-Waterfront","Karma",1) and Tracker:FindObjectForCode("spearmaster").Active and has_lttm_access() then 
            visited["water"] = false
            regionprint("Waterfront access from The Struts")
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        if gatelogic("Gate_Precipice-LTTM","Karma",1) and Tracker:FindObjectForCode("spearmaster").Active and has_lttm_access() then 
            visited["water"] = false
            regionprint("Precipice access from Moon")
            Tracker:FindObjectForCode("Waterfront").Active = true
            return true
        end
        visited["water"] = false
        regionprint("Does NOT have Waterfront access!")
        return false
    else
        regionprint("Moon has collapsed!")
        return false
    end
end
function has_metro_access()
    regionprint("Checking Metropolis access...")
    if visited["metro"] then
        regionprint("Already in a Metro block")
        return false
    end
    visited["metro"] = true
    if Tracker:FindObjectForCode("Metro").Active then
        visited["metro"] = false
        regionprint("Metropolis is active!")
        return true
    end
    if gatelogic("Gate_Wall-Metropolis","drone",0) and Tracker:FindObjectForCode("arti").Active and has_exterior_access() then 
        visited["metro"] = false
        regionprint("Metropolis access from The Wall")
        Tracker:FindObjectForCode("Metro").Active = true
        return true
    end
    visited["metro"] = false
    regionprint("Does NOT have Metropolis access!")
    return false
end
function has_rot_access()
    regionprint("Checking Rot access...")
    if Tracker:FindObjectForCode("riv").Active then
        if visited["rot"] then
            regionprint("Already in a Rot block!")
            return false
        end
        visited["rot"] = true
        if Tracker:FindObjectForCode("Rot").Active then
            visited["rot"] = false
            regionprint("The Rot is Active!")
            return true
        end
        if has_exterior_access() and Tracker:FindObjectForCode("west").Active and (gatelogic("Gate_Wall-Five_Pebbles","Karma",1) or gatelogic("Gate_Underhang-Five_Pebbles","Karma",5)) then 
            visited["rot"] = false
            regionprint("Rot access from the Exterior")
            Tracker:FindObjectForCode("Rot").Active = true
            return true
        end
        visited["rot"] = false
        regionprint("Does NOT have Rot access!")
        return false
    else
        regionprint("Rot is Rivulet exclusive!")
        return false
    end
end
function has_lttm_access()
    regionprint("Checking LTTM access...")
    if Tracker:FindObjectForCode("spearmaster").Active then
        if visited["moon"] then
            regionprint("Already in a Moon block!")
            return false
        end
        visited["moon"] = true
        if Tracker:FindObjectForCode("Moon").Active then
            visited["moon"] = false
            regionprint("LTTM is active!")
            return true
        end
        if gatelogic("Gate_Struts-Waterfront","Karma",1) and has_waterfront_access() then 
            visited["moon"] = false
            regionprint("Moon access from Waterfront")
            Tracker:FindObjectForCode("Moon").Active = true
            return true
        end
        if gatelogic("Gate_Precipice-LTTM","Karma",5) and has_waterfront_access() then 
            visited["moon"] = false
            regionprint("Moon access from The Precipice")
            Tracker:FindObjectForCode("Moon").Active = true
            return true
        end
        visited["moon"] = false
        regionprint("Does NOT have Moon access!")
        return false
    else
        regionprint("LTTM is Spearmaster exclusive!")
        return false
    end
end
function has_silent_access()
    regionprint("Checking Silent Construct access...")
    if Tracker:FindObjectForCode("saint").Active then
        if visited["silent"] then
            regionprint("Already in a Silent block!")
            return false
        end
        visited["silent"] = true
        if Tracker:FindObjectForCode("Silent").Active then
            visited["silent"] = false
            regionprint("Silent Construct is active!")
            return true
        end
        if has_shoreline_access() and gatelogic("Gate_Shoreline-Silent_Construct","Karma",5) then 
            visited["silent"] = false
            regionprint("Silent access from Shoreline")
            Tracker:FindObjectForCode("Silent").Active = true
            return true
        end
        if gatelogic("Gate_Industrial-Shaded","Karma",5) and has_industrial_access() then 
            visited["silent"] = false
            regionprint("Silent access from Industrial")
            Tracker:FindObjectForCode("Silent").Active = true
            return true
        end
        if gatelogic("Gate_Garbage-Shaded","Karma",4) and has_garbage_access() then 
            visited["silent"] = false
            regionprint("Silent access from Garbage")
            Tracker:FindObjectForCode("Silent").Active = true
            return true
        end
        visited["silent"] = false
        regionprint("Does NOT have Silent access!")
        return false
    else
        regionprint("Silent Construct is Saint exclusive!")
        return false
    end
end
function has_rubicon_access()
    regionprint("Checking Rubicon access...")
    if has_subterranean_access() and (Tracker:FindObjectForCode("Karma").CurrentStage == 8) and Tracker:FindObjectForCode("saint").Active and Tracker:FindObjectForCode("glow").Active then 
        Tracker:FindObjectForCode("Rubicon").Active = true
        regionprint("Has Rubicon access")
        return true
    end
    regionprint("Does NOT have Rubicon access!")
    return false
end


--for determining how many wanderer pips you should have access to
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

