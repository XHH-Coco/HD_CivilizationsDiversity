print("HD Suk_SiamRamkhamhaeng_CoreFunctions Loaded")

--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-- The Thai Alphabet

-- BoostSources (Table in UI context)
-- BOOST_SOURCE_RESEARCH_AGREEMENT	5
-- BOOST_SOURCE_ESPIONAGE	4
-- BOOST_SOURCE_TRIGGER	0
-- BOOST_SOURCE_TEAMMATE	6
-- BOOST_SOURCE_CAPTURED_CITY	7
-- BOOST_SOURCE_GREAT_PERSON	3
-- BOOST_SOURCE_GOODYHUT	1
-- BOOST_SOURCE_WONDER	2
-- NO_BOOST_SOURCE	-1
----------------------------------------------------------------------------------------------------------------------------
local iMod = (GameInfo.GameSpeeds[GameConfiguration.GetGameSpeedType()].CostMultiplier)/100
local THE_THAI_ALPHABET_GOLD_PERCENTAGE = GlobalParameters.HD_THE_THAI_ALPHABET_GOLD_PERCENTAGE or 0;
------------------------------------------
--Trait_ThaiAlphabet_GetGold
------------------------------------------
function Trait_ThaiAlphabet_GetGold(iCost)
	local iReward = ((iCost/10) + math.sqrt(10 * iCost))
	iReward = math.floor(iReward * iMod * THE_THAI_ALPHABET_GOLD_PERCENTAGE / 100)

	return iReward
end
------------------------------------------
--Trait_ThaiAlphabet_CivicGold
------------------------------------------
function Trait_ThaiAlphabet_CivicGold(iPlayer, iCivic, iCivicProgress, iSource)
  if not ExposedMembers.DLHD.Utils.LeaderHasTrait(iPlayer, 'TRAIT_LEADER_SUK_THE_THAI_ALPHABET') then
		return;
	end

	local pPlayer = Players[iPlayer]
	local iCivicCost = GameInfo.Civics[iCivic].Cost
	if iCivicCost < 1 then return end

	local iReward = Trait_ThaiAlphabet_GetGold(iCivicCost)
	pPlayer:GetTreasury():ChangeGoldBalance(iReward)

	if iPlayer == Game.GetLocalPlayer() then
		local sCivic	= Locale.Lookup(GameInfo.Civics[iCivic].Name)
		local sString	= Locale.Lookup("LOC_TRAIT_LEADER_SUK_THE_THAI_ALPHABET_INSPIRATION", iReward, sCivic)

    local CapitalCity = pPlayer:GetCities():GetCapitalCity();
    if CapitalCity then
      Game.AddWorldViewText(ReportingStatusTypes.DEFAULT, sString, CapitalCity:GetX(), CapitalCity:GetY())
    end
	end
end
Events.CivicBoostTriggered.Add(Trait_ThaiAlphabet_CivicGold)
------------------------------------------
--Trait_ThaiAlphabet_TechGold
------------------------------------------
function Trait_ThaiAlphabet_TechGold(iPlayer, iTech, iTechProgress, iSource)
  if not ExposedMembers.DLHD.Utils.LeaderHasTrait(iPlayer, 'TRAIT_LEADER_SUK_THE_THAI_ALPHABET') then
		return;
	end

	local pPlayer = Players[iPlayer]
	local iTechCost = GameInfo.Technologies[iTech].Cost
	if iTechCost < 1 then return end

	local iReward = Trait_ThaiAlphabet_GetGold(iTechCost)
	pPlayer:GetTreasury():ChangeGoldBalance(iReward)

	if iPlayer == Game.GetLocalPlayer() then
		local sTech = Locale.Lookup(GameInfo.Technologies[iTech].Name)
		local sString	= Locale.Lookup("LOC_TRAIT_LEADER_SUK_THE_THAI_ALPHABET_EUREKA", iReward, sTech)

		local CapitalCity = pPlayer:GetCities():GetCapitalCity();
    if CapitalCity then
      Game.AddWorldViewText(ReportingStatusTypes.DEFAULT, sString, CapitalCity:GetX(), CapitalCity:GetY())
    end
	end
end
Events.TechBoostTriggered.Add(Trait_ThaiAlphabet_TechGold)
--==========================================================================================================================
--==========================================================================================================================