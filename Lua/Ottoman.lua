function OttomanCityAddedToMap(playerId, cityId, x, y)
	if not ExposedMembers.DLHD.Utils.LeaderHasTrait(playerId, 'TRAIT_LEADER_SULEIMAN_GOVERNOR') then
		return;
	end
    local city = CityManager.GetCity(playerId, cityId);
	if city:GetOriginalOwner() ~= playerId and city:IsOriginalCapital() then
		ExposedMembers.GameEvents.OttomanAttachModifierSwitch.Call(playerId);
	end
end
Events.CityAddedToMap.Add(OttomanCityAddedToMap);