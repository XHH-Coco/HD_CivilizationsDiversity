local GREAT_MERCHANT_INDEX = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_MERCHANT'].Index;
function MalaysiaUnitGreatPersonCreated(playerId, unitId, greatPersonClassId, greatPersonIndividualId)
	if greatPersonClassId ~= GREAT_MERCHANT_INDEX then
		return;
	end

	if ExposedMembers.DLHD.Utils.CivilizationHasTrait(playerId, 'TRAIT_CIVILIZATION_CVS_MALAYSIA_UA') then
		local player = Players[playerId];
		player:AttachModifierByID('TRAIT_MALAYSIA_INFLUENCE_TOKEN');
	end
end
Events.UnitGreatPersonCreated.Add(MalaysiaUnitGreatPersonCreated);