-- Traits
delete from TraitModifiers where TraitType = 'TRAIT_LEADER_GEDEMO_MUTOTA_LTRAIT' and ModifierId like 'GEDEMO_MUTOTA_MERCHANT_WALL%';
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT';
update ModifierArguments set Value = 5 where ModifierId = 'MUTOTA_STRONGER_IN_RIVER' and Name = 'Amount';
update ModifierArguments set Value = 1 where (ModifierId = 'GEDEMO_ZIMBABWE_TRAIT_CULTURE_IMPROVEMENT_CAMP_TRADE' or ModifierId = 'GEDEMO_ZIMBABWE_TRAIT_CULTURE_IMPROVEMENT_PLANTATION_TRADE') and Name = 'Amount';
insert or replace into TraitModifiers
	(TraitType,											ModifierId)
values
	('TRAIT_LEADER_GEDEMO_MUTOTA_LTRAIT',				'TRAIT_MUTOTA_DZIMBABWE_MERCHANT_TRAIT_ATTACH'),
	('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',	'GEDEMO_ZIMBABWE_TRAIT_CULTURE_IMPROVEMENT_PLANTATION_TRADE'),
	('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',	'GEDEMO_ZIMBABWE_TRAIT_CULTURE_IMPROVEMENT_CAMP_TRADE');
insert or replace into Modifiers
	(ModifierId,										ModifierType,										SubjectRequirementSetId,										SubjectStackLimit)
values
	('TRAIT_MUTOTA_DZIMBABWE_MERCHANT_TRAIT_ATTACH',	'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',		'PLOT_HAS_IMPROVEMENT_GEDEMO_DZIMBABWE_REQUIREMENTS',			null),
	('TRAIT_MUTOTA_DZIMBABWE_MERCHANT_ATTACH',			'MODIFIER_CITY_OWNER_ATTACH_MODIFIER',				'PLAYER_HAS_TECH_MASONRY_REQUIREMENTS',							1),
	('TRAIT_MUTOTA_DZIMBABWE_MERCHANT',					'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',		null,															null);
insert or replace into ModifierArguments
	(ModifierId,										Name,						Value)
values
	('TRAIT_MUTOTA_DZIMBABWE_MERCHANT_TRAIT_ATTACH',	'ModifierId',				'TRAIT_MUTOTA_DZIMBABWE_MERCHANT_ATTACH'),
	('TRAIT_MUTOTA_DZIMBABWE_MERCHANT_ATTACH',			'ModifierId',				'TRAIT_MUTOTA_DZIMBABWE_MERCHANT'),
	('TRAIT_MUTOTA_DZIMBABWE_MERCHANT',					'GreatPersonClassType',		'GREAT_PERSON_CLASS_MERCHANT'),
	('TRAIT_MUTOTA_DZIMBABWE_MERCHANT',					'Amount',					3);

delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT' 
and exists (select FeatureType from Features where FeatureType = 'FEATURE_JNR_SAVANNAH');

-- Unique Unit
update Units set Combat = 30, Cost = 45, PrereqTech = 'TECH_ANIMAL_HUSBANDRY' where UnitType = 'UNIT_GEDEMO_ROZWI';
insert or replace into TypeTags
	(Type,					Tag)
values
	('UNIT_GEDEMO_ROZWI',	'CLASS_WALL_ATTACK');
-- Unique Improvement
update Improvements set DefenseModifier = 0 where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';
update Improvements set PrereqTech = 'TECH_MINING' where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';
update Improvements set SameAdjacentValid = 1 where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';

insert or replace into Improvement_ValidTerrains
	(ImprovementType,					TerrainType,		PrereqTech)
values
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_DESERT',	'TECH_BUTTRESS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_GRASS',	'TECH_BUTTRESS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_PLAINS',	'TECH_BUTTRESS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_SNOW',		'TECH_BUTTRESS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_TUNDRA',	'TECH_BUTTRESS');

insert or replace into Improvement_ValidFeatures
	(ImprovementType,					FeatureType)
values
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'FEATURE_VOLCANIC_SOIL');

insert or replace into Improvement_YieldChanges
	(ImprovementType,						YieldType,				YieldChange)
values
	('IMPROVEMENT_GEDEMO_DZIMBABWE',		'YIELD_FOOD',			1),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',		'YIELD_PRODUCTION',		0),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',		'YIELD_GOLD',			2);

delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_IMPROVEMENT_GEDEMO_DZIMBABWE' and ModifierId = 'DZIMBABWE_BUFF_ADJACENT_TILES';
delete from ImprovementModifiers where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';

insert or replace into Improvement_Adjacencies
	(ImprovementType,					YieldChangeId)
