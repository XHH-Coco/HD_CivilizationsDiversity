create temporary table HD_LamassuYields (
	BuildingType text not null,
	YieldType text not null,
	YieldChange int not null,
	ModifierId text,
	primary key (BuildingType, YieldType)
);
insert or replace into HD_LamassuYields
	(BuildingType,	YieldType,	YieldChange)
select
	BuildingType,	YieldType,	YieldChange
from Building_YieldChanges where BuildingType in (select BuildingType from Buildings where PrereqDistrict = 'DISTRICT_CITY_CENTER') and BuildingType != 'BUILDING_PALACE';
update HD_LamassuYields set ModifierId = 'BOOM_LAMASSU_' || BuildingType || '_' || YieldType;
insert or replace into ImprovementModifiers
	(ImprovementType,				ModifierId)
select
	'IMPROVEMENT_BOOM_LAMASSU',		ModifierId
from HD_LamassuYields;
insert or replace into Modifiers
	(ModifierId,	ModifierType,									SubjectRequirementSetId)
select
	ModifierId,		'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',		'CITY_HAS_' || BuildingType || '_REQUIREMENTS'
from HD_LamassuYields;
insert or replace into ModifierArguments
	(ModifierId,	Name,			Value)
select
	ModifierId,		'YieldType',	YieldType
from HD_LamassuYields;
insert or replace into ModifierArguments
	(ModifierId,	Name,			Value)
select
	ModifierId,		'Amount',		YieldChange
from HD_LamassuYields;