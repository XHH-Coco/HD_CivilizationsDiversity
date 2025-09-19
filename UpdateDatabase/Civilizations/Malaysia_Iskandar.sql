-- Leader Ability
delete from TraitModifiers where TraitType = 'MINOR_CIV_DEFAULT_TRAIT' and ModifierId like 'MODIFIER_CVS_ISKANDAR_UA_ATTACH_%';
insert or replace into TraitModifiers
	(TraitType,										ModifierId)
values
	('TRAIT_LEADER_CVS_ISKANDAR_UA',				'MODIFIER_CVS_ISKANDAR_UA_ADJUST_AMENITIES');
insert or replace into Modifiers
    (ModifierId,						            ModifierType,										SubjectRequirementSetId)
values
	('MODIFIER_CVS_ISKANDAR_UA_ADJUST_AMENITIES',	'MODIFIER_PLAYER_CITIES_ADJUST_TRAIT_AMENITY',		'REQSET_CVS_CITY_NEAR_COAST');
insert or replace into ModifierArguments
	(ModifierId,									Name,				Value)
values
	('MODIFIER_CVS_ISKANDAR_UA_ADJUST_AMENITIES',	'Amount',			1);
insert or ignore into RequirementSets
	(RequirementSetId,					RequirementSetType)
values
	('REQSET_CVS_CITY_NEAR_COAST',		'REQUIREMENTSET_TEST_ALL');
insert or ignore into RequirementSetRequirements
    (RequirementSetId,					RequirementId)
values
	('REQSET_CVS_CITY_NEAR_COAST',		'REQ_CVS_ISKANDAR_UA_NEAR_COAST');
delete from RequirementSetRequirements where RequirementSetId = 'REQSET_CVS_ISKANDAR_UA_NEAR_COAST' and RequirementId = 'REQ_CVS_ISKANDAR_UA_IS_NEW_CITY';