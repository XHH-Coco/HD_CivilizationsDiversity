-- Traits

insert or replace into TraitModifiers
	(TraitType,											ModifierId)
values
	('TRAIT_LEADER_GEDEMO_MUTOTA_LTRAIT',	            'GEDEMO_ZIMBABWE_TRAIT_CULTURE_IMPROVEMENT_PLANTATION_TRADE'),
	('TRAIT_LEADER_GEDEMO_MUTOTA_LTRAIT',	            'GEDEMO_ZIMBABWE_TRAIT_CULTURE_IMPROVEMENT_CAMP_TRADE'),
    ('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',	'GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_MINE'),
    ('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',	'GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_PASTURE'),
    ('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',	'GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_CAMP'),
    ('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',	'GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_PLANTATION'),
    ('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',	'GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_QUARRY'),
    ('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',	'GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_LUMBER_MILL'),
    ('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',	'GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_FARM');
insert or replace into Modifiers
	(ModifierId,										    ModifierType,									SubjectRequirementSetId)
values
	('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_MINE',           'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',            'MINE_ON_JNR_SAVANNAH'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_PASTURE',        'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',            'PASTURE_ON_JNR_SAVANNAH'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_CAMP',           'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',            'CAMP_ON_JNR_SAVANNAH'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_PLANTATION',     'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',            'PLANTATION_ON_JNR_SAVANNAH'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_QUARRY',         'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',            'QUARRY_ON_JNR_SAVANNAH'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_LUMBER_MILL',    'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',            'LUMBER_MILL_ON_JNR_SAVANNAH'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_FARM',           'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',            'FARM_ON_JNR_SAVANNAH');

insert or replace into ModifierArguments
	(ModifierId,										    Name,						Value)
values
	('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_MINE',           'YieldType',                'YIELD_PRODUCTION,YIELD_CULTURE'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_MINE',           'Amount',                   '1,1'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_PASTURE',        'YieldType',                'YIELD_FOOD,YIELD_CULTURE'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_PASTURE',        'Amount' ,                  '1,1'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_CAMP',           'YieldType',                'YIELD_FOOD,YIELD_CULTURE'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_CAMP',           'Amount',                   '1,1'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_PLANTATION',     'YieldType',                'YIELD_FOOD,YIELD_CULTURE'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_PLANTATION',     'Amount',                   '1,1'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_QUARRY',         'YieldType',                'YIELD_PRODUCTION,YIELD_CULTURE'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_QUARRY',         'Amount',                   '1,1'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_LUMBER_MILL',    'YieldType',                'YIELD_PRODUCTION,YIELD_CULTURE'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_LUMBER_MILL',    'Amount',                   '1,1'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_FARM',           'YieldType',                'YIELD_FOOD,YIELD_CULTURE'),
    ('GEDEMO_ZIMBABWE_TRAIT_SAVANNAH_YIELD_FARM',           'Amount',                   '1,1');

insert or replace into RequirementSetRequirements
	(RequirementSetId,				 RequirementId)
values
    ('MINE_ON_JNR_SAVANNAH',		'PLOT_IS_JNR_SAVANNAH_REQUIREMENT'),
    ('MINE_ON_JNR_SAVANNAH',		'REQUIRES_PLOT_HAS_MINE'),
    ('PASTURE_ON_JNR_SAVANNAH',		'PLOT_IS_JNR_SAVANNAH_REQUIREMENT'),
    ('PASTURE_ON_JNR_SAVANNAH',		'REQUIRES_PLOT_HAS_PASTURE'),
    ('CAMP_ON_JNR_SAVANNAH',		'PLOT_IS_JNR_SAVANNAH_REQUIREMENT'),
    ('CAMP_ON_JNR_SAVANNAH',		'REQUIRES_PLOT_HAS_CAMP'),
    ('PLANTATION_ON_JNR_SAVANNAH',	'PLOT_IS_JNR_SAVANNAH_REQUIREMENT'),
    ('PLANTATION_ON_JNR_SAVANNAH',	'REQUIRES_PLOT_HAS_PLANTATION'),
    ('QUARRY_ON_JNR_SAVANNAH',		'PLOT_IS_JNR_SAVANNAH_REQUIREMENT'),
    ('QUARRY_ON_JNR_SAVANNAH',		'REQUIRES_PLOT_HAS_QUARRY'),
    ('LUMBER_MILL_ON_JNR_SAVANNAH',	'PLOT_IS_JNR_SAVANNAH_REQUIREMENT'),
    ('LUMBER_MILL_ON_JNR_SAVANNAH',	'REQUIRES_PLOT_HAS_LUMBER_MILL'),
    ('FARM_ON_JNR_SAVANNAH',		'PLOT_IS_JNR_SAVANNAH_REQUIREMENT'),
    ('FARM_ON_JNR_SAVANNAH',		'REQUIRES_PLOT_HAS_FARM');
    
