delete from TraitModifiers where TraitType in ('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT', 'TRAIT_LEADER_GEDEMO_MUTOTA_LTRAIT', 'TRAIT_CIVILIZATION_IMPROVEMENT_GEDEMO_DZIMBABWE');

insert or ignore into HD_Building_Base_On_ResourceClassification (BuildingType, ResourceClassificationType, DetectRange, PropertyKey) values
	('BUILDING_TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',     'RESOURCE_CLASSIFICATION_HD_TRANSIT',				'PLAYER', 'HD_PLOT_BINARY_COMPRESS_ZIMBABWE_CIV_TRANSIT'),
	('BUILDING_TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',     'RESOURCE_CLASSIFICATION_HD_BEAST',					'PLAYER', 'HD_PLOT_BINARY_COMPRESS_ZIMBABWE_CIV_BEAST'),
	('BUILDING_TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT',     'RESOURCE_CLASSIFICATION_HD_MINTING',				'PLAYER', 'HD_PLOT_BINARY_COMPRESS_ZIMBABWE_CIV_MINTING'),
	('BUILDING_TRAIT_CIVILIZATION_IMPROVEMENT_GEDEMO_DZIMBABWE',  'RESOURCE_CLASSIFICATION_HD_TRANSIT',				'PLAYER', 'HD_PLOT_BINARY_COMPRESS_DZIMBABWE_TRANSIT'),
	('BUILDING_TRAIT_CIVILIZATION_IMPROVEMENT_GEDEMO_DZIMBABWE',  'RESOURCE_CLASSIFICATION_HD_CONSTRUCTION',	'PLAYER', 'HD_PLOT_BINARY_COMPRESS_DZIMBABWE_CONSTRUCTION'),
	('BUILDING_TRAIT_CIVILIZATION_IMPROVEMENT_GEDEMO_DZIMBABWE',  'RESOURCE_CLASSIFICATION_HD_ART',						'PLAYER', 'HD_PLOT_BINARY_COMPRESS_DZIMBABWE_ART'),
	('BUILDING_TRAIT_CIVILIZATION_IMPROVEMENT_GEDEMO_DZIMBABWE',  'RESOURCE_CLASSIFICATION_HD_CELEBRATION',		'PLAYER', 'HD_PLOT_BINARY_COMPRESS_DZIMBABWE_CELEBRATION');

insert or ignore into HD_Binary_Compress_Keys (Key, MaxExp) values
	('HD_PLOT_BINARY_COMPRESS_ZIMBABWE_CIV_TRANSIT', 		3),
	('HD_PLOT_BINARY_COMPRESS_ZIMBABWE_CIV_BEAST', 			3),
	('HD_PLOT_BINARY_COMPRESS_ZIMBABWE_CIV_MINTING', 		3),
	('HD_PLOT_BINARY_COMPRESS_DZIMBABWE_TRANSIT', 			3),
	('HD_PLOT_BINARY_COMPRESS_DZIMBABWE_CONSTRUCTION', 	4),
	('HD_PLOT_BINARY_COMPRESS_DZIMBABWE_ART', 					4),
	('HD_PLOT_BINARY_COMPRESS_DZIMBABWE_CELEBRATION', 	4);

-- UA/LA
insert or ignore into TraitModifiers (TraitType, ModifierId) values
	('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT', 	'HD_ZIMBABWE_CIV_COMMERCIAL_HUB_ATTACH'),
	('TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT', 	'HD_ZIMBABWE_CIV_INDUSTRIAL_ZONE_ATTACH'),
	('TRAIT_LEADER_GEDEMO_MUTOTA_LTRAIT', 						'HD_LTRAIT_UNITS_ABILITY');

insert or ignore into BuildingModifiers (BuildingType, ModifierId) select
	'BUILDING_TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT', 'HD_ZIMBABWE_CIV_TRADE_ROUTE_CAPACITY_' || Exp
from HD_Binary_Compress where Exp < 4;

insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) select
	'HD_ZIMBABWE_CIV_TRADE_ROUTE_CAPACITY_' || Exp, 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY', 'HD_PLOT_BINARY_COMPRESS_ZIMBABWE_CIV_TRANSIT_' || Exp || '_REQUIREMENTS'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_ZIMBABWE_CIV_TRADE_ROUTE_CAPACITY_' || Exp, 'Amount', Amount
from HD_Binary_Compress where Exp < 4;

