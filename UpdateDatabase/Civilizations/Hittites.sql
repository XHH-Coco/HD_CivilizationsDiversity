-- Rename type to disable lua script
update Types set Type = 'TRAIT_CIVILIZATION_MER_SUN_AND_STORM_HD' where Type = 'TRAIT_CIVILIZATION_MER_SUN_AND_STORM';
-- Start Bias
delete from StartBiasTerrains where CivilizationType = 'CIVILIZATION_MER_HITTITES';
insert or replace into StartBiasResources
	(CivilizationType,				ResourceType,		Tier)
values
	('CIVILIZATION_MER_HITTITES',	'RESOURCE_IRON',	1),
	('CIVILIZATION_MER_HITTITES',	'RESOURCE_HORSES',	4);
-- Traits
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_MER_SUN_AND_STORM_HD' or TraitType = 'TRAIT_LEADER_MER_BOND_AND_OATH';
insert or replace into TraitModifiers
	(TraitType,										Modifierid)
values
	('TRAIT_CIVILIZATION_MER_SUN_AND_STORM_HD',		'HITTITES_REVEAL_IRON'),
	('TRAIT_CIVILIZATION_MER_SUN_AND_STORM_HD',		'HITTITES_IRON_PRODUCITON'),
	('TRAIT_CIVILIZATION_MER_SUN_AND_STORM_HD',		'HITTITES_IRON_SCIENCE'),
	('TRAIT_CIVILIZATION_MER_SUN_AND_STORM_HD',		'HITTITES_IRON_DISTRICT_SCIENCE_ATTACH'),
	('TRAIT_LEADER_MER_BOND_AND_OATH',				'MODIFIER_MER_SUN_AND_STORM_SCIENCE'),
	('TRAIT_LEADER_MER_BOND_AND_OATH',				'MODIFIER_MER_SUN_AND_STORM_BUILDINGS'),
	('TRAIT_LEADER_MER_BOND_AND_OATH',				'MODIFIER_MER_SUN_AND_STORM_DISTRICTS'),
	('TRAIT_LEADER_MER_BOND_AND_OATH',				'MODIFIER_MER_SUN_AND_STORM_MILITARY'),
	('TRAIT_LEADER_MER_BOND_AND_OATH',				'MODIFIER_MER_SUN_AND_STORM_TRADE'),
	('TRAIT_LEADER_MER_BOND_AND_OATH',				'MODIFIER_MER_SUN_AND_STORM_RELIGION'),
	('TRAIT_LEADER_MER_BOND_AND_OATH',				'MODIFIER_MER_SUN_AND_STORM_CULTURE'),
	('TRAIT_LEADER_MER_BOND_AND_OATH',				'MODIFIER_MER_SUN_AND_STORM_ALLIANCE_FAVOR'),
	('TRAIT_LEADER_MER_BOND_AND_OATH',				'MODIFIER_MER_SUN_AND_STORM_SUZERAIN_FAVOR');
insert or replace into Modifiers
	(ModifierId,										ModifierType,															SubjectRequirementSetId)
values
	('HITTITES_REVEAL_IRON',							'MODIFIER_PLAYER_GRANT_FREE_RESOURCE_VISIBILITY',						null),
	('HITTITES_IRON_PRODUCITON',						'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',									'HAS_IMPROVED_IRON'),
	('HITTITES_IRON_SCIENCE',							'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',									'HAS_IMPROVED_IRON'),
	('HITTITES_STRATEGIC_DISTRICT_PRODUCTION_ATTACH',	'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',							'HD_PLOT_HAS_STRATEGIC_RESOURCE_REQUIREMENTS'),
	('HITTITES_STRATEGIC_DISTRICT_PRODUCTION',			'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',							'HD_DISTRICTS_IS_NOT_WONDERS_OR_CITY_CENTER_REQUIREMENTS'),
	('HITTITES_IRON_DISTRICT_SCIENCE_ATTACH',			'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',							'RESOURCE_IRON_IN_PLOT_REQUIREMENTS'),
	('HITTITES_IRON_DISTRICT_SCIENCE',					'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',							'HD_DISTRICTS_IS_NOT_WONDERS_OR_CITY_CENTER_REQUIREMENTS');
update Modifiers set SubjectStackLimit = 1 where ModifierId = 'HITTITES_IRON_DISTRICT_SCIENCE_ATTACH';
insert or replace into ModifierArguments
	(ModifierId,										Name,				Value)
values
	('HITTITES_REVEAL_IRON',							'ResourceType',		'RESOURCE_IRON'),
	('HITTITES_IRON_PRODUCITON',						'YieldType',		'YIELD_PRODUCTION'),
	('HITTITES_IRON_PRODUCITON',						'Amount',			1),
	('HITTITES_IRON_SCIENCE',							'YieldType',		'YIELD_SCIENCE'),
	('HITTITES_IRON_SCIENCE',							'Amount',			1),
	('HITTITES_STRATEGIC_DISTRICT_PRODUCTION_ATTACH',	'ModifierId',		'HITTITES_STRATEGIC_DISTRICT_PRODUCTION'),
	('HITTITES_STRATEGIC_DISTRICT_PRODUCTION',			'YieldType',		'YIELD_PRODUCTION'),
	('HITTITES_STRATEGIC_DISTRICT_PRODUCTION',			'Amount',			1),
	('HITTITES_IRON_DISTRICT_SCIENCE_ATTACH',			'ModifierId',		'HITTITES_IRON_DISTRICT_SCIENCE'),
	('HITTITES_IRON_DISTRICT_SCIENCE',					'YieldType',		'YIELD_SCIENCE'),
	('HITTITES_IRON_DISTRICT_SCIENCE',					'Amount',			1);
insert or replace into TraitModifiers
	(TraitType,										ModifierId)
select
	'TRAIT_CIVILIZATION_MER_SUN_AND_STORM_HD',		'HITTITES_' || ResourceType || '_DISTRICT_PRODUCTION_ATTACH'
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';
insert or replace into Modifiers
	(ModifierId,													ModifierType,										SubjectRequirementSetId)
select
	'HITTITES_' || ResourceType || '_DISTRICT_PRODUCTION_ATTACH',	'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',		ResourceType || '_IN_PLOT_REQUIREMENTS'
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';
insert or replace into ModifierArguments
	(ModifierId,													Name,			Value)
select
	'HITTITES_' || ResourceType || '_DISTRICT_PRODUCTION_ATTACH',	'ModifierId',	'HITTITES_' || ResourceType || '_DISTRICT_PRODUCTION'
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';
insert or replace into Modifiers
	(ModifierId,													ModifierType,										SubjectRequirementSetId,									SubjectStackLimit)
select
	'HITTITES_' || ResourceType || '_DISTRICT_PRODUCTION',			'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',		'HD_DISTRICTS_IS_NOT_WONDERS_OR_CITY_CENTER_REQUIREMENTS',	1
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';
insert or replace into ModifierArguments
	(ModifierId,													Name,			Value)
select
	'HITTITES_' || ResourceType || '_DISTRICT_PRODUCTION',			'YieldType',	'YIELD_PRODUCTION'
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';
insert or replace into ModifierArguments
	(ModifierId,													Name,			Value)
select
	'HITTITES_' || ResourceType || '_DISTRICT_PRODUCTION',			'Amount',		1
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';
-- Civitas City State Expansion support
insert or replace into TraitModifiers
	(TraitType,								Modifierid)
select
	'TRAIT_LEADER_MER_BOND_AND_OATH',		'MODIFIER_MER_SUN_AND_STORM_AGRICULTURAL'
where exists (select TraitType from Traits where TraitType = 'MINOR_CIV_CSE_AGRICULTURAL_TRAIT');
insert or replace into TraitModifiers
	(TraitType,								Modifierid)
select
	'TRAIT_LEADER_MER_BOND_AND_OATH',		'MODIFIER_MER_SUN_AND_STORM_MARITIME'
where exists (select TraitType from Traits where TraitType = 'MINOR_CIV_CSE_MARITIME_TRAIT');
insert or replace into Modifiers
	(ModifierId,									ModifierType,											OwnerRequirementSetId)
select
	'MODIFIER_MER_SUN_AND_STORM_AGRICULTURAL',		'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',	'CVS_CITYSTATE_AGRICULTURAL_SUZERAIN_1_REQUIREMENTSET'
where exists (select TraitType from Traits where TraitType = 'MINOR_CIV_CSE_AGRICULTURAL_TRAIT');
insert or replace into Modifiers
	(ModifierId,									ModifierType,											OwnerRequirementSetId)
select
	'MODIFIER_MER_SUN_AND_STORM_MARITIME',			'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',	'CVS_CITYSTATE_MARITIME_SUZERAIN_1_REQUIREMENTSET'
where exists (select TraitType from Traits where TraitType = 'MINOR_CIV_CSE_MARITIME_TRAIT');
insert or replace into ModifierArguments
	(ModifierId,									Name,			Value)
select
	'MODIFIER_MER_SUN_AND_STORM_AGRICULTURAL',		'YieldType',	'YIELD_FOOD'
where exists (select TraitType from Traits where TraitType = 'MINOR_CIV_CSE_AGRICULTURAL_TRAIT');
insert or replace into ModifierArguments
	(ModifierId,									Name,			Value)
select
	'MODIFIER_MER_SUN_AND_STORM_AGRICULTURAL',		'Amount',		10
where exists (select TraitType from Traits where TraitType = 'MINOR_CIV_CSE_AGRICULTURAL_TRAIT');
insert or replace into ModifierArguments
	(ModifierId,									Name,			Value)
select
	'MODIFIER_MER_SUN_AND_STORM_MARITIME',			'YieldType',	'YIELD_FOOD'
where exists (select TraitType from Traits where TraitType = 'MINOR_CIV_CSE_MARITIME_TRAIT');
insert or replace into ModifierArguments
	(ModifierId,									Name,			Value)
select
	'MODIFIER_MER_SUN_AND_STORM_MARITIME',			'Amount',		10
where exists (select TraitType from Traits where TraitType = 'MINOR_CIV_CSE_MARITIME_TRAIT');
-- Unique Unit
update Units set Combat = 33, BaseMoves = 3, Cost = 55 where UnitType = 'UNIT_MER_ANSUKURRA';
-- Unique Building
update Buildings set Cost = 100, Maintenance = 1 where BuildingType = 'BUILDING_MER_ROYAL_ARCHIVE';
insert or replace into Building_CitizenYieldChanges
	(BuildingType,					YieldType,			YieldChange)
values
	('BUILDING_MER_ROYAL_ARCHIVE',	'YIELD_SCIENCE',	1),
	('BUILDING_MER_ROYAL_ARCHIVE',	'YIELD_GOLD',		-1);
delete from BuildingModifiers where BuildingType = 'BUILDING_MER_ROYAL_ARCHIVE';
insert or replace into BuildingModifiers
	(BuildingType,					ModifierId)
values
	('BUILDING_MER_ROYAL_ARCHIVE',	'LIBRARY_POP_SCIENCE_MODIFIER'),
	('BUILDING_MER_ROYAL_ARCHIVE',	'ROYAL_ARCHIVE_INFLUENCE_POINT'),
	('BUILDING_MER_ROYAL_ARCHIVE',	'ROYAL_ARCHIVE_STRATEGIC_SCIENCE');
insert or replace into Modifiers
	(ModifierId,							ModifierType,											SubjectRequirementSetId)
values
	('ROYAL_ARCHIVE_INFLUENCE_POINT',		'MODIFIER_PLAYER_ADJUST_INFLUENCE_POINTS_PER_TURN',		null),
	('ROYAL_ARCHIVE_STRATEGIC_SCIENCE',		'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',			'PLOT_HAS_STRATEGIC_IMPROVED_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,							Name,			Value)
values
	('ROYAL_ARCHIVE_INFLUENCE_POINT',		'Amount',		2),
	('ROYAL_ARCHIVE_STRATEGIC_SCIENCE',		'YieldType',	'YIELD_SCIENCE'),
	('ROYAL_ARCHIVE_STRATEGIC_SCIENCE',		'Amount',		1);

-- Religion
insert or replace into FavoredReligions
	(LeaderType,					ReligionType)
select
	'LEADER_MER_SUPPILULIUMA',		'RELIGION_LIIM_DINGIRMES'
where exists (select ReligionType from Religions where ReligionType = 'RELIGION_LIIM_DINGIRMES');

--给赫梯STUU弯刀战士
insert or replace into CivilizationTraits (CivilizationType,    TraitType) select
    'CIVILIZATION_MER_HITTITES',                               	'TRAIT_CIVILIZATION_UNIT_EGYPTIAN_KHOPESH'
where exists (select UnitType from Units where UnitType = 'UNIT_EGYPTIAN_KHOPESH');
-- STUU-hittites.sql
--update Units set Description = 'LOC_UNIT_EGYPTIAN_KHOPESH_HITTITES_DESCRIPTION' where UnitType = 'UNIT_EGYPTIAN_KHOPESH';

