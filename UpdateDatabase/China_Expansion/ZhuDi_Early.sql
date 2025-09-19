-- 新领袖
insert or replace into Types
	(Type,										Kind)
values
	('LEADER_ZHUDI',					'KIND_LEADER'),
	('TRAIT_ZHUDI',						'KIND_TRAIT'),
	('TRAIT_AGENDA_HD_ZHUDI',	'KIND_TRAIT');

insert or replace into CivilizationLeaders
	(CivilizationType,			LeaderType,			CapitalName)
values
	('CIVILIZATION_CHINA',	'LEADER_ZHUDI',	'LOC_CITY_NAME_BEIJING');

insert or replace into Leaders
	(LeaderType,					Name,									    InheritFrom,				SceneLayers)
values
	('LEADER_ZHUDI',	    'LOC_LEADER_ZHUDI_NAME',	'LEADER_DEFAULT',		4);

insert or replace into LeaderQuotes
	(LeaderType,					Quote,									    									QuoteAudio)
values
	('LEADER_ZHUDI',	    'LOC_PEDIA_LEADERS_PAGE_LEADER_YONGLE_QUOTE',	'YONGLE_MA_MISC_PEP_TALK_B_SELECT');

insert or replace into LeaderTraits
	(LeaderType,	 				TraitType)
values
	('LEADER_ZHUDI',	    'TRAIT_ZHUDI'),
	('LEADER_ZHUDI',	    'TRAIT_LEADER_SCIENCE_MAJOR_CIV'),
	('LEADER_ZHUDI',			'TRAIT_CIVILIZATION_UNIT_CHINESE_CROUCHING_TIGER'),
	('LEADER_ZHUDI',			'TRAIT_LEADER_EXPANSIONIST');

insert or replace into Traits
	(TraitType,			Name,								    Description)
values
	('TRAIT_ZHUDI',	'LOC_TRAIT_ZHUDI_NAME',	'LOC_TRAIT_ZHUDI_DESCRIPTION');

-- 议程
insert or replace into Traits (TraitType, Name, Description) values
	('TRAIT_AGENDA_HD_ZHUDI', 'LOC_PLACEHOLDER', 'LOC_PLACEHOLDER');

insert or replace into HistoricalAgendas (LeaderType, AgendaType) values
	('LEADER_ZHUDI', 'AGENDA_HD_ZHUDI');

insert or replace into Agendas (AgendaType, Name, Description) values
	('AGENDA_HD_ZHUDI', 'LOC_AGENDA_HD_ZHUDI_NAME', 'LOC_AGENDA_HD_ZHUDI_DESCRIPTION');

insert or replace into AgendaTraits (AgendaType, TraitType) values
	('AGENDA_HD_ZHUDI', 'TRAIT_AGENDA_HD_ZHUDI');

insert or replace into TraitModifiers (TraitType, ModifierId) values
	('TRAIT_AGENDA_HD_ZHUDI',	'AGENDA_HD_ZHUDI_HIGH_COASTAL_CITES_LOW_EXPLORATION'),
	('TRAIT_AGENDA_HD_ZHUDI',	'AGENDA_HD_ZHUDI_PILLAGER_HIGH_EXPLORATION');

insert or replace into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) values
	('AGENDA_HD_ZHUDI_HIGH_COASTAL_CITES_LOW_EXPLORATION',	'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'ON_TURN_STARTED',			'HD_HAS_HIGH_COASTAL_CITES_LOW_EXPLORATION'),
	('AGENDA_HD_ZHUDI_PILLAGER_HIGH_EXPLORATION',						'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'ON_TURN_STARTED',			'HD_PILLAGER_HIGH_EXPLORATION');

insert or replace into ModifierArguments (ModifierId, Name, Value) values
	('AGENDA_HD_ZHUDI_HIGH_COASTAL_CITES_LOW_EXPLORATION',	'InitialValue',								8),
	('AGENDA_HD_ZHUDI_HIGH_COASTAL_CITES_LOW_EXPLORATION',	'StatementKey',								'LOC_DIPLO_KUDO_LEADER_ZHUDI_REASON_ANY'),
	('AGENDA_HD_ZHUDI_HIGH_COASTAL_CITES_LOW_EXPLORATION',	'SimpleModifierDescription',	'LOC_DIPLO_AGENDA_HD_ZHUDI_POSITIVE'),
	('AGENDA_HD_ZHUDI_PILLAGER_HIGH_EXPLORATION',						'InitialValue',								-12),
	('AGENDA_HD_ZHUDI_PILLAGER_HIGH_EXPLORATION',						'StatementKey',								'LOC_DIPLO_WARNING_LEADER_ZHUDI_REASON_ANY'),
	('AGENDA_HD_ZHUDI_PILLAGER_HIGH_EXPLORATION',						'SimpleModifierDescription',	'LOC_DIPLO_AGENDA_HD_ZHUDI_NEGATIVE');

insert or replace into ModifierStrings (ModifierId, Context, Text) values
	('AGENDA_HD_ZHUDI_HIGH_COASTAL_CITES_LOW_EXPLORATION',	'Sample',	'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL'),
	('AGENDA_HD_ZHUDI_PILLAGER_HIGH_EXPLORATION',						'Sample',	'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL');

insert or replace into ExclusiveAgendas (AgendaOne, AgendaTwo) values
	('AGENDA_HD_ZHUDI', 'AGENDA_EXPLORER'),
	('AGENDA_HD_ZHUDI', 'AGENDA_PILLAGER'),
	('AGENDA_HD_ZHUDI', 'AGENDA_DARWINIST');

-- 美术
insert or replace into LoadingInfo
	(LeaderType,			ForegroundImage,					BackgroundImage,              LeaderText,												DawnOfManLeaderId)
values
	('LEADER_ZHUDI',	'HD_ZHUDI_FOREGROUND',		'LEADER_YONGLE_BACKGROUND',   'LOC_LOADING_INFO_LEADER_ZHUDI',	'LEADER_YONGLE');

-- 宗教
insert or replace into FavoredReligions
	(LeaderType,				ReligionType)
values
	('LEADER_ZHUDI',		'RELIGION_CONFUCIANISM');