insert or ignore into BuildingModifiers (BuildingType, ModifierId) select
	'BUILDING_TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT', 'HD_ZIMBABWE_CIV_TRADE_ROUTE_CULTURE_' || Exp
from HD_Binary_Compress where Exp < 4;

insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) select
	'HD_ZIMBABWE_CIV_TRADE_ROUTE_CULTURE_' || Exp, 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD', 'HD_PLOT_BINARY_COMPRESS_ZIMBABWE_CIV_BEAST_' || Exp || '_REQUIREMENTS'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_ZIMBABWE_CIV_TRADE_ROUTE_CULTURE_' || Exp, 'YieldType', 'YIELD_CULTURE'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_ZIMBABWE_CIV_TRADE_ROUTE_CULTURE_' || Exp, 'Amount', Amount
from HD_Binary_Compress where Exp < 4;

insert or ignore into BuildingModifiers (BuildingType, ModifierId) select
	'BUILDING_TRAIT_CIVILIZATION_GEDEMO_ZIMBABWE_CIV_TRAIT', 'HD_ZIMBABWE_CIV_TRADE_ROUTE_GOLD_' || Exp
from HD_Binary_Compress where Exp < 4;

insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) select
	'HD_ZIMBABWE_CIV_TRADE_ROUTE_GOLD_' || Exp, 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD', 'HD_PLOT_BINARY_COMPRESS_ZIMBABWE_CIV_MINTING_' || Exp || '_REQUIREMENTS'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_ZIMBABWE_CIV_TRADE_ROUTE_GOLD_' || Exp, 'YieldType', 'YIELD_GOLD'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_ZIMBABWE_CIV_TRADE_ROUTE_GOLD_' || Exp, 'Amount', Amount * 6
from HD_Binary_Compress where Exp < 4;

-- UI
update Improvements set
	PrereqTech = 'TECH_MASONRY',
	Housing = 1,
	DefenseModifier = 0,
	SameAdjacentValid = 0,
	OnePerCity = 1
where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';

delete from Improvement_YieldChanges where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';
delete from ImprovementModifiers where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';
delete from Improvement_Adjacencies where ImprovementType = 'IMPROVEMENT_GEDEMO_DZIMBABWE';

insert or replace into Improvement_ValidTerrains (ImprovementType, TerrainType) values
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_DESERT'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_GRASS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_PLAINS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_SNOW'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_TUNDRA'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_DESERT_HILLS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_GRASS_HILLS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_PLAINS_HILLS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_SNOW_HILLS'),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'TERRAIN_TUNDRA_HILLS');

insert or replace into Improvement_YieldChanges (ImprovementType, YieldType, YieldChange) values
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'YIELD_PRODUCTION',	1),
	('IMPROVEMENT_GEDEMO_DZIMBABWE',	'YIELD_CULTURE',		1);

insert or replace into Improvement_ValidBuildUnits (UnitType, ImprovementType) values
	('UNIT_ZIMBABWE_PATHFINDER', 'IMPROVEMENT_GEDEMO_DZIMBABWE');

insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) values
	('IMPROVEMENT_GEDEMO_DZIMBABWE', 'HD_DZIMBABWE_HOUSING');

insert or ignore into BuildingModifiers (BuildingType, ModifierId) select
	'BUILDING_TRAIT_CIVILIZATION_IMPROVEMENT_GEDEMO_DZIMBABWE', 'HD_DZIMBABWE_TRANSIT_GOLD_' || Exp
from HD_Binary_Compress where Exp < 4;

insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) select
	'HD_DZIMBABWE_TRANSIT_GOLD_' || Exp, 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'HD_PLOT_BINARY_COMPRESS_DZIMBABWE_TRANSIT_' || Exp || '_REQUIREMENTS', 'PLOT_HAS_IMPROVEMENT_GEDEMO_DZIMBABWE_REQUIREMENTS'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_DZIMBABWE_TRANSIT_GOLD_' || Exp, 'YieldType', 'YIELD_GOLD'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_DZIMBABWE_TRANSIT_GOLD_' || Exp, 'Amount', Amount * 3
from HD_Binary_Compress where Exp < 4;

insert or ignore into BuildingModifiers (BuildingType, ModifierId) select
	'BUILDING_TRAIT_CIVILIZATION_IMPROVEMENT_GEDEMO_DZIMBABWE', 'HD_DZIMBABWE_TRANSIT_PRODUCTION_' || Exp
from HD_Binary_Compress where Exp < 4;

insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) select
	'HD_DZIMBABWE_TRANSIT_PRODUCTION_' || Exp, 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'HD_PLOT_BINARY_COMPRESS_DZIMBABWE_CONSTRUCTION_' || Exp || '_REQUIREMENTS', 'PLOT_HAS_IMPROVEMENT_GEDEMO_DZIMBABWE_REQUIREMENTS'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_DZIMBABWE_TRANSIT_PRODUCTION_' || Exp, 'YieldType', 'YIELD_PRODUCTION'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_DZIMBABWE_TRANSIT_PRODUCTION_' || Exp, 'Amount', Amount
from HD_Binary_Compress where Exp < 4;

insert or ignore into BuildingModifiers (BuildingType, ModifierId) select
	'BUILDING_TRAIT_CIVILIZATION_IMPROVEMENT_GEDEMO_DZIMBABWE', 'HD_DZIMBABWE_TRANSIT_CULTURE_' || Exp
from HD_Binary_Compress where Exp < 4;

insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) select
	'HD_DZIMBABWE_TRANSIT_CULTURE_' || Exp, 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'HD_PLOT_BINARY_COMPRESS_DZIMBABWE_ART_' || Exp || '_REQUIREMENTS', 'PLOT_HAS_IMPROVEMENT_GEDEMO_DZIMBABWE_REQUIREMENTS'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_DZIMBABWE_TRANSIT_CULTURE_' || Exp, 'YieldType', 'YIELD_CULTURE'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_DZIMBABWE_TRANSIT_CULTURE_' || Exp, 'Amount', Amount
from HD_Binary_Compress where Exp < 4;

insert or ignore into BuildingModifiers (BuildingType, ModifierId) select
	'BUILDING_TRAIT_CIVILIZATION_IMPROVEMENT_GEDEMO_DZIMBABWE', 'HD_DZIMBABWE_TRANSIT_FAITH_' || Exp
from HD_Binary_Compress where Exp < 4;

insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) select
	'HD_DZIMBABWE_TRANSIT_FAITH_' || Exp, 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'HD_PLOT_BINARY_COMPRESS_DZIMBABWE_CELEBRATION_' || Exp || '_REQUIREMENTS', 'PLOT_HAS_IMPROVEMENT_GEDEMO_DZIMBABWE_REQUIREMENTS'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_DZIMBABWE_TRANSIT_FAITH_' || Exp, 'YieldType', 'YIELD_FAITH'
from HD_Binary_Compress where Exp < 4;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'HD_DZIMBABWE_TRANSIT_FAITH_' || Exp, 'Amount', Amount
from HD_Binary_Compress where Exp < 4;