insert or replace into RequirementSets 
    (RequirementSetId,              RequirementSetType)
values
    ('MINE_ON_JNR_SAVANNAH',         'REQUIREMENTSET_TEST_ALL'),
    ('PASTURE_ON_JNR_SAVANNAH',      'REQUIREMENTSET_TEST_ALL'),
    ('CAMP_ON_JNR_SAVANNAH',         'REQUIREMENTSET_TEST_ALL'),
    ('PLANTATION_ON_JNR_SAVANNAH',   'REQUIREMENTSET_TEST_ALL'),
    ('QUARRY_ON_JNR_SAVANNAH',       'REQUIREMENTSET_TEST_ALL'),
    ('LUMBER_MILL_ON_JNR_SAVANNAH',  'REQUIREMENTSET_TEST_ALL'),
    ('FARM_ON_JNR_SAVANNAH',         'REQUIREMENTSET_TEST_ALL');

-- Unique Improvement
update Improvements set DefenseModifier = 0 where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';
update Improvements set PrereqTech = 'TECH_MINING' where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';
update Improvements set SameAdjacentValid = 0 where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';
delete from Improvement_Adjacencies where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';

insert or replace into Improvement_ValidTerrains
	(ImprovementType,					TerrainType)
values
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_DESERT'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_GRASS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_PLAINS'),	
    ('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_GRASS_HILLS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_PLAINS_HILLS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_DESERT_HILLS');

insert or replace into Improvement_ValidFeatures
	(ImprovementType,					FeatureType)
values
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'FEATURE_VOLCANIC_SOIL'),
    ('IMPROVEMENT_GEDEMO_DZIMBABWE',	'FEATURE_JNR_SAVANNAH');
insert or replace into Improvement_ValidFeatures
	(ImprovementType,					FeatureType,                PrereqTech)
values
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'FEATURE_VOLCANIC_SOIL',    'TECH_BUTTRESS');

insert or replace into Improvement_YieldChanges
	(ImprovementType,						YieldType,				YieldChange)
values
	('IMPROVEMENT_GEDEMO_DZIMBABWE',		'YIELD_FOOD',			1),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',		'YIELD_PRODUCTION',		1),
    ('IMPROVEMENT_GEDEMO_DZIMBABWE',		'YIELD_GOLD',		    0),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',		'YIELD_CULTURE',		0);

delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_IMPROVEMENT_GEDEMO_DZIMBABWE' and ModifierId = 'DZIMBABWE_BUFF_ADJACENT_TILES';
delete from ImprovementModifiers where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';

insert or replace into Improvement_Adjacencies
	(ImprovementType,					YieldChangeId)
