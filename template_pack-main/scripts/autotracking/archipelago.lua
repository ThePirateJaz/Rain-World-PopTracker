-- this is an example/default implementation for AP autotracking
-- it will use the mappings defined in item_mapping.lua and location_mapping.lua to track items and locations via their ids
-- it will also keep track of the current index of on_item messages in CUR_INDEX
-- addition it will keep track of what items are local items and which one are remote using the globals LOCAL_ITEMS and GLOBAL_ITEMS
-- this is useful since remote items will not reset but local items might
-- if you run into issues when touching A LOT of items/locations here, see the comment about Tracker.AllowDeferredLogicUpdate in autotracking.lua
ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

-- resets an item to its initial state
function resetItem(item_code, item_type)
	local obj = Tracker:FindObjectForCode(item_code)
	if obj then
		item_type = item_type or obj.Type
		if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("resetItem: resetting item %s of type %s", item_code, item_type))
		end
		if item_type == "toggle" or item_type == "toggle_badged" then
			obj.Active = false
		elseif item_type == "progressive" or item_type == "progressive_toggle" then
			obj.CurrentStage = 0
			obj.Active = false
		elseif item_type == "consumable" then
			obj.AcquiredCount = 0
		elseif item_type == "custom" then
			-- your code for your custom lua items goes here
		elseif item_type == "static" and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("resetItem: tried to reset static item %s", item_code))
		elseif item_type == "composite_toggle" and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format(
				"resetItem: tried to reset composite_toggle item %s but composite_toggle cannot be accessed via lua." ..
				"Please use the respective left/right toggle item codes instead.", item_code))
		elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("resetItem: unknown item type %s for code %s", item_type, item_code))
		end
	elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("resetItem: could not find item object for code %s", item_code))
	end
end

-- advances the state of an item
function incrementItem(item_code, item_type, multiplier)
	local obj = Tracker:FindObjectForCode(item_code)
	if obj then
		item_type = item_type or obj.Type
		if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("incrementItem: code: %s, type %s", item_code, item_type))
		end
		if item_type == "toggle" or item_type == "toggle_badged" then
			obj.Active = true
		elseif item_type == "progressive" or item_type == "progressive_toggle" then
			if obj.Active then
				obj.CurrentStage = obj.CurrentStage + 1
			else
				obj.Active = true
			end
		elseif item_type == "consumable" then
			obj.AcquiredCount = obj.AcquiredCount + obj.Increment * multiplier
		elseif item_type == "custom" then
			-- your code for your custom lua items goes here
		elseif item_type == "static" and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("incrementItem: tried to increment static item %s", item_code))
		elseif item_type == "composite_toggle" and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format(
				"incrementItem: tried to increment composite_toggle item %s but composite_toggle cannot be access via lua." ..
				"Please use the respective left/right toggle item codes instead.", item_code))
		elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("incrementItem: unknown item type %s for code %s", item_type, item_code))
		end
	elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("incrementItem: could not find object for code %s", item_code))
	end
end