-- Modifiers
insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) values
	('HD_DZIMBABWE_HOUSING', 												'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 	'PLOT_IS_FRESH_WATER_REQUIREMENTS',	NULL),
	('HD_ZIMBABWE_CIV_COMMERCIAL_HUB_ATTACH', 			'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 				NULL,																'DISTRICT_IS_COMMERCIAL_HUB'),
	('HD_ZIMBABWE_CIV_INDUSTRIAL_ZONE_ATTACH', 			'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 				NULL,																'DISTRICT_IS_INDUSTRIAL_ZONE'),
	('HD_ZIMBABWE_CIV_COMMERCIAL_HUB_PLOT_YIELDS', 	'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 								NULL,																'REQUIRES_PLOT_HAS_LUXURY_AND_ADJACENT_TO_OWNER'),
	('HD_ZIMBABWE_CIV_INDUSTRIAL_ZONE_PLOT_YIELDS', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 								NULL,																'REQUIRES_PLOT_HAS_LUXURY_AND_ADJACENT_TO_OWNER'),
	('HD_LTRAIT_UNITS_ABILITY', 										'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 							NULL,																NULL);

insert or ignore into ModifierArguments (ModifierId, Name, Value) values
	('HD_DZIMBABWE_HOUSING', 												'Amount', 		3),
	('HD_ZIMBABWE_CIV_COMMERCIAL_HUB_ATTACH', 			'ModifierId', 'HD_ZIMBABWE_CIV_COMMERCIAL_HUB_PLOT_YIELDS'),
	('HD_ZIMBABWE_CIV_INDUSTRIAL_ZONE_ATTACH', 			'ModifierId', 'HD_ZIMBABWE_CIV_INDUSTRIAL_ZONE_PLOT_YIELDS'),
	('HD_ZIMBABWE_CIV_COMMERCIAL_HUB_PLOT_YIELDS',	'YieldType',	'YIELD_CULTURE'),
	('HD_ZIMBABWE_CIV_COMMERCIAL_HUB_PLOT_YIELDS',	'Amount', 		1),
	('HD_ZIMBABWE_CIV_INDUSTRIAL_ZONE_PLOT_YIELDS',	'YieldType',	'YIELD_CULTURE'),
	('HD_ZIMBABWE_CIV_INDUSTRIAL_ZONE_PLOT_YIELDS',	'Amount', 		1),
	('HD_LTRAIT_UNITS_ABILITY',											'AbilityType','ABILITY_HD_LTRAIT_UNITS');

-- UU
update Units set
	Combat = 15,
	Cost = 25,
	Maintenance = 0,
	PrereqTech = NULL
where UnitType = 'UNIT_GEDEMO_ROZWI';

-- Ability
insert or ignore into Types (Type, Kind) values
	('ABILITY_HD_LTRAIT_UNITS',									'KIND_ABILITY'),
	('ABILITY_HD_ROZWI',												'KIND_ABILITY'),
	('ABILITY_HD_ROZWI_PROPERTY',								'KIND_ABILITY'),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_MOVEMENT',	'KIND_ABILITY'),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_CHARGE',		'KIND_ABILITY'),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_PROPERTY',	'KIND_ABILITY');

insert or ignore into Tags (Tag, Vocabulary) values
	('CLASS_HD_ROZWI',													'ABILITY_CLASS'),
	('CLASS_HD_ZIMBABWE_PATHFINDER',						'ABILITY_CLASS');

insert or ignore into TypeTags (Type, Tag) values
	('ABILITY_HD_LTRAIT_UNITS',									'CLASS_MILITARY'),
	('ABILITY_HD_LTRAIT_UNITS',									'CLASS_LANDCIVILIAN'),
	('UNIT_GEDEMO_ROZWI',												'CLASS_HD_ROZWI'),
	('ABILITY_HD_ROZWI',												'CLASS_HD_ROZWI'),
	('ABILITY_HD_ROZWI_PROPERTY',								'CLASS_HD_ROZWI'),
	('UNIT_ZIMBABWE_PATHFINDER',								'CLASS_HD_ZIMBABWE_PATHFINDER'),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_MOVEMENT',	'CLASS_HD_ZIMBABWE_PATHFINDER'),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_CHARGE',		'CLASS_HD_ZIMBABWE_PATHFINDER'),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_PROPERTY',	'CLASS_HD_ZIMBABWE_PATHFINDER');

insert or ignore into UnitAbilities (UnitAbilityType, Name, Description, Inactive) values
	('ABILITY_HD_LTRAIT_UNITS',
	'LOC_ABILITY_HD_LTRAIT_UNITS_NAME',
	'LOC_ABILITY_HD_LTRAIT_UNITS_DESCRIPTION',
	1),
	('ABILITY_HD_ROZWI',
	'LOC_ABILITY_HD_ROZWI_NAME',
	'LOC_ABILITY_HD_ROZWI_DESCRIPTION',
	0),
	('ABILITY_HD_ROZWI_PROPERTY',
	'LOC_ABILITY_HD_ROZWI_PROPERTY_NAME',
	'LOC_ABILITY_HD_ROZWI_PROPERTY_DESCRIPTION',
	0),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_MOVEMENT',
	'LOC_ABILITY_HD_ZIMBABWE_PATHFINDER_MOVEMENT_NAME',
	'LOC_ABILITY_HD_ZIMBABWE_PATHFINDER_MOVEMENT_DESCRIPTION',
	1),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_CHARGE',
	'LOC_ABILITY_HD_ZIMBABWE_PATHFINDER_CHARGE_NAME',
	'LOC_ABILITY_HD_ZIMBABWE_PATHFINDER_CHARGE_DESCRIPTION',
	1),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_PROPERTY',
	NULL,
	NULL,
	0);

