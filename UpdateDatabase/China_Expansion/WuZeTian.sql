insert or replace into GlobalParameters
	(Name,															        Value)
values
	('HD_WU_ZETIAN_ALT_HOLY_SITE_PERCENTAGE',		50),
	('HD_WU_ZETIAN_ALT_HOLY_SITE_ERA_SCORE',		10);

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
  ('HD_WU_ZETIAN_ALT_HOLY_SITE_ERA_SCORE_ADJACENCY', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_BASE_YIELD_CHANGE', 'CITY_HAS_WONDER_DISTRICT_IS_HOLY_SITE_REQUIREMENTS');

insert or replace into ModifierArguments (ModifierId, Name, Value) values
  ('HD_WU_ZETIAN_ALT_HOLY_SITE_ERA_SCORE_ADJACENCY', 'YieldType', 'YIELD_FAITH'),
  ('HD_WU_ZETIAN_ALT_HOLY_SITE_ERA_SCORE_ADJACENCY', 'Amount',    1);

insert or replace into TraitModifiers (TraitType,	ModifierId)
  select 'TRAIT_WU_ZETIAN_ALT', 'HD_WU_ZETIAN_ALT_WONDER_' || DistrictType || '_ADJACENCY'
from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
  select 'HD_WU_ZETIAN_ALT_WONDER_' || DistrictType || '_ADJACENCY', 'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 'PLOT_HAS_COMPLETE_WONDER'
from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

insert or replace into ModifierArguments (ModifierId, Name, Value)
  select 'HD_WU_ZETIAN_ALT_WONDER_' || DistrictType || '_ADJACENCY', 'ModifierId', 'HD_WU_ZETIAN_ALT_WONDER_' || DistrictType || '_ADJACENCY_MODIFIER'
from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
  select 'HD_WU_ZETIAN_ALT_WONDER_' || DistrictType || '_ADJACENCY_MODIFIER', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_BASE_YIELD_CHANGE', 'HD_DISTRICT_IS_' || DistrictType || '_ADJACENT'
from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

insert or replace into ModifierArguments (ModifierId, Name, Value)
  select 'HD_WU_ZETIAN_ALT_WONDER_' || DistrictType || '_ADJACENCY_MODIFIER', 'YieldType', YieldType
from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

insert or replace into ModifierArguments (ModifierId, Name, Value)
  select 'HD_WU_ZETIAN_ALT_WONDER_' || DistrictType || '_ADJACENCY_MODIFIER', 'Amount', 2
from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;