ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

--桑尼阿里时代分回血
function SonniAliPlayerEraScoreChanged(playerId, amountAwarded)
	local player = Players[playerId];
	local sSonniAli = 'TRAIT_LEADER_CVS_SONNI_ALI_UA';
	local amount = GlobalParameters.SONNI_ALI_EXTRA_HIT_POINTS;
	if (not Utils.LeaderHasTrait(playerId, sSonniAli)) then 
        return;
    end
    for _, unit in player:GetUnits():Members() do
        if unit:GetDamage() ~= 0 then
            unit:ChangeDamage(-amount*amountAwarded);
        end
    end
end

Events.PlayerEraScoreChanged.Add(SonniAliPlayerEraScoreChanged);