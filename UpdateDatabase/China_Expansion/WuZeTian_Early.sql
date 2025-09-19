-- 新领袖
insert or replace into Types
	(Type,									  		Kind)
values
	('LEADER_WU_ZETIAN_ALT',			'KIND_LEADER'),
	('TRAIT_WU_ZETIAN_ALT',				'KIND_TRAIT'),
	('TRAIT_AGENDA_HD_TIANSHOU',	'KIND_TRAIT');

insert or replace into CivilizationLeaders
	(CivilizationType,			  LeaderType,			        CapitalName)
values
	('CIVILIZATION_CHINA',	  'LEADER_WU_ZETIAN_ALT',	'LOC_CITY_NAME_SHEN_DU');

insert or replace into Leaders
	(LeaderType,					    Name,									            InheritFrom,				SceneLayers)
values
	('LEADER_WU_ZETIAN_ALT',	'LOC_LEADER_WU_ZETIAN_ALT_NAME',	'LEADER_DEFAULT',		4);

insert or replace into LeaderQuotes
	(LeaderType,					    Quote,									    									    QuoteAudio)
values
	('LEADER_WU_ZETIAN_ALT',	'LOC_PEDIA_LEADERS_PAGE_LEADER_WU_ZETIAN_QUOTE',	'WUZETIAN_MA_MISC_PEP_TALK_A_SELECT');

insert or replace into LeaderTraits
	(LeaderType,	 				    TraitType)
values
	('LEADER_WU_ZETIAN_ALT',	'TRAIT_WU_ZETIAN_ALT'),
	('LEADER_WU_ZETIAN_ALT',	'TRAIT_LEADER_RELIGIOUS_MAJOR_CIV'),
	('LEADER_WU_ZETIAN_ALT',  'TRAIT_PLUM_INTERNAL_SECURITY_HD');

insert or replace into Traits
	(TraitType,			        Name,								            Description)
values
	('TRAIT_WU_ZETIAN_ALT',	'LOC_TRAIT_WU_ZETIAN_ALT_NAME',	'LOC_TRAIT_WU_ZETIAN_ALT_DESCRIPTION');

-- 议程
insert or replace into Traits (TraitType, Name, Description) values
	('TRAIT_AGENDA_HD_TIANSHOU', 'LOC_PLACEHOLDER', 'LOC_PLACEHOLDER');

insert or replace into HistoricalAgendas (LeaderType, AgendaType) values
	('LEADER_WU_ZETIAN_ALT', 'AGENDA_HD_TIANSHOU');

insert or replace into Agendas (AgendaType, Name, Description) values
	('AGENDA_HD_TIANSHOU', 'LOC_AGENDA_HD_TIANSHOU_NAME', 'LOC_AGENDA_HD_TIANSHOU_DESCRIPTION');

insert or replace into AgendaTraits (AgendaType, TraitType) values
	('AGENDA_HD_TIANSHOU', 'TRAIT_AGENDA_HD_TIANSHOU');

insert or replace into TraitModifiers (TraitType, ModifierId) values
	('TRAIT_AGENDA_HD_TIANSHOU',	'AGENDA_HD_TIANSHOU_GOLDEN_AGE_BUILD_WONDER'),
	('TRAIT_AGENDA_HD_TIANSHOU',	'AGENDA_HD_TIANSHOU_NOT_GOLDEN_AGE_AT_WAR');

insert or replace into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) values
	('AGENDA_HD_TIANSHOU_GOLDEN_AGE_BUILD_WONDER',	'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'ON_TURN_STARTED',			'HD_AT_GOLDEN_AGE_BUILD_WONDER'),
	('AGENDA_HD_TIANSHOU_NOT_GOLDEN_AGE_AT_WAR',		'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'ON_TURN_STARTED',			'HD_AT_DARK_AGE_AT_WAR');

insert or replace into ModifierArguments (ModifierId, Name, Value) values
	('AGENDA_HD_TIANSHOU_GOLDEN_AGE_BUILD_WONDER',	'InitialValue',								8),
	('AGENDA_HD_TIANSHOU_GOLDEN_AGE_BUILD_WONDER',	'StatementKey',								'LOC_DIPLO_KUDO_LEADER_WU_ZETIAN_ALT_REASON_ANY'),
	('AGENDA_HD_TIANSHOU_GOLDEN_AGE_BUILD_WONDER',	'SimpleModifierDescription',	'LOC_DIPLO_AGENDA_HD_TIANSHOU_POSITIVE'),
	('AGENDA_HD_TIANSHOU_NOT_GOLDEN_AGE_AT_WAR',		'InitialValue',								-12),
	('AGENDA_HD_TIANSHOU_NOT_GOLDEN_AGE_AT_WAR',		'StatementKey',								'LOC_DIPLO_WARNING_LEADER_WU_ZETIAN_ALT_REASON_ANY'),
	('AGENDA_HD_TIANSHOU_NOT_GOLDEN_AGE_AT_WAR',		'SimpleModifierDescription',	'LOC_DIPLO_AGENDA_HD_TIANSHOU_NEGATIVE');

insert or replace into ModifierStrings (ModifierId, Context, Text) values
	('AGENDA_HD_TIANSHOU_GOLDEN_AGE_BUILD_WONDER',	'Sample',	'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL'),
	('AGENDA_HD_TIANSHOU_NOT_GOLDEN_AGE_AT_WAR',		'Sample',	'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL');

insert or replace into ExclusiveAgendas (AgendaOne, AgendaTwo) values
	('AGENDA_HD_TIANSHOU', 'AGENDA_WONDER_ADVOCATE'),
	('AGENDA_HD_TIANSHOU', 'AGENDA_PEACEKEEPER'),
	('AGENDA_HD_TIANSHOU', 'AGENDA_SYCOPHANT'),
	('AGENDA_HD_TIANSHOU', 'AGENDA_SYMPATHIZER'),
	('AGENDA_HD_TIANSHOU', 'AGENDA_DARWINIST');

-- 美术
insert or replace into LoadingInfo
	(LeaderType,			        ForegroundImage,							  BackgroundImage,                LeaderText,												        DawnOfManLeaderId)
values
	('LEADER_WU_ZETIAN_ALT',	'HD_WU_ZETIAN_ALT_FOREGROUND',	'LEADER_WU_ZETIAN_BACKGROUND',  'LOC_LOADING_INFO_LEADER_WU_ZETIAN_ALT',	'LEADER_WU_ZETIAN');

-- 宗教
insert or replace into FavoredReligions
	(LeaderType,				      ReligionType)
values
	('LEADER_WU_ZETIAN_ALT',  'RELIGION_BUDDHISM');