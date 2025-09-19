-- Replaces Tycoon when Monopoly Mode enbaled
update Units set BuildCharges = 2,
	Description = '{LOC_UNIT_ZIMBABWE_PATHFINDER_MONOPOLY_DESCRIPTION_PREFIX}{' || (select Description from Units where UnitType = 'UNIT_LEU_TYCOON') || '}'
	where UnitType = 'UNIT_ZIMBABWE_PATHFINDER';
insert or replace into UnitReplaces
	(CivUniqueUnitType,				ReplacesUnitType)
values
	('UNIT_ZIMBABWE_PATHFINDER',	'UNIT_LEU_TYCOON');
insert or replace into TypeTags
	(Type,							Tag)
select
	'UNIT_ZIMBABWE_PATHFINDER',		Tag
from TypeTags where Type = 'UNIT_LEU_TYCOON';
insert or replace into UnitAiInfos
	(UnitType,						AiType)
select
	'UNIT_ZIMBABWE_PATHFINDER',		AiType
from UnitAiInfos where UnitType = 'UNIT_LEU_TYCOON';
insert or replace into Unit_BuildingPrereqs
	(Unit,							PrereqBuilding)
select
	'UNIT_ZIMBABWE_PATHFINDER',		PrereqBuilding
from Unit_BuildingPrereqs where Unit = 'UNIT_LEU_TYCOON';
insert or replace into Route_ValidBuildUnits
	(UnitType,						RouteType)
select
	'UNIT_ZIMBABWE_PATHFINDER',		RouteType
from Route_ValidBuildUnits where UnitType = 'UNIT_LEU_TYCOON';
insert or replace into Improvement_ValidBuildUnits
	(UnitType,						ImprovementType)
select
	'UNIT_ZIMBABWE_PATHFINDER',		ImprovementType
from Improvement_ValidBuildUnits where UnitType = 'UNIT_LEU_TYCOON';
insert or replace into TypeProperties
	(Type,							Name,	Value,	PropertyType)
select
	'UNIT_ZIMBABWE_PATHFINDER',		Name,	Value,	PropertyType
from TypeProperties where Type = 'UNIT_LEU_TYCOON';