ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

-- 圣地加速
local WU_ZETIAN_ALT_HOLY_SITE_PERCENTAGE = GlobalParameters.HD_WU_ZETIAN_ALT_HOLY_SITE_PERCENTAGE or 0;
local WU_ZETIAN_ALT_HOLY_SITE_PERCENTAGE_TAG = 'HD_WU_ZETIAN_ALT_HOLY_SITE_PERCENTAGE_TAG'
function WuZeTianAltCityProductionChanged(playerId, cityId, productionId, objectId)
	local player = Players[playerId];

	if Utils.LeaderHasTrait(playerId, 'TRAIT_WU_ZETIAN_ALT') then
		local city = player:GetCities():FindID(cityId);
		if city ~= nil and city:GetProperty(WU_ZETIAN_ALT_HOLY_SITE_PERCENTAGE_TAG) ~= 1 then
			local current = city:GetBuildQueue():CurrentlyBuilding();
			if current then
				local districtInfo = GameInfo.Districts[current];
				if districtInfo ~= nil then
					if Utils.IsDistrictType(districtInfo.Index, 'DISTRICT_HOLY_SITE') then
						city:SetProperty(WU_ZETIAN_ALT_HOLY_SITE_PERCENTAGE_TAG, 1)
            -- TODO 判定是否相邻已建成奇观
            local x, y = Utils.GetCityBuildQueueLocationAt(playerId, cityId, 0);
            local adjacentToWonder = false;
            if x >= 0 and y >= 0 then
              for direction = 0, 5 do
                local adjacentPlot = Map.GetAdjacentPlot(x, y, direction);
                if adjacentPlot then
                  local adjacentCity = Cities.GetPlotPurchaseCity(adjacentPlot);
                  if adjacentCity and adjacentCity:GetBuildings():HasBuilding(adjacentPlot:GetWonderType()) then
                    print("万象神宫 圣地相邻奇观", adjacentPlot:GetWonderType());
                    adjacentToWonder = true;
                    break;
                  end
                end
              end
            end
            
            if adjacentToWonder then
						  Utils.CityAddProgressPercentage(playerId, cityId, WU_ZETIAN_ALT_HOLY_SITE_PERCENTAGE, {AddViewText = false})
            end
					end
				end
			end
		end
	end
end
Events.CityProductionChanged.Add(WuZeTianAltCityProductionChanged)

-- 圣地相邻
local WU_ZETIAN_ALT_HOLY_SITE_ERA_SCORE = GlobalParameters.HD_WU_ZETIAN_ALT_HOLY_SITE_ERA_SCORE or 0;
function WuZeTianAltPlayerTurnEnded()
	for _, playerId in ipairs(PlayerManager.GetAliveMajorIDs()) do
		if WU_ZETIAN_ALT_HOLY_SITE_ERA_SCORE > 0 and Utils.LeaderHasTrait(playerId, 'TRAIT_WU_ZETIAN_ALT') then
			local player = Players[playerId];
			-- 判断是否到达进入黄金时代的分数阈值
			local threshold = Utils.GetPlayerGoldenAgeThreshold(playerId);
			local totalScore = Utils.GetPlayerCurrentScore(playerId);
			print("圣母神皇", threshold, totalScore)
			if totalScore > threshold then
				local num = math.floor((totalScore - threshold) / WU_ZETIAN_ALT_HOLY_SITE_ERA_SCORE)
				print("圣母神皇 溢出分数", num)
				if num > 0 then
					for i=1,num,1 do
						player:AttachModifierByID('HD_WU_ZETIAN_ALT_HOLY_SITE_ERA_SCORE_ADJACENCY');
						print("圣母神皇 圣地相邻+1")
					end
					Utils.ChangePlayerEraScore(playerId, -num * WU_ZETIAN_ALT_HOLY_SITE_ERA_SCORE);
					print("圣母神皇 扣除时代分", -num * WU_ZETIAN_ALT_HOLY_SITE_ERA_SCORE)
				end
			end
		end
	end
end
GameEvents.OnGameTurnEnded.Add(WuZeTianAltPlayerTurnEnded)