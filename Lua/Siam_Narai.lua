ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

function NaraiMeetCitystate(playerId, citystateId)
  local citystateConfig = PlayerConfigurations[citystateId]
  local citystateLeader = citystateConfig:GetLeaderTypeName()
  local citystateType = GameInfo.Leaders[citystateLeader].InheritFrom
  print('NaraiDiplomacyMeet', citystateLeader, citystateType)

  local player = Players[playerId];
  player:AttachModifierByID('HD_SUK_SIAMOISES_MEET_' .. citystateType .. '_CAPITAL_BONUS')
  player:AttachModifierByID('HD_SUK_SIAMOISES_MEET_' .. citystateType .. '_DISTRICT_BONUS')
end

function NaraiDiplomacyMeet(player1Id, player2Id)
  if Utils.LeaderHasTrait(player1Id, 'TRAIT_LEADER_SUK_SIAMOISES') then
    if Utils.PlayerIsMinor(player2Id) then
      NaraiMeetCitystate(player1Id, player2Id)
    end
  elseif Utils.LeaderHasTrait(player2Id, 'TRAIT_LEADER_SUK_SIAMOISES') then
    if Utils.PlayerIsMinor(player1Id) then
      NaraiMeetCitystate(player2Id, player1Id)
    end
  end
end
Events.DiplomacyMeet.Add(NaraiDiplomacyMeet)

local NaraiAllianceTag = 'HD_NaraiAlliance_'
function NaraiAlliance(id1, id2)
  local allianceTypeId = Utils.GetAllianceTypeBetweenPlayers(id1, id2)
	if allianceTypeId == nil or allianceTypeId == -1 then return; end

  if Utils.LeaderHasTrait(id1, 'TRAIT_LEADER_SUK_SIAMOISES') then
    local allianceType = GameInfo.Alliances[allianceTypeId].AllianceType
    local player = Players[id1]
    if player:GetProperty(NaraiAllianceTag .. id2) ~= 1 then
      player:SetProperty(NaraiAllianceTag .. id2, 1)
      player:AttachModifierByID('HD_SUK_SIAMOISES_' .. allianceType .. '_BONUS')
      print("那莱建立同盟", allianceType)
    end
  end
end
Events.DiplomacyRelationshipChanged.Add(NaraiAlliance)