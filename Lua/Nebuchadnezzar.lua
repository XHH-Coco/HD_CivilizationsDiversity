function NebuchadnezzarCityConquered (capturerId, ownerId, cityId, x, y)
	if not ExposedMembers.DLHD.Utils.LeaderHasTrait(capturerId, 'TRAIT_HANGING_GARDENS') then
		return;
	end
	local player = Players[capturerId];
	local conquerCity = CityManager.GetCityAt(x, y);
	local citizen = conquerCity:GetPopulation();
	local goldPerPopulation = GlobalParameters.NEBUCHADNEZZAR_GOLD_PER_POPULATION;
	local amount = citizen * goldPerPopulation;
	player:GetTreasury():ChangeGoldBalance(amount);
	Game.AddWorldViewText(0, '[COLOR:ResGoldLabelCS]+' .. amount .. '[ENDCOLOR][ICON_Gold]', conquerCity:GetX(), conquerCity:GetY());
end

GameEvents.CityConquered.Add(NebuchadnezzarCityConquered)