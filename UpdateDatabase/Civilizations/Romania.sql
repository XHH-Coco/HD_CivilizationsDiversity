-- Rename type to disable lua script
update Types set Type = 'TRAIT_LEADER_CVS_VLAD_III_UA_HD' where Type = 'TRAIT_LEADER_CVS_VLAD_III_UA';
-- Trait
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_CVS_ROMANIA_UA';
delete from EmergencyBuffs where ModifierId = 'MODIFIER_CVS_ROMANIA_UA_FLANK_BONUS_ATTACH' or ModifierId = 'MODIFIER_CVS_ROMANIA_UA_SUPPORT_BONUS_ATTACH';
delete from EmergencyRewards where ModifierId in ('MODIFIER_CVS_ROMANIA_UA_MEMBER_REWARD_TECH', 'MODIFIER_CVS_ROMANIA_UA_MEMBER_REWARD_CIVIC', 'MODIFIER_CVS_ROMANIA_UA_TARGET_REWARD_TECH', 'MODIFIER_CVS_ROMANIA_UA_TARGET_REWARD_CIVIC');
create temporary table HD_RomaniaGovernmentModifiers (
	GovernmentType text not null,
	ModifierId text not null,
	AttachModifierId text,
	primary key (GovernmentType, ModifierId)
);
with Legacy	(GovernmentType,	Tier,	ModifierId)
as (select	GovernmentType,		Tier,	ModifierId
from (Governments inner join PolicyModifiers on PolicyToUnlock = PolicyType))
insert or replace into HD_RomaniaGovernmentModifiers
	(GovernmentType,				ModifierId)
select
	Governments.GovernmentType,		Legacy.ModifierId
from Legacy cross join Governments where Governments.Tier is not null and cast(replace(Governments.Tier, 'Tier', '') as integer) > cast(replace(Legacy.Tier, 'Tier', '') as integer);
update HD_RomaniaGovernmentModifiers set AttachModifierId = 'ROMANIA_' || GovernmentType || '_' || ModifierId;
insert or replace into GovernmentModifiers
	(GovernmentType,	ModifierId)
select
	GovernmentType,		AttachModifierId
from HD_RomaniaGovernmentModifiers;
insert or replace into Modifiers
	(ModifierId,		ModifierType,										SubjectRequirementSetId)
select
	AttachModifierId,	'MODIFIER_PLAYER_CAPITAL_CITY_ATTACH_MODIFIER',		'PLAYER_IS_CIVILIZATION_CVS_ROMANIA_REQUIREMENTS'
from HD_RomaniaGovernmentModifiers;
insert or replace into ModifierArguments
	(ModifierId,		Name,			Value)
select
	AttachModifierId,	'ModifierId',	ModifierId
from HD_RomaniaGovernmentModifiers;
-- All yield bonus after switching a gpovernment
insert or replace into GlobalParameters
	(Name,						Value)
values
	('ROMANIA_CIVIC_PRECENT',	50),
	('ROMANIA_DURATION',		10);
insert or replace into TraitModifiers
	(TraitType,								ModifierId)
select
	'TRAIT_CIVILIZATION_CVS_ROMANIA_UA',	'ROMANIA_SWITCH_GOVERNMENT' || YieldType
from Yields;
insert or replace into Modifiers
	(ModifierId,								ModifierType,											SubjectRequirementSetId)
select
	'ROMANIA_SWITCH_GOVERNMENT' || YieldType,	'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',	'PLAYER_HAS_SWITCHED_TO_HIGHER_TIER_GOVERNMENT'
from Yields;
insert or replace into ModifierArguments
	(ModifierId,								Name,			Value)
select
	'ROMANIA_SWITCH_GOVERNMENT' || YieldType,	'YieldType',	YieldType
from Yields;
insert or replace into ModifierArguments
	(ModifierId,								Name,			Value)
select
	'ROMANIA_SWITCH_GOVERNMENT' || YieldType,	'Amount',		10
from Yields;
insert or ignore into RequirementSets
	(RequirementSetId,									RequirementSetType)
values
	('PLAYER_HAS_SWITCHED_TO_HIGHER_TIER_GOVERNMENT',	'REQUIREMENTSET_TEST_ALL');
insert or ignore into RequirementSetRequirements
	(RequirementSetId,									RequirementId)
