-- 朱棣
insert or replace into Players
	(CivilizationType, Portrait, PortraitBackground,
	LeaderType, LeaderName, LeaderIcon, LeaderAbilityName, LeaderAbilityDescription, LeaderAbilityIcon,
	CivilizationName, CivilizationIcon, CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, Domain)
select
	CivilizationType, 'HD_ZHUDI_FOREGROUND', 'LEADER_YONGLE_BACKGROUND',
	'LEADER_ZHUDI', 'LOC_LEADER_ZHUDI_NAME', 'ICON_LEADER_ZHUDI', 'LOC_TRAIT_ZHUDI_NAME', 'LOC_TRAIT_ZHUDI_DESCRIPTION', LeaderAbilityIcon,
	CivilizationName, CivilizationIcon, CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, Domain
from Players where CivilizationType = 'CIVILIZATION_CHINA' and LeaderType = 'LEADER_YONGLE';

insert or replace into PlayerItems	
	(CivilizationType,	LeaderType,			Type, Icon, Name, Description, SortIndex, Domain)
select
	CivilizationType,		'LEADER_ZHUDI',	Type, Icon, Name, Description, SortIndex, Domain
from PlayerItems where CivilizationType = 'CIVILIZATION_CHINA' AND LeaderType = 'LEADER_YONGLE';

-- 武则天
insert or replace into Players
	(CivilizationType, Portrait, PortraitBackground,
	LeaderType, LeaderName, LeaderIcon, LeaderAbilityName, LeaderAbilityDescription, LeaderAbilityIcon,
	CivilizationName, CivilizationIcon, CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, Domain)
select
	CivilizationType, 'HD_WU_ZETIAN_ALT_FOREGROUND', 'LEADER_WU_ZETIAN_BACKGROUND',
	'LEADER_WU_ZETIAN_ALT', 'LOC_LEADER_WU_ZETIAN_ALT_NAME', 'ICON_LEADER_WU_ZETIAN_ALT', 'LOC_TRAIT_WU_ZETIAN_ALT_NAME', 'LOC_TRAIT_WU_ZETIAN_ALT_DESCRIPTION', LeaderAbilityIcon,
	CivilizationName, CivilizationIcon, CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, Domain
from Players where CivilizationType = 'CIVILIZATION_CHINA' and LeaderType = 'LEADER_WU_ZETIAN';

insert or replace into PlayerItems	
	(CivilizationType,	LeaderType,							Type, Icon, Name, Description, SortIndex, Domain)
select
	CivilizationType,		'LEADER_WU_ZETIAN_ALT',	Type, Icon, Name, Description, SortIndex, Domain
from PlayerItems where CivilizationType = 'CIVILIZATION_CHINA' AND LeaderType = 'LEADER_WU_ZETIAN';

-- Hittites
-- STUU士--playeritem
--update PlayerItems set Description = 'LOC_UNIT_EGYPTIAN_KHOPESH_HITTITES_DESCRIPTION' where Type = 'UNIT_EGYPTIAN_KHOPESH'
--	and exists (select CivilizationType from Players where CivilizationType = 'CIVILIZATION_MER_HITTITES');
insert or ignore into PlayerItems
    (Domain,                        CivilizationType,       		LeaderType,         		Type,                     Icon,                           Name,                              Description,                          SortIndex)
select
    "Players:Expansion2_Players",  "CIVILIZATION_MER_HITTITES",    "LEADER_MER_SUPPILULIUMA",   "UNIT_EGYPTIAN_KHOPESH",  "ICON_UNIT_EGYPTIAN_KHOPESH",   "LOC_UNIT_EGYPTIAN_KHOPESH_NAME",  "LOC_UNIT_EGYPTIAN_KHOPESH_DESCRIPTION",    10
where exists (select CivilizationType from Players where CivilizationType = 'CIVILIZATION_MER_HITTITES') and exists (select Type from PlayerItems where Type = 'UNIT_EGYPTIAN_KHOPESH');

-- Hattusa City State Rename
update CityStates set Name = 'LOC_CIVILIZATION_MER_HITTITES_CS_NAME', Icon = 'ICON_CIVILIZATION_BAKU' where CivilizationType = 'CIVILIZATION_HATTUSA'
	and exists (select CivilizationType from Players where CivilizationType = 'CIVILIZATION_MER_HITTITES');

-- Assyria
-- Rename type to disable lua script
update Players set CivilizationType = 'CIVILIZATION_BOOM_ASSYRIA_HD' where CivilizationType = 'CIVILIZATION_BOOM_ASSYRIA';
update PlayerItems set CivilizationType = 'CIVILIZATION_BOOM_ASSYRIA_HD' where CivilizationType = 'CIVILIZATION_BOOM_ASSYRIA';
-- Unique Units
insert or ignore into PlayerItems
	(Domain,						CivilizationType,					LeaderType,					Type,							Icon,								Name,									Description,									SortIndex)
