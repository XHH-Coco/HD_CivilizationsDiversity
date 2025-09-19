--桑尼阿里
--删除原能力
delete from TraitModifiers where TraitType = 'TRAIT_LEADER_CVS_SONNI_ALI_UA';

--每获得一点时代分，为所有军事单位恢复5点生命。进入黄金时代后，所有单位+5力，宣战不产生不满。在非你创建的城市中购买建筑和单位时-15%花费。
insert or replace into TraitModifiers
	(TraitType,								ModifierId)
values
	('TRAIT_LEADER_CVS_SONNI_ALI_UA',		'MODIFIER_CVS_SONNI_ALI_UA_GOLDEN_COMBAT_HD'),
	('TRAIT_LEADER_CVS_SONNI_ALI_UA',		'MODIFIER_CVS_SONNI_ALI_UA_GOLDEN_DECLARE_WAR'),
	('TRAIT_LEADER_CVS_SONNI_ALI_UA',		'MODIFIER_CVS_SONNI_ALI_UA_BUILDING_DISCOUNT'),
	('TRAIT_LEADER_CVS_SONNI_ALI_UA',		'MODIFIER_CVS_SONNI_ALI_UA_UNIT_DISCOUNT');
insert or replace into Modifiers
	(ModifierId,													ModifierType,													SubjectRequirementSetId)
values
	('MODIFIER_CVS_SONNI_ALI_UA_GOLDEN_COMBAT_HD',					'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',							'PLAYER_HAS_GOLDEN_AGE'),
	('HD_SONGHAI_EXTRA_STRENGTH',									'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',							NULL),
	('MODIFIER_CVS_SONNI_ALI_UA_GOLDEN_DECLARE_WAR',				'MODIFIER_PLAYER_ADJUST_MAX_WARMONGER_PERCENT',					'PLAYER_HAS_GOLDEN_AGE'),
	('MODIFIER_CVS_SONNI_ALI_UA_BUILDING_DISCOUNT',					'MODIFIER_PLAYER_CITIES_ADJUST_ALL_BUILDINGS_PURCHASE_COST',	'CITY_NOT_FOUNDED'),
	('MODIFIER_CVS_SONNI_ALI_UA_UNIT_DISCOUNT',						'MODIFIER_PLAYER_CITIES_ADJUST_UNITS_PURCHASE_COST',			'CITY_NOT_FOUNDED');


insert or replace into ModifierArguments
	(ModifierId,													Name,						Value)
values
	('MODIFIER_CVS_SONNI_ALI_UA_GOLDEN_COMBAT_HD',					'AbilityType',				'ABILITY_GOLDEN_AGE_EXTRA_STRENGTH'),
	('HD_SONGHAI_EXTRA_STRENGTH',									'Amount',					5),
	('MODIFIER_CVS_SONNI_ALI_UA_GOLDEN_DECLARE_WAR',				'MaxPercent',				0),
	('MODIFIER_CVS_SONNI_ALI_UA_BUILDING_DISCOUNT',					'Amount',					15),
	('MODIFIER_CVS_SONNI_ALI_UA_UNIT_DISCOUNT',						'Amount',					15),
	('MODIFIER_CVS_SONNI_ALI_UA_UNIT_DISCOUNT',						'IncludeCivilian',			1);

insert or replace into ModifierStrings
	(ModifierId,										Context,					Text)
values
	('HD_SONGHAI_EXTRA_STRENGTH',						'Preview',					'+{1_Amount} {LOC_HD_SONGHAI_EXTRA_STRENGTH_PREVIEW_TEXT}');
insert or replace into Types
	(Type,															Kind)
values
	('ABILITY_GOLDEN_AGE_EXTRA_STRENGTH',							'KIND_ABILITY');

insert or replace into UnitAbilities
	(UnitAbilityType,							Name,				Description,												Inactive,	ShowFloatTextWhenEarned,	Permanent)
values
	('ABILITY_GOLDEN_AGE_EXTRA_STRENGTH',		NULL,				'LOC_ABILITY_GOLDEN_AGE_EXTRA_STRENGTH_DESCRIPTION',		1,			0,							0);

insert or replace into UnitAbilityModifiers
	(UnitAbilityType,							ModifierId)
values
	('ABILITY_GOLDEN_AGE_EXTRA_STRENGTH',		'HD_SONGHAI_EXTRA_STRENGTH');

insert or replace into TypeTags
	(Type,										Tag)
values
	('ABILITY_GOLDEN_AGE_EXTRA_STRENGTH',		'CLASS_ALL_UNITS');

insert or replace into GlobalParameters
	(Name,							Value)
values
	('SONNI_ALI_EXTRA_HIT_POINTS',	5);