values
	('PLAYER_HAS_SWITCHED_TO_HIGHER_TIER_GOVERNMENT',	'REQUIRES_PLAYER_HAS_SWITCHED_TO_HIGHER_TIER_GOVERNMENT');
insert or ignore into Requirements
	(RequirementId,												RequirementType)
values
	('REQUIRES_PLAYER_HAS_SWITCHED_TO_HIGHER_TIER_GOVERNMENT',	'REQUIREMENT_PLOT_PROPERTY_MATCHES');
insert or ignore into RequirementArguments
	(RequirementId,												Name,				Value)
values
	('REQUIRES_PLAYER_HAS_SWITCHED_TO_HIGHER_TIER_GOVERNMENT',	'PropertyMinimum',	1),
	('REQUIRES_PLAYER_HAS_SWITCHED_TO_HIGHER_TIER_GOVERNMENT',	'PropertyName',		'PLAYER_HAS_SWITCHED_TO_HIGHER_TIER_GOVERNMENT');
-- Unique Building
insert or ignore into BuildingPrereqs
	(Building,					PrereqBuilding)
select
	'BUILDING_CVS_ROMANIA_UI',	PrereqBuilding
from BuildingPrereqs where Building = 'BUILDING_ARMORY';
insert or ignore into BuildingPrereqs
	(Building,	PrereqBuilding)
select
	Building,	'BUILDING_CVS_ROMANIA_UI'
from BuildingPrereqs where PrereqBuilding = 'BUILDING_ARMORY';
with MutuallyExclusiveBuildings_Pre
	(Building,						MutuallyExclusiveBuilding)
as (values
	('BUILDING_CVS_ROMANIA_UI',		'BUILDING_ARMORY'),
	('BUILDING_CVS_ROMANIA_UI',		'BUILDING_JNR_CAVALIER'),
	('BUILDING_CVS_ROMANIA_UI',		'BUILDING_JNR_DEPOT'),
	('BUILDING_ARMORY',				'BUILDING_CVS_ROMANIA_UI'),
	('BUILDING_JNR_CAVALIER',		'BUILDING_CVS_ROMANIA_UI'),
	('BUILDING_JNR_DEPOT',			'BUILDING_CVS_ROMANIA_UI'))
insert or replace into MutuallyExclusiveBuildings
	(Building,						MutuallyExclusiveBuilding)
select
	Building,						MutuallyExclusiveBuilding
from MutuallyExclusiveBuildings_Pre where Building in (select BuildingType from Buildings) and MutuallyExclusiveBuilding in (select BuildingType from Buildings);
insert or replace into Unit_BuildingPrereqs
	(Unit,							PrereqBuilding)
values
	('UNIT_MILITARY_ENGINEER',		'BUILDING_CVS_ROMANIA_UI');
update Buildings set Cost = 240, Maintenance = 4, PrereqTech = null, PrereqCivic = 'CIVIC_FEUDALISM' where BuildingType = 'BUILDING_CVS_ROMANIA_UI';
delete from Building_YieldChanges where BuildingType = 'BUILDING_CVS_ROMANIA_UI' and YieldType = 'YIELD_PRODUCTION';
insert or replace into Building_CitizenYieldChanges
	(BuildingType,					YieldType,				YieldChange)
values
	('BUILDING_CVS_ROMANIA_UI',		'YIELD_PRODUCTION',		1),
	('BUILDING_CVS_ROMANIA_UI',		'YIELD_GOLD',			-1);
delete from Building_GreatWorks where BuildingType = 'BUILDING_CVS_ROMANIA_UI'; 
delete from BuildingModifiers where BuildingType = 'BUILDING_CVS_ROMANIA_UI';
insert or replace into BuildingModifiers
	(BuildingType,					ModifierId)
values
	('BUILDING_CVS_ROMANIA_UI',		'ROMANIA_FORT_UNTI_HEAL_ON_KILL_ATTACH'),
	('BUILDING_CVS_ROMANIA_UI',		'LAHORE_NIHANG_ARMORY_ADD_PURCHASE_COST'),
	('BUILDING_CVS_ROMANIA_UI',		'LAHORE_NIHANG_ARMORY_ABILITY');

insert or replace into Modifiers
	(ModifierId,									ModifierType)
