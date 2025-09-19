delete from TraitModifiers where TraitType = 'TRAIT_LEADER_SUK_SIAMOISES';
delete from TraitModifiers where ModifierId like '%_SUK_SIAMOISES';

insert or replace into TraitModifiers
	(TraitType,							ModifierId)
values
	--城市有外交区可以额外建造区域
	('TRAIT_LEADER_SUK_SIAMOISES',		'SUK_SIAMOISES_DIPLOMACY_EXTRA_DISTRICT');

insert or replace into Modifiers
	(ModifierId,																ModifierType,																					SubjectRequirementSetId)
values
	('SUK_SIAMOISES_DIPLOMACY_EXTRA_DISTRICT',	'MODIFIER_PLAYER_CITIES_EXTRA_DISTRICT',							'CITY_HAS_DISTRICT_DIPLOMATIC_QUARTER_REQUIREMENTS');

insert or replace into ModifierArguments
	(ModifierId,																Name,						Value)
values
	('SUK_SIAMOISES_DIPLOMACY_EXTRA_DISTRICT',	'Amount',				1);

-- 会晤城邦产出
insert or replace into Modifiers (ModifierId, ModifierType)
	select 'HD_SUK_SIAMOISES_MEET_LEADER_MINOR_CIV_' || CityStateType || '_CAPITAL_BONUS', 'MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_CHANGE'
from CityStateCorrespondingYieldType_HD;

insert or replace into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId)
	select 'HD_SUK_SIAMOISES_MEET_LEADER_MINOR_CIV_' || CityStateType || '_DISTRICT_BONUS', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'PLAYER_HAS_CIVIC_DIPLOMATIC_SERVICE_REQUIREMENTS', 'DISTRICT_IS_DISTRICT_DIPLOMATIC_QUARTER_REQUIREMENTS'
from CityStateCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'HD_SUK_SIAMOISES_MEET_LEADER_MINOR_CIV_' || CityStateType || '_CAPITAL_BONUS', 'YieldType', YieldType
from CityStateCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'HD_SUK_SIAMOISES_MEET_LEADER_MINOR_CIV_' || CityStateType || '_CAPITAL_BONUS', 'Amount', Amount
from CityStateCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'HD_SUK_SIAMOISES_MEET_LEADER_MINOR_CIV_' || CityStateType || '_DISTRICT_BONUS', 'YieldType', YieldType
from CityStateCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'HD_SUK_SIAMOISES_MEET_LEADER_MINOR_CIV_' || CityStateType || '_DISTRICT_BONUS', 'Amount', Amount
from CityStateCorrespondingYieldType_HD;

-- 建立同盟加产出
insert or replace into Modifiers (ModifierId, ModifierType)
	select 'HD_SUK_SIAMOISES_' || AllianceType || '_BONUS', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER'
from AllianceCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'HD_SUK_SIAMOISES_' || AllianceType || '_BONUS', 'YieldType', YieldType
from AllianceCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'HD_SUK_SIAMOISES_' || AllianceType || '_BONUS', 'Amount', 10
from AllianceCorrespondingYieldType_HD;