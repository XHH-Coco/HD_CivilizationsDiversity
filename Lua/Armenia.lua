local ARMENIA_APOSTLE_INDEX = GameInfo.Units['UNIT_ARMENIA_APOSTLE'].Index;
function ArmeniaUnitKilledInCombat (killedPlayerId, killedUnitId, playerId, unitId)
	local unit = UnitManager.GetUnit(killedPlayerId, killedUnitId) or 0;
	if unit:GetType() ~= ARMENIA_APOSTLE_INDEX then
		return;
	end
	local religion = unit:GetReligion():GetReligionType();
	local amount = GlobalParameters.ARMENIA_APOSTLE_PRESSURE;
	local killingUnit = UnitManager.GetUnit(playerId, unitId);
	local location = killingUnit:GetLocation();
	for _, player in ipairs(Players) do
		if player:GetCities() ~= nil then
			for _, city in player:GetCities():Members() do
				local cityLocation = city:GetLocation();
				if Map.GetPlotDistance(location.x, location.y, cityLocation.x, cityLocation.y) <= 6 then
					city:GetReligion():AddReligiousPressure(killedPlayerId, religion, amount, killedPlayerId);
				end
			end
		end
	end
end
Events.UnitKilledInCombat.Add(ArmeniaUnitKilledInCombat);