-- apply everything needed from slot_data, called from onClear
function apply_slot_data(slot_data)
	if slot_data["is_msc_enabled"] == 1 and Tracker:FindObjectForCode("MSC").Active == false then
		Tracker:FindObjectForCode("MSC").Active = true
	end
	Tracker:FindObjectForCode("scug").CurrentStage = slot_data["which_campaign"]
	if slot_data["starting_room"] == nil  then
		if slot_data["which_campaign"] == 0 or slot_data["which_campaign"] == 1 then
			Tracker:FindObjectForCode("Outskirts").Active = true return
		elseif slot_data["which_campaign"] == 2 then
			Tracker:FindObjectForCode("Farm").Active = true return
		elseif slot_data["which_campaign"] == 3 then
			Tracker:FindObjectForCode("Shaded").Active = true return
		elseif slot_data["which_campaign"] == 4 then
			Tracker:FindObjectForCode("Garbage").Active = true return
		elseif slot_data["which_campaign"] == 5 then
			Tracker:FindObjectForCode("Drainage").Active = true return
		elseif slot_data["which_campaign"] == 6 then
			Tracker:FindObjectForCode("Outskirts").Active = true
			Tracker:FindObjectForCode("early").Active = true return
		elseif slot_data["which_campaign"] == 7 then
			Tracker:FindObjectForCode("Sky").Active = true return
		end
	elseif slot_data["starting_room"] == "CC_S04" then
		Tracker:FindObjectForCode("Chimney").Active = true return
	elseif slot_data["starting_room"] == "CC_S05" then
		Tracker:FindObjectForCode("Chimney").Active = true return
	elseif slot_data["starting_room"] == "CC_S01" then
		Tracker:FindObjectForCode("Chimney").Active = true return
	elseif slot_data["starting_room"] == "CC_S03" then
		Tracker:FindObjectForCode("Chimney").Active = true return
	elseif slot_data["starting_room"] == "CC_S03" then
		Tracker:FindObjectForCode("Chimney").Active = true return
	elseif slot_data["starting_room"] == "CC_S07" then
		Tracker:FindObjectForCode("Chimney").Active = true return
	elseif slot_data["starting_room"] == "DS_S03" then
		Tracker:FindObjectForCode("Drainage").Active = true return
	elseif slot_data["starting_room"] == "DS_S01R" then
		Tracker:FindObjectForCode("Drainage").Active = true return
	elseif slot_data["starting_room"] == "DS_S04" then
		Tracker:FindObjectForCode("Drainage").Active = true return
	elseif slot_data["starting_room"] == "DS_S02L" then
		Tracker:FindObjectForCode("Drainage").Active = true return
	elseif slot_data["starting_room"] == "UG_S03" then
		Tracker:FindObjectForCode("Drainage").Active = true return
	elseif slot_data["starting_room"] == "UG_S01R" then
		Tracker:FindObjectForCode("Drainage").Active = true return
	elseif slot_data["starting_room"] == "UG_S04" then
		Tracker:FindObjectForCode("Drainage").Active = true return
	elseif slot_data["starting_room"] == "UG_S02L" then
		Tracker:FindObjectForCode("Drainage").Active = true return
	elseif slot_data["starting_room"] == "GW_S01" then
		Tracker:FindObjectForCode("Garbage").Active = true return
	elseif slot_data["starting_room"] == "GW_S02" then
		Tracker:FindObjectForCode("Garbage").Active = true return
	elseif slot_data["starting_room"] == "GW_S03" then
		Tracker:FindObjectForCode("Garbage").Active = true return
	elseif slot_data["starting_room"] == "GW_S04" then
		Tracker:FindObjectForCode("Garbage").Active = true return
	elseif slot_data["starting_room"] == "GW_S05" then
		Tracker:FindObjectForCode("Garbage").Active = true return
	elseif slot_data["starting_room"] == "GW_S06" then
		Tracker:FindObjectForCode("Garbage").Active = true return
	elseif slot_data["starting_room"] == "GW_S07" then
		Tracker:FindObjectForCode("Garbage").Active = true return
	elseif slot_data["starting_room"] == "GW_S08" then
		Tracker:FindObjectForCode("Garbage").Active = true return
	elseif slot_data["starting_room"] == "GW_S09" then
		Tracker:FindObjectForCode("Garbage").Active = true return
	elseif slot_data["starting_room"] == "HI_S01" then
		Tracker:FindObjectForCode("Industrial").Active = true return
	elseif slot_data["starting_room"] == "HI_S02" then
		Tracker:FindObjectForCode("Industrial").Active = true return
	elseif slot_data["starting_room"] == "HI_S03" then
		Tracker:FindObjectForCode("Industrial").Active = true return
	elseif slot_data["starting_room"] == "HI_S04" then
		Tracker:FindObjectForCode("Industrial").Active = true return
	elseif slot_data["starting_room"] == "HI_S05" then
		Tracker:FindObjectForCode("Industrial").Active = true return
	elseif slot_data["starting_room"] == "HI_S06" then
		Tracker:FindObjectForCode("Industrial").Active = true return
	elseif slot_data["starting_room"] == "LF_S01" then
		Tracker:FindObjectForCode("Farm").Active = true return
	elseif slot_data["starting_room"] == "LF_S02" then
		Tracker:FindObjectForCode("Farm").Active = true return
	elseif slot_data["starting_room"] == "LF_S03" then
		Tracker:FindObjectForCode("Farm").Active = true return
	elseif slot_data["starting_room"] == "LF_S04" then
		Tracker:FindObjectForCode("Farm").Active = true return
	elseif slot_data["starting_room"] == "LF_S05" then
		Tracker:FindObjectForCode("Farm").Active = true return
	elseif slot_data["starting_room"] == "LF_S06" then
		Tracker:FindObjectForCode("Farm").Active = true return
	elseif slot_data["starting_room"] == "LF_S07" then
		Tracker:FindObjectForCode("Farm").Active = true return
	elseif slot_data["starting_room"] == "SB_S01" then
		Tracker:FindObjectForCode("Subterranean").Active = true return
	elseif slot_data["starting_room"] == "SB_S02" then
		Tracker:FindObjectForCode("Subterranean").Active = true return
	elseif slot_data["starting_room"] == "SB_S03" then
		Tracker:FindObjectForCode("Subterranean").Active = true return
	elseif slot_data["starting_room"] == "SB_S04" then
		Tracker:FindObjectForCode("Subterranean").Active = true return
	elseif slot_data["starting_room"] == "SB_S05" then
		Tracker:FindObjectForCode("Subterranean").Active = true return
	elseif slot_data["starting_room"] == "SB_S06" then
		Tracker:FindObjectForCode("Subterranean").Active = true return
	elseif slot_data["starting_room"] == "SB_S07" then
		Tracker:FindObjectForCode("Subterranean").Active = true return
	elseif slot_data["starting_room"] == "SB_S09" then
		Tracker:FindObjectForCode("Subterranean").Active = true return
	elseif slot_data["starting_room"] == "SB_S10" then
		Tracker:FindObjectForCode("Subterranean").Active = true return
	elseif slot_data["starting_room"] == "SH_S01" then
		Tracker:FindObjectForCode("Shaded").Active = true return
	elseif slot_data["starting_room"] == "SH_S02" then
		Tracker:FindObjectForCode("Shaded").Active = true return
	elseif slot_data["starting_room"] == "SH_S03" then
		Tracker:FindObjectForCode("Shaded").Active = true return
	elseif slot_data["starting_room"] == "SH_S04" then
		Tracker:FindObjectForCode("Shaded").Active = true return
	elseif slot_data["starting_room"] == "SH_S05" then
		Tracker:FindObjectForCode("Shaded").Active = true return
	elseif slot_data["starting_room"] == "SH_S06" then
		Tracker:FindObjectForCode("Shaded").Active = true return
	elseif slot_data["starting_room"] == "SH_S07" then
		Tracker:FindObjectForCode("Shaded").Active = true return
	elseif slot_data["starting_room"] == "SH_S08" then
		Tracker:FindObjectForCode("Shaded").Active = true return
	elseif slot_data["starting_room"] == "SH_S09" then
		Tracker:FindObjectForCode("Shaded").Active = true return
	elseif slot_data["starting_room"] == "SH_S10" then
		Tracker:FindObjectForCode("Shaded").Active = true return
	elseif slot_data["starting_room"] == "SH_S11" then
		Tracker:FindObjectForCode("Shaded").Active = true return
	elseif slot_data["starting_room"] == "SI_S03" then
		Tracker:FindObjectForCode("Sky").Active = true return
	elseif slot_data["starting_room"] == "SI_S04" then
		Tracker:FindObjectForCode("Sky").Active = true return
	elseif slot_data["starting_room"] == "SI_S05" then
		Tracker:FindObjectForCode("Sky").Active = true return
	elseif slot_data["starting_room"] == "SI_S06" then
		Tracker:FindObjectForCode("Sky").Active = true return
	elseif slot_data["starting_room"] == "SL_S02" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_S07" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_S05" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_S10" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_S06" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_S09" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_S03" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_S08" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_S04" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_S1" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_S13" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_S15" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_STOP" then
		Tracker:FindObjectForCode("Shoreline").Active = true return
	elseif slot_data["starting_room"] == "SL_SCRUSHED" then
		Tracker:FindObjectForCode("5P").Active = true return
	elseif slot_data["starting_room"] == "SS_S01" then
		Tracker:FindObjectForCode("5P").Active = true return
	elseif slot_data["starting_room"] == "SS_S02" then
		Tracker:FindObjectForCode("5P").Active = true return
	elseif slot_data["starting_room"] == "SS_S03" then
		Tracker:FindObjectForCode("5P").Active = true return
	elseif slot_data["starting_room"] == "SS_S04" then
		Tracker:FindObjectForCode("5P").Active = true return
	elseif slot_data["starting_room"] == "SS_S05" then
		Tracker:FindObjectForCode("5P").Active = true return
	elseif slot_data["starting_room"] == "SU_S01" then
		Tracker:FindObjectForCode("Outskirts").Active = true return
	elseif slot_data["starting_room"] == "SU_S03" then
		Tracker:FindObjectForCode("Outskirts").Active = true return
	elseif slot_data["starting_room"] == "SU_S04" then
		Tracker:FindObjectForCode("Outskirts").Active = true return
	elseif slot_data["starting_room"] == "SU_S05" then
		Tracker:FindObjectForCode("Outskirts").Active = true return
	elseif slot_data["starting_room"] == "UW_S01" then
		Tracker:FindObjectForCode("Exterior").Active = true return
	elseif slot_data["starting_room"] == "UW_S02" then
		Tracker:FindObjectForCode("Exterior").Active = true return
	elseif slot_data["starting_room"] == "UW_S03" then
		Tracker:FindObjectForCode("Exterior").Active = true return
	elseif slot_data["starting_room"] == "UW_S04" then
		Tracker:FindObjectForCode("Exterior").Active = true return
	elseif slot_data["starting_room"] == "UW_S05" then
		Tracker:FindObjectForCode("Exterior").Active = true return
	elseif slot_data["starting_room"] == "UW_S06" then
		Tracker:FindObjectForCode("Exterior").Active = true return
	elseif slot_data["starting_room"] == "UW_S07" then
		Tracker:FindObjectForCode("Exterior").Active = true return
	elseif slot_data["starting_room"] == "CL_S03" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S12" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S01" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S11" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S10" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S20" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S15" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S21" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_LCS2" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S05" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S08" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S14" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S13" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "CL_S02" then
		Tracker:FindObjectForCode("Silent").Active = true return
	elseif slot_data["starting_room"] == "DM_S01" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "DM_S02" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "DM_S03" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "DM_S04" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "DM_S05" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "DM_S06" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "DM_S10" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "DM_S11" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "DM_S13" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "DM_S14" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "DM_STOP" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "DM_LAB5" then
		Tracker:FindObjectForCode("Moon").Active = true return
	elseif slot_data["starting_room"] == "LC_S01" then
		Tracker:FindObjectForCode("Metro").Active = true return
	elseif slot_data["starting_room"] == "LC_S03" then
		Tracker:FindObjectForCode("Metro").Active = true return
	elseif slot_data["starting_room"] == "LC_S04" then
		Tracker:FindObjectForCode("Metro").Active = true return
	elseif slot_data["starting_room"] == "LC_S05" then
		Tracker:FindObjectForCode("Metro").Active = true return
	elseif slot_data["starting_room"] == "LC_S06" then
		Tracker:FindObjectForCode("Metro").Active = true return
	elseif slot_data["starting_room"] == "LC_A05" then
		Tracker:FindObjectForCode("Metro").Active = true return
	elseif slot_data["starting_room"] == "LC_SHELTER_ABOVE" then
		Tracker:FindObjectForCode("Metro").Active = true return
	elseif slot_data["starting_room"] == "LC_SROOFS" then
		Tracker:FindObjectForCode("Metro").Active = true return
	elseif slot_data["starting_room"] == "LC_SHELTERTRAIN1" then
		Tracker:FindObjectForCode("Metro").Active = true return
	elseif slot_data["starting_room"] == "LM_S15" then
		Tracker:FindObjectForCode("Waterfront").Active = true return
	elseif slot_data["starting_room"] == "LM_S02" then
		Tracker:FindObjectForCode("Waterfront").Active = true return
	elseif slot_data["starting_room"] == "LM_S07" then
		Tracker:FindObjectForCode("Waterfront").Active = true return
	elseif slot_data["starting_room"] == "LM_S05" then
		Tracker:FindObjectForCode("Waterfront").Active = true return
	elseif slot_data["starting_room"] == "LM_S09" then
		Tracker:FindObjectForCode("Waterfront").Active = true return
	elseif slot_data["starting_room"] == "LM_S03" then
		Tracker:FindObjectForCode("Waterfront").Active = true return
	elseif slot_data["starting_room"] == "LM_S04" then
		Tracker:FindObjectForCode("Waterfront").Active = true return
	elseif slot_data["starting_room"] == "LM_S11" then
		Tracker:FindObjectForCode("Waterfront").Active = true return
	elseif slot_data["starting_room"] == "LM_S13" then
		Tracker:FindObjectForCode("Waterfront").Active = true return
	elseif slot_data["starting_room"] == "LM_S06" then
		Tracker:FindObjectForCode("Waterfront").Active = true return
	elseif slot_data["starting_room"] == "OE_S01" then
		Tracker:FindObjectForCode("Outer").Active = true return
	elseif slot_data["starting_room"] == "OE_S03" then
		Tracker:FindObjectForCode("Outer").Active = true return
	elseif slot_data["starting_room"] == "OE_S04" then
		Tracker:FindObjectForCode("Outer").Active = true return
	elseif slot_data["starting_room"] == "OE_S06" then
		Tracker:FindObjectForCode("Outer").Active = true return
	elseif slot_data["starting_room"] == "OE_EXSHELTER" then
		Tracker:FindObjectForCode("Outer").Active = true return
	elseif slot_data["starting_room"] == "OE_MIDSHELTER" then
		Tracker:FindObjectForCode("Outer").Active = true return
	elseif slot_data["starting_room"] == "OE_SFINAL" then
		Tracker:FindObjectForCode("Outer").Active = true return
	elseif slot_data["starting_room"] == "RM_S01" then
		Tracker:FindObjectForCode("Rot").Active = true return
	elseif slot_data["starting_room"] == "RM_S02" then
		Tracker:FindObjectForCode("Rot").Active = true return
	elseif slot_data["starting_room"] == "RM_S03" then
		Tracker:FindObjectForCode("Rot").Active = true return
	elseif slot_data["starting_room"] == "RM_S04" then
		Tracker:FindObjectForCode("Rot").Active = true return
	elseif slot_data["starting_room"] == "RM_S05" then
		Tracker:FindObjectForCode("Rot").Active = true return
	elseif slot_data["starting_room"] == "RM_S06" then
		Tracker:FindObjectForCode("Rot").Active = true return
	elseif slot_data["starting_room"] == "RM_LCS1" then
		Tracker:FindObjectForCode("Rot").Active = true return
	elseif slot_data["starting_room"] == "RM_LCS2" then
		Tracker:FindObjectForCode("Rot").Active = true return
	elseif slot_data["starting_room"] == "RM_SDEAD" then
		Tracker:FindObjectForCode("Rot").Active = true return
	elseif slot_data["starting_room"] == "RM_SFINAL" then
		Tracker:FindObjectForCode("Rot").Active = true return
	elseif slot_data["starting_room"] == "VS_S04" then
		Tracker:FindObjectForCode("Pipeyard").Active = true return
	elseif slot_data["starting_room"] == "VS_S01" then
		Tracker:FindObjectForCode("Pipeyard").Active = true return
	elseif slot_data["starting_room"] == "VS_S20" then
		Tracker:FindObjectForCode("Pipeyard").Active = true return
	elseif slot_data["starting_room"] == "VS_S09" then
		Tracker:FindObjectForCode("Pipeyard").Active = true return
	elseif slot_data["starting_room"] == "VS_S05" then
		Tracker:FindObjectForCode("Pipeyard").Active = true return
	elseif slot_data["starting_room"] == "VS_S07" then
		Tracker:FindObjectForCode("Pipeyard").Active = true return
	elseif slot_data["starting_room"] == "VS_S02" then
		Tracker:FindObjectForCode("Pipeyard").Active = true return
	elseif slot_data["starting_room"] == "VS_S06" then
		Tracker:FindObjectForCode("Pipeyard").Active = true return
	elseif slot_data["starting_room"] == "VS_S08" then
		Tracker:FindObjectForCode("Pipeyard").Active = true return
	elseif slot_data["starting_room"] == "VS_S03" then
		Tracker:FindObjectForCode("Pipeyard").Active = true
		return
	end
