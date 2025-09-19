ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

--桑海送单位
local HARBOR_INDEX = GameInfo.Districts['DISTRICT_HARBOR'].Index;
local ENCAMPMENT_INDEX = GameInfo.Districts['DISTRICT_ENCAMPMENT'].Index;
function SONGHAIGameEraChanged (previousEra, newEra)
	for playerId, playerConfig in pairs(PlayerConfigurations) do
			-- print(playerId, Locale.Lookup(GameInfo.Civilizations[playerConfig:GetCivilizationTypeName()].Name))
		-- if Utils.CivilizationHasTrait(playerId, 'TRAIT_CIVILIZATION_CVS_SONGHAI_UA') then
		-- 	local player = Players[playerId];
		-- 	if not (Game.GetEras():HasGoldenAge(playerId) or Game.GetEras():HasHeroicGoldenAge(playerId)) then
		-- 		return;
		-- 	end
		-- 	for _, city in player:GetCities():Members() do
		-- 		if city ~= nil then
		-- 			local cityId = city:GetID();
		-- 			if city:IsOriginalCapital() then  -- unable to be used in Gameplay
		-- 				ExposedMembers.GameEvents.AttachModifierSwitch.Call(playerId, cityId, 'HD_SONGHAI_SETTLER');
		-- 			end
		-- 			for _, district in city:GetDistricts():Members() do
		-- 				local districtId = district:GetType();
		-- 				if districtId == HARBOR_INDEX then
		-- 					ExposedMembers.GameEvents.AttachModifierSwitch.Call(playerId, cityId, 'HD_SONGHAI_NAVAL_MELEE');
		-- 				end
		-- 				if districtId == ENCAMPMENT_INDEX then
		-- 					ExposedMembers.GameEvents.AttachModifierSwitch.Call(playerId, cityId, 'HD_SONGHAI_MELEE');
		-- 				end
		-- 			end
		-- 		end
		-- 	end
		-- end
	end
end
-- Events.GameEraChanged.Add(SONGHAIGameEraChanged);