values
	('ROMANIA_FORT_UNTI_HEAL_ON_KILL_ATTACH',		'MODIFIER_CITY_TRAINED_UNITS_ATTACH_MODIFIER'),
	('ROMANIA_FORT_UNTI_HEAL_ON_KILL',				'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_FROM_COMBAT');
insert or replace into ModifierArguments
	(ModifierId,									Name,				Value)
values
	('ROMANIA_FORT_UNTI_HEAL_ON_KILL_ATTACH',		'ModifierId',		'ROMANIA_FORT_UNTI_HEAL_ON_KILL'),
	('ROMANIA_FORT_UNTI_HEAL_ON_KILL',				'Amount',			30);
-- Modifiers used by lua
insert or replace into Modifiers
	(ModifierId,							ModifierType)
select
	'ROMANIA_FORT_BASIC_' || YieldType,		'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD'
from Yields;
insert or replace into ModifierArguments
	(ModifierId,							Name,				Value)
select
	'ROMANIA_FORT_BASIC_' || YieldType,		'BuildingType',		'BUILDING_CVS_ROMANIA_UI'
from Yields;
insert or replace into ModifierArguments
	(ModifierId,							Name,				Value)
select
	'ROMANIA_FORT_BASIC_' || YieldType,		'YieldType',		YieldType
from Yields;
insert or replace into ModifierArguments
	(ModifierId,							Name,				Value)
select
	'ROMANIA_FORT_BASIC_' || YieldType,		'Amount',			1
from Yields;
-- Unique Unit
-- Move from Leader UU to Civilization UU
delete from LeaderTraits where LeaderType = 'LEADER_CVS_VLAD_III' and TraitType = 'TRAIT_LEADER_CVS_VLAD_III_UU';
insert or replace into CivilizationTraits
	(CivilizationType,				TraitType)
values
	('CIVILIZATION_CVS_ROMANIA',	'TRAIT_LEADER_CVS_VLAD_III_UU');
-- Replaces Courser instead of Crossbowman
update UnitReplaces set ReplacesUnitType = 'UNIT_COURSER' where CivUniqueUnitType = 'UNIT_CVS_VLAD_III_UU';
delete from TypeTags where Type = 'UNIT_CVS_VLAD_III_UU' and Tag in (select Tag from TypeTags where Type = 'UNIT_CROSSBOWMAN');
insert or replace into TypeTags
	(Type,						Tag)
select
	'UNIT_CVS_VLAD_III_UU',		Tag
from TypeTags where Type = 'UNIT_COURSER';
delete from UnitUpgrades where Unit = 'UNIT_CVS_VLAD_III_UU';
insert or replace into UnitUpgrades
	(Unit,						UpgradeUnit)
select
	'UNIT_CVS_VLAD_III_UU',		UpgradeUnit
from UnitUpgrades where Unit = 'UNIT_COURSER';
delete from UnitAiInfos where UnitType = 'UNIT_CVS_VLAD_III_UU';
insert or replace into UnitAiInfos
	(UnitType,					AiType)
select
	'UNIT_CVS_VLAD_III_UU',		AiType
from UnitAiInfos where UnitType = 'UNIT_COURSER';
-- Unit info
update Units set
	Cost = 110,
	Combat = 47,
	RangedCombat = 40,
	Range = 1,
	ZoneOfControl = 1,
	PromotionClass = 'PROMOTION_CLASS_LIGHT_CAVALRY',
	MandatoryObsoleteTech = 'TECH_SYNTHETIC_MATERIALS',
	PrereqTech = 'TECH_STIRRUPS',
	PrereqCivic = null,
	StrategicResource = 'RESOURCE_HORSES'
where UnitType = 'UNIT_CVS_VLAD_III_UU';
update Units_XP2 set
	ResourceCost = 5,
	ResourceMaintenanceType = 'RESOURCE_HORSES',
	ResourceMaintenanceAmount = 1
where UnitType = 'UNIT_CVS_VLAD_III_UU';
update Units set
	Cost = 460,
	Combat = 80,
	RangedCombat = 70,
	Maintenance = 8
where UnitType = 'UNIT_CVS_ROMANIA_UU';
-- Religion
insert or replace into FavoredReligions
	(LeaderType,					ReligionType)
select
	'LEADER_CVS_VLAD_III',			'RELIGION_9B_CATHOLICISM'
where exists (select ReligionType from Religions where ReligionType = 'RELIGION_9B_CATHOLICISM');