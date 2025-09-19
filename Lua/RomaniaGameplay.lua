--单位攻击造成穿透伤害

--伤害衰减比例
local m_DeclineRate = 0.8;
function LineCombat(pCombatResult)

    -- 施暴者信息
    local attacker = pCombatResult[CombatResultParameters.ATTACKER];
    local attInfo = attacker[CombatResultParameters.ID];
    local pPlayerConfig = PlayerConfigurations[attInfo.player];

	if (pPlayerConfig == nil)
    or (pPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_CVS_ROMANIA") then
        return
    end

	if  (attInfo.type ~= ComponentType.UNIT) then
		return
	end

    local attUnit = UnitManager.GetUnit(attInfo.player, attInfo.id);
    local attLocation = attUnit:GetLocation();
    local attX = attLocation.x;
    local attY = attLocation.y;

    -- 受害者信息
    local defender = pCombatResult[CombatResultParameters.DEFENDER];
    local defInfo = defender[CombatResultParameters.ID];

	if  (defInfo.type ~= ComponentType.UNIT) then
		return
	end

    local defUnit = UnitManager.GetUnit(defInfo.player, defInfo.id);
    local damage = defender[CombatResultParameters.DAMAGE_TO];
    local defLocation = defUnit:GetLocation();
    local defX = defLocation.x;
    local defY = defLocation.y;

    local m_direction = -1;
    local pNeighborPlots = Map.GetAdjacentPlots(attX,attY);
    for i, pNeighborPlot in ipairs(pNeighborPlots) do
        if (defX == pNeighborPlot:GetX() and defY == pNeighborPlot:GetY()) then
            m_direction = i - 1;
        end
    end

    local mapW, mapH = Map.GetGridSize();

    local pPlot = Map.GetAdjacentPlot(defX, defY, m_direction);
    local defSndUnits = Units.GetUnitsInPlot(pPlot:GetX(),pPlot:GetY());
    for _, defSndUnit in ipairs(defSndUnits) do
		local owner = defSndUnit:GetOwner();
		if attUnit:GetOwner() ~= owner then
			local defSndUnitInfo = GameInfo.Units[defSndUnit:GetType()];
			if (defSndUnitInfo.FormationClass == 'FORMATION_CLASS_LAND_COMBAT') or (defSndUnitInfo.FormationClass == 'FORMATION_CLASS_NAVAL') or (defSndUnitInfo.FormationClass == 'FORMATION_CLASS_AIR') then
				defSndUnit:ChangeDamage(damage*m_DeclineRate);
			end
		end
    end

    --防止找到地图外的单元格
    if (pPlot:GetY() == 0)
    or (pPlot:GetY() == mapH) then
        return
    end

    local tPlot = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), m_direction);
    local defTrdUnits = Units.GetUnitsInPlot(tPlot:GetX(), tPlot:GetY());
    for _, defTrdUnit in ipairs(defTrdUnits) do
		local owner = defTrdUnit:GetOwner();
		if attUnit:GetOwner() ~= owner then
			local defTrdUnitInfo = GameInfo.Units[defTrdUnit:GetType()];
			if (defTrdUnitInfo.FormationClass == 'FORMATION_CLASS_LAND_COMBAT') or (defTrdUnitInfo.FormationClass == 'FORMATION_CLASS_NAVAL') or (defTrdUnitInfo.FormationClass == 'FORMATION_CLASS_AIR') then
				defTrdUnit:ChangeDamage(damage*m_DeclineRate*m_DeclineRate);
			end
		end
    end
end

Events.Combat.Add(LineCombat);

local ROMANIA_CACHE_KEY = 'ROMANIA_CACHE';
local PROPERTY_NAME = 'PLAYER_HAS_SWITCHED_TO_HIGHER_TIER_GOVERNMENT';
function RefreshSwitchGovernmentTurns (playerId)
	local player = Players[playerId];
	local cache = player:GetProperty(ROMANIA_CACHE_KEY) or {};
	local turn = Game.GetCurrentGameTurn();
	for _, city in player:GetCities():Members() do
		local location = city:GetLocation();
		local plot = Map.GetPlot(location.x, location.y);
		if (cache[turn] ~= nil) and (cache[turn] == 1) then
			plot:SetProperty(PROPERTY_NAME, 1);
		else
			plot:SetProperty(PROPERTY_NAME, 0);
		end
	end
end
function RomaniaGovernmentChanged (playerId, governmentId)
	local governmentInfo = GameInfo.Governments[governmentId];
	if governmentInfo.Tier == nil then
		return;
	end
	local player = Players[playerId];
	local cache = player:GetProperty(ROMANIA_CACHE_KEY) or {};
	if cache[governmentInfo.Tier] == nil then
		cache[governmentInfo.Tier] = 1;
		local turn = Game.GetCurrentGameTurn();
		for t = 0, (GlobalParameters.ROMANIA_DURATION or 0) - 1 do
			cache[turn + t] = 1;
		end
		player:SetProperty(ROMANIA_CACHE_KEY, cache);
		RefreshSwitchGovernmentTurns(playerId);
	end
end
Events.GovernmentChanged.Add(RomaniaGovernmentChanged);
GameEvents.PlayerTurnStartComplete.Add(RefreshSwitchGovernmentTurns);
Events.CityAddedToMap.Add(RefreshSwitchGovernmentTurns);

-- GameEvents.RomaniaChangeCultureSwitch.Add(function (playerId, civicId, amount)
--     local player = Players[playerId];
-- 	player:GetCulture():SetCulturalProgress(civicId, amount);
-- end);

GameEvents.RomaniaCityAttachModifierSwitch.Add(function (playerId, cityId, modifierId)
	local city = CityManager.GetCity(playerId, cityId);
	city:AttachModifierByID(modifierId);
end);

local ROMANIA_PROGRESS_KEY = 'ROMANIA_PROGRESS';
function RomaniaPlayerTurnActivated	(playerId, isFirstTime)
	if not ExposedMembers.DLHD.Utils.CivilizationHasTrait(playerId, 'TRAIT_CIVILIZATION_CVS_ROMANIA_UA') then
		return;
	end
	local player = Players[playerId];
	if player:GetProperty(ROMANIA_PROGRESS_KEY) ~= nil then
		return;
	else
		player:SetProperty(ROMANIA_PROGRESS_KEY, 1);
	end
	local percent = GlobalParameters.ROMANIA_CIVIC_PRECENT;
	local valids = {};
	for row in GameInfo.Governments() do
		if row.PrereqCivic ~= nil then
			table.insert(valids, GameInfo.Civics[row.PrereqCivic].Index);
		end
	end
	local culture = player:GetCulture();
	for _, civicId in ipairs(valids) do
		culture:SetCulturalProgress(civicId, culture:GetCultureCost(civicId) * percent / 100);
	end
end
Events.PlayerTurnActivated.Add(RomaniaPlayerTurnActivated);