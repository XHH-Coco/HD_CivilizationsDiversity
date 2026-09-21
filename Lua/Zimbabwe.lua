ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

-- ======================================================================================================================================================
-- 津巴布韦LA 单位消耗资源
-- ======================================================================================================================================================
local LTRAIT_UNITS_TURN_TAG = 'HD_LTRAIT_UNITS_TURN';

local LTRAIT_UNITS_OWNED_RESOURCE_LOST_HP_MIN = GlobalParameters.HD_LTRAIT_UNITS_OWNED_RESOURCE_LOST_HP_MIN or 0;
local LTRAIT_UNITS_OWNED_RESOURCE_LOST_HP_MAX = GlobalParameters.HD_LTRAIT_UNITS_OWNED_RESOURCE_LOST_HP_MAX or 0;
local LTRAIT_UNITS_RECOVER_MOVEMENT = GlobalParameters.HD_LTRAIT_UNITS_RECOVER_MOVEMENT or 0;
function MutotaLtraitConsumeResource(playerId, unitId)
  local player = Players[playerId];
	if not player then return; end
  local unit = UnitManager.GetUnit(playerId, unitId);
  if not unit then return; end
  local unitInfo = GameInfo.Units[unit:GetTypeHash()];
  if not unitInfo then return; end
  local plot = Map.GetPlot(unit:GetX(), unit:GetY());
	if not plot then return; end

  local resourceId = plot:GetResourceType();
	if resourceId == -1 then return; end
	local resourceInfo = GameInfo.Resources[resourceId];
	if not resourceInfo then return; end
	if resourceInfo.Frequency <= 0 and resourceInfo.SeaFrequency <= 0 and resourceInfo.ResourceClassType ~= 'RESOURCECLASS_ARTIFACT' then return; end

  -- 判断是否在有主之地
  local plotOwner = plot:GetOwner();
  if plotOwner ~= -1 and plotOwner ~= playerId then
    local damage = Game.GetRandNum(LTRAIT_UNITS_OWNED_RESOURCE_LOST_HP_MAX - LTRAIT_UNITS_OWNED_RESOURCE_LOST_HP_MIN + 1, "Random Damage for " .. playerId) + LTRAIT_UNITS_OWNED_RESOURCE_LOST_HP_MIN;
    local currentHP = unit:GetMaxDamage() - unit:GetDamage();
    unit:ChangeDamage(damage);

    if damage >= currentHP then return; end
  end

  -- 移除资源 摧毁改良
  if plot:GetImprovementType() ~= -1 then
    ImprovementBuilder.SetImprovementType(plot, -1);
  end
  ResourceBuilder.SetResourceType(plot, -1);

  -- 记录回合数 每回合限一次
  local turn = Game.GetCurrentGameTurn();
  unit:SetProperty(LTRAIT_UNITS_TURN_TAG, turn);

  -- 额外特效
  local recoverMovement = LTRAIT_UNITS_RECOVER_MOVEMENT;
  local recoverHP = 0;
  local exp = 0;
  local gold = 0;
  local science = 0;
  local culture = 0;
  local faith = 0;

  Game.AddWorldViewText({
    MessageType = 0,
    MessageText = '+' .. LTRAIT_UNITS_RECOVER_MOVEMENT .. ' [ICON_MOVEMENT]',
    PlotX = unit:GetX(),
    PlotY = unit:GetY(),
    Visibility = RevealedState.VISIBLE,
    TargetID = playerId
  });

  local classificationList = Utils.Resource_Classification_Map[resourceInfo.ResourceType] or {};
	for row in GameInfo.HD_Resource_ExtraEffects() do
    local meetFilter = row.ResourceType == resourceInfo.ResourceType or row.ResourceClassType == resourceInfo.ResourceClassType;
    if not meetFilter then
			for _, classification in ipairs(classificationList) do
				if row.ResourceClassificationType == classification then
					meetFilter = true;
					break;
				end
			end
		end

    if meetFilter then
      local amount = row.MinAmount or 0;
      if row.MaxAmount ~= nil and row.MaxAmount > amount then
        amount = Game.GetRandNum(row.MaxAmount - amount + 1, "Random num for " .. playerId) + amount;
      end
      print("津巴布韦 消耗资源 获得额外效果：" .. row.ExtraEffectType, amount);

      local msg;

      if row.ExtraEffectType == 'HEAL' and unit:GetDamage() > 0 then
        recoverHP = recoverHP + amount;
        -- msg = '+' .. amount .. ' [ICON_DAMAGED]';
      elseif row.ExtraEffectType == 'EXP' and unitInfo.PromotionClass ~= nil then
        exp = exp + amount;
        -- msg = '+' .. amount .. 'EXP';
      elseif row.ExtraEffectType == 'MOVEMENT' then
        recoverMovement = recoverMovement + amount;
        msg = '+' .. amount .. ' [ICON_MOVEMENT]';
      elseif row.ExtraEffectType == 'GOLD' then
        gold = gold + amount;
        msg = '+' .. amount .. ' [ICON_GOLD]';
      elseif row.ExtraEffectType == 'SCIENCE' then
        science = science + amount;
        msg = '+' .. amount .. ' [ICON_SCIENCE]';
      elseif row.ExtraEffectType == 'CULTURE' then
        culture = culture + amount;
        msg = '+' .. amount .. ' [ICON_CULTURE]';
      elseif row.ExtraEffectType == 'FAITH' then
        faith = faith + amount;
        msg = '+' .. amount .. ' [ICON_FAITH]';
      elseif row.ExtraEffectType == 'MODIFIER' and row.ModifierId ~= nil then
        player:AttachModifierByID(row.ModifierId);
        if row.Description ~= nil then
          msg = Locale.Lookup(row.Description);
        end
      end

      if msg then
        Game.AddWorldViewText({
          MessageType = 0,
          MessageText = msg,
          PlotX = unit:GetX(),
          PlotY = unit:GetY(),
          Visibility = RevealedState.VISIBLE,
          TargetID = playerId
        });
      end
    end
  end

  if recoverMovement > 0 then
    unit:ChangeMovesRemaining(recoverMovement);
  end
  if recoverHP > 0 then
    unit:ChangeDamage(-recoverHP);
  end
  if exp > 0 then
    unit:GetExperience():ChangeExperience(exp);
  end
  if gold > 0 then
    player:GetTreasury():ChangeGoldBalance(gold);
  end
  if science > 0 then
    player:GetTechs():ChangeCurrentResearchProgress(science);
  end
  if culture > 0 then
    player:GetCulture():ChangeCurrentCulturalProgress(culture);
  end
  if faith > 0 then
    player:GetReligion():ChangeFaithBalance(faith);
  end
