-- Start Bias
delete from StartBiasTerrains where CivilizationType = 'CIVILIZATION_CVS_ARMENIA';
insert or replace into StartBiasResources
	(CivilizationType,				ResourceType,	Tier)
select
	'CIVILIZATION_CVS_ARMENIA',		ResourceType,	2
from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_QUARRY';
-- Traits
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_CVS_ARMENIA_UA' or TraitType = 'TRAIT_LEADER_CVS_TIGRANES_II_UA';
insert or replace into TraitModifiers
	(TraitType,									ModifierId)
values
	('TRAIT_CIVILIZATION_CVS_ARMENIA_UA',		'ARMENIA_GREAT_PROPHET_ATTACH'),
	('TRAIT_CIVILIZATION_CVS_ARMENIA_UA',		'ARMENIA_FOLLOWER_CULTURE'),
	('TRAIT_LEADER_CVS_TIGRANES_II_UA',			'TIGRANES_HILL_MOVEMENT');
insert or replace into Modifiers
	(ModifierId,						ModifierType,												SubjectRequirementSetId)
values
	('ARMENIA_GREAT_PROPHET_ATTACH',	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',					'CITY_HAS_DISTRICT_HOLY_SITE_REQUIREMENTS'),
	('ARMENIA_GREAT_PROPHET',			'MODIFIER_SINGLE_CITY_GRANT_GREAT_PERSON_CLASS_IN_CITY',	'STONEHENGE_PROPHET_REQUIREMENTS'),
	('ARMENIA_FOLLOWER_CULTURE',		'MODIFIER_PLAYER_RELIGION_ADD_RELIGIOUS_BELIEF_YIELD',		null),
	('TIGRANES_HILL_MOVEMENT',			'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',					'PLOT_IS_HILLS');
insert or replace into ModifierArguments
	(ModifierId,						Name,						Value)
values
	('ARMENIA_GREAT_PROPHET_ATTACH',	'ModifierId',				'ARMENIA_GREAT_PROPHET'),
	('ARMENIA_GREAT_PROPHET',			'GreatPersonClassType',		'GREAT_PERSON_CLASS_PROPHET'),
	('ARMENIA_GREAT_PROPHET',			'Amount',					1),
	('ARMENIA_FOLLOWER_CULTURE',		'BeliefYieldType',			'BELIEF_YIELD_PER_FOREIGN_FOLLOWER'),
	('ARMENIA_FOLLOWER_CULTURE',		'PerXItems',				2),
	('ARMENIA_FOLLOWER_CULTURE',		'YieldType',				'YIELD_CULTURE'),
	('ARMENIA_FOLLOWER_CULTURE',		'Amount',					1),
	('TIGRANES_HILL_MOVEMENT',			'Amount',					1);
-- Unique District
delete from Types where Type = 'IMPROVEMENT_CVS_ARMENIA_UI';
delete from District_ValidTerrains where DistrictType = 'DISTRICT_CVS_ARMENIA_UI';
insert or replace into Adjacency_YieldChanges
	(ID,				Description,			YieldType,		YieldChange,	AdjacentImprovement)
values
	('Quarry_Faith',	'LOC_QUARRY_FAITH',		'YIELD_FAITH',	2,				'IMPROVEMENT_QUARRY');
insert or replace into District_Adjacencies
	(DistrictType,						YieldChangeId)
values
	('DISTRICT_CVS_ARMENIA_UI',			'Quarry_Faith');
delete from District_GreatPersonPoints where DistrictType = 'DISTRICT_CVS_ARMENIA_UI' and GreatPersonClassType = 'GREAT_PERSON_CLASS_ENGINEER';
delete from DistrictModifiers where DistrictType = 'DISTRICT_CVS_ARMENIA_UI';
insert or replace into DistrictModifiers
	(DistrictType,						ModifierId)
values
	('DISTRICT_CVS_ARMENIA_UI',			'ARMENIA_QUARRY_CULTURE');
insert or replace into Modifiers
	(ModifierId,						ModifierType,										SubjectRequirementSetId)
values
	('ARMENIA_QUARRY_CULTURE',			'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',		'PLOT_HAS_IMPROVEMENT_QUARRY_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,						Name,				Value)
values
	('ARMENIA_QUARRY_CULTURE',			'YieldType',		'YIELD_CULTURE'),
	('ARMENIA_QUARRY_CULTURE',			'Amount',			1);
-- Resume change about Stone Circle
update Modifiers set SubjectRequirementSetId = 'PLOT_HAS_QUARRY_REQUIREMENTS' where ModifierId = 'STONE_CIRCLES_QUARRY_FAITH_MODIFIER';
update Beliefs set Description = 'LOC_BELIEF_STONE_CIRCLES_DL_DESCRIPTION' where BeliefType = 'BELIEF_STONE_CIRCLES';
-- Unique Unit
update Units set Combat = 36, Cost = 65, StrategicResource = 'RESOURCE_HORSES' where UnitType = 'UNIT_CVS_ARMENIA_UU';
insert or replace into Units_XP2
	(UnitType,					ResourceCost,	ResourceMaintenanceType,	ResourceMaintenanceAmount)
values
	('UNIT_CVS_ARMENIA_UU',		5,				'RESOURCE_HORSES',			1);
delete from UnitAbilityModifiers where UnitAbilityType = 'ABILITY_CVS_ARMENIA_UU';
insert or replace into UnitAbilityModifiers
	(UnitAbilityType,				ModifierId)
values
	('ABILITY_CVS_ARMENIA_UU',		'ARMENIA_IGNORE_HILLS'),
	('ABILITY_CVS_ARMENIA_UU',		'ARMENIA_ATTACKING_MELEE');
insert or replace into Modifiers
	(ModifierId,					ModifierType,												SubjectRequirementSetId)
values
	('ARMENIA_IGNORE_HILLS',		'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_TERRAIN_COST',			null),
	('ARMENIA_ATTACKING_MELEE',		'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',						'ATTACKING_MELEE_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,					Name,		Value)
values
	('ARMENIA_IGNORE_HILLS',		'Type',		'HILLS'),
	('ARMENIA_IGNORE_HILLS',		'Ignore',	1),
	('ARMENIA_ATTACKING_MELEE',		'Amount',	5);
insert or replace into ModifierStrings
	(ModifierId,					Context,	Text)
values
	('ARMENIA_ATTACKING_MELEE',		'Preview',	'LOC_ARMENIA_ATTACKING_MELEE');
insert or replace into RequirementSets
	(RequirementSetId,						RequirementSetType)
values
	('ATTACKING_MELEE_REQUIREMENTS',		'REQUIREMENTSET_TEST_ALL');
insert or replace into RequirementSetRequirements
	(RequirementSetId,						RequirementId)
values
	('ATTACKING_MELEE_REQUIREMENTS',		'PLAYER_IS_ATTACKER_REQUIREMENTS'),
	('ATTACKING_MELEE_REQUIREMENTS',		'OPPONENT_MELEE_REQUIREMENT');
insert or replace into Requirements
	(RequirementId,							RequirementType)
values
	('OPPONENT_MELEE_REQUIREMENT',			'REQUIREMENT_OPPONENT_UNIT_PROMOTION_CLASS_MATCHES');
insert or replace into RequirementArguments
	(RequirementId,							Name,					Value)
values
	('OPPONENT_MELEE_REQUIREMENT',			'UnitPromotionClass',	'PROMOTION_CLASS_MELEE');
-- New Unique Unit
insert or replace into Types
	(Type,											Kind)
values
	('TRAIT_CIVILIZATION_UNIT_ARMENIA_APOSTLE',		'KIND_TRAIT'),
	('UNIT_ARMENIA_APOSTLE',						'KIND_UNIT');
insert or replace into Traits (TraitType) values ('TRAIT_CIVILIZATION_UNIT_ARMENIA_APOSTLE');
insert or replace into CivilizationTraits
	(CivilizationType, 					TraitType)
values
	('CIVILIZATION_CVS_ARMENIA',		'TRAIT_CIVILIZATION_UNIT_ARMENIA_APOSTLE');
insert or replace into TypeTags
	(Type,						Tag)
select
	'UNIT_ARMENIA_APOSTLE',		Tag
from TypeTags where Type = 'UNIT_APOSTLE';
insert or replace into UnitAiInfos
	(UnitType,					AiType)
select
	'UNIT_ARMENIA_APOSTLE',		AiType
from UnitAiInfos where UnitType = 'UNIT_APOSTLE';
insert or replace into Units
	(UnitType,					Name,								BaseSightRange,	BaseMoves,	Domain,			FormationClass,					Cost,	Description,							EvangelizeBelief,	LaunchInquisition,	ReligiousStrength,	ReligionEvictPercent,	SpreadCharges,	CostProgressionModel,				CostProgressionParam1,	PromotionClass,				InitialLevel,	NumRandomChoices,	PrereqCivic,			CanTrain,	PurchaseYield,	MustPurchase,	PseudoYieldType,				TrackReligion,	TraitType)
values
	('UNIT_ARMENIA_APOSTLE',	'LOC_UNIT_ARMENIA_APOSTLE_NAME',	2,				4,			'DOMAIN_LAND',	'FORMATION_CLASS_CIVILIAN',		150,	'LOC_UNIT_ARMENIA_APOSTLE_DESCRIPTION',	1,					1,					110,				25,						3,				'COST_PROGRESSION_PREVIOUS_COPIES',	10,						'PROMOTION_CLASS_APOSTLE',	2,				3,					'CIVIC_DRAMA_POETRY',	1,			'YIELD_FAITH',	1,				'PSEUDOYIELD_UNIT_RELIGIOUS',	1,				'TRAIT_CIVILIZATION_UNIT_ARMENIA_APOSTLE');
insert or replace into UnitReplaces
	(CivUniqueUnitType,				ReplacesUnitType)
values
	('UNIT_ARMENIA_APOSTLE',		'UNIT_APOSTLE');
insert or replace into Unit_BuildingPrereqs
	(Unit,							PrereqBuilding)
values
	('UNIT_ARMENIA_APOSTLE',		'BUILDING_SHRINE');
insert or replace into Unit_BuildingPrereqs
	(Unit,							PrereqBuilding)
select
	'UNIT_ARMENIA_APOSTLE',			PrereqBuilding
from Unit_BuildingPrereqs where Unit = 'UNIT_APOSTLE';
insert or replace into RequirementSetRequirements
	(RequirementSetId,				RequirementId)
select
	RequirementSetId,				'REQUIRES_UNIT_IS_UNIT_ARMENIA_APOSTLE'
from RequirementSetRequirements where RequirementId = 'REQUIRES_UNIT_IS_UNIT_APOSTLE';
insert or replace into GlobalParameters
	(Name,							Value)
values
	('ARMENIA_APOSTLE_PRESSURE',	500);