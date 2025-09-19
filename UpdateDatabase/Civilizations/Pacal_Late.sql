--帕卡尔
insert or replace into TraitModifiers
	(TraitType,						            ModifierId)
select
	'TRAIT_LEADER_LEU_PACAL_HD',	            'TRAIT_PACAL_' || BuildingType || '_' || YieldType
from Building_YieldChanges where BuildingType in (select BuildingType from Buildings where IsWonder = 1);

insert or replace into Modifiers
	(ModifierId,														ModifierType)
select
	'TRAIT_PACAL_' || BuildingType || '_' || YieldType,					'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'
from Building_YieldChanges where BuildingType in (select BuildingType from Buildings where IsWonder = 1) union all
select
	'TRAIT_PACAL_' || BuildingType || '_' || YieldType || '_MODIFIER',	'MODIFIER_BUILDING_YIELD_CHANGE'
from Building_YieldChanges where BuildingType in (select BuildingType from Buildings where IsWonder = 1);

insert or replace into ModifierArguments
	(ModifierId,														Name,				Value)
select
	'TRAIT_PACAL_' || BuildingType || '_' || YieldType,					'ModifierId',		'TRAIT_PACAL_' || BuildingType || '_' || YieldType || '_MODIFIER'
from Building_YieldChanges where BuildingType in (select BuildingType from Buildings where IsWonder = 1) union all
select
	'TRAIT_PACAL_' || BuildingType || '_' || YieldType || '_MODIFIER',	'Amount',			YieldChange
from Building_YieldChanges where BuildingType in (select BuildingType from Buildings where IsWonder = 1) union all
select
	'TRAIT_PACAL_' || BuildingType || '_' || YieldType || '_MODIFIER',	'BuildingType',		BuildingType
from Building_YieldChanges where BuildingType in (select BuildingType from Buildings where IsWonder = 1) union all
select
	'TRAIT_PACAL_' || BuildingType || '_' || YieldType || '_MODIFIER',	'YieldType',		YieldType
from Building_YieldChanges where BuildingType in (select BuildingType from Buildings where IsWonder = 1);