end

-- called right after an AP slot is connected
function onClear(slot_data)
	-- use bulk update to pause logic updates until we are done resetting all items/locations
	Tracker.BulkUpdate = true	
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
	end
	CUR_INDEX = -1
	-- reset locations
	for _, mapping_entry in pairs(LOCATION_MAPPING) do
		for _, location_table in ipairs(mapping_entry) do
			if location_table then
				local location_code = location_table[1]
				if location_code then
					if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
						print(string.format("onClear: clearing location %s", location_code))
					end
					if location_code:sub(1, 1) == "@" then
						local obj = Tracker:FindObjectForCode(location_code)
						if obj then
							obj.AvailableChestCount = obj.ChestCount
						elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
							print(string.format("onClear: could not find location object for code %s", location_code))
						end
					else
						-- reset hosted item
						local item_type = location_table[2]
						resetItem(location_code, item_type)
					end
				elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
					print(string.format("onClear: skipping location_table with no location_code"))
				end
			elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
				print(string.format("onClear: skipping empty location_table"))
			end
		end
	end
	-- reset items
	for _, mapping_entry in pairs(ITEM_MAPPING) do
		for _, item_table in ipairs(mapping_entry) do
			if item_table then
				local item_code = item_table[1]
				local item_type = item_table[2]
				if item_code then
					resetItem(item_code, item_type)
				elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
					print(string.format("onClear: skipping item_table with no item_code"))
				end
			elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
				print(string.format("onClear: skipping empty item_table"))
			end
		end
	end
	apply_slot_data(slot_data)
	LOCAL_ITEMS = {}
	GLOBAL_ITEMS = {}
	-- manually run snes interface functions after onClear in case we need to update them (i.e. because they need slot_data)
	if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
		-- add snes interface functions here
	end
	Tracker.BulkUpdate = false
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
	end
	if not AUTOTRACKER_ENABLE_ITEM_TRACKING then
		return
	end
	if index <= CUR_INDEX then
		return
	end
	local is_local = player_number == Archipelago.PlayerNumber
	CUR_INDEX = index;
	local mapping_entry = ITEM_MAPPING[item_id]
	if not mapping_entry then
		if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("onItem: could not find item mapping for id %s", item_id))
		end
		return
	end
	for _, item_table in pairs(mapping_entry) do
		if item_table then
			local item_code = item_table[1]
			local item_type = item_table[2]
			local multiplier = item_table[3] or 1
			if item_code then
				incrementItem(item_code, item_type, multiplier)
				-- keep track which items we touch are local and which are global
				if is_local then
					if LOCAL_ITEMS[item_code] then
						LOCAL_ITEMS[item_code] = LOCAL_ITEMS[item_code] + 1
					else
						LOCAL_ITEMS[item_code] = 1
					end
				else
					if GLOBAL_ITEMS[item_code] then
						GLOBAL_ITEMS[item_code] = GLOBAL_ITEMS[item_code] + 1
					else
						GLOBAL_ITEMS[item_code] = 1
					end
				end
			elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
				print(string.format("onClear: skipping item_table with no item_code"))
			end
		elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("onClear: skipping empty item_table"))
		end
	end
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
		print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
	end
	-- track local items via snes interface
	if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
		-- add snes interface functions for local item tracking here
	end
