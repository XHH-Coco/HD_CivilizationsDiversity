-- Traits
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_GREAT_TURKISH_BOMBARD' and
	ModifierId in ('TRAIT_SIEGE_PRODUCTION', 'TRAIT_CAPTURED_LOYALTY');
delete from TraitModifiers where TraitType = 'TRAIT_LEADER_SULEIMAN_GOVERNOR';
update Modifiers set SubjectRequirementSetId = null, SubjectStackLimit = 1 where ModifierId = 'SULEIMAN_GOVERNOR_POINTS';
insert or replace into TraitModifiers
	(TraitType,										ModifierId)
values
	('TRAIT_CIVILIZATION_GREAT_TURKISH_BOMBARD',	'GREAT_TURKISH_BOMBARD_CAPTURED_CITY_GOLD'),
	('TRAIT_CIVILIZATION_GREAT_TURKISH_BOMBARD',	'GREAT_TURKISH_BOMBARD_CAPTURED_CITY_DISTRICT_PRODUCITON'),
	('TRAIT_CIVILIZATION_GREAT_TURKISH_BOMBARD',	'GREAT_TURKISH_BOMBARD_CAPTURED_CITY_BUILDING_PRODUCITON');
insert or replace into Modifiers
	(ModifierId,															ModifierType,														SubjectRequirementSetId)
values
	('GREAT_TURKISH_BOMBARD_CAPTURED_CITY_GOLD',							'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',				'CITY_WAS_NOT_FOUNDED'),
	('GREAT_TURKISH_BOMBARD_CAPTURED_CITY_DISTRICT_PRODUCITON',				'MODIFIER_PLAYER_CITIES_ADJUST_ALL_DISTRICTS_PRODUCTION',			'CITY_WAS_NOT_FOUNDED'),
	('GREAT_TURKISH_BOMBARD_CAPTURED_CITY_BUILDING_PRODUCITON',				'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION_MODIFIER',	'CITY_WAS_NOT_FOUNDED');
insert or replace into ModifierArguments
	(ModifierId,															Name,			Value)
values
	('GREAT_TURKISH_BOMBARD_CAPTURED_CITY_GOLD',							'YieldType',	'YIELD_GOLD'),
	('GREAT_TURKISH_BOMBARD_CAPTURED_CITY_GOLD',							'Amount',		20),
	('GREAT_TURKISH_BOMBARD_CAPTURED_CITY_DISTRICT_PRODUCITON',				'Amount',		40),
	('GREAT_TURKISH_BOMBARD_CAPTURED_CITY_BUILDING_PRODUCITON',				'Amount',		40),
	('GREAT_TURKISH_BOMBARD_CAPTURED_CITY_BUILDING_PRODUCITON',				'IsWonder',		0);
insert or replace into TraitModifiers
	(TraitType,										ModifierId)
select
	'TRAIT_LEADER_SULEIMAN_GOVERNOR',				'GREAT_TURKISH_BOMBARD_' || UnitType || '_PRODUCTION'
from Units where CanTrain = 1;
insert or replace into Modifiers
	(ModifierId,												ModifierType)
select
	'GREAT_TURKISH_BOMBARD_' || UnitType || '_PRODUCTION',		'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_PRODUCTION'
from Units where CanTrain = 1;
insert or replace into ModifierArguments
	(ModifierId,												Name,			Value)
select
	'GREAT_TURKISH_BOMBARD_' || UnitType || '_PRODUCTION',		'UnitType',		UnitType
from Units where CanTrain = 1;
insert or replace into ModifierArguments
	(ModifierId,												Name,			Value)
select
	'GREAT_TURKISH_BOMBARD_' || UnitType || '_PRODUCTION',		'Amount',		20
from Units where CanTrain = 1;
-- Unique Governor
-- order
update GovernorPromotions set Column = 0 where GovernorPromotionType = 'GOVERNOR_PROMOTION_GRAND_VISIER';
update GovernorPromotions set Level = 2, Column = 2 where GovernorPromotionType = 'GOVERNOR_PROMOTION_KHASS_ODA_BASHI';
update GovernorPromotions set Column = 1 where GovernorPromotionType = 'GOVERNOR_PROMOTION_CAPOU_AGHA';
delete from GovernorPromotionPrereqs where GovernorPromotionType = 'GOVERNOR_PROMOTION_KHASS_ODA_BASHI'
	or (GovernorPromotionType = 'GOVERNOR_PROMOTION_GRAND_VISIER' and PrereqGovernorPromotion = 'GOVERNOR_PROMOTION_SERASKER');
insert or replace into GovernorPromotionPrereqs
	(GovernorPromotionType,						PrereqGovernorPromotion)
values
	('GOVERNOR_PROMOTION_KHASS_ODA_BASHI',		'GOVERNOR_PROMOTION_SERASKER'),
	('GOVERNOR_PROMOTION_KHASS_ODA_BASHI',		'GOVERNOR_PROMOTION_GRAND_VISIER'),
	('GOVERNOR_PROMOTION_GRAND_VISIER',			'GOVERNOR_PROMOTION_KHASS_ODA_BASHI'),
	('GOVERNOR_PROMOTION_CAPOU_AGHA',			'GOVERNOR_PROMOTION_KHASS_ODA_BASHI');
-- content
delete from GovernorPromotionModifiers where GovernorPromotionType = 'GOVERNOR_PROMOTION_SERASKER' or GovernorPromotionType = 'GOVERNOR_PROMOTION_KHASS_ODA_BASHI' or GovernorPromotionType = 'GOVERNOR_PROMOTION_GRAND_VISIER'
	or (GovernorPromotionType = 'GOVERNOR_PROMOTION_CAPOU_AGHA' and ModifierId = 'PASHA_BONUS_UNIT_PRODUCTION');
update ModifierArguments set Value = 50 where ModifierId = 'HEAD_FALCONER_ENCAMPMENT_BUILDINGS_PRODUCTION_MODIFIER' and Name = 'Amount';
insert or replace into GovernorPromotionModifiers
	(GovernorPromotionType,						ModifierId)
values
	('GOVERNOR_PROMOTION_PASHA',				'PASHA_UNIT_TRAIN_GRANT_SCIENCE_LATE'),
	('GOVERNOR_PROMOTION_HEAD_FALCONER',		'SERASKER_ADJUST_GOVERNOR_COMBAT_DISTRICT'),
	('GOVERNOR_PROMOTION_SERASKER',				'SERASKER_ENCAMPMENT_ADJACENCY'),
	('GOVERNOR_PROMOTION_SERASKER',				'SERASKER_COMMERCIAL_ADJACENCY'),
	('GOVERNOR_PROMOTION_SERASKER',				'SERASKER_ENCAMPMENT_SCIENCE'),
	('GOVERNOR_PROMOTION_SERASKER',				'SERASKER_COMMERCIAL_SCIENCE'),
	('GOVERNOR_PROMOTION_SERASKER',				'SERASKER_COMMERCIAL_SCIENCE'),
	('GOVERNOR_PROMOTION_GRAND_VISIER',			'GRAND_VISIER_COMBAT_ATTACH'),
	('GOVERNOR_PROMOTION_KHASS_ODA_BASHI',		'KHASS_ODA_BASHI_GOLD_ATTACH'),
	('GOVERNOR_PROMOTION_KHASS_ODA_BASHI',		'KHASS_ODA_BASHI_MERCHANT_ATTACH'),
	('GOVERNOR_PROMOTION_KHASS_ODA_BASHI',		'KHASS_ODA_BASHI_COMMERCIAL_PRODUCTION'),
	('GOVERNOR_PROMOTION_KHASS_ODA_BASHI',		'KHASS_ODA_BASHI_HARBOR_PRODUCTION');
insert or replace into Modifiers
	(ModifierId,									ModifierType,																SubjectRequirementSetId)
values
	('PASHA_UNIT_TRAIN_GRANT_SCIENCE_LATE',			'MODIFIER_SINGLE_CITY_GRANT_YIELD_PER_UNIT_COST',							'CITY_HAS_DISTRICT_ENCAMPMENT_TIER_2_BUILDING_REQUIREMENTS'),
	('SERASKER_ENCAMPMENT_ADJACENCY',				'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_MODIFIER',							'DISTRICT_IS_DISTRICT_ENCAMPMENT_REQUIREMENTS'),
	('SERASKER_COMMERCIAL_ADJACENCY',				'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_MODIFIER',							'DISTRICT_IS_DISTRICT_COMMERCIAL_HUB_REQUIREMENTS'),
	('SERASKER_ENCAMPMENT_SCIENCE',					'MODIFIER_SINGLE_CITY_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',		'DISTRICT_IS_DISTRICT_ENCAMPMENT_REQUIREMENTS'),
	('SERASKER_COMMERCIAL_SCIENCE',					'MODIFIER_SINGLE_CITY_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',		'DISTRICT_IS_DISTRICT_COMMERCIAL_HUB_REQUIREMENTS'),
	('GRAND_VISIER_COMBAT_ATTACH',					'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER',									null),
	('GRAND_VISIER_COMBAT',							'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',										null),
	('KHASS_ODA_BASHI_GOLD_ATTACH',					'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER',									'TRADER_WITHIN_FIVE_PLOTS'),
	('KHASS_ODA_BASHI_GOLD',						'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',							'CITY_HAS_KHASS_ODA_BASHI'),
	('KHASS_ODA_BASHI_MERCHANT_ATTACH',				'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER',									'TRADER_WITHIN_FIVE_PLOTS'),
	('KHASS_ODA_BASHI_MERCHANT',					'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT_BASE',					'CITY_HAS_KHASS_ODA_BASHI'),
	('KHASS_ODA_BASHI_COMMERCIAL_PRODUCTION',		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',							'CITY_HAS_DISTRICT_COMMERCIAL_HUB_REQUIREMENTS'),
	('KHASS_ODA_BASHI_HARBOR_PRODUCTION',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',							'CITY_HAS_DISTRICT_HARBOR_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,									Name,						Value)
values
	('PASHA_UNIT_TRAIN_GRANT_SCIENCE_LATE',			'YieldType',				'YIELD_SCIENCE'),
	('PASHA_UNIT_TRAIN_GRANT_SCIENCE_LATE',			'UnitProductionPercent',	25),
	('SERASKER_ENCAMPMENT_ADJACENCY',				'YieldType',				'YIELD_PRODUCTION'),
	('SERASKER_ENCAMPMENT_ADJACENCY',				'Amount',					100),
	('SERASKER_COMMERCIAL_ADJACENCY',				'YieldType',				'YIELD_GOLD'),
	('SERASKER_COMMERCIAL_ADJACENCY',				'Amount',					100),
	('SERASKER_ENCAMPMENT_SCIENCE',					'YieldTypeToMirror',		'YIELD_PRODUCTION'),
	('SERASKER_ENCAMPMENT_SCIENCE',					'YieldTypeToGrant',			'YIELD_SCIENCE'),
	('SERASKER_COMMERCIAL_SCIENCE',					'YieldTypeToMirror',		'YIELD_GOLD'),
	('SERASKER_COMMERCIAL_SCIENCE',					'YieldTypeToGrant',			'YIELD_SCIENCE'),
	('GRAND_VISIER_COMBAT_ATTACH',					'ModifierId',				'GRAND_VISIER_COMBAT'),
	('GRAND_VISIER_COMBAT',							'Amount',					5),
	('KHASS_ODA_BASHI_GOLD_ATTACH',					'ModifierId',				'KHASS_ODA_BASHI_GOLD'),
	('KHASS_ODA_BASHI_GOLD',						'YieldType',				'YIELD_GOLD'),
	('KHASS_ODA_BASHI_GOLD',						'Amount',					10),
	('KHASS_ODA_BASHI_MERCHANT_ATTACH',				'ModifierId',				'KHASS_ODA_BASHI_MERCHANT'),
	('KHASS_ODA_BASHI_MERCHANT',					'GreatPersonClassType',		'GREAT_PERSON_CLASS_MERCHANT'),
	('KHASS_ODA_BASHI_MERCHANT',					'Amount',					3),
	('KHASS_ODA_BASHI_COMMERCIAL_PRODUCTION',		'YieldType',				'YIELD_PRODUCTION'),
	('KHASS_ODA_BASHI_COMMERCIAL_PRODUCTION',		'Amount',					10),
	('KHASS_ODA_BASHI_HARBOR_PRODUCTION',			'YieldType',				'YIELD_PRODUCTION'),
	('KHASS_ODA_BASHI_HARBOR_PRODUCTION',			'Amount',					10);
insert or replace into ModifierStrings
	(ModifierId,									Context,		Text)
values
	('GRAND_VISIER_COMBAT',							'Preview',		'LOC_GRAND_VISIER_COMBAT');
insert or replace into GovernorPromotionModifiers
	(GovernorPromotionType,						ModifierId)
select
	'GOVERNOR_PROMOTION_KHASS_ODA_BASHI',		'KHASS_ODA_BASHI_' || BuildingType || '_REQUIREMENTS'
from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_COMMERCIAL_HUB' or PrereqDistrict = 'DISTRICT_HARBOR';
insert or replace into Modifiers
	(ModifierId,												ModifierType,											SubjectRequirementSetId)
select
	'KHASS_ODA_BASHI_' || BuildingType || '_REQUIREMENTS',		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',		'CITY_HAS_' || BuildingType || '_REQUIREMENTS'
from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_COMMERCIAL_HUB' or PrereqDistrict = 'DISTRICT_HARBOR';
insert or replace into ModifierArguments
	(ModifierId,												Name,			Value)
select
	'KHASS_ODA_BASHI_' || BuildingType || '_REQUIREMENTS',		'YieldType',	'YIELD_PRODUCTION'
from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_COMMERCIAL_HUB' or PrereqDistrict = 'DISTRICT_HARBOR';
insert or replace into ModifierArguments
	(ModifierId,												Name,			Value)
select
	'KHASS_ODA_BASHI_' || BuildingType || '_REQUIREMENTS',		'Amount',		10
from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_COMMERCIAL_HUB' or PrereqDistrict = 'DISTRICT_HARBOR';
insert or replace into TypeTags
	(Type,			Tag)
select
	UnitType,		'CLASS_CAPOU_EXTRA'
from Units where (PromotionClass = 'PROMOTION_CLASS_MELEE' or PromotionClass = 'PROMOTION_CLASS_SIEGE')
	and (PrereqTech in (select TechnologyType from Technologies where EraType = 'ERA_MEDIEVAL') or PrereqCivic in (select CivicType from Civics where EraType = 'ERA_MEDIEVAL'));
insert or ignore into RequirementSets
	(RequirementSetId,							RequirementSetType)
values
	('TRADER_WITHIN_FIVE_PLOTS',				'REQUIREMENTSET_TEST_ALL'),
	('CITY_HAS_KHASS_ODA_BASHI',				'REQUIREMENTSET_TEST_ALL');
insert or ignore into RequirementSetRequirements
	(RequirementSetId,							RequirementId)
values
	('TRADER_WITHIN_FIVE_PLOTS',				'REQUIRES_OBJECT_WITHIN_5_TILES'),
	('TRADER_WITHIN_FIVE_PLOTS',				'REQUIRES_UNIT_IS_UNIT_TRADER'),
	('CITY_HAS_KHASS_ODA_BASHI',				'REQUIRES_CITY_HAS_KHASS_ODA_BASHI');
insert or ignore into Requirements
	(RequirementId,								RequirementType)
values
	('REQUIRES_CITY_HAS_KHASS_ODA_BASHI',		'REQUIREMENT_CITY_HAS_SPECIFIC_GOVERNOR_PROMOTION_TYPE');
insert or ignore into RequirementArguments
	(RequirementId,								Name,						Value)
values
	('REQUIRES_CITY_HAS_KHASS_ODA_BASHI',		'GovernorPromotionType',	'GOVERNOR_PROMOTION_KHASS_ODA_BASHI');