values
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Plantation_TIER1'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Camp_TIER1'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Farm_TIER1'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Pasture_TIER1'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Quarry_TIER1'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Plantation_TIER2'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Camp_TIER2'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Farm_TIER2'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Pasture_TIER2'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Quarry_TIER2');
insert or replace into Adjacency_YieldChanges
	(ID,										Description,	YieldType,				YieldChange,	AdjacentImprovement,		PrereqCivic,				ObsoleteCivic)
values
	('Dzimbabwe_Adjacency_Plantation_TIER1',	'Placeholder',	'YIELD_FOOD',			1,				'IMPROVEMENT_PLANTATION',	Null,						'CIVIC_FEUDALISM'),
	('Dzimbabwe_Adjacency_Farm_TIER1',			'Placeholder',	'YIELD_FOOD',			1,				'IMPROVEMENT_FARM',			Null,						'CIVIC_FEUDALISM'),
	('Dzimbabwe_Adjacency_Camp_TIER1',			'Placeholder',	'YIELD_FOOD',			1,				'IMPROVEMENT_CAMP',			Null,						'CIVIC_FEUDALISM'),
	('Dzimbabwe_Adjacency_Pasture_TIER1',		'Placeholder',	'YIELD_PRODUCTION',		1,				'IMPROVEMENT_PASTURE',		Null,						'CIVIC_FEUDALISM'),
	('Dzimbabwe_Adjacency_Quarry_TIER1',		'Placeholder',	'YIELD_PRODUCTION',		1,				'IMPROVEMENT_QUARRY',		Null,						'CIVIC_FEUDALISM'),
	('Dzimbabwe_Adjacency_Plantation_TIER2',	'Placeholder',	'YIELD_FOOD',			2,				'IMPROVEMENT_PLANTATION',	'CIVIC_FEUDALISM',			Null),
	('Dzimbabwe_Adjacency_Farm_TIER2',			'Placeholder',	'YIELD_FOOD',			2,				'IMPROVEMENT_FARM',			'CIVIC_FEUDALISM',			Null),
	('Dzimbabwe_Adjacency_Camp_TIER2',			'Placeholder',	'YIELD_FOOD',			2,				'IMPROVEMENT_CAMP',			'CIVIC_FEUDALISM',			Null),
	('Dzimbabwe_Adjacency_Pasture_TIER2',		'Placeholder',	'YIELD_PRODUCTION',		2,				'IMPROVEMENT_PASTURE',		'CIVIC_FEUDALISM',			Null),
	('Dzimbabwe_Adjacency_Quarry_TIER2',		'Placeholder',	'YIELD_PRODUCTION',		2,				'IMPROVEMENT_QUARRY',		'CIVIC_FEUDALISM',			Null);

update Improvement_Tourism set TourismSource = 'TOURISMSOURCE_FOOD' where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';

-- New Unique Unit
insert or replace into GlobalParameters
	(Name,								Value)
values
	('PATHFINDER_ACTIVATION_CHARGE',	2);
insert or replace into Types
	(Type,												Kind)
values
	('TRAIT_CIVILIZATION_UNIT_ZIMBABWE_PATHFINDER',		'KIND_TRAIT'),
	('UNIT_ZIMBABWE_PATHFINDER',						'KIND_UNIT');
insert or replace into Traits (TraitType) values ('TRAIT_CIVILIZATION_UNIT_ZIMBABWE_PATHFINDER');
insert or replace into CivilizationTraits
	(CivilizationType, 					TraitType)
values
	('CIVILIZATION_GEDEMO_ZIMBABWE',	'TRAIT_CIVILIZATION_UNIT_ZIMBABWE_PATHFINDER');
insert or replace into TypeTags
	(Type,							Tag)
values
	('UNIT_ZIMBABWE_PATHFINDER',	'CLASS_LANDCIVILIAN'),
	('UNIT_ZIMBABWE_PATHFINDER',	'CLASS_LAND_UNITS');
insert or replace into Units
	(UnitType,						Name,									BaseSightRange,	BaseMoves,	Domain,			FormationClass,					Cost,	CostProgressionModel,				CostProgressionParam1,	Description,								CanRetreatWhenCaptured,		PrereqTech,			CanTrain,	PurchaseYield,	AdvisorType,		TraitType)
values
	('UNIT_ZIMBABWE_PATHFINDER',	'LOC_UNIT_ZIMBABWE_PATHFINDER_NAME',	2,				4,			'DOMAIN_LAND',	'FORMATION_CLASS_CIVILIAN',		120,	'COST_PROGRESSION_PREVIOUS_COPIES',	10,						'LOC_UNIT_ZIMBABWE_PATHFINDER_DESCRIPTION',	1,							'TECH_CURRENCY',	1,			'YIELD_GOLD',	'ADVISOR_GENERIC',	'TRAIT_CIVILIZATION_UNIT_ZIMBABWE_PATHFINDER');