end
GameEvents.HD_MutotaLtraitConsumeResource.Add(MutotaLtraitConsumeResource);

-- ======================================================================================================================================================
-- 津巴布韦UU 猎象人
-- ======================================================================================================================================================
local UNIT_GEDEMO_ROZWI_TAG = 'HD_UNIT_GEDEMO_ROZWI';

local TERRAIN_SNOW_INDEX = GameInfo.Terrains['TERRAIN_SNOW'].Index;
local TERRAIN_SNOW_HILLS_INDEX = GameInfo.Terrains['TERRAIN_SNOW_HILLS'].Index;

local RESOURCE_P0K_PENGUINS_INFO = GameInfo.Resources['RESOURCE_P0K_PENGUINS'];

local validResourceList = {};
function InitRozwiValidResourceList()
  for row in GameInfo.Improvement_ValidResources() do
    if (row.ImprovementType == 'IMPROVEMENT_PASTURE' or row.ImprovementType == 'IMPROVEMENT_CAMP')
      and row.ResourceType ~= 'RESOURCE_TRUFFLES'
      and row.ResourceType ~= 'RESOURCE_HONEY'
      and row.ResourceType ~= 'RESOURCE_MEDIHERBS'
      and row.ResourceType ~= 'RESOURCE_CRABS'
      and row.ResourceType ~= 'RESOURCE_MUSHROOMS'
    then
      local resourceInfo = GameInfo.Resources[row.ResourceType];
      if resourceInfo then
        table.insert(validResourceList, resourceInfo.Index);
      end
    end
  end
