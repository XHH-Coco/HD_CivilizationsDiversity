-- Leader Ability
delete from TraitModifiers where TraitType = 'TRAIT_LEADER_CVS_TUN_PERAK_UA' and ModifierId = 'MODIFIER_CVS_TUN_PERAK_UA_GOV_SLOT';
delete from PolicyModifiers where ModifierId = 'MODIFIER_CVS_TUN_PERAK_UA_POLICY_FAVOR';
insert or replace into TraitModifiers
	(TraitType,							ModifierId)
values
	('TRAIT_LEADER_CVS_TUN_PERAK_UA',	'TUN_PERAK_COMBAT_ATTACH'),
	('TRAIT_LEADER_CVS_TUN_PERAK_UA',	'TUN_PERAK_POP_CULTURE'),
	('TRAIT_LEADER_CVS_TUN_PERAK_UA',	'TUN_PERAK_GOVERNMENT_PRODUCTION'),
	('TRAIT_LEADER_CVS_TUN_PERAK_UA',	'TUN_PERAK_GOVERNMENT_INFLUENCE');
insert or replace into TraitModifiers
	(TraitType,							ModifierId)
select
	'TRAIT_LEADER_CVS_TUN_PERAK_UA',	'TUN_PERAK_DIPLOMATIC_QUARTER_PRODUCTION'
