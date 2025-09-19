-- Rename type to disable lua script
update Types set Type = 'CIVILIZATION_BOOM_ASSYRIA_HD' where Type = 'CIVILIZATION_BOOM_ASSYRIA';
update Types set Hash = Make_Hash(Type) where Type = 'CIVILIZATION_BOOM_ASSYRIA_HD';
-- Start Bias
delete from StartBiasTerrains where CivilizationType = 'CIVILIZATION_BOOM_ASSYRIA_HD';
delete from StartBiasResources where CivilizationType = 'CIVILIZATION_BOOM_ASSYRIA_HD';
-- Traits
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_BOOM_RUBAUM' or TraitType = 'TRAIT_LEADER_BOOM_ASHURBANIPAL';
-- Parameters used by lua
insert or replace into GlobalParameters
	(Name,								Value)
values
	('ASSYRIA_DAMAGE',					10),
	('ASSYRIA_SCIENCE_PER_POPULATION',	20);
-- Modifiers used by lua
insert or replace into Modifiers
	(ModifierId,							ModifierType,												RunOnce,	OwnerRequirementSetId)
values
	('ASSYRIA_GRANT_SETTLER',				'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL',					1,			null),
	('ASHURBANIPAL_CAPITAL_CULTURE',		'MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_CHANGE',	0,			null),
	('ASHURBANIPAL_ROYAL_LIBRARY_CULTURE',	'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',		0,			'PLAYER_HAS_BUILDING_BOOM_ROYAL_LIBRARY_REQUIREMENTS'),
	('ASHURBANIPAL_ROYAL_LIBRARY_GOLD',		'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',		0,			'PLAYER_HAS_BUILDING_BOOM_ROYAL_LIBRARY_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,							Name,			Value)
values
	('ASSYRIA_GRANT_SETTLER',				'UnitType',		'UNIT_SETTLER'),
	('ASSYRIA_GRANT_SETTLER',				'Amount',		1),
	('ASHURBANIPAL_CAPITAL_CULTURE',		'YieldType',	'YIELD_CULTURE'),
	('ASHURBANIPAL_CAPITAL_CULTURE',		'Amount',		2),
	('ASHURBANIPAL_ROYAL_LIBRARY_CULTURE',	'YieldType',	'YIELD_CULTURE'),
	('ASHURBANIPAL_ROYAL_LIBRARY_CULTURE',	'Amount',		3),
	('ASHURBANIPAL_ROYAL_LIBRARY_GOLD',		'YieldType',	'YIELD_GOLD'),
	('ASHURBANIPAL_ROYAL_LIBRARY_GOLD',		'Amount',		3);
-- Leader Unique Building
update Buildings set Entertainment = 0 where BuildingType = 'BUILDING_BOOM_ROYAL_LIBRARY';
delete from Building_GreatWorks where BuildingType = 'BUILDING_BOOM_ROYAL_LIBRARY';
delete from Building_GreatPersonPoints where BuildingType = 'BUILDING_BOOM_ROYAL_LIBRARY';
insert or replace into BuildingModifiers
	(BuildingType,						ModifierId)
values
	('BUILDING_BOOM_ROYAL_LIBRARY',		'ROYAL_LIBRARY_MILITARY_PRODUCTION'),
	('BUILDING_BOOM_ROYAL_LIBRARY',		'ROYAL_LIBRARY_PILLAGE_DISTRICT'),
	('BUILDING_BOOM_ROYAL_LIBRARY',		'ROYAL_LIBRARY_PILLAGE_IMPROVEMENT'),
	('BUILDING_BOOM_ROYAL_LIBRARY',		'ROYAL_LIBRARY_SETTLER_MOVEMENT'),
	('BUILDING_BOOM_ROYAL_LIBRARY',		'ROYAL_LIBRARY_BUILDER_MOVEMENT');
insert or replace into Modifiers
	(ModifierId,							ModifierType,												SubjectRequirementSetId)
values
	('ROYAL_LIBRARY_MILITARY_PRODUCTION',	'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNIT_PRODUCTION',	null),
	('ROYAL_LIBRARY_SUPPORT_PRODUCTION',	'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION',	null),
	('ROYAL_LIBRARY_PILLAGE_DISTRICT',		'MODIFIER_PLAYER_ADJUST_DISTRICT_PILLAGE',					null),
	('ROYAL_LIBRARY_PILLAGE_IMPROVEMENT',	'MODIFIER_PLAYER_ADJUST_IMPROVEMENT_PILLAGE',				null),
	('ROYAL_LIBRARY_SETTLER_MOVEMENT',		'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',					'UNIT_IS_UNIT_SETTLER_REQUIREMENTS'),
	('ROYAL_LIBRARY_BUILDER_MOVEMENT',		'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',					'UNIT_IS_UNIT_BUILDER_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,							Name,		Value)
values
	('ROYAL_LIBRARY_MILITARY_PRODUCTION',	'Amount',	30),
	('ROYAL_LIBRARY_PILLAGE_DISTRICT',		'Amount',	200),
	('ROYAL_LIBRARY_PILLAGE_IMPROVEMENT',	'Amount',	200),
	('ROYAL_LIBRARY_SETTLER_MOVEMENT',		'Amount',	1),
	('ROYAL_LIBRARY_BUILDER_MOVEMENT',		'Amount',	1);
-- Unique Improvement
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_BOOM_IMPROVEMENT_LAMASSU';
delete from Improvement_Adjacencies where ImprovementType = 'IMPROVEMENT_BOOM_LAMASSU';
insert or replace into Improvement_ValidFeatures
	(ImprovementType,				FeatureType)
values
	('IMPROVEMENT_BOOM_LAMASSU',	'FEATURE_VOLCANIC_SOIL');
insert or replace into Improvement_YieldChanges
	(ImprovementType,				YieldType,			YieldChange)
values
	('IMPROVEMENT_BOOM_LAMASSU',	'YIELD_FAITH',		1);
delete from Improvement_BonusYieldChanges where ImprovementType = 'IMPROVEMENT_BOOM_LAMASSU';
delete from Improvement_Tourism where ImprovementType = 'IMPROVEMENT_BOOM_LAMASSU';
insert or replace into ImprovementModifiers
	(ImprovementType,				ModifierId)
values
	('IMPROVEMENT_BOOM_LAMASSU',	'BOOM_LAMASSU_ENCAMPMENT_GENERAL_ATTACH');
insert or replace into Modifiers
	(ModifierId,								ModifierType,										SubjectRequirementSetId,						SubjectStackLimit)
values
	('BOOM_LAMASSU_ENCAMPMENT_GENERAL_ATTACH',	'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER',		'DISTRICT_IS_ENCAMPMENT_ADJACENT_TO_OWNER',		1),
	('BOOM_LAMASSU_ENCAMPMENT_GENERAL',			'MODIFIER_SINGLE_CITY_ADJUST_GREAT_PERSON_POINT',	null,											null);
insert or replace into ModifierArguments
	(ModifierId,								Name,					Value)
values
	('BOOM_LAMASSU_ENCAMPMENT_GENERAL_ATTACH',	'ModifierId',			'BOOM_LAMASSU_ENCAMPMENT_GENERAL'),
	('BOOM_LAMASSU_ENCAMPMENT_GENERAL',			'GreatPersonClassType',	'GREAT_PERSON_CLASS_GENERAL'),
	('BOOM_LAMASSU_ENCAMPMENT_GENERAL',			'Amount',				2);
insert or ignore into RequirementSets
	(RequirementSetId,								RequirementSetType)
values
	('DISTRICT_IS_ENCAMPMENT_ADJACENT_TO_OWNER',	'REQUIREMENTSET_TEST_ALL');
insert or ignore into RequirementSetRequirements
	(RequirementSetId,								RequirementId)
values
	('DISTRICT_IS_ENCAMPMENT_ADJACENT_TO_OWNER',	'ADJACENT_TO_OWNER'),
	('DISTRICT_IS_ENCAMPMENT_ADJACENT_TO_OWNER',	'REQUIRES_DISTRICT_IS_DISTRICT_ENCAMPMENT');
-- Unique Unit
-- bug fix
update Modifiers set SubjectRequirementSetId = 'OBJECT_IS_AT_OR_ADJACENT' where ModifierId = 'BOOM_ASSYRIA_SIEGE_ENGINE_BONUS1' or ModifierId = 'BOOM_ASSYRIA_SIEGE_ENGINE_BONUS2';
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_BOOM_UNIT_SIEGE_ENGINE';
insert or replace into TraitModifiers
	(TraitType,										ModifierId)
values
	('TRAIT_CIVILIZATION_BOOM_UNIT_SIEGE_ENGINE',	'BOOM_ASSYRIA_SIEGE_ENGINE_BONUS1_ATTACH'),
	('TRAIT_CIVILIZATION_BOOM_UNIT_SIEGE_ENGINE',	'BOOM_ASSYRIA_SIEGE_ENGINE_BONUS2_ATTACH');
insert or replace into Modifiers
	(ModifierId,									ModifierType,								SubjectRequirementSetId)
values
	('BOOM_ASSYRIA_SIEGE_ENGINE_BONUS1_ATTACH',		'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER',	'UNIT_IS_UNIT_BOOM_SIEGE_ENGINE_REQUIREMENTS'),
	('BOOM_ASSYRIA_SIEGE_ENGINE_BONUS2_ATTACH',		'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER',	'UNIT_IS_UNIT_BOOM_SIEGE_ENGINE_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,									Name,			Value)
values
	('BOOM_ASSYRIA_SIEGE_ENGINE_BONUS1_ATTACH',		'ModifierId',	'BOOM_ASSYRIA_SIEGE_ENGINE_BONUS1'),
	('BOOM_ASSYRIA_SIEGE_ENGINE_BONUS2_ATTACH',		'ModifierId',	'BOOM_ASSYRIA_SIEGE_ENGINE_BONUS2');
-- New Unique Unit
insert or replace into Types
	(Type,												Kind)
values
	('TRAIT_CIVILIZATION_UNIT_ASSYRIA_KISIR_SARRUTI',	'KIND_TRAIT'),
	('UNIT_ASSYRIA_KISIR_SARRUTI',						'KIND_UNIT');
insert or replace into Traits (TraitType) values ('TRAIT_CIVILIZATION_UNIT_ASSYRIA_KISIR_SARRUTI');
insert or replace into CivilizationTraits
	(CivilizationType, 					TraitType)
values
	('CIVILIZATION_BOOM_ASSYRIA_HD',	'TRAIT_CIVILIZATION_UNIT_ASSYRIA_KISIR_SARRUTI');
insert or replace into TypeTags
	(Type,							Tag)
select
	'UNIT_ASSYRIA_KISIR_SARRUTI',	Tag
from TypeTags where Type = 'UNIT_PIKEMAN';
insert or replace into UnitAiInfos
	(UnitType,						AiType)
select
	'UNIT_ASSYRIA_KISIR_SARRUTI',	AiType
from UnitAiInfos where UnitType = 'UNIT_PIKEMAN';
insert or replace into Units
	(UnitType,						Name,									BaseSightRange,	BaseMoves,	Combat,	Domain,			FormationClass,					Cost,	Description,									CanCapture,	PromotionClass,					PrereqTech,				CanTrain,	PurchaseYield,	Maintenance,	ZoneOfControl,	AdvisorType,		TraitType)
values
	('UNIT_ASSYRIA_KISIR_SARRUTI',	'LOC_UNIT_ASSYRIA_KISIR_SARRUTI_NAME',	2,				3,			40,		'DOMAIN_LAND',	'FORMATION_CLASS_LAND_COMBAT',	70,		'LOC_UNIT_ASSYRIA_KISIR_SARRUTI_DESCRIPTION',	1,			'PROMOTION_CLASS_ANTI_CAVALRY',	'TECH_IRON_WORKING',	1,			'YIELD_GOLD',	3,				1,				'ADVISOR_CONQUEST',	'TRAIT_CIVILIZATION_UNIT_ASSYRIA_KISIR_SARRUTI');
insert or replace into UnitReplaces
	(CivUniqueUnitType,				ReplacesUnitType)
values
	('UNIT_ASSYRIA_KISIR_SARRUTI',	'UNIT_PIKEMAN');
insert or replace into UnitUpgrades
	(Unit,							UpgradeUnit)
values
	('UNIT_ASSYRIA_KISIR_SARRUTI',	'UNIT_PIKE_AND_SHOT');
insert or replace into TraitModifiers
	(TraitType,											ModifierId)
values
	('TRAIT_CIVILIZATION_UNIT_ASSYRIA_KISIR_SARRUTI',	'TRAIT_UNIT_ASSYRIA_KISIR_SARRUTI_PROMOTION');
insert or replace into Modifiers
	(ModifierId,										ModifierType,										SubjectRequirementSetId)
values
	('TRAIT_UNIT_ASSYRIA_KISIR_SARRUTI_PROMOTION',		'MODIFIER_PLAYER_UNITS_ADJUST_GRANT_EXPERIENCE',	'UNIT_IS_UNIT_ASSYRIA_KISIR_SARRUTI_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,										Name,		Value)
values
	('TRAIT_UNIT_ASSYRIA_KISIR_SARRUTI_PROMOTION',		'Amount',	-1);
-- Religion
insert or replace into FavoredReligions
	(LeaderType,					ReligionType)
select
	'LEADER_BOOM_ASHURBANIPAL',		'RELIGION_M1_ASHURISM'
where exists (select ReligionType from Religions where ReligionType = 'RELIGION_M1_ASHURISM');
-- Bug fix
delete from RequirementSets where RequirementSetId = 'PLOT_IS_BOOM_FOUNDED_CITY_LAMASSU' or RequirementSetId = 'PLOT_IS_BOOM_CAPTURED_CITY_LAMASSU';