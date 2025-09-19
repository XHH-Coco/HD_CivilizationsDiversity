--UB（区域扩展）
insert or replace into Buildings	(
		BuildingType,
		Name,
		Description,
		TraitType,
		PrereqTech,
		PrereqCivic,
		Cost,
		PrereqDistrict,
		Housing,
		PurchaseYield,
		Maintenance,
		CitizenSlots,
		RegionalRange,
		OuterDefenseStrength,
		DefenseModifier,
		AdvisorType
		)
select	'BUILDING_CVS_SONGHAI_UI', -- BuildingType
		'LOC_BUILDING_CVS_SONGHAI_UI_NAME', -- Name
		'LOC_BUILDING_CVS_SONGHAI_UI_DESCRIPTION_HD', -- Description
		'TRAIT_CIVILIZATION_BUILDING_CVS_SONGHAI_UI', -- TraitType
		NULL,
		'CIVIC_DIVINE_RIGHT',
		Cost,
		PrereqDistrict,
		Housing,
		'YIELD_FAITH',
		Maintenance,
		CitizenSlots,
		RegionalRange,
		OuterDefenseStrength,
		DefenseModifier,
		AdvisorType
from	Buildings
where	BuildingType = 'BUILDING_JNR_SCHOOL';
delete from Building_YieldChanges where BuildingType = 'BUILDING_CVS_SONGHAI_UI';

insert or replace into BuildingReplaces
	(CivUniqueBuildingType,			ReplacesBuildingType)
values
	('BUILDING_CVS_SONGHAI_UI',		'BUILDING_JNR_SCHOOL');

insert or replace into HD_BuildingTiers
	(BuildingType,					PrereqDistrict,				Tier,		ReplacesOther)
values
	('BUILDING_CVS_SONGHAI_UI',		'DISTRICT_CAMPUS',			2,			1);

insert or replace into MutuallyExclusiveBuildings
	(Building,						MutuallyExclusiveBuilding)
values
	('BUILDING_CVS_SONGHAI_UI',		'BUILDING_UNIVERSITY');

insert or ignore into BuildingPrereqs
	(Building,						PrereqBuilding)
select
	Building,						'BUILDING_CVS_SONGHAI_UI'
from BuildingPrereqs where PrereqBuilding = 'BUILDING_JNR_SCHOOL';

insert or ignore into BuildingPrereqs
	(Building,						PrereqBuilding)
select
	'BUILDING_CVS_SONGHAI_UI',		PrereqBuilding
from BuildingPrereqs where Building = 'BUILDING_JNR_SCHOOL';

insert or replace into Building_YieldChanges
	(BuildingType,				YieldType,			YieldChange)
values
	('BUILDING_CVS_SONGHAI_UI',	'YIELD_SCIENCE',	2);

insert or replace into Building_TourismBombs_XP2
	(BuildingType,					TourismBombValue)
select
	'BUILDING_CVS_SONGHAI_UI',		TourismBombValue
from Building_TourismBombs_XP2 where BuildingType = 'BUILDING_JNR_SCHOOL';

delete from BuildingModifiers where ModifierId = 'UNIVERSITY_ADD_POPULATION_SCIENCE';

insert or replace into BuildingModifiers
	(BuildingType,					ModifierId)
values
	('BUILDING_CVS_SONGHAI_UI',		'CITY_SCHOOL_SPECILTY_DISTRICT_SCIENCE'),
	('BUILDING_CVS_SONGHAI_UI',		'CITY_SCHOOL_CAMPUS_DISTRICT_ADJACENCY'),
	('BUILDING_CVS_SONGHAI_UI',		'CITY_SCHOOL_SPECILTY_DISTRICT_FAITH'),
	('BUILDING_CVS_SONGHAI_UI',		'BUILDING_CVS_SONGHAI_UI_DESERT_SCIENCE'),
	('BUILDING_CVS_SONGHAI_UI',		'BUILDING_CVS_SONGHAI_UI_DESERT_HILLS_SCIENCE');

insert or replace into Modifiers
	(ModifierId,										ModifierType,										SubjectRequirementSetId)
values
	('CITY_SCHOOL_SPECILTY_DISTRICT_FAITH',				'MODIFIER_CITY_ADJUST_CITY_YIELD_PER_DISTRICT',		NULL),
	('BUILDING_CVS_SONGHAI_UI_DESERT_SCIENCE',			'MODIFIER_CITY_ADJUST_CITY_YIELD_PER_TERRAIN_TYPE',	'CITY_NOT_FOUNDED'),
	('BUILDING_CVS_SONGHAI_UI_DESERT_HILLS_SCIENCE',	'MODIFIER_CITY_ADJUST_CITY_YIELD_PER_TERRAIN_TYPE',	'CITY_NOT_FOUNDED');

insert or replace into ModifierArguments
	(ModifierId,										Name,				Value)
values
	('CITY_SCHOOL_SPECILTY_DISTRICT_FAITH',				'YieldType',		'YIELD_FAITH'),
	('CITY_SCHOOL_SPECILTY_DISTRICT_FAITH',				'Amount',			2),
	('BUILDING_CVS_SONGHAI_UI_DESERT_SCIENCE',			'Amount',			1),
	('BUILDING_CVS_SONGHAI_UI_DESERT_SCIENCE',			'TerrainType',		'TERRAIN_DESERT'),
	('BUILDING_CVS_SONGHAI_UI_DESERT_SCIENCE',			'YieldType',		'YIELD_SCIENCE'),
	('BUILDING_CVS_SONGHAI_UI_DESERT_HILLS_SCIENCE',	'Amount',			1),
	('BUILDING_CVS_SONGHAI_UI_DESERT_HILLS_SCIENCE',	'TerrainType',		'TERRAIN_DESERT_HILLS'),
	('BUILDING_CVS_SONGHAI_UI_DESERT_HILLS_SCIENCE',	'YieldType',		'YIELD_SCIENCE');