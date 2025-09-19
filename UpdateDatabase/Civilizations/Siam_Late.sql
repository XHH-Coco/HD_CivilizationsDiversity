-- 市政给市政效果
insert or replace into TraitModifiers (TraitType, ModifierId)
	select 'TRAIT_CIVILIZATION_SUK_SRI_AYUTTHAYA', 'HD_SUK_SRI_AYUTTHAYA_' || CivicType || '_EXTRA_TOKEN'
from CivicModifiers where ModifierId in (
	'CIVIC_AWARD_ONE_INFLUENCE_TOKEN', 'CIVIC_AWARD_TWO_INFLUENCE_TOKENS', 'CIVIC_AWARD_THREE_INFLUENCE_TOKENS'
);

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
	select 'HD_SUK_SRI_AYUTTHAYA_' || CivicType || '_EXTRA_TOKEN', 'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN', 'PLAYER_HAS_' || CivicType || '_REQUIREMENTS'
from CivicModifiers where ModifierId in (
	'CIVIC_AWARD_ONE_INFLUENCE_TOKEN', 'CIVIC_AWARD_TWO_INFLUENCE_TOKENS', 'CIVIC_AWARD_THREE_INFLUENCE_TOKENS'
);

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'HD_SUK_SRI_AYUTTHAYA_' || CivicType || '_EXTRA_TOKEN', 'Amount', 1
from CivicModifiers where ModifierId in (
	'CIVIC_AWARD_ONE_INFLUENCE_TOKEN', 'CIVIC_AWARD_TWO_INFLUENCE_TOKENS', 'CIVIC_AWARD_THREE_INFLUENCE_TOKENS'
);