select
	'Players:Expansion2_Players',	'CIVILIZATION_BOOM_ASSYRIA_HD',		'LEADER_BOOM_ASHURBANIPAL',	'UNIT_ASSYRIA_KISIR_SARRUTI',	'ICON_UNIT_ASSYRIA_KISIR_SARRUTI',	'LOC_UNIT_ASSYRIA_KISIR_SARRUTI_NAME',	'LOC_UNIT_ASSYRIA_KISIR_SARRUTI_DESCRIPTION',	31
where exists (select CivilizationType from Players where CivilizationType = 'CIVILIZATION_BOOM_ASSYRIA_HD');

-- Nebuchadnezzar
-- New Leader
insert or replace into Players
	(CivilizationType,	Portrait,							PortraitBackground,
	LeaderType,					LeaderName,								LeaderIcon,							LeaderAbilityName,					LeaderAbilityDescription,					LeaderAbilityIcon,
	CivilizationName,	CivilizationIcon,	CivilizationAbilityName,	CivilizationAbilityDescription,	CivilizationAbilityIcon,	Domain)
select
	CivilizationType,	'NEBUCHADNEZZAR_II_FOREGROUND.dds',	'LEADER_HAMMURABI_BACKGROUND',
	'LEADER_NEBUCHADNEZZAR_II',	'LOC_LEADER_NEBUCHADNEZZAR_II_NAME',	'ICON_LEADER_NEBUCHADNEZZAR_II',	'LOC_TRAIT_HANGING_GARDENS_NAME',	'LOC_TRAIT_HANGING_GARDENS_DESCRIPTION',	'ICON_LEADER_HAMMURABI',
	CivilizationName,	CivilizationIcon,	CivilizationAbilityName,	CivilizationAbilityDescription,	CivilizationAbilityIcon,	Domain
from Players where CivilizationType = 'CIVILIZATION_BABYLON_STK' and LeaderType = 'LEADER_HAMMURABI';
insert or replace into PlayerItems	
	(CivilizationType,	LeaderType,					Type, Icon, Name, Description, SortIndex, Domain)
select
	CivilizationType,	'LEADER_NEBUCHADNEZZAR_II',	Type, Icon, Name, Description, SortIndex, Domain
from PlayerItems where CivilizationType = 'CIVILIZATION_BABYLON_STK' AND LeaderType = 'LEADER_HAMMURABI';

-- Bulgaria
-- Unique Units
insert or ignore into PlayerItems
	(Domain,						CivilizationType,				LeaderType,				Type,						Icon,							Name,								Description,								SortIndex)
select
	'Players:Expansion2_Players',	'CIVILIZATION_MER_BULGARIA',	'LEADER_MER_SIMEON_I',	'UNIT_BULGARIA_KONIKK',		'ICON_UNIT_BULGARIA_KONIKK',	'LOC_UNIT_BULGARIA_KONIKK_NAME',	'LOC_UNIT_BULGARIA_KONIKK_DESCRIPTION',		31
where exists (select CivilizationType from Players where CivilizationType = 'CIVILIZATION_MER_BULGARIA');
-- Preslav City State Rename
update CityStates set Name = 'LOC_CIVILIZATION_MER_BULGARIA_CS_NAME', Icon = 'ICON_CIVILIZATION_GALATIA' where CivilizationType = 'CIVILIZATION_PRESLAV'
	and exists (select CivilizationType from Players where CivilizationType = 'CIVILIZATION_MER_BULGARIA');

-- Siam
-- Unique Units
insert or ignore into PlayerItems
	(Domain,						CivilizationType,				LeaderType,		Type,									Icon,										Name,											Description,											SortIndex)
select distinct
	'Players:Expansion2_Players',	'CIVILIZATION_SUK_SIAM',		LeaderType,		'UNIT_SIAMESE_EXPEDITIONARY_FORCES',	'ICON_UNIT_SIAMESE_EXPEDITIONARY_FORCES',	'LOC_UNIT_SIAMESE_EXPEDITIONARY_FORCES_NAME',	'LOC_UNIT_SIAMESE_EXPEDITIONARY_FORCES_DESCRIPTION',	31
from Players where CivilizationType = 'CIVILIZATION_SUK_SIAM';

-- Zimbabwe
-- Unique Units
insert or ignore into PlayerItems
	(Domain,						CivilizationType,				LeaderType,		Type,							Icon,								Name,									Description,											SortIndex)
select distinct
	'Players:Expansion2_Players',	'CIVILIZATION_GEDEMO_ZIMBABWE',	LeaderType,		'UNIT_ZIMBABWE_PATHFINDER',		'ICON_UNIT_ZIMBABWE_PATHFINDER',	'LOC_UNIT_ZIMBABWE_PATHFINDER_NAME',	'LOC_UNIT_ZIMBABWE_PATHFINDER_DESCRIPTION_FRONTEND',	31
from Players where CivilizationType = 'CIVILIZATION_GEDEMO_ZIMBABWE';

-- Armenia
-- Unique Units
insert or ignore into PlayerItems
	(Domain,						CivilizationType,				LeaderType,		Type,							Icon,					Name,									Description,								SortIndex)
select distinct
	'Players:Expansion2_Players',	'CIVILIZATION_CVS_ARMENIA',		LeaderType,		'UNIT_ARMENIA_APOSTLE',			'ICON_UNIT_APOSTLE',	'LOC_UNIT_ARMENIA_APOSTLE_NAME',		'LOC_UNIT_ARMENIA_APOSTLE_DESCRIPTION',		31
from Players where CivilizationType = 'CIVILIZATION_CVS_ARMENIA';

-- Swahili
-- Unique Units
insert or ignore into PlayerItems
	(Domain,						CivilizationType,				LeaderType,		Type,							Icon,						Name,									Description,								SortIndex)
select distinct
	'Players:Expansion2_Players',	'CIVILIZATION_SUK_SWAHILI',		LeaderType,		'UNIT_SWAHILI_DHOW',			'ICON_UNIT_SWAHILI_DHOW',	'LOC_UNIT_SWAHILI_DHOW_NAME',			'LOC_UNIT_SWAHILI_DHOW_DESCRIPTION',		31
from Players where CivilizationType = 'CIVILIZATION_SUK_SWAHILI';

-- Malaysia
-- Unique Units
insert or ignore into PlayerItems
	(Domain,	CivilizationType,	LeaderType,				Type,	Icon,	Name,	Description,	SortIndex)
select
	Domain,		CivilizationType,	'LEADER_CVS_ISKANDAR',	Type,	Icon,	Name,	Description,	SortIndex
from PlayerItems where CivilizationType = 'CIVILIZATION_CVS_MALAYSIA' and LeaderType = 'LEADER_CVS_TUN_PERAK' and Type = 'UNIT_CVS_TUN_PERAK_UU'
	and exists (select LeaderType from Players where LeaderType = 'LEADER_CVS_ISKANDAR');


-- CVS Masinissa
Delete from PlayerItems where LeaderType = 'LEADER_CVS_MASINISSA' and Type = 'UNIT_CVS_BERBER_UU';

INSERT OR REPLACE INTO PlayerItems (Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
SELECT DISTINCT
		Domain,
		'CIVILIZATION_CVS_BERBER',
		'LEADER_CVS_MASINISSA',	
		'UNIT_OTTOMAN_BARBARY_CORSAIR',
		'ICON_UNIT_OTTOMAN_BARBARY_CORSAIR',
		'LOC_UNIT_OTTOMAN_BARBARY_CORSAIR_NAME',
		'LOC_UNIT_OTTOMAN_BARBARY_CORSAIR_DESCRIPTION',
		40
FROM PlayerItems WHERE Domain IN ('Players:Expansion1_Players', 'Players:Expansion2_Players', 'Players:StandardPlayers') AND 
EXISTS (SELECT LeaderType FROM Players WHERE LeaderType = 'LEADER_CVS_MASINISSA');

Delete from PlayerItems where LeaderType = 'LEADER_CVS_DIHYA' and Type = 'UNIT_CVS_BERBER_UU';
INSERT OR REPLACE INTO PlayerItems (Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
SELECT DISTINCT
		Domain,
		'CIVILIZATION_CVS_BERBER',
		'LEADER_CVS_DIHYA',	
		'UNIT_OTTOMAN_BARBARY_CORSAIR',
		'ICON_UNIT_OTTOMAN_BARBARY_CORSAIR',
		'LOC_UNIT_OTTOMAN_BARBARY_CORSAIR_NAME',
		'LOC_UNIT_OTTOMAN_BARBARY_CORSAIR_DESCRIPTION',
		40
FROM PlayerItems WHERE Domain IN ('Players:Expansion1_Players', 'Players:Expansion2_Players', 'Players:StandardPlayers') AND 
EXISTS (SELECT LeaderType FROM Players WHERE LeaderType = 'LEADER_CVS_DIHYA');
--Iceland
insert or ignore into PlayerItems
	(Domain,						CivilizationType,				LeaderType,				Type,						Icon,							Name,								Description,								SortIndex)
select
	'Players:Expansion2_Players',	'CIVILIZATION_SUK_ICELAND',		'LEADER_SUK_INGOLFUR',	'UNIT_KNARR',				'ICON_UNIT_KNARR',				'LOC_UNIT_KNARR_NAME',				'LOC_UNIT_KNARR_DESCRIPTION',				31
where exists (select CivilizationType from Players where CivilizationType = 'CIVILIZATION_SUK_ICELAND');

update PlayerItems set Description = 'LOC_BUILDING_CVS_SONGHAI_UI_DESCRIPTION_HD' where Description = 'LOC_BUILDING_CVS_SONGHAI_UI_DESCRIPTION' and exists (select Description from PlayerItems where Description = 'LOC_BUILDING_MADRASA_DESCRIPTION_UC_JNR');