-- Unique Unit
update Units set Combat = 56, Cost = 130, Maintenance = 3, StrategicResource = null where UnitType = 'UNIT_SUK_SIAM_CHANGSUEK';
update Units_XP2 set ResourceCost = 0, ResourceMaintenanceType = 'RESOURCE_IRON', ResourceMaintenanceAmount = 1 where UnitType = 'UNIT_SUK_SIAM_CHANGSUEK';
-- New Unique Unit
insert or replace into Types
	(Type,																										Kind)
values
	('TRAIT_CIVILIZATION_UNIT_SIAMESE_EXPEDITIONARY_FORCES',	'KIND_TRAIT'),
	('UNIT_SIAMESE_EXPEDITIONARY_FORCES',											'KIND_UNIT'),
	('ABILITY_UNIT_SIAMESE_EXPEDITIONARY_FORCES_IGNORE_RIVER','KIND_ABILITY');

insert or replace into Traits (TraitType) values ('TRAIT_CIVILIZATION_UNIT_SIAMESE_EXPEDITIONARY_FORCES');
insert or replace into CivilizationTraits (CivilizationType, TraitType) values ('CIVILIZATION_SUK_SIAM', 'TRAIT_CIVILIZATION_UNIT_SIAMESE_EXPEDITIONARY_FORCES');

insert or replace into TypeTags
	(Type,									Tag)
select
	'UNIT_SIAMESE_EXPEDITIONARY_FORCES',	Tag
from TypeTags where Type = 'UNIT_INFANTRY';

insert or replace into UnitAiInfos
	(UnitType,								AiType)
select
	'UNIT_SIAMESE_EXPEDITIONARY_FORCES',	AiType
from UnitAiInfos where UnitType = 'UNIT_INFANTRY';

insert or replace into Units
	(UnitType,								Name,											BaseSightRange,	BaseMoves,	Combat,	Domain,			FormationClass,					Cost,	StrategicResource,	Description,											CanCapture,	PromotionClass,				PrereqTech,					CanTrain,	PurchaseYield,	Maintenance,	ZoneOfControl,	AdvisorType,		TraitType)
values
	('UNIT_SIAMESE_EXPEDITIONARY_FORCES',	'LOC_UNIT_SIAMESE_EXPEDITIONARY_FORCES_NAME',	2,				3,			75,		'DOMAIN_LAND',	'FORMATION_CLASS_LAND_COMBAT',	200,	'RESOURCE_NITER',	'LOC_UNIT_SIAMESE_EXPEDITIONARY_FORCES_DESCRIPTION',	1,			'PROMOTION_CLASS_MELEE',	'TECH_REPLACEABLE_PARTS',	1,			'YIELD_GOLD',	6,				1,				'ADVISOR_CONQUEST',	'TRAIT_CIVILIZATION_UNIT_SIAMESE_EXPEDITIONARY_FORCES');

insert or replace into Units_XP2
	(UnitType,								ResourceCost,	ResourceMaintenanceType,	ResourceMaintenanceAmount)
values
	('UNIT_SIAMESE_EXPEDITIONARY_FORCES',	5,				'RESOURCE_NITER',			1);

insert or replace into UnitReplaces
	(CivUniqueUnitType,						ReplacesUnitType)
values
	('UNIT_SIAMESE_EXPEDITIONARY_FORCES',	'UNIT_INFANTRY');

insert or replace into UnitUpgrades
	(Unit,									UpgradeUnit)
values
	('UNIT_SIAMESE_EXPEDITIONARY_FORCES',	'UNIT_MECHANIZED_INFANTRY');

-- UU 能力
insert or replace into Tags (Tag, Vocabulary) values
	('CLASS_SIAMESE_EXPEDITIONARY_FORCES', 'ABILITY_CLASS');

insert or replace into TypeTags (Type, Tag) values
	('UNIT_SIAMESE_EXPEDITIONARY_FORCES', 										 'CLASS_SIAMESE_EXPEDITIONARY_FORCES'),
	('ABILITY_UNIT_SIAMESE_EXPEDITIONARY_FORCES_IGNORE_RIVER', 'CLASS_SIAMESE_EXPEDITIONARY_FORCES');

insert or replace into UnitAbilities (UnitAbilityType, Name, Description, Inactive) values
	('ABILITY_UNIT_SIAMESE_EXPEDITIONARY_FORCES_IGNORE_RIVER',
	'LOC_ABILITY_UNIT_SIAMESE_EXPEDITIONARY_FORCES_IGNORE_RIVER_NAME',
	'LOC_ABILITY_UNIT_SIAMESE_EXPEDITIONARY_FORCES_IGNORE_RIVER_DESCRIPTION',
	0);

insert or replace into UnitAbilityModifiers (UnitAbilityType, ModifierId) values
	('ABILITY_UNIT_SIAMESE_EXPEDITIONARY_FORCES_IGNORE_RIVER', 'TRAIT_UNIT_SIAMESE_EXPEDITIONARY_FORCES_IGNORE_RIVER');

-- UD 水上市场
update Districts set TravelTime = 2 where DistrictType = 'DISTRICT_SUK_FLOATINGMARKET';
insert or replace into Adjacency_YieldChanges
	(ID,																		Description,																YieldType,					YieldChange,	AdjacentDistrict, 							PrereqTech,				AdjacentRiver)
