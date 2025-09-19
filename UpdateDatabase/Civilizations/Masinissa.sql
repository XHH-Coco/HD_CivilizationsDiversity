-- 柏柏尔领袖马西尼萨
delete from TraitModifiers where TraitType = 'TRAIT_LEADER_CVS_MASINISSA_UA';
delete from TraitModifiers where TraitType = 'TRAIT_LEADER_MAJOR_CIV' and ModifierId = 'MODIFIER_CVS_MASINISSA_WORKER_RECEIVE';
delete from Modifiers where SubjectRequirementSetId = 'REQSET_CVS_MASINISSA_FRIEND' and ModifierId = 'MODIFIER_CVS_MASINISSA_WORKER_RECEIVE';

insert or ignore into Modifiers
	(ModifierId,																														ModifierType,																																	SubjectRequirementSetId,	RunOnce,	Permanent)
values
	-- 建造者获得等同于最高同盟等级的额外次数
	('HD_CVS_MASINISSA_BUILDER_EXTRA_CHARGE',																'MODIFIER_PLAYER_UNITS_ADJUST_BUILDER_CHARGES',																'UNIT_IS_BUILDER',				0,				0),
	-- 宣友后双方获得骑兵（会随科技升级）
	('HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY',																	'MODIFIER_PLAYER_GRANT_UNIT_OF_ABILITY_BY_CLASS_IN_CAPITAL_WITH_MODIFIER',		NULL,											0,				0),
	('HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST',						'MODIFIER_PLAYER_UNIT_GRANT_ABILITY',																					NULL,											1,				1),
	('HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST_MODIFIER',	'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_RESOURCE_MAINTENANCE',										NULL,											0,				0),
	-- 自己UU马和船分享给盟友
	('HD_CVS_MASINISSA_UNLOCK_UNIT_CVS_MASINISSA_UU',												'MODIFIER_PLAYER_ADJUST_VALID_UNIT_BUILD',																		NULL,											0,				0),
	('HD_CVS_MASINISSA_UNLOCK_UNIT_OTTOMAN_BARBARY_CORSAIR',								'MODIFIER_PLAYER_ADJUST_VALID_UNIT_BUILD',																		NULL,											0,				0);
	
insert or ignore into ModifierArguments
	(ModifierId,																														Name,											Value)
values
	('HD_CVS_MASINISSA_BUILDER_EXTRA_CHARGE',																'Amount',									1),
	('HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY',																	'UnitPromotionClassType',	'PROMOTION_CLASS_LIGHT_CAVALRY'),
	('HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY',																	'ModifierId',							'HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST'),
	('HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST',						'AbilityType',						'ABILITY_HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST'),
	('HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST_MODIFIER',	'Ignore',									1),
	('HD_CVS_MASINISSA_UNLOCK_UNIT_CVS_MASINISSA_UU',												'UnitType',								'UNIT_CVS_MASINISSA_UU'),
	('HD_CVS_MASINISSA_UNLOCK_UNIT_OTTOMAN_BARBARY_CORSAIR',								'UnitType',								'UNIT_OTTOMAN_BARBARY_CORSAIR');

insert or replace into Types (Type, Kind) values
	('ABILITY_HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST', 'KIND_ABILITY');

insert or replace into TypeTags (Type, Tag) values
	('ABILITY_HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST', 'CLASS_LIGHT_CAVALRY');

insert or replace into UnitAbilities (UnitAbilityType, Name, Description, Inactive) values
	('ABILITY_HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST',
	'LOC_ABILITY_HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST_NAME',
	'LOC_ABILITY_HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST_DESCRIPTION',
	0);

insert or replace into UnitAbilityModifiers (UnitAbilityType, ModifierId) values
	('ABILITY_HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST', 'HD_CVS_MASINISSA_GRANT_LIGHTCAVARLY_WITHOUT_RESOURCE_COST_MODIFIER');

--UU 
delete from CivilizationTraits where CivilizationType = 'CIVILIZATION_CVS_BERBER' and TraitType = 'TRAIT_CIVILIZATION_CVS_BERBER_UU';
INSERT OR IGNORE INTO LeaderTraits(LeaderType,TraitType)
VALUES	('LEADER_CVS_MASINISSA','TRAIT_CIVILIZATION_UNIT_OTTOMAN_BARBARY_CORSAIR');

-- 是否保留阿尔瑞战士给Dihay
-- WITH Leaders_DIHYA (LeaderType) AS (values ("LEADER_CVS_DIHYA"))
-- INSERT OR IGNORE INTO LeaderTraits(LeaderType,TraitType)
-- SELECT LeaderType,'TRAIT_CIVILIZATION_CVS_BERBER_UU'
-- FROM Leaders_DIHYA WHERE LeaderType IN (SELECT LeaderType FROM LEADERS);

delete from UnitAbilityModifiers where UnitAbilityType = 'ABILITY_CVS_MASINISSA_UU' and ModifierId = 'MODIFIER_CVS_MASINISSA_UU_ATTACK_MOVE';
delete from UnitAbilityModifiers where UnitAbilityType = 'ABILITY_CVS_MASINISSA_UU' and ModifierId = 'MODIFIER_CVS_MASINISSA_UU_PILLAGE_MOVE';

insert or replace into UnitAbilityModifiers (UnitAbilityType,ModifierId)
values ('ABILITY_CVS_MASINISSA_UU',	'MODIFIER_CVS_MASINISSA_UU_STRONGE_ALLIANCE');

insert or replace into Modifiers (ModifierId,ModifierType)
values ('MODIFIER_CVS_MASINISSA_UU_STRONGE_ALLIANCE',	'MODIFIER_SINGLE_UNIT_ADJUST_COMBAT_FOR_NUMBER_ALLIES');
insert or replace into ModifierArguments (ModifierId,Name,Value)
values ('MODIFIER_CVS_MASINISSA_UU_STRONGE_ALLIANCE','Amount','2');

update Units set BaseMoves = 4 where UnitType = 'UNIT_CVS_MASINISSA_UU';
update Units set Cost = 60 where UnitType = 'UNIT_CVS_MASINISSA_UU';