end
InitRozwiValidResourceList();

function RozwiGeneratePastureCampResource(playerId, unitX, unitY)
  local player = Players[playerId];
  if not player then return; end

  local cityList = {};
  for _, city in player:GetCities():Members() do
    table.insert(cityList, city);
  end
  if #cityList == 0 then return; end

  for i = #cityList, 1, -1 do
    local city = cityList[i];

    -- print("猎象人", Locale.Lookup(city:GetName()));
    local neighborPlots = Map.GetNeighborPlots(city:GetX(), city:GetY(), 3);
    local validPlots = {};
    for _, plot in ipairs(neighborPlots) do
      if plot:GetImprovementType() == -1
        and plot:GetDistrictType() == -1
        and not plot:IsWater()
        and not plot:IsNaturalWonder()
        and not plot:IsMountain()
      then
        local terrainId = plot:GetTerrainType();
        if RESOURCE_P0K_PENGUINS_INFO or (terrainId ~= TERRAIN_SNOW_INDEX and terrainId ~= TERRAIN_SNOW_HILLS_INDEX) then
          table.insert(validPlots, plot);
        end        
      end
    end

    if #validPlots > 0 then
      -- 随机选取单元格
      local randomIndex = Game.GetRandNum(#validPlots, "Random random plot for " .. playerId) + 1;
      local targetPlot = validPlots[randomIndex];
      local terrainId = targetPlot:GetTerrainType();

      local targetResourceId = -1;
      if targetPlot == TERRAIN_SNOW_INDEX or targetPlot == TERRAIN_SNOW_HILLS_INDEX then
        if RESOURCE_P0K_PENGUINS_INFO then
          targetResourceId = RESOURCE_P0K_PENGUINS_INFO.Index;
        end
      else
        -- 查询可用牧场营地资源
        local validResources = {};
        for _, validResourceId in ipairs(validResourceList) do
          if Utils.IsResourceVisible(playerId, validResourceId) and ResourceBuilder.CanHaveResource(targetPlot, validResourceId) then
            table.insert(validResources, validResourceId);
            -- print("猎象人 可用资源：" .. Locale.Lookup(GameInfo.Resources[validResourceId].Name))
          end
        end

        randomIndex = Game.GetRandNum(#validResources, "Random random resource for " .. playerId) + 1;
        targetResourceId = validResources[randomIndex];
      end

      local resourceInfo = GameInfo.Resources[targetResourceId];
      if resourceInfo then
        -- print("猎象人 选定资源：" .. Locale.Lookup(resourceInfo.Name));
        Utils.GenerateResource(targetPlot, targetResourceId);
        Game.AddWorldViewText({
          MessageType = 0,
          MessageText = Locale.Lookup('LOC_ABILITY_HD_ROZWI_VIEWTEXT', '[ICON_' .. resourceInfo.ResourceType .. '] ', resourceInfo.Name, city:GetName()),
          PlotX = unitX,
          PlotY = unitY,
          Visibility = RevealedState.VISIBLE,
          TargetID = playerId
        });
        return;
      end
    end
  end

end

function RozwiGoodyHutReward(playerId, unitId, rewardType, rewardSubType)
  local unit = UnitManager.GetUnit(playerId, unitId);
  if not unit then return; end

  local isRozwi = unit:GetProperty(UNIT_GEDEMO_ROZWI_TAG) or 0;
  if isRozwi > 0 then
    RozwiGeneratePastureCampResource(playerId, unit:GetX(), unit:GetY());
  end
end
Events.GoodyHutReward.Add(RozwiGoodyHutReward);

function RozwiClearBarbarian(x, y, playerId)
  local units = Units.GetUnitsInPlot(x, y);
  for _, unit in ipairs(units) do
    if unit then
      local isRozwi = unit:GetProperty(UNIT_GEDEMO_ROZWI_TAG) or 0;
      if isRozwi > 0 and unit:GetOwner() == playerId then
        RozwiGeneratePastureCampResource(playerId, x, y);
        return;
      end
    end
  end
end
GameEvents.HDClearBarbarianCamp.Add(RozwiClearBarbarian)

-- ======================================================================================================================================================
-- 津巴布韦LU 探路者
-- ======================================================================================================================================================
local UNIT_ZIMBABWE_PATHFINDER_RESOURCE_TAG = 'HD_UNIT_ZIMBABWE_PATHFINDER_RESOURCE';
local UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_PLAYER_TAG = 'HD_UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_PLAYER_';
local UNIT_ZIMBABWE_PATHFINDER_FOUND_CITY_TAG = 'HD_UNIT_ZIMBABWE_PATHFINDER_FOUND_CITY';

local UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_BASE = GlobalParameters.HD_UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_BASE or 0;
local UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_ADD_PER_TIME = GlobalParameters.HD_UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_ADD_PER_TIME or 0;

function ZimbabwePathfinderEquipResource(playerId, unitId)
  ReportingEvents.SendLuaEvent('HD_CallZimbabwePathfinderSelectResourceEvent', {PlayerId = playerId, UnitId = unitId});
end
GameEvents.HD_ZimbabwePathfinderEquipResource.Add(ZimbabwePathfinderEquipResource);

function ZimbabwePathfinderSelectResource(playerId, param)
  local player = Players[playerId];
  if not player then return; end

  local resourceInfo = GameInfo.Resources[param.ResourceId];
  if not resourceInfo then return; end

  local scriptParam = param.ScriptParam or {};
  local unitId = scriptParam.UnitId;
  if not unitId then return; end

  local unit = UnitManager.GetUnit(playerId, unitId);
  if not unit then return; end

  -- 减少资源
  if resourceInfo.ResourceClassType == 'RESOURCECLASS_STRATEGIC' then
    local requiredAmount = 0;
    local times = player:GetProperty(UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_PLAYER_TAG .. resourceInfo.ResourceType) or 0;
    requiredAmount = UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_BASE + UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_ADD_PER_TIME * times;
    player:SetProperty(UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_PLAYER_TAG .. resourceInfo.ResourceType, times + 1);
    player:GetResources():ChangeResourceAmount(resourceInfo.Index, -requiredAmount);
  else
    local unitAbility = unit:GetAbility();
    if unitAbility:GetAbilityCount('ABILITY_HD_ZIMBABWE_PATHFINDER_EQUIP_' .. resourceInfo.ResourceType) == 0 then
      unitAbility:ChangeAbilityCount('ABILITY_HD_ZIMBABWE_PATHFINDER_EQUIP_' .. resourceInfo.ResourceType, 1);
    end
  end

  -- 记录资源
  unit:SetProperty(UNIT_ZIMBABWE_PATHFINDER_RESOURCE_TAG, param.ResourceId);

  -- 激活能力
  local unitAbility = unit:GetAbility();
  if unitAbility:GetAbilityCount('ABILITY_HD_ZIMBABWE_PATHFINDER_MOVEMENT') == 0 then
    unitAbility:ChangeAbilityCount('ABILITY_HD_ZIMBABWE_PATHFINDER_MOVEMENT', 1);
  end

  -- 获得移动力
  local movesRemaining = Utils.GetUnitMovesRemaining(playerId, unitId);
  unit:ChangeMovesRemaining(movesRemaining + 2);

  -- 改名
  local name = Locale.Lookup(unit:GetName());
  name = name .. ' [ICON_' .. resourceInfo.ResourceType .. ']';
  unit:GetExperience():SetVeteranName(name);
end
GameEvents.HD_ZimbabwePathfinderSelectResource.Add(ZimbabwePathfinderSelectResource)

function ZimbabwePathfinderFoundCity(playerId, unitId)
  local player = Players[playerId];
  if not player then return; end

  local unit = UnitManager.GetUnit(playerId, unitId);
  if not unit then return; end

  local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
  if not unitPlot then return; end

  local canFound = player:GetCities():IsValidFoundLocation(unit:GetX(), unit:GetY());
  if canFound then
    unit:SetProperty(UNIT_ZIMBABWE_PATHFINDER_FOUND_CITY_TAG, 1);

    -- 印资源
    local resourceId = unit:GetProperty(UNIT_ZIMBABWE_PATHFINDER_RESOURCE_TAG);
    local resourceInfo = GameInfo.Resources[resourceId];
    local targetPlot;
    if resourceInfo and (resourceInfo.Frequency > 0 or resourceInfo.SeaFrequency > 0)  then
      -- 地图资源
      local neighborPlots = Map.GetNeighborPlots(unit:GetX(), unit:GetY(), 3);
      local validPlots = {};
      for _, plot in ipairs(neighborPlots) do
        if plot:GetImprovementType() == -1
          and plot:GetResourceType() == -1
          and plot:GetDistrictType() == -1
          and not plot:IsWater()
          and not plot:IsNaturalWonder()
          and not plot:IsMountain()
          and (plot:GetOwner() == -1 or plot:GetOwner() == playerId)
        then
          if ResourceBuilder.CanHaveResource(plot, resourceInfo.Index) then
            table.insert(validPlots, plot);
          end
        end
      end

      if #validPlots > 0 then
        -- 生成资源
        local randomIndex = Game.GetRandNum(#validPlots, "Random random plot for " .. playerId) + 1;
        targetPlot = validPlots[randomIndex];
        Utils.GenerateResource(targetPlot, resourceInfo.Index);
      end
    end

    -- 建立城市
    local newCity = player:GetCities():Create(unit:GetX(), unit:GetY());
    if not newCity then return; end

    -- 显示印资源信息
    if targetPlot then
      Game.AddWorldViewText({
        MessageType = 0,
        MessageText = Locale.Lookup('LOC_ABILITY_HD_ZIMBABWE_PATHFINDER_GENERATE_RESOURCE_VIEWTEXT', '[ICON_' .. resourceInfo.ResourceType .. '] ', resourceInfo.Name, newCity:GetName()),
        PlotX = targetPlot:GetX(),
        PlotY = targetPlot:GetY(),
        Visibility = RevealedState.VISIBLE,
        TargetID = playerId
      });
    elseif resourceInfo.ResourceClassType == 'RESOURCECLASS_STRATEGIC' then
      -- 没有合法的生成单元格
      Game.AddWorldViewText({
        MessageType = 0,
        MessageText = Locale.Lookup('LOC_ABILITY_HD_ZIMBABWE_PATHFINDER_LOST_RESOURCE_VIEWTEXT', '[ICON_' .. resourceInfo.ResourceType .. '] ', resourceInfo.Name),
        PlotX = unit:GetX(),
        PlotY = unit:GetY(),
        Visibility = RevealedState.VISIBLE,
        TargetID = playerId
      });
    end

    -- 判断城市是否相邻或位于奢侈资源
    local hasOrAdjacentToLuxury = false;
    local neighborPlots = Map.GetNeighborPlots(unit:GetX(), unit:GetY(), 1);
    for _, unitPlot in ipairs(neighborPlots) do
      local unitPlotResourceId = unitPlot:GetResourceType();
      local unitPlotResourceInfo = GameInfo.Resources[unitPlotResourceId];
      if unitPlotResourceInfo and unitPlotResourceInfo.ResourceClassType == 'RESOURCECLASS_LUXURY' then
        hasOrAdjacentToLuxury = true;
        break;
      end
    end

    if hasOrAdjacentToLuxury then
      -- 激活能力
      local unitAbility = unit:GetAbility();
      if unitAbility:GetAbilityCount('ABILITY_HD_ZIMBABWE_PATHFINDER_CHARGE') == 0 then
        unitAbility:ChangeAbilityCount('ABILITY_HD_ZIMBABWE_PATHFINDER_CHARGE', 1);
      end
    else
      -- 删除单位
      player:GetUnits():Destroy(unit);
    end

  end
end
GameEvents.HD_ZimbabwePathfinderFoundCity.Add(ZimbabwePathfinderFoundCity);