end

-- called when a location gets cleared
function onLocation(location_id, location_name)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("called onLocation: %s, %s", location_id, location_name))
	end
	if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
		return
	end
	local mapping_entry = LOCATION_MAPPING[location_id]
	if not mapping_entry then
		if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("onLocation: could not find location mapping for id %s", location_id))
		end
		return
	end
	for _, location_table in pairs(mapping_entry) do
		if location_table then
			local location_code = location_table[1]
			if location_code then
				local obj = Tracker:FindObjectForCode(location_code)
				if obj then
					if location_code:sub(1, 1) == "@" then
						obj.AvailableChestCount = obj.AvailableChestCount - 1
					else
						-- increment hosted item
						local item_type = location_table[2]
						incrementItem(location_code, item_type)
					end
				elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
					print(string.format("onLocation: could not find object for code %s", location_code))
				end
			elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
				print(string.format("onLocation: skipping location_table with no location_code"))
			end
		elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("onLocation: skipping empty location_table"))
		end
	end
end

-- called when a locations is scouted
function onScout(location_id, location_name, item_id, item_name, item_player)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("called onScout: %s, %s, %s, %s, %s", location_id, location_name, item_id, item_name,
			item_player))
	end
	-- not implemented yet :(
end

-- called when a bounce message is received
function onBounce(json)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("called onBounce: %s", dump_table(json)))
	end
	-- your code goes here
end

-- add AP callbacks
-- un-/comment as needed
Archipelago:AddClearHandler("clear handler", onClear)
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
	Archipelago:AddItemHandler("item handler", onItem)
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
	Archipelago:AddLocationHandler("location handler", onLocation)
end
-- Archipelago:AddScoutHandler("scout handler", onScout)
-- Archipelago:AddBouncedHandler("bounce handler", onBounce)
