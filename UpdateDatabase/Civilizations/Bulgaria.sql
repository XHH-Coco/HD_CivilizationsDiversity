-- Rename type to disable lua script
update Types set Type = 'TRAIT_CIVILIZATION_MER_CYRILLIC_SCRIPTS_HD' where Type = 'TRAIT_CIVILIZATION_MER_CYRILLIC_SCRIPTS';
-- Bug fix
delete from Types where Type = 'ABILITY_BALKAN_CAVALRY_RELIGION';
-- Start bias
insert or replace into StartBiasResources
	(CivilizationType,					ResourceType,			Tier)
values
	('CIVILIZATION_MER_BULGARIA',		'RESOURCE_HORSES',		2);
insert or replace into StartBiasTerrains
	(CivilizationType,					TerrainType,				Tier)
values
	('CIVILIZATION_MER_BULGARIA',		'TERRAIN_GRASS_MOUNTAIN',	2),
	('CIVILIZATION_MER_BULGARIA',		'TERRAIN_PLAINS_MOUNTAIN',	2),
	('CIVILIZATION_MER_BULGARIA',		'TERRAIN_GRASS_HILLS',		2),
	('CIVILIZATION_MER_BULGARIA',		'TERRAIN_PLAINS_HILLS',		2);
-- Traits
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_MER_CYRILLIC_SCRIPTS_HD' or TraitType = 'TRAIT_LEADER_MER_CLAIM_TO_BYZANTIUM';
insert or replace into TraitModifiers
	(TraitType,										ModifierId)
values
	('TRAIT_CIVILIZATION_MER_CYRILLIC_SCRIPTS_HD',	'MER_CYRILLIC_SCRIPTS_HD_EXTRA_DISTRICT'),
	--('TRAIT_CIVILIZATION_MER_CYRILLIC_SCRIPTS_HD',	'MER_CYRILLIC_SCRIPTS_HD_DISTRICT_SPEED'),
	('TRAIT_CIVILIZATION_MER_CYRILLIC_SCRIPTS_HD',	'MER_CYRILLIC_SCRIPTS_HD_DISTRICT_CULTURE'),
	('TRAIT_CIVILIZATION_MER_CYRILLIC_SCRIPTS_HD',	'MER_CYRILLIC_SCRIPTS_HD_DISTRICT_ADJACENCY'),
	('TRAIT_LEADER_MER_CLAIM_TO_BYZANTIUM',			'MER_CLAIM_TO_BYZANTIUM_CULTURE_PER_CITY_FOLLOWING_RELIGION'),
	('TRAIT_LEADER_MER_CLAIM_TO_BYZANTIUM',			'MER_CLAIM_TO_BYZANTIUM_RELIGION_PRESSURE');
insert or replace into Modifiers
	(ModifierId,													ModifierType,													SubjectRequirementSetId)
values
	('MER_CYRILLIC_SCRIPTS_HD_EXTRA_DISTRICT',						'MODIFIER_PLAYER_CITIES_EXTRA_DISTRICT',						'PLOT_IS_HILLS_OR_ADJACENT_TO_MOUNTAIN'),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_SPEED',						'MODIFIER_PLAYER_CITIES_ADJUST_ALL_DISTRICTS_PRODUCTION',		'PLOT_IS_HILLS_OR_ADJACENT_TO_MOUNTAIN'),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_CULTURE',					'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER',					'PLOT_IS_HILLS_OR_ADJACENT_TO_MOUNTAIN'),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_CULTURE_MODIFIER',			'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_CHANGE',					'HD_DISTRICTS_IS_NOT_WONDERS_REQUIREMENTS'),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_ADJACENCY',					'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER',					'HD_DISTRICTS_IS_NOT_WONDERS_REQUIREMENTS'),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_ADJACENCY_MODIFIER',			'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',							'PLOT_IS_HILLS_AND_ADJACENT_TO_OWNER'),
	('MER_CLAIM_TO_BYZANTIUM_CULTURE_PER_CITY_FOLLOWING_RELIGION',	'MODIFIER_PLAYER_RELIGION_ADD_PLAYER_BELIEF_YIELD',				NULL),
	('MER_CLAIM_TO_BYZANTIUM_RELIGION_PRESSURE',					'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',						NULL),
	('MER_CLAIM_TO_BYZANTIUM_RELIGION_PRESSURE_MODIFIER',			'MODIFIER_SINGLE_CITY_RELIGION_PRESSURE',						NULL),
	('TRAIT_LEADER_MER_CLAIM_TO_BYZANTIUM_PROPHET',					'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',					NULL);