values
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Plantation_Production_TIER1'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Camp_Production_TIER1'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Mine_TIER1'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Pasture_Production_TIER1'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Quarry_Production_TIER1'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Plantation_Production_TIER2'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Camp_Production_TIER2'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Mine_TIER2'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Pasture_Production_TIER2'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Quarry_Production_TIER2'),
    ('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Plantation_CULTURE'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Camp_CULTURE'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Mine_CULTURE'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Pasture_CULTURE'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'Dzimbabwe_Adjacency_Quarry_CULTURE');

insert or replace into Adjacency_YieldChanges
	(ID,										                Description,	YieldType,				YieldChange,	AdjacentImprovement,		PrereqCivic,				ObsoleteCivic)
values
	('Dzimbabwe_Adjacency_Plantation_Production_TIER1',	        'Placeholder',	'YIELD_PRODUCTION',		1,				'IMPROVEMENT_PLANTATION',	Null,						'CIVIC_MERCANTILISM'),
	('Dzimbabwe_Adjacency_Mine_TIER1',			                'Placeholder',	'YIELD_PRODUCTION',		1,				'IMPROVEMENT_MINE',			Null,						'CIVIC_MERCANTILISM'),
	('Dzimbabwe_Adjacency_Camp_Production_TIER1',			    'Placeholder',	'YIELD_PRODUCTION',		1,				'IMPROVEMENT_CAMP',			Null,						'CIVIC_MERCANTILISM'),
	('Dzimbabwe_Adjacency_Pasture_Production_TIER1',		    'Placeholder',	'YIELD_PRODUCTION',		1,				'IMPROVEMENT_PASTURE',		Null,						'CIVIC_MERCANTILISM'),
	('Dzimbabwe_Adjacency_Quarry_Production_TIER1',		        'Placeholder',	'YIELD_PRODUCTION',		1,				'IMPROVEMENT_QUARRY',		Null,						'CIVIC_MERCANTILISM'),
	('Dzimbabwe_Adjacency_Plantation_Production_TIER2',	        'Placeholder',	'YIELD_PRODUCTION',		2,				'IMPROVEMENT_PLANTATION',	'CIVIC_MERCANTILISM',	    Null),
	('Dzimbabwe_Adjacency_Mine_TIER2',			                'Placeholder',	'YIELD_PRODUCTION',		2,				'IMPROVEMENT_MINE',			'CIVIC_MERCANTILISM',		Null),
	('Dzimbabwe_Adjacency_Camp_Production_TIER2',			    'Placeholder',	'YIELD_PRODUCTION',		2,				'IMPROVEMENT_CAMP',			'CIVIC_MERCANTILISM',		Null),
	('Dzimbabwe_Adjacency_Pasture_Production_TIER2',		    'Placeholder',	'YIELD_PRODUCTION',		2,				'IMPROVEMENT_PASTURE',		'CIVIC_MERCANTILISM',		Null),
	('Dzimbabwe_Adjacency_Quarry_Production_TIER2',		        'Placeholder',	'YIELD_PRODUCTION',		2,				'IMPROVEMENT_QUARRY',		'CIVIC_MERCANTILISM',		Null),
    ('Dzimbabwe_Adjacency_Plantation_CULTURE',	                'Placeholder',	'YIELD_CULTURE',		1,				'IMPROVEMENT_PLANTATION',	'CIVIC_RECORDED_HISTORY',	Null),
	('Dzimbabwe_Adjacency_Camp_CULTURE',		                'Placeholder',	'YIELD_CULTURE',		1,				'IMPROVEMENT_CAMP',			'CIVIC_RECORDED_HISTORY',	Null),
	('Dzimbabwe_Adjacency_Mine_CULTURE',		                'Placeholder',	'YIELD_CULTURE',		1,				'IMPROVEMENT_MINE',			'CIVIC_RECORDED_HISTORY',	Null),
	('Dzimbabwe_Adjacency_Pasture_CULTURE',		                'Placeholder',	'YIELD_CULTURE',		1,				'IMPROVEMENT_PASTURE',		'CIVIC_RECORDED_HISTORY',	Null),
	('Dzimbabwe_Adjacency_Quarry_CULTURE',		                'Placeholder',	'YIELD_CULTURE',		1,				'IMPROVEMENT_QUARRY',		'CIVIC_RECORDED_HISTORY',	Null);

update Improvement_Tourism set TourismSource = 'TOURISMSOURCE_PRODUCTION' where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';

--StartBias
delete from StartBiasFeatures where CivilizationType = 'CIVILIZATION_GEDEMO_ZIMBABWE';
delete from StartBiasTerrains where CivilizationType = 'CIVILIZATION_GEDEMO_ZIMBABWE';

insert or replace into StartBiasFeatures
	(CivilizationType,					FeatureType,				Tier)
values
	('CIVILIZATION_GEDEMO_ZIMBABWE',	'FEATURE_JNR_SAVANNAH',	    1);