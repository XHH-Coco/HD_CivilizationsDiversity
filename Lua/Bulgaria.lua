ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

--保加利亚传教
local BULGARIA_MISSIONARY_INDEX = GameInfo.Units['UNIT_MISSIONARY'].Index;
local BULGARIA_APOSTLE_INDEX = GameInfo.Units['UNIT_APOSTLE'].Index;
local BULGARIA_GURU_INDEX = GameInfo.Units['UNIT_GURU'].Index;
local BULGARIA_INQUISITOR_INDEX = GameInfo.Units['UNIT_INQUISITOR'].Index;
function BulgariaUnitKilledInCombat (killedPlayerId, killedUnitId, playerId, unitId)
	local unit = UnitManager.GetUnit(killedPlayerId, killedUnitId) or 0;
	if (unit:GetType() ~= BULGARIA_MISSIONARY_INDEX and unit:GetType() ~= BULGARIA_APOSTLE_INDEX and unit:GetType() ~= BULGARIA_GURU_INDEX and unit:GetType() ~= BULGARIA_INQUISITOR_INDEX)then
		return;
	end
	local killedplayer = Players[killedPlayerId];
	local sBulgaria = 'TRAIT_LEADER_MER_CLAIM_TO_BYZANTIUM';
	if (not Utils.LeaderHasTrait(killedPlayerId, sBulgaria)) then 
		return;
	end
	local religion = unit:GetReligion():GetReligionType();
	local amount = GlobalParameters.BULGARIA_UNIT_KILLED_INCOMBAT;
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
Events.UnitKilledInCombat.Add(BulgariaUnitKilledInCombat);
--保加利亚伟人点
function BulgariaUnitGreatPersonCreated(playerID, unitID, greatPersonClassID, greatPersonIndividualID)
	for row in GameInfo.GreatPersonIndividuals() do
		if row.Index == greatPersonIndividualID and row.GreatPersonClassType == 'GREAT_PERSON_CLASS_PROPHET' then
			for pPlayerID, player in ipairs(Players) do
				if Utils.LeaderHasTrait(pPlayerID, 'TRAIT_LEADER_MER_CLAIM_TO_BYZANTIUM') then
					player:AttachModifierByID('TRAIT_LEADER_MER_CLAIM_TO_BYZANTIUM_PROPHET');
				end
			end
		end
	end
end
Events.UnitGreatPersonCreated.Add(BulgariaUnitGreatPersonCreated);