insert or ignore into UnitAbilityModifiers (UnitAbilityType, ModifierId) values
	('ABILITY_HD_LTRAIT_UNITS',									'HD_LTRAIT_UNITS_PROPERTY'),
	('ABILITY_HD_ROZWI',												'HD_ROZWI_BARBARIAN_COMBAT'),
	('ABILITY_HD_ROZWI',												'HD_ROZWI_MOVE_AFTER_ATTACKING'),
	('ABILITY_HD_ROZWI',												'HD_ROZWI_IGNORE_HILLS'),
	('ABILITY_HD_ROZWI',												'HD_ROZWI_IGNORE_FOREST'),
	('ABILITY_HD_ROZWI',												'HD_ROZWI_SIGHT_THROUGH_FEATURES'),
	('ABILITY_HD_ROZWI_PROPERTY',								'HD_ROZWI_PROPERTY'),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_MOVEMENT',	'HD_ZIMBABWE_PATHFINDER_MOVEMENT'),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_CHARGE',		'HD_ZIMBABWE_PATHFINDER_CHARGE'),
	('ABILITY_HD_ZIMBABWE_PATHFINDER_PROPERTY',	'HD_ZIMBABWE_PATHFINDER_PROPERTY');

insert or ignore into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId, Permanent) values
	('HD_LTRAIT_UNITS_PROPERTY',								'MODIFIER_UNIT_ADJUST_PROPERTY',											NULL,		0),
	('HD_ROZWI_BARBARIAN_COMBAT',								'MODIFIER_PLAYER_UNIT_ADJUST_BARBARIAN_COMBAT',				NULL,		0),
	('HD_ROZWI_MOVE_AFTER_ATTACKING',						'MODIFIER_PLAYER_UNIT_ADJUST_ATTACK_AND_MOVE',				NULL,		0),
	('HD_ROZWI_IGNORE_HILLS',										'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_TERRAIN_COST',		NULL,		0),
	('HD_ROZWI_IGNORE_FOREST',									'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_TERRAIN_COST',		NULL,		0),
	('HD_ROZWI_SIGHT_THROUGH_FEATURES',					'MODIFIER_PLAYER_UNIT_ADJUST_SEE_THROUGH_FEATURES',		NULL,		0),
	('HD_ROZWI_PROPERTY',												'MODIFIER_UNIT_ADJUST_PROPERTY',											NULL,		0),
	('HD_ZIMBABWE_PATHFINDER_MOVEMENT',					'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT',								NULL,		0),
	('HD_ZIMBABWE_PATHFINDER_CHARGE',						'MODIFIER_UNIT_ADJUST_BUILDER_CHARGES',								NULL,		0),
	('HD_ZIMBABWE_PATHFINDER_PROPERTY',					'MODIFIER_UNIT_ADJUST_PROPERTY',											NULL,		0);

insert or ignore into ModifierArguments (ModifierId, Name, Value) values
	('HD_LTRAIT_UNITS_PROPERTY',								'Key',				'HD_LTRAIT_UNITS'),
	('HD_LTRAIT_UNITS_PROPERTY',								'Amount',			1),
	('HD_ROZWI_BARBARIAN_COMBAT',								'Amount',			7),
	('HD_ROZWI_MOVE_AFTER_ATTACKING',						'CanMove',		1),
	('HD_ROZWI_IGNORE_HILLS',										'Ignore',			1),
	('HD_ROZWI_IGNORE_HILLS',										'Type',				'HILLS'),
	('HD_ROZWI_IGNORE_FOREST',									'Ignore',			1),
	('HD_ROZWI_IGNORE_FOREST',									'Type',				'FOREST'),
	('HD_ROZWI_SIGHT_THROUGH_FEATURES',					'CanSee',			1),
	('HD_ROZWI_PROPERTY',												'Key',				'HD_UNIT_GEDEMO_ROZWI'),
	('HD_ROZWI_PROPERTY',												'Amount',			1),
	('HD_ZIMBABWE_PATHFINDER_MOVEMENT',					'Amount',			2),
	('HD_ZIMBABWE_PATHFINDER_CHARGE',						'Amount',			1),
	('HD_ZIMBABWE_PATHFINDER_PROPERTY',					'Key',				'HD_UNIT_ZIMBABWE_PATHFINDER'),
	('HD_ZIMBABWE_PATHFINDER_PROPERTY',					'Amount',			1);

-- Global Parameter
insert or replace into GlobalParameters (Name, Value) values
  ('HD_LTRAIT_UNITS_OWNED_RESOURCE_LOST_HP_MIN', 									10),
  ('HD_LTRAIT_UNITS_OWNED_RESOURCE_LOST_HP_MAX', 									50),
  ('HD_LTRAIT_UNITS_RECOVER_MOVEMENT', 					 									2),
  ('HD_UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_BASE', 				10),
  ('HD_UNIT_ZIMBABWE_PATHFINDER_STRATEGIC_RESOURCE_ADD_PER_TIME', 10);