values
	('Plantation_Floatingmarkert_Gold', 		'Placeholder',															'YIELD_GOLD',				3,						'DISTRICT_SUK_FLOATINGMARKET',	'TECH_CURRENCY',	0),
	('Pasture_Floatingmarkert_Gold', 				'Placeholder',															'YIELD_GOLD',				3,						'DISTRICT_SUK_FLOATINGMARKET',	'TECH_CURRENCY',	0),
	('Camp_Floatingmarkert_Gold', 					'Placeholder',															'YIELD_GOLD',				3,						'DISTRICT_SUK_FLOATINGMARKET',	'TECH_CURRENCY',	0);

insert or replace into Improvement_Adjacencies
	(ImprovementType,						YieldChangeId)
values
	('IMPROVEMENT_CAMP',				'Camp_Floatingmarkert_Gold'),
	('IMPROVEMENT_PLANTATION',	'Plantation_Floatingmarkert_Gold'),
	('IMPROVEMENT_PASTURE',			'Pasture_Floatingmarkert_Gold');

delete from DistrictModifiers where DistrictType = 'DISTRICT_SUK_FLOATINGMARKET' and ModifierId in (
	'SUK_FLOATINGMARKET_LUXURY_GOLD_MODIFIER',
	'SUK_FLOATINGMARKET_LUXURY_GOLD_FLOODPLAINS_MODIFIER',
	'SUK_FLOATINGMARKET_LUXURY_CULTURE_MODIFIER'
);
insert or replace into DistrictModifiers
	(DistrictType,									ModifierId)
values
	('DISTRICT_SUK_FLOATINGMARKET',	'HD_SUK_FLOATINGMARKET_RESOURCE_GOLD'),
	('DISTRICT_SUK_FLOATINGMARKET',	'HD_SUK_FLOATINGMARKET_RIVER_DISTRICT_FOOD'),
	('DISTRICT_SUK_FLOATINGMARKET',	'HD_SUK_FLOATINGMARKET_RIVER_DISTRICT_PRODUCTION');

-- UA
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_SUK_SRI_AYUTTHAYA' and ModifierId = 'SRI_AYUTTHAYA_RIVER_FOOD';
update ModifierArguments set Value = 1 where ModifierId = 'SUK_SRI_AYUTTHAYA_RIVER_HOUSING' and Name = 'Amount';
insert or replace into TraitModifiers
	(TraitType,																ModifierId)
values
	('TRAIT_CIVILIZATION_SUK_SRI_AYUTTHAYA',	'HD_SRI_AYUTTHAYA_RIVER_FARM_CULTURE');

insert or replace into Modifiers
	(ModifierId,																							ModifierType,																		SubjectRequirementSetId)
values
	('TRAIT_UNIT_SIAMESE_EXPEDITIONARY_FORCES_IGNORE_RIVER',	'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_RIVERS',		NULL),
	('HD_SRI_AYUTTHAYA_RIVER_FARM_CULTURE',										'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',						'HD_PLOT_IS_FARM_ADJACENT_TO_RIVER_REQUIREMENTS'),
	('HD_SUK_FLOATINGMARKET_RESOURCE_GOLD',										'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'HD_PLOT_HAS_RESOURCE_REQUIREMENTS');

insert or replace into Modifiers
	(ModifierId,																							ModifierType,																		OwnerRequirementSetId,									SubjectRequirementSetId)
values
	('HD_SUK_FLOATINGMARKET_RIVER_DISTRICT_FOOD',							'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',	'PLOT_ADJACENT_TO_RIVER_REQUIREMENTS',	'PLOT_IS_DISTRICT_ADJACENT_TO_RIVER_REQUIREMENTS'),
	('HD_SUK_FLOATINGMARKET_RIVER_DISTRICT_PRODUCTION',				'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',	'PLOT_ADJACENT_TO_RIVER_REQUIREMENTS',	'PLOT_IS_DISTRICT_ADJACENT_TO_RIVER_REQUIREMENTS');

insert or replace into ModifierArguments
	(ModifierId,																							Name,					Value)
values
	('TRAIT_UNIT_SIAMESE_EXPEDITIONARY_FORCES_IGNORE_RIVER',	'Ignore',			1),
	('HD_SRI_AYUTTHAYA_RIVER_FARM_CULTURE',										'YieldType',	'YIELD_CULTURE'),
	('HD_SRI_AYUTTHAYA_RIVER_FARM_CULTURE',										'Amount',			1),
	('HD_SUK_FLOATINGMARKET_RESOURCE_GOLD',										'YieldType',	'YIELD_GOLD'),
	('HD_SUK_FLOATINGMARKET_RESOURCE_GOLD',										'Amount',			3),
	('HD_SUK_FLOATINGMARKET_RIVER_DISTRICT_FOOD',							'YieldType',	'YIELD_FOOD'),
	('HD_SUK_FLOATINGMARKET_RIVER_DISTRICT_FOOD',							'Amount',			1),
	('HD_SUK_FLOATINGMARKET_RIVER_DISTRICT_PRODUCTION',				'YieldType',	'YIELD_PRODUCTION'),
	('HD_SUK_FLOATINGMARKET_RIVER_DISTRICT_PRODUCTION',				'Amount',			1);

-- 字母泰金币系数
insert or replace into GlobalParameters (Name, Value) values
  ('HD_THE_THAI_ALPHABET_GOLD_PERCENTAGE',		75);