insert or replace into ModifierArguments
	(ModifierId,													Name,					Value)
	values
	('MER_CYRILLIC_SCRIPTS_HD_EXTRA_DISTRICT',						'Amount',				1),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_SPEED',						'Amount',				25),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_CULTURE',					'ModifierId',			'MER_CYRILLIC_SCRIPTS_HD_DISTRICT_CULTURE_MODIFIER'),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_CULTURE_MODIFIER',			'Amount',				1),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_CULTURE_MODIFIER',			'YieldType',			'YIELD_CULTURE'),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_ADJACENCY',					'ModifierId',			'MER_CYRILLIC_SCRIPTS_HD_DISTRICT_ADJACENCY_MODIFIER'),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_ADJACENCY_MODIFIER',			'Amount',				2),
	('MER_CYRILLIC_SCRIPTS_HD_DISTRICT_ADJACENCY_MODIFIER',			'YieldType',			'YIELD_FAITH'),
	('MER_CLAIM_TO_BYZANTIUM_CULTURE_PER_CITY_FOLLOWING_RELIGION',	'Amount',				3),
	('MER_CLAIM_TO_BYZANTIUM_CULTURE_PER_CITY_FOLLOWING_RELIGION',	'BeliefYieldType',		'BELIEF_YIELD_PER_CITY'),
	('MER_CLAIM_TO_BYZANTIUM_CULTURE_PER_CITY_FOLLOWING_RELIGION',	'PerXItems',			1),
	('MER_CLAIM_TO_BYZANTIUM_CULTURE_PER_CITY_FOLLOWING_RELIGION',	'YieldType',			'YIELD_CULTURE'),
	('MER_CLAIM_TO_BYZANTIUM_RELIGION_PRESSURE',					'ModifierId',			'MER_CLAIM_TO_BYZANTIUM_RELIGION_PRESSURE_MODIFIER'),
	('MER_CLAIM_TO_BYZANTIUM_RELIGION_PRESSURE_MODIFIER',			'Amount',				100),
	('TRAIT_LEADER_MER_CLAIM_TO_BYZANTIUM_PROPHET',					'Amount',				2),
	('TRAIT_LEADER_MER_CLAIM_TO_BYZANTIUM_PROPHET',					'GreatPersonClassType',	'GREAT_PERSON_CLASS_PROPHET');
-- Unique Unit
update Units set Combat = 53, RangedCombat = 40, Cost = 130 where UnitType = 'UNIT_MER_CUMAN_CAVALRY';
insert or replace into Units_XP2
	(UnitType,					ResourceCost,	ResourceMaintenanceType,	ResourceMaintenanceAmount)
values
	('UNIT_MER_CUMAN_CAVALRY',	5,				'RESOURCE_HORSES',			1);
-- Unique Building
update BuildingReplaces set ReplacesBuildingType = 'BUILDING_JNR_ACADEMY' where CivUniqueBuildingType = 'BUILDING_MER_LITERARY_SCHOOL_HD'
	and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_ACADEMY');
update MutuallyExclusiveBuildings set MutuallyExclusiveBuilding = 'BUILDING_LIBRARY' where Building = 'BUILDING_MER_LITERARY_SCHOOL_HD'
	and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_ACADEMY');
update Buildings set Cost = 95, RegionalRange = 4, PrereqTech = 'TECH_WRITING', Description = 'LOC_BUILDING_MER_LITERARY_SCHOOL_DESCRIPTION' where BuildingType = 'BUILDING_MER_LITERARY_SCHOOL_HD';
update Building_YieldChanges set YieldChange = 2 where BuildingType = 'BUILDING_MER_LITERARY_SCHOOL_HD' and YieldType = 'YIELD_CULTURE';
insert or replace into Building_CitizenYieldChanges
	(BuildingType,						YieldType,			YieldChange)
values
	('BUILDING_MER_LITERARY_SCHOOL_HD',	'YIELD_SCIENCE',	1),
	('BUILDING_MER_LITERARY_SCHOOL_HD',	'YIELD_CULTURE',	1),
	('BUILDING_MER_LITERARY_SCHOOL_HD',	'YIELD_GOLD',		-1);
update Building_GreatWorks set ThemingUniquePerson = 1, ThemingYieldMultiplier = 100, ThemingTourismMultiplier = 100, ThemingBonusDescription = 'LOC_BUILDING_THEMINGBONUS_LITERARY_SCHOOL' where BuildingType = 'BUILDING_MER_LITERARY_SCHOOL_HD';
-- New Unique Unit
insert or replace into Types
	(Type,											Kind)
values
	('TRAIT_CIVILIZATION_UNIT_BULGARIA_KONIKK',		'KIND_TRAIT'),
	('UNIT_BULGARIA_KONIKK',						'KIND_UNIT'),
	('ABILITY_BULGARIA_KONIKK',						'KIND_ABILITY');
insert or replace into Traits (TraitType) values ('TRAIT_CIVILIZATION_UNIT_BULGARIA_KONIKK');
insert or replace into CivilizationTraits
	(CivilizationType, 				TraitType)
values
	('CIVILIZATION_MER_BULGARIA',	'TRAIT_CIVILIZATION_UNIT_BULGARIA_KONIKK');
insert or replace into TypeTags
	(Type,						Tag)
select
	'UNIT_BULGARIA_KONIKK',		Tag
from TypeTags where Type = 'UNIT_COURSER';
insert or replace into UnitAiInfos
	(UnitType,					AiType)
select
	'UNIT_BULGARIA_KONIKK',		AiType
from UnitAiInfos where UnitType = 'UNIT_COURSER';
insert or replace into Units
	(UnitType,					Name,								BaseSightRange,	BaseMoves,	Combat,	Domain,			FormationClass,					Cost,	StrategicResource,	Description,							CanCapture,	PromotionClass,						PrereqTech,			CanTrain,	PurchaseYield,	Maintenance,	ZoneOfControl,	AdvisorType,		TraitType)
values
	('UNIT_BULGARIA_KONIKK',	'LOC_UNIT_BULGARIA_KONIKK_NAME',	2,				5,			50,		'DOMAIN_LAND',	'FORMATION_CLASS_LAND_COMBAT',	100,	'RESOURCE_HORSES',	'LOC_UNIT_BULGARIA_KONIKK_DESCRIPTION',	1,			'PROMOTION_CLASS_LIGHT_CAVALRY',	'TECH_STIRRUPS',	1,			'YIELD_GOLD',	3,				1,				'ADVISOR_CONQUEST',	'TRAIT_CIVILIZATION_UNIT_BULGARIA_KONIKK');
insert or replace into Units_XP2
	(UnitType,					ResourceCost,	ResourceMaintenanceType,	ResourceMaintenanceAmount)
values
	('UNIT_BULGARIA_KONIKK',	5,				'RESOURCE_HORSES',			1);
insert or replace into UnitReplaces
	(CivUniqueUnitType,			ReplacesUnitType)
values
	('UNIT_BULGARIA_KONIKK',	'UNIT_COURSER');
insert or replace into UnitUpgrades
	(Unit,						UpgradeUnit)
values
	('UNIT_BULGARIA_KONIKK',	'UNIT_CAVALRY');
insert or replace into Tags
	(Tag,				Vocabulary)
values
	('CLASS_KONIKK',	'ABILITY_CLASS');
insert or replace into TypeTags
	(Type,							Tag)
values
	('ABILITY_BULGARIA_KONIKK',		'CLASS_KONIKK'),
	('UNIT_BULGARIA_KONIKK',		'CLASS_KONIKK');
insert or replace into UnitAbilities
	(UnitAbilityType,				Description)
values
	('ABILITY_BULGARIA_KONIKK',		'LOC_ABILITY_BULGARIA_KONIKK_DESCRIPTION');
insert or replace into UnitAbilityModifiers
	(UnitAbilityType,				ModifierId)
values
	('ABILITY_BULGARIA_KONIKK',		'BULGARIA_KONIKK_ADD_STRENGTH');
insert or replace into Modifiers
	(ModifierId,						ModifierType,								SubjectRequirementSetId)
values
	('BULGARIA_KONIKK_ADD_STRENGTH',	'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',		'UNIT_IS_ON_OR_VS_DISTRICT');
insert or replace into ModifierArguments
	(ModifierId,						Name,		Value)
values
	('BULGARIA_KONIKK_ADD_STRENGTH',	'Amount',	5);
insert or replace into RequirementSets
	(RequirementSetId,				RequirementSetType)
values
	('UNIT_IS_ON_OR_VS_DISTRICT',	'REQUIREMENTSET_TEST_ANY');
insert or replace into RequirementSetRequirements
	(RequirementSetId,				RequirementId)
values
	('UNIT_IS_ON_OR_VS_DISTRICT',	'OPPONENT_IS_DISTRICT'),
	('UNIT_IS_ON_OR_VS_DISTRICT',	'ATTACKER_IS_OCCUPYING_DISTRICT_REQUIREMENT');
insert or replace into ModifierStrings
	(ModifierId,						Context,		Text)
values
	('BULGARIA_KONIKK_ADD_STRENGTH',	'Preview',		'LOC_BULGARIA_KONIKK_ADD_STRENGTH');
insert or replace into GlobalParameters
	(Name,								Value)
values
	('BULGARIA_UNIT_KILLED_INCOMBAT',	250);