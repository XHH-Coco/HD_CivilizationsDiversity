function MalaysiaTradeRouteActivityChanged(PlayerID,OriginPlayerID,OriginCityID,TargetPlayerID,TargetCityID)
	local player = Players[PlayerID];
	local targetPlayer = Players[TargetPlayerID];
	local MALAYSIA_CACHE_KEY = 'MALAYSIA_CACHE';
	if not ExposedMembers.DLHD.Utils.CivilizationHasTrait(PlayerID, 'TRAIT_CIVILIZATION_CVS_MALAYSIA_UA') then
		return;
	end
	if not targetPlayer:GetInfluence():CanReceiveInfluence() then
		return;
	end
	if targetPlayer:GetProperty(MALAYSIA_CACHE_KEY) == 1 then
		return;
	end
	player:GetInfluence():GiveFreeTokenToPlayer(TargetPlayerID);
	targetPlayer:SetProperty(MALAYSIA_CACHE_KEY,1);
end
Events.TradeRouteActivityChanged.Add(MalaysiaTradeRouteActivityChanged);
