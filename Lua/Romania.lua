-- local pendingChange = {};
-- local pendingBoost = {};
-- function RomaniaCivicBoostTriggered (playerId, civicId, unknown1, unknown2)
-- 	local playerConfig = PlayerConfigurations[playerId];
-- 	local civ = playerConfig:GetCivilizationTypeName();
-- 	if not ExposedMembers.DLHD.Utils.CivilizationHasTrait(civ, 'TRAIT_CIVILIZATION_CVS_ROMANIA_UA') then
-- 		return;
-- 	end
-- 	local civicInfo = GameInfo.Civics[civicId];
-- 	local player = Players[playerId];
-- 	local valid = false;
-- 	for row in GameInfo.Governments() do
-- 		if row.PrereqCivic == civicInfo.CivicType then
-- 			valid = true;
-- 		end
-- 	end
-- 	if valid then
-- 		local progress = player:GetCulture():GetCulturalProgress(civicId);
-- 		if (pendingBoost[playerId] ~= nil) and (pendingBoost[playerId][civicId] ~= progress) then
-- 			ExposedMembers.GameEvents.RomaniaChangeCultureSwitch.Call(playerId, civicId, 2 * progress);
-- 		else
-- 			pendingChange[playerId] = pendingChange[playerId] or {};
-- 			pendingChange[playerId][civicId] = 1;
-- 		end
-- 	end
-- end
-- Events.CivicBoostTriggered.Add(RomaniaCivicBoostTriggered);
-- 
-- function RomaniaCivicChanged (playerId, civicId)
-- 	local player = Players[playerId];
-- 	if (pendingChange[playerId] ~= nil) and (pendingChange[playerId][civicId] == 1) then
-- 		pendingChange[playerId][civicId] = 0;
-- 		local progress = player:GetCulture():GetCulturalProgress(civicId);
-- 		ExposedMembers.GameEvents.RomaniaChangeCultureSwitch.Call(playerId, civicId, 2 * progress);
-- 	else
-- 		pendingBoost[playerId] = pendingBoost[playerId] or {};
-- 		pendingBoost[playerId][civicId] = player:GetCulture():GetCulturalProgress(civicId);
-- 	end
-- end
-- Events.CivicChanged.Add(RomaniaCivicChanged);

local ROMANIA_FORT_INDEX = GameInfo.Buildings['BUILDING_CVS_ROMANIA_UI'].Index;
local CITY_CENTER_INDEX = GameInfo.Districts['DISTRICT_CITY_CENTER'].Index;
function RomaniaBuildingAddedToMap (x, y, buildingId, playerId, unknown1, unknown2)
	if buildingId ~= ROMANIA_FORT_INDEX then
		return;
	end

	local district = CityManager.GetDistrictAt(x, y);
	local city = district:GetCity();

	local yield = {};
	for direction = 0, 5 do
		local plot = Map.GetAdjacentPlot(x, y, direction);
		if plot then
			local district = plot:GetDistrictType();
			if district == -1 or district == nil or district == CITY_CENTER_INDEX then
				for row in GameInfo.Yields() do
					yield[row.YieldType] = (yield[row.YieldType] or 0) + plot:GetYield(row.Index);
				end
			end
		end
	end
	for row in GameInfo.Yields() do
		for i = 1, (yield[row.YieldType] or 0) do
			ExposedMembers.GameEvents.RomaniaCityAttachModifierSwitch.Call(playerId, city:GetID(), 'ROMANIA_FORT_BASIC_' .. row.YieldType);
		end
	end
	city:SetProperty(ROMANIA_CACHE_KEY, yield);
end
Events.BuildingAddedToMap.Add(RomaniaBuildingAddedToMap);