where exists (select DistrictType from Districts where DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER');
insert or replace into TraitModifiers
	(TraitType,							ModifierId)
select
	'TRAIT_LEADER_CVS_TUN_PERAK_UA',	'TUN_PERAK_DIPLOMATIC_QUARTER_INFLUENCE'
where exists (select DistrictType from Districts where DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER');
insert or replace into Modifiers
	(ModifierId,									ModifierType,													SubjectRequirementSetId)
values
	('TUN_PERAK_COMBAT_ATTACH',						'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER',						'PLAYER_HAS_GOLDEN_AGE'),
	('TUN_PERAK_COMBAT',							'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',							null),
	('TUN_PERAK_POP_CULTURE',						'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_POPULATION',		'PLAYER_HAS_GOLDEN_AGE'),
	('TUN_PERAK_GOVERNMENT_PRODUCTION',				'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE',				'DISTRICT_IS_DISTRICT_GOVERNMENT_REQUIREMENTS'),
	('TUN_PERAK_GOVERNMENT_INFLUENCE',				'MODIFIER_PLAYER_ADJUST_INFLUENCE_POINTS_PER_TURN',				'PLAYER_HAS_DISTRICT_GOVERNMENT_REQUIREMENTS');
insert or replace into Modifiers
	(ModifierId,									ModifierType,													SubjectRequirementSetId)
select
	'TUN_PERAK_DIPLOMATIC_QUARTER_PRODUCTION',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE',				'DISTRICT_IS_DISTRICT_DIPLOMATIC_QUARTER_REQUIREMENTS'
where exists (select DistrictType from Districts where DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER');
insert or replace into Modifiers
	(ModifierId,									ModifierType,													SubjectRequirementSetId)
select
	'TUN_PERAK_DIPLOMATIC_QUARTER_INFLUENCE',		'MODIFIER_PLAYER_ADJUST_INFLUENCE_POINTS_PER_TURN',				'PLAYER_HAS_DISTRICT_DIPLOMATIC_QUARTER_REQUIREMENTS'
where exists (select DistrictType from Districts where DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER');
insert or replace into ModifierArguments
	(ModifierId,									Name,			Value)
values
	('TUN_PERAK_COMBAT_ATTACH',						'ModifierId',	'TUN_PERAK_COMBAT'),
	('TUN_PERAK_COMBAT',							'Amount',		3),
	('TUN_PERAK_POP_CULTURE',						'YieldType',	'YIELD_CULTURE'),
	('TUN_PERAK_POP_CULTURE',						'Amount',		0.3),
	('TUN_PERAK_GOVERNMENT_PRODUCTION',				'YieldType',	'YIELD_PRODUCTION'),
	('TUN_PERAK_GOVERNMENT_PRODUCTION',				'Amount',		3),
	('TUN_PERAK_DIPLOMATIC_QUARTER_PRODUCTION',		'YieldType',	'YIELD_PRODUCTION'),
	('TUN_PERAK_DIPLOMATIC_QUARTER_PRODUCTION',		'Amount',		3),
	('TUN_PERAK_GOVERNMENT_INFLUENCE',				'Amount',		2),
	('TUN_PERAK_DIPLOMATIC_QUARTER_INFLUENCE',		'Amount',		2);
insert or replace into ModifierArguments
	(ModifierId,									Name,			Value)
select
	'TUN_PERAK_DIPLOMATIC_QUARTER_PRODUCTION',		'YieldType',	'YIELD_PRODUCTION'
where exists (select DistrictType from Districts where DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER');
insert or replace into ModifierArguments
	(ModifierId,									Name,			Value)
select
	'TUN_PERAK_DIPLOMATIC_QUARTER_PRODUCTION',		'Amount',		3
where exists (select DistrictType from Districts where DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER');
insert or replace into ModifierArguments
	(ModifierId,									Name,			Value)
select
	'TUN_PERAK_DIPLOMATIC_QUARTER_INFLUENCE',		'Amount',		2
where exists (select DistrictType from Districts where DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER');
insert or replace into ModifierStrings
	(ModifierId,									Context,		Text)
values
	('TUN_PERAK_COMBAT',							'Preview',		'+{1_Amount} {LOC_TUN_PERAK_COMBAT_PREVIEW_TEXT}');
insert or replace into TraitModifiers
	(TraitType,							ModifierId)
select
	'TRAIT_LEADER_CVS_TUN_PERAK_UA',	'LEADER_CVS_TUN_PERAK_' || BuildingType || '_PRODUCTION'
from HD_BuildingTiers where (PrereqDistrict = 'DISTRICT_GOVERNMENT' or PrereqDistrict = 'DISTRICT_DIPLOMATIC_QUARTER') and ReplacesOther = 0;
insert or replace into Modifiers	
	(ModifierId,												ModifierType)
select
	'LEADER_CVS_TUN_PERAK_' || BuildingType || '_PRODUCTION',	'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
from HD_BuildingTiers where (PrereqDistrict = 'DISTRICT_GOVERNMENT' or PrereqDistrict = 'DISTRICT_DIPLOMATIC_QUARTER') and ReplacesOther = 0;
insert or replace into ModifierArguments	
	(ModifierId,												Name,				Value)
select
	'LEADER_CVS_TUN_PERAK_' || BuildingType || '_PRODUCTION',	'BuildingType',		BuildingType
from HD_BuildingTiers where (PrereqDistrict = 'DISTRICT_GOVERNMENT' or PrereqDistrict = 'DISTRICT_DIPLOMATIC_QUARTER') and ReplacesOther = 0;
insert or replace into ModifierArguments	
	(ModifierId,												Name,				Value)
select
	'LEADER_CVS_TUN_PERAK_' || BuildingType || '_PRODUCTION',	'YieldType',		'YIELD_PRODUCTION'
from HD_BuildingTiers where (PrereqDistrict = 'DISTRICT_GOVERNMENT' or PrereqDistrict = 'DISTRICT_DIPLOMATIC_QUARTER') and ReplacesOther = 0;
insert or replace into ModifierArguments	
	(ModifierId,												Name,				Value)
select
	'LEADER_CVS_TUN_PERAK_' || BuildingType || '_PRODUCTION',	'Amount',			3
from HD_BuildingTiers where (PrereqDistrict = 'DISTRICT_GOVERNMENT' or PrereqDistrict = 'DISTRICT_DIPLOMATIC_QUARTER') and ReplacesOther = 0;
insert or replace into TraitModifiers
	(TraitType,							ModifierId)
select
	'TRAIT_LEADER_CVS_TUN_PERAK_UA',	'LEADER_CVS_TUN_PERAK_' || BuildingType || '_INFLUENCE'
from HD_BuildingTiers where (PrereqDistrict = 'DISTRICT_GOVERNMENT' or PrereqDistrict = 'DISTRICT_DIPLOMATIC_QUARTER') and ReplacesOther = 0;
insert or replace into Modifiers	
	(ModifierId,												ModifierType,											SubjectRequirementSetId)
select
	'LEADER_CVS_TUN_PERAK_' || BuildingType || '_INFLUENCE',	'MODIFIER_PLAYER_ADJUST_INFLUENCE_POINTS_PER_TURN',		'PLAYER_HAS_' || BuildingType || '_REQUIREMENTS'
from HD_BuildingTiers where (PrereqDistrict = 'DISTRICT_GOVERNMENT' or PrereqDistrict = 'DISTRICT_DIPLOMATIC_QUARTER') and ReplacesOther = 0;
insert or replace into ModifierArguments	
	(ModifierId,												Name,				Value)
select
	'LEADER_CVS_TUN_PERAK_' || BuildingType || '_INFLUENCE',	'Amount',			2
from HD_BuildingTiers where (PrereqDistrict = 'DISTRICT_GOVERNMENT' or PrereqDistrict = 'DISTRICT_DIPLOMATIC_QUARTER') and ReplacesOther = 0;
-- Leader Unique Unit
delete from LeaderTraits where TraitType = 'TRAIT_LEADER_CVS_TUN_PERAK_UU';
insert or replace into CivilizationTraits
	(CivilizationType,				TraitType)
values
	('CIVILIZATION_CVS_MALAYSIA',	'TRAIT_LEADER_CVS_TUN_PERAK_UU');
update Units set Combat = 38 where UnitType = 'UNIT_CVS_TUN_PERAK_UU';
insert or replace into TraitModifiers
	(TraitType,							ModifierId)
values
	('TRAIT_LEADER_CVS_TUN_PERAK_UU',	'UNIT_CVS_TUN_PERAK_UU_MOVEMENT');
insert or replace into Modifiers
	(ModifierId,							ModifierType,								SubjectRequirementSetId)
values
	('UNIT_CVS_TUN_PERAK_UU_MOVEMENT',		'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',	'HD_UNIT_TUN_PERAK_IS_EMBARKED');
insert or replace into ModifierArguments
	(ModifierId,							Name,				Value)
values
	('UNIT_CVS_TUN_PERAK_UU_MOVEMENT',		'Amount',			2);
insert or ignore into RequirementSets
	(RequirementSetId,					RequirementSetType)
values
	('HD_UNIT_TUN_PERAK_IS_EMBARKED',	'REQUIREMENTSET_TEST_ALL');
insert or ignore into RequirementSetRequirements
	(RequirementSetId,					RequirementId)
values
	('HD_UNIT_TUN_PERAK_IS_EMBARKED',	'REQUIRES_UNIT_IS_EMBARKED'),
	('HD_UNIT_TUN_PERAK_IS_EMBARKED',	'REQUIRES_UNIT_IS_UNIT_CVS_TUN_PERAK_UU');