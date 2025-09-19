ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

--伟人
local WRITER_INDEX = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_WRITER'].Index;

function IcelandPlayerEraScoreChanged(playerID, amountAwarded)
	local player = Players[playerID];
	local sIceland = 'TRAIT_CIVILIZATION_SUK_SAGAS_OF_THE_ICELANDERS';
	if (not Utils.CivilizationHasTrait(playerID, sIceland)) then
		return;
	end
	player:GetGreatPeoplePoints():ChangePointsTotal(WRITER_INDEX, amountAwarded * 2);
end

Events.PlayerEraScoreChanged.Add(IcelandPlayerEraScoreChanged);

