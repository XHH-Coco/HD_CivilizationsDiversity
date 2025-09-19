local GREAT_WRITER_INDEX = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_WRITER'].Index;
function CharlemagneUnitGreatPersonCreated(playerId, unitId, greatPersonClassId, greatPersonIndividualId)
	if greatPersonClassId ~= GREAT_WRITER_INDEX then
		return;
	end
	local player = Players[playerId];
	if ExposedMembers.DLHD.Utils.LeaderHasTrait(playerId, 'TRAIT_LEADER_GEDEMO_CHARLEMAGNE1') then
		player:AttachModifierByID('CHARLEMAGNE_FREE_PALADIN_FRANCE');
	end
	if ExposedMembers.DLHD.Utils.LeaderHasTrait(playerId, 'TRAIT_LEADER_GEDEMO_KARLDERGROSSE1') then
		player:AttachModifierByID('CHARLEMAGNE_FREE_PALADIN_GERMANY');
	end
end
Events.UnitGreatPersonCreated.Add(CharlemagneUnitGreatPersonCreated);

-- Project Text
function CharlemagneCityProjectCompleted (playerId, cityId, projectId)
	local projectInfo = GameInfo.Projects[projectId];
	local projectType = projectInfo.ProjectType;
	if string.find(projectType, 'PROJECT_CHALEMAGNE_') ~= nil then
		local city = CityManager.GetCity(playerId, cityId);
		local x = city:GetX();
		local y = city:GetY();
		Game.AddWorldViewText(0, Locale.Lookup("LOC_" .. projectType .. "_FLAVOR"), x, y);
	end
end
Events.CityProjectCompleted.Add(CharlemagneCityProjectCompleted);