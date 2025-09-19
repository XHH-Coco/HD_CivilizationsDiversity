insert or replace into Modifiers
	(ModifierId,								            ModifierType)
values
	('ZHUDI_TRADE_ADD_TRADE_ROUTE',			    'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY');

insert or replace into ModifierArguments
	(ModifierId,								            Name,			Value)
values
	('ZHUDI_TRADE_ADD_TRADE_ROUTE',			    'Amount',		1);

insert or replace into Modifiers
	(ModifierId,								                              ModifierType)
select
  'ZHUDI_LEADER_MINOR_CIV_' || CityStateType || '_BONUS',  'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD'
from CityStateCorrespondingYieldType_HD;

insert or replace into ModifierArguments
	(ModifierId,								                             Name,			  Value)
select
  'ZHUDI_LEADER_MINOR_CIV_' || CityStateType || '_BONUS',  'YieldType', YieldType
from CityStateCorrespondingYieldType_HD;

insert or replace into ModifierArguments
	(ModifierId,								                             Name,			  Value)
select
  'ZHUDI_LEADER_MINOR_CIV_' || CityStateType || '_BONUS',  'Amount',    Amount
from CityStateCorrespondingYieldType_HD;