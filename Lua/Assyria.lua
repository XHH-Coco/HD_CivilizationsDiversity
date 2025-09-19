
function AssyriaUnitKilledInCombat (killedPlayerId,	killedUnitId, playerId, unitId)
	if not ExposedMembers.DLHD.Utils.CivilizationHasTrait(playerId, 'TRAIT_CIVILIZATION_BOOM_RUBAUM') then
		return;
	end
	local player = Players[playerId];
	local killingUnit = UnitManager.GetUnit(playerId, unitId);
	local location = killingUnit:GetLocation();
	local x = location.x;
	local y = location.y;
	local damage = GlobalParameters.ASSYRIA_DAMAGE;
	for direction = 0, 5 do
		local plot = Map.GetAdjacentPlot(x, y, direction);
		if plot then
			for unit in Map.GetUnitsAt(plot):Units() do
				local owner = unit:GetOwner();
				if player:GetDiplomacy():IsAtWarWith(owner) then
					local unitInfo = GameInfo.Units[unit:GetType()];
					if (unitInfo.FormationClass == 'FORMATION_CLASS_LAND_COMBAT') or (unitInfo.FormationClass == 'FORMATION_CLASS_NAVAL') or (unitInfo.FormationClass == 'FORMATION_CLASS_AIR') then
						unit:ChangeDamage(damage);
					end
				end
			end
		end
	end
end
Events.UnitKilledInCombat.Add(AssyriaUnitKilledInCombat);

local ASSYRIA_CONQUER_CACHE_KEY = 'ASSYRIA_CONQUER_CACHE';
function AssyriaCityConquered (newPlayerId, oldPlayerId, newCityId, x, y)
	local player = Players[newPlayerId];
	local city = CityManager.GetCity(newPlayerId, newCityId);
	local cache = player:GetProperty(ASSYRIA_CONQUER_CACHE_KEY) or {};
	cache[newCityId] = {
		turn = Game.GetCurrentGameTurn(),
		population = city:GetPopulation()
	};
	player:SetProperty(ASSYRIA_CONQUER_CACHE_KEY, cache);
end
GameEvents.CityConquered.Add(AssyriaCityConquered);

function AssyriaCityRemovedFromMap (playerId, cityId)
	local player = Players[playerId];
	local cache = player:GetProperty(ASSYRIA_CONQUER_CACHE_KEY) or {};
	local cityCache = cache[cityId];
	if (cityCache == nil) or (cityCache.turn ~= Game.GetCurrentGameTurn()) then
		return;
	end

	if not ExposedMembers.DLHD.Utils.CivilizationHasTrait(playerId, 'TRAIT_CIVILIZATION_BOOM_RUBAUM') then
		return;
	end
	local city = CityManager.GetCity(playerId, cityId);
	if city ~= nil then
		return;
	end
	local population = cityCache.population;
	local amountPerPopulation = GlobalParameters.ASSYRIA_SCIENCE_PER_POPULATION;
	player:GetTechs():ChangeCurrentResearchProgress(population * amountPerPopulation);
	player:AttachModifierByID('ASSYRIA_GRANT_SETTLER');
end
Events.CityRemovedFromMap.Add(AssyriaCityRemovedFromMap);

function AshurbanipalCityRemovedFromMap (playerId, cityId)
	local player = Players[playerId];
	local cache = player:GetProperty(ASSYRIA_CONQUER_CACHE_KEY) or {};
	local cityCache = cache[cityId];
	if (cityCache == nil) or (cityCache.turn ~= Game.GetCurrentGameTurn()) then
		return;
	end

	if ExposedMembers.DLHD.Utils.LeaderHasTrait(playerId, 'TRAIT_LEADER_BOOM_ASHURBANIPAL') then
		player:AttachModifierByID('ASHURBANIPAL_CAPITAL_CULTURE');
	end
	if ExposedMembers.DLHD.Utils.LeaderHasTrait(playerId, 'TRAIT_LEADER_BOOM_BUILDING_ROYAL_LIBRARY') then
		player:AttachModifierByID('ASHURBANIPAL_ROYAL_LIBRARY_CULTURE');
		player:AttachModifierByID('ASHURBANIPAL_ROYAL_LIBRARY_GOLD');
	end
end
Events.CityRemovedFromMap.Add(AshurbanipalCityRemovedFromMap);