GameEvents.OttomanAttachModifierSwitch.Add(function (playerId)
	local player = Players[playerId];
	player:AttachModifierByID('SULEIMAN_GOVERNOR_POINTS');
end);

function OttomanCityConquered(newPlayerId, oldPlayerId, newCityId, x, y)
	local playerConfig = PlayerConfigurations[newPlayerId];
	if not ExposedMembers.DLHD.Utils.LeaderHasTrait(newPlayerId, 'TRAIT_LEADER_SULEIMAN_GOVERNOR') then
		return;
	end
	local oldPlayer = Players[oldPlayerId];
	if not oldPlayer:GetInfluence():CanReceiveInfluence() then
		return;
	end
	local player = Players[playerId];
	player:AttachModifierByID('SULEIMAN_GOVERNOR_POINTS');
end
GameEvents.CityConquered.Add(OttomanCityConquered);