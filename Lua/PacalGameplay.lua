local SACRIFICE_INDEX = GameInfo.Projects['PROJECT_SACRIFICE'].Index;
function CityProjectCompleted (playerId, cityId, projectId)
	if projectId ~= SACRIFICE_INDEX then
		return;
	end
    local player = Players[playerId];
	local city = CityManager.GetCity(playerID, cityId);
	if city:GetPopulation() > 1 then
		local culture = GlobalParameters.PACAL_SACRIFICE_CULTURE_AMOUNT;
		local faith = GlobalParameters.PACAL_SACRIFICE_FAITH_AMOUNT;
		local multiplier = GlobalParameters.PACAL_CONQUERED_MULTIPLIER;
		if city:GetOriginalOwner() ~= playerId then
			culture = culture * multiplier;
			faith = faith * multiplier;
		end
		local x = city:GetLocation().x;
		local y = city:GetLocation().y;
		city:ChangePopulation(-1);
		player:GetCulture():ChangeCurrentCulturalProgress(culture);
		Game.AddWorldViewText(0, '[COLOR:ResCultureLabelCS]+' .. culture .. ' [ENDCOLOR][ICON_CULTURE]', x, y);
		player:GetReligion():ChangeFaithBalance(faith);
		Game.AddWorldViewText(0, '[COLOR:ResFaithLabelCS]+' .. faith .. ' [ENDCOLOR][ICON_FAITH]', x, y);
	end
end

Events.CityProjectCompleted.Add(CityProjectCompleted);