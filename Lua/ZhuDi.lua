ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

-- 与城邦相遇
local NOTIFICATION_CITYSTATE_MET_FIRST_HASH = GameInfo.Types['NOTIFICATION_CITYSTATE_MET_FIRST'].Hash;
function ZhuDiMeetCitystate(playerId, citystateId)
  local citystateConfig = PlayerConfigurations[citystateId]
  local citystateLeader = citystateConfig:GetLeaderTypeName()
  local citystateType = GameInfo.Leaders[citystateLeader].InheritFrom
  print('ZhuDiDiplomacyMeet', citystateLeader, citystateType)

  local player = Players[playerId];
  local meetList = player:GetProperty("HD_ZHUDI_MEET_CITYSTATE_LIST")
  local msg = Locale.Lookup("LOC_CITY_STATES_TYPE_" .. string.sub(citystateType, 18))
  if meetList == nil then
    meetList = {}
  else
    local last = meetList[#meetList]
    -- local last2 = meetList[#meetList - 1]
    -- local last3 = meetList[#meetList - 2]
    msg = Locale.Lookup("LOC_CITY_STATES_TYPE_" .. string.sub(last, 18)) .. "; " .. msg
    -- if last2 ~= nil then
    --   msg = Locale.Lookup("LOC_CITY_STATES_TYPE_" .. string.sub(last2, 18)) .. "; " .. msg
    -- end
    -- if last3 ~= nil then
    --   msg = Locale.Lookup("LOC_CITY_STATES_TYPE_" .. string.sub(last3, 18)) .. "; " .. msg
    -- end
    if last ~= citystateType then
      -- 商路增产
      print('ZhuDiDiplomacyMeet last', last)
      print('ZhuDiDiplomacyMeet now', citystateType)
      player:AttachModifierByID('ZHUDI_' .. citystateType .. '_BONUS')

      -- 送商路
      -- if #meetList >= 3 then
      --   if citystateType ~= last2 and citystateType ~= last3 and last ~= last2 and last ~= last3 and last2 ~= last3 then
      --     print('ZhuDiDiplomacyMeet last3', last3)
      --     print('ZhuDiDiplomacyMeet last2', last2)
      --     print('ZhuDiDiplomacyMeet last', last)
      --     print('ZhuDiDiplomacyMeet now', citystateType)
      --     player:AttachModifierByID('ZHUDI_TRADE_ADD_TRADE_ROUTE');
      --   end
      -- end
    end
  end
  meetList[#meetList + 1] = citystateType
  player:SetProperty("HD_ZHUDI_MEET_CITYSTATE_LIST", meetList)
  SendMeetCitystateNotification(playerId, NOTIFICATION_CITYSTATE_MET_FIRST_HASH, Locale.Lookup('LOC_TRAIT_ZHUDI_NAME'), msg)
end

function SendMeetCitystateNotification(playerId, notificationType, message, summary)
  local data = {};
	data[ParameterTypes.MESSAGE] = message;
	data[ParameterTypes.SUMMARY] = summary;

  local notifyIdList = NotificationManager.GetList(playerId);
	if(notifyIdList ~= nil) then
		for _, notifyId in pairs(notifyIdList) do
			local notification = NotificationManager.Find(playerId, notifyId);
			if notification ~= nil
				and notification:GetType() == notificationType
				and not notification:IsDismissed()
				and notification:GetValue(ParameterTypes.MESSAGE) == message then
          NotificationManager.Dismiss(playerId, notifyId);
			end
		end
	end

  NotificationManager.SendNotification(playerId, notificationType, data);
end

function ZhuDiDiplomacyMeet(player1Id, player2Id)
  if Utils.LeaderHasTrait(player1Id, 'TRAIT_ZHUDI') then
    if Utils.PlayerIsMinor(player2Id) then
      ZhuDiMeetCitystate(player1Id, player2Id)
    end
  elseif Utils.LeaderHasTrait(player2Id, 'TRAIT_ZHUDI') then
    if Utils.PlayerIsMinor(player1Id) then
      ZhuDiMeetCitystate(player2Id, player1Id)
    end
  end
end
Events.DiplomacyMeet.Add(ZhuDiDiplomacyMeet)

-- 宗主城邦
local ZhuDi_Suzerain_Tag = 'HD_ZhuDi_Suzerain_'
function ZhuDiSuzerain(citystateId)
  local citystate = Players[citystateId]
	local playerId = citystate:GetInfluence():GetSuzerain()

  if playerId ~= nil and playerId ~= -1 and Utils.LeaderHasTrait(playerId, 'TRAIT_ZHUDI') then
    local player = Players[playerId]
		local citystateConfig = PlayerConfigurations[citystateId]
		local citystateLeader = citystateConfig:GetLeaderTypeName()
		local citystateType = GameInfo.Leaders[citystateLeader].InheritFrom
    if player:GetProperty(ZhuDi_Suzerain_Tag .. citystateType) ~= 1 then
      -- 首次宗主该类型
			player:SetProperty(ZhuDi_Suzerain_Tag .. citystateType, 1)
      print('ZhuDiSuzerain', citystateType, playerId)
      player:AttachModifierByID('ZHUDI_TRADE_ADD_TRADE_ROUTE')
    end
  end
end
Events.InfluenceGiven.Add(ZhuDiSuzerain)