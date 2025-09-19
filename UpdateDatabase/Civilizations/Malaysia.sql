-- Start Bias
delete from StartBiasFeatures where CivilizationType = 'CIVILIZATION_CVS_MALAYSIA';
delete from StartBiasResources where CivilizationType = 'CIVILIZATION_CVS_MALAYSIA';
-- Unique Ability
delete from TraitModifiers where TraitType = 'MINOR_CIV_DEFAULT_TRAIT' and ModifierId = 'MODIFIER_CVS_MALAYSIA_UA_TRADE_CAPACITY_ATTACH';
insert or ignore into TraitModifiers
	(TraitType,									ModifierId)
values
	('TRAIT_CIVILIZATION_CVS_MALAYSIA_UA',		'TRAIT_MALAYSIA_COAST_COMMERCIAL_HUB');
insert or ignore into Modifiers
	(ModifierId,								ModifierType)
values
	('TRAIT_MALAYSIA_COAST_COMMERCIAL_HUB',		'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY'),
	('TRAIT_MALAYSIA_INFLUENCE_TOKEN',			'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN');
insert or ignore into ModifierArguments
	(ModifierId,								Name,				Value)
values
	('TRAIT_MALAYSIA_COAST_COMMERCIAL_HUB',		'DistrictType',		'DISTRICT_COMMERCIAL_HUB'),
	('TRAIT_MALAYSIA_COAST_COMMERCIAL_HUB',		'TerrainType',		'TERRAIN_COAST'),
	('TRAIT_MALAYSIA_COAST_COMMERCIAL_HUB',		'YieldType',		'YIELD_GOLD'),
	('TRAIT_MALAYSIA_COAST_COMMERCIAL_HUB',		'Amount',			1),
	('TRAIT_MALAYSIA_COAST_COMMERCIAL_HUB',		'TilesRequired',	1),
	('TRAIT_MALAYSIA_COAST_COMMERCIAL_HUB',		'Description',		'LOC_DISTRICT_COMMERCIAL_HUB_GOLD'),
	('TRAIT_MALAYSIA_INFLUENCE_TOKEN',			'Amount',			1);
-- Unique District
update Districts set cost = 60 where DistrictType = 'DISTRICT_CVS_MALAYSIA_UI';
delete from ImprovementModifiers where ModifierId = 'MODIFIER_CVS_MALAYSIA_UA_TRADE_CULTURE' or ModifierId = 'MODIFIER_CVS_MALAYSIA_UA_TRADE_GOLD';
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_MALAYSIA_UI' and (ModifierId = 'MODIFIER_CVS_MALAYSIA_UI_CULTURE_ATTACH' or ModifierId = 'MODIFIER_CVS_MALAYSIA_UI_TRADING_POST');
insert or ignore into TraitModifiers
	(TraitType,								ModifierId)
values
	('TRAIT_CIVILIZATION_MALAYSIA_UI',		'MALAYSIA_UI_BONUS_GOLD_ATTACH');
insert or ignore into Modifiers
	(ModifierId,						ModifierType,														SubjectRequirementSetId)
values
	('MALAYSIA_UI_BONUS_GOLD_ATTACH',	'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',						'MALAYSIA_UI_REQUIREMENTS'),
	('MALAYSIA_UI_BONUS_GOLD',			'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL',	NULL);
insert or ignore into ModifierArguments
	(ModifierId,						Name,				Value)
values
	('MALAYSIA_UI_BONUS_GOLD_ATTACH',	'ModifierId',		'MALAYSIA_UI_BONUS_GOLD'),
	('MALAYSIA_UI_BONUS_GOLD',			'YieldType',		'YIELD_GOLD'),
	('MALAYSIA_UI_BONUS_GOLD',			'Amount',			1);
insert or ignore into District_CitizenGreatPersonPoints
	(DistrictType,						GreatPersonClassType,			PointsPerTurn)
values
	('DISTRICT_CVS_MALAYSIA_UI',		'GREAT_PERSON_CLASS_MERCHANT',	1);
insert or ignore into Adjacency_YieldChanges
	(ID,								Description,		YieldType,		YieldChange,	TilesRequired,			AdjacentDistrict)
values
	('Fishing_Boats_Malaysia_Gold',		'Placeholder',		'YIELD_GOLD',	2,				1,						'DISTRICT_CVS_MALAYSIA_UI');
	insert or ignore into Improvement_Adjacencies
	(ImprovementType,					YieldChangeId)
values
	('IMPROVEMENT_FISHING_BOATS',		'Fishing_Boats_Malaysia_Gold');
insert or ignore into District_Adjacencies
	(DistrictType,						YieldChangeId)
select
	'DISTRICT_CVS_MALAYSIA_UI',			'HD_INDUSTRY_HARBOR_GOLD'
where exists (select ImprovementType from Improvements where ImprovementType = 'IMPROVEMENT_INDUSTRY');
insert or ignore into District_Adjacencies
	(DistrictType,						YieldChangeId)
select
	'DISTRICT_CVS_MALAYSIA_UI',			'HD_CORPORATION_HARBOR_GOLD'
where exists (select ImprovementType from Improvements where ImprovementType = 'IMPROVEMENT_CORPORATION');
insert or ignore into RequirementSets
	(RequirementSetId,					RequirementSetType)
values
	('MALAYSIA_UI_REQUIREMENTS',		'REQUIREMENTSET_TEST_ALL');
insert or ignore into RequirementSetRequirements
    (RequirementSetId,					RequirementId)
values
	('MALAYSIA_UI_REQUIREMENTS',		'REQ_CVS_MALAYSIA_UI_CITY_HAS_DERMAGA'),
	('MALAYSIA_UI_REQUIREMENTS',		'REQUIRES_PLOT_HAS_IMPROVEMENT_FISHING_BOATS');
-- Unique Unit
update Units set Combat = 58 where UnitType = 'UNIT_CVS_MALAYSIA_UU';
update ModifierArguments set value = 20 where ModifierId = 'MODIFIER_CVS_MALAYSIA_UU_KILL_GPP' and Name = 'Amount';