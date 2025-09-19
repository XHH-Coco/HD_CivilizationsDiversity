ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

local MasinissaFriendShip_Tag = 'HD_MasinissaFriendShip_'
local MasinissaAlliance_UU_Tag = 'HD_MasinissaAlliance_UU'
local MasinissaAlliance_Builder_Tag = 'HD_MasinissaAlliance_Builder_'
function MasinissaDiplomacyRelationshipChanged(playerId, allyId)
  local friendshipTurn = Utils.GetDeclaredFriendshipTurn(playerId, allyId)
  if friendshipTurn > 0 and Utils.LeaderHasTrait(playerId, 'TRAIT_LEADER_CVS_MASINISSA_UA') then
    print("马西尼萨宣布友谊", friendshipTurn)
    local player = Players[playerId]
    local ally = Players[allyId]

    if player:GetProperty(MasinissaFriendShip_Tag .. allyId) ~= 1 then
      player:SetProperty(MasinissaFriendShip_Tag .. allyId, 1)
      print("马西尼萨与", allyId, "宣友 获得轻骑兵单位")
      player:AttachModifierByID('HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY')
    end
    if ally:GetProperty(MasinissaFriendShip_Tag .. playerId) ~= 1 then
      ally:SetProperty(MasinissaFriendShip_Tag .. playerId, 1)
      print(playerId, "与马西尼萨宣友 获得轻骑兵单位")
      ally:AttachModifierByID('HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY')
    end
  end

  local allianceTypeId = Utils.GetAllianceTypeBetweenPlayers(playerId, allyId)
  if allianceTypeId ~= nil and allianceTypeId ~= -1 and Utils.LeaderHasTrait(playerId, 'TRAIT_LEADER_CVS_MASINISSA_UA') then
    local player = Players[playerId]
    local ally = Players[allyId]
    -- 获得马西尼萨的UU
    if ally:GetProperty(MasinissaAlliance_UU_Tag) ~= 1 then
      ally:SetProperty(MasinissaAlliance_UU_Tag, 1)
      print("获得马西尼萨的特色单位")
      ally:AttachModifierByID('HD_CVS_MASINISSA_UNLOCK_UNIT_CVS_MASINISSA_UU')
      ally:AttachModifierByID('HD_CVS_MASINISSA_UNLOCK_UNIT_OTTOMAN_BARBARY_CORSAIR')
    end

    -- 建造者次数
    local allianceLevel = Utils.GetAllianceLevelBetweenPlayers(playerId, alivePlayerId)
    if player:GetProperty(MasinissaAlliance_Builder_Tag .. allianceLevel) ~= 1 then
      player:SetProperty(MasinissaAlliance_Builder_Tag .. allianceLevel, 1)
      print("马西尼萨第", allianceLevel, "级同盟 建造者+1次数")
      player:AttachModifierByID('HD_CVS_MASINISSA_BUILDER_EXTRA_CHARGE')
    end
    -- if ally:GetProperty(MasinissaAlliance_Builder_Tag .. allianceLevel) ~= 1 then
    --   ally:SetProperty(MasinissaAlliance_Builder_Tag .. allianceLevel, 1)
    --   print(allyId, "与马西尼萨第", allianceLevel, "级同盟 建造者+1次数")
    --   ally:AttachModifierByID('HD_CVS_MASINISSA_BUILDER_EXTRA_CHARGE')
    -- end
  end

  
end
Events.DiplomacyRelationshipChanged.Add(MasinissaDiplomacyRelationshipChanged)