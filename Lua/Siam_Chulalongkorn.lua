
function ChulalongkornCityProductionCompleted (playerId, cityId, order, type, canceled, typeMod)
	if canceled then
		return;
	end

	local player = Players[playerId];
	local CHULALONGKORN_CACHE_KEY = 'CHULALONGKORN_CACHE';
	if not ExposedMembers.DLHD.Utils.LeaderHasTrait(playerId, 'TRAIT_LEADER_SUK_MONTHON_SYSTEM_HD') then
		return;
	end
	local valid = false;
	if order == 1 then
		local buildingInfo = GameInfo.Buildings[type];
		if (buildingInfo ~= nil) and (buildingInfo.PrereqDistrict == 'DISTRICT_GOVERNMENT') then
			valid = true;
		end
	elseif order == 2  then
		local districtInfo = GameInfo.Districts[type];
		if (districtInfo ~= nil) and (districtInfo.DistrictType == 'DISTRICT_GOVERNMENT') then
			valid = true;
			if player:GetProperty(CHULALONGKORN_CACHE_KEY) == 1 then
				return;
			end
			player:SetProperty(CHULALONGKORN_CACHE_KEY,1);
		end
	end
	if valid then
		local cost = GlobalParameters.MONTHON_SYSTEM_ENVOY_COST;
		if cost == nil then
			return;
		end
		local award = GlobalParameters.MONTHON_SYSTEM_GOVERNOR_AWARD or 0;
		local envoy = player:GetInfluence():GetTokensToGive();
		if envoy >= cost then
			player:GetInfluence():ChangeTokensToGive(-cost);
            player:GetGovernors():ChangeGovernorPoints(award);
		end
	end
end
Events.CityProductionCompleted.Add(ChulalongkornCityProductionCompleted)