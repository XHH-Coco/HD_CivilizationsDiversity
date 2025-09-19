--桑海UA
--历史时刻提供额外+1时代分。
--黄金时代平民加1速。进入[ICON_GLORY_GOLDEN_AGE] 黄金时代时，从每个军营和港口处获得一个免费的近战或海军近战单位，这些单位拥有额外+1移动力。从每个你控制的文明首都获得一个开拓者。
--删除原能力
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_CVS_SONGHAI_UA';

insert or replace into TraitModifiers
	(TraitType,									ModifierId)
values
	('TRAIT_CIVILIZATION_CVS_SONGHAI_UA',		'MODIFIER_CVS_SONGHAI_UA_EXTRA_SCORE'),
	('TRAIT_CIVILIZATION_CVS_SONGHAI_UA',		'MODIFIER_CVS_SONGHAI_UA_EXTRA_MOVEMENT');

insert or replace into Modifiers
	(ModifierId,								ModifierType,													Runonce,	SubjectRequirementSetId)
values
	('MODIFIER_CVS_SONGHAI_UA_EXTRA_SCORE',		'MODIFIER_PLAYER_ADJUST_PLAYER_ERA_SCORE_PER_PRIDE_MOMENT',		0,			NULL),
	('HD_SONGHAI_SETTLER',						'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_CITY',						1,			NULL),
	('HD_SONGHAI_MELEE',						'MODIFIER_SINGLE_CITY_GRANT_UNIT_OF_ABILITY_WITH_MODIFIER',		1,			NULL),
	('HD_SONGHAI_NAVAL_MELEE',					'MODIFIER_SINGLE_CITY_GRANT_UNIT_OF_ABILITY_WITH_MODIFIER',		1,			NULL),
	('HD_SONGHAI_EXTRA_MOVEMENT',				'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT',							0,			NULL),
	('MODIFIER_CVS_SONGHAI_UA_EXTRA_MOVEMENT',	'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',							0,			'PLAYER_HAS_GOLDEN_AGE');

insert or replace into ModifierArguments
	(ModifierId,								Name,						Value)
values
	('MODIFIER_CVS_SONGHAI_UA_EXTRA_SCORE',		'MinScore',					1),
	('MODIFIER_CVS_SONGHAI_UA_EXTRA_SCORE',		'Amount',					1),
	('HD_SONGHAI_SETTLER',						'Amount',					1),
	('HD_SONGHAI_SETTLER',						'UnitType',					'UNIT_SETTLER'),
	('HD_SONGHAI_MELEE',						'ModifierId',				'HD_SONGHAI_EXTRA_MOVEMENT'),
	('HD_SONGHAI_MELEE',						'UnitPromotionClassType',	'PROMOTION_CLASS_MELEE'),
	('HD_SONGHAI_NAVAL_MELEE',					'ModifierId',				'HD_SONGHAI_EXTRA_MOVEMENT'),
	('HD_SONGHAI_NAVAL_MELEE',					'UnitPromotionClassType',	'PROMOTION_CLASS_NAVAL_MELEE'),
	('HD_SONGHAI_EXTRA_MOVEMENT',				'Amount',					1),
	('MODIFIER_CVS_SONGHAI_UA_EXTRA_MOVEMENT',	'AbilityType',				'ABILITY_GOLDEN_AGE_EXTRA_MOVEMENT');

insert or replace into Types
	(Type,															Kind)
values
	('ABILITY_GOLDEN_AGE_EXTRA_MOVEMENT',							'KIND_ABILITY'),
	('MODIFIER_SINGLE_CITY_GRANT_UNIT_OF_ABILITY_WITH_MODIFIER',	'KIND_MODIFIER');

insert or replace into UnitAbilities
	(UnitAbilityType,							Name,				Description,												Inactive,	ShowFloatTextWhenEarned,	Permanent)
values
	('ABILITY_GOLDEN_AGE_EXTRA_MOVEMENT',		NULL,				'LOC_ABILITY_GOLDEN_AGE_EXTRA_MOVEMENT_DESCRIPTION',		1,			0,							0);

insert or replace into UnitAbilityModifiers
	(UnitAbilityType,							ModifierId)
values
	('ABILITY_GOLDEN_AGE_EXTRA_MOVEMENT',		'HD_SONGHAI_EXTRA_MOVEMENT');

insert or replace into TypeTags
	(Type,										Tag)
values
	('ABILITY_GOLDEN_AGE_EXTRA_MOVEMENT',		'CLASS_LANDCIVILIAN');

insert or replace into DynamicModifiers
	(ModifierType,														CollectionType,					EffectType)
values
	('MODIFIER_SINGLE_CITY_GRANT_UNIT_OF_ABILITY_WITH_MODIFIER',		'COLLECTION_OWNER',				'EFFECT_GRANT_UNIT_OF_CLASS_AND_APPLY_ABILITY');

--UU
insert or replace into Units	(
		UnitType,
		Name,
		Description,
		TraitType,
		BaseMoves,
		Cost,
		PurchaseYield,
		AdvisorType,
		Combat,
		BaseSightRange,
		ZoneOfControl,
		Domain,
		FormationClass,
		PromotionClass,
		Maintenance,
		MandatoryObsoleteTech,
		PrereqTech,
		PrereqCivic
		)
select	'UNIT_CVS_SONGHAI_UU',	-- UnitType
		'LOC_UNIT_CVS_SONGHAI_UU_NAME',	-- Name
		'LOC_UNIT_CVS_SONGHAI_UU_DESCRIPTION', -- Description
		'TRAIT_CIVILIZATION_CVS_SONGHAI_UU', -- TraitType
		BaseMoves,
		Cost,
		PurchaseYield,
		AdvisorType,
		Combat + 3, -- Combat
		BaseSightRange,
		ZoneOfControl,
		Domain,
		FormationClass,
		PromotionClass,
		Maintenance,
		MandatoryObsoleteTech,
		PrereqTech,
		PrereqCivic
from	Units
where	UnitType = 'UNIT_COURSER';

insert or replace into Units_XP2 (UnitType, ResourceMaintenanceAmount, ResourceCost) 
select	'UNIT_CVS_SONGHAI_UU',
		ResourceMaintenanceAmount,
		ResourceCost
from	Units_XP2
where	UnitType = 'UNIT_COURSER';

--UB（不开区域扩展）
insert or replace into Buildings	(
		BuildingType,
		Name,
		Description,
		TraitType,
		PrereqTech,
		PrereqCivic,
		Cost,
		PrereqDistrict,
		Housing,
		PurchaseYield,
		Maintenance,
		CitizenSlots,
		RegionalRange,
		OuterDefenseStrength,
		DefenseModifier,
		AdvisorType
		)
select	'BUILDING_CVS_SONGHAI_UI', -- BuildingType
		'LOC_BUILDING_CVS_SONGHAI_UI_NAME', -- Name
		'LOC_BUILDING_CVS_SONGHAI_UI_DESCRIPTION', -- Description
		'TRAIT_CIVILIZATION_BUILDING_CVS_SONGHAI_UI', -- TraitType
		NULL,
		'CIVIC_DIVINE_RIGHT',
		Cost,
		PrereqDistrict,
		Housing,
		'YIELD_FAITH',
		Maintenance,
		CitizenSlots,
		RegionalRange,
		OuterDefenseStrength,
		DefenseModifier,
		AdvisorType
from	Buildings
where	BuildingType = 'BUILDING_UNIVERSITY';

insert or replace into BuildingReplaces
	(CivUniqueBuildingType,			ReplacesBuildingType)
values
	('BUILDING_CVS_SONGHAI_UI',		'BUILDING_UNIVERSITY');

insert or replace into HD_BuildingTiers
	(BuildingType,					PrereqDistrict,				Tier,		ReplacesOther)
values
	('BUILDING_CVS_SONGHAI_UI',		'DISTRICT_CAMPUS',			2,			1);
insert or ignore into BuildingPrereqs
	(Building,					PrereqBuilding)
values
	('BUILDING_CVS_SONGHAI_UI',	'BUILDING_LIBRARY');

insert or ignore into BuildingReplaces
	(CivUniqueBuildingType,		ReplacesBuildingType)
values
	('BUILDING_CVS_SONGHAI_UI',	'BUILDING_UNIVERSITY');

insert or replace into Building_YieldChanges
	(BuildingType,				YieldType,			YieldChange)
values
	('BUILDING_CVS_SONGHAI_UI',	'YIELD_SCIENCE',	4),
	('BUILDING_CVS_SONGHAI_UI',	'YIELD_FAITH',		4);

insert or replace into Building_CitizenYieldChanges
	(BuildingType,				YieldType,			YieldChange)
values
	('BUILDING_CVS_SONGHAI_UI',	'YIELD_SCIENCE',	1),
	('BUILDING_CVS_SONGHAI_UI',	'YIELD_GOLD',		-1);

delete from Building_GreatPersonPoints where BuildingType = 'BUILDING_CVS_SONGHAI_UI';

insert or replace into Building_GreatPersonPoints
	(BuildingType,				GreatPersonClassType,	PointsPerTurn)
select
	'BUILDING_CVS_SONGHAI_UI',	GreatPersonClassType,	PointsPerTurn
from Building_GreatPersonPoints where BuildingType = 'BUILDING_UNIVERSITY';

delete from Building_GreatWorks where BuildingType = 'BUILDING_CVS_SONGHAI_UI';

insert or replace into Building_TourismBombs_XP2
	(BuildingType,					TourismBombValue)
select
	'BUILDING_CVS_SONGHAI_UI',		TourismBombValue
from Building_TourismBombs_XP2 where BuildingType = 'BUILDING_UNIVERSITY';

delete from BuildingModifiers where ModifierId = 'MODIFIER_CVS_SONGHAI_UA_GW_SCIENCE';

insert or replace into BuildingModifiers
	(BuildingType,					ModifierId)
values
	('BUILDING_CVS_SONGHAI_UI',		'UNIVERSITY_ADD_POPULATION_SCIENCE'),
	('BUILDING_CVS_SONGHAI_UI',		'FEUDALISM_ADD_RAINFOREST_ADJACENCY');

--城市
delete from CityNames where CivilizationType = 'CIVILIZATION_CVS_SONGHAI';

insert or replace into CityNames (ID, CivilizationType, CityName) values
(7001, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_GAO'),
(7002, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_TIMBUKTU'),
(7003, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_JENNE'),
(7004, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_KUKIYA'),
(7005, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_WALATA'),
(7006, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_GOUNDAM'),
(7007, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_BAMAKO'),
(7008, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_TAGHAZA'),
(7009, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_AGADEZ'),
(7010, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_ESSOUK'),
(7011, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_AWDAGHUST'),
(7012, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_SEGU'),
(7013, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_ARAOUANE'),
(7014, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_TAOUDENNI'),
(7015, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_SANSANDING'),
(7016, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_BANAMBA'),
(7017, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_BIRNIN_KEBB'),
(7018, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_KUMBI_SALEH'),
(7019, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_KANO'),
(7020, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_GWANDU'),
(7021, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_ZAZZAU'),
(7022, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_KAYI'),
(7023, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_TENENKOU'),
(7024, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_DOUENTZA'),
(7025, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_SARAFERE'),
(7026, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_YATENGA'),
(7027, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_NIORO'),
(7028, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_MASINA'),
(7029, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_ARGUNGU'),
(7030, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_MOPTI'),
(7031, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_OUATAGOUNA'),
(7032, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_TEKEDDA'),
(7033, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_OUADANE'),
(7034, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_NIAMEY'),
(7035, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_SAN'),
(7036, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_BOUSSA'),
(7037, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_TONDIBI'),
(7038, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_DORI'),
(7039, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_BAMBA'),
(7040, 'CIVILIZATION_CVS_SONGHAI', 'LOC_CITY_NAME_TORODI');

--山脉
delete from NamedMountainCivilizations where CivilizationType = 'CIVILIZATION_CVS_SONGHAI';

insert or replace into NamedMountainCivilizations (NamedMountainType, CivilizationType) values
('NAMED_MOUNTAIN_AIR',	'CIVILIZATION_CVS_SONGHAI');

insert or ignore into NamedMountains (NamedMountainType, Name) values
('NAMED_MOUNTAIN_AIR',	'LOC_NAMED_MOUNTAIN_AIR_HD_NAME');

--河流
delete from NamedRiverCivilizations where CivilizationType = 'CIVILIZATION_CVS_SONGHAI';

insert or replace into NamedRiverCivilizations (NamedRiverType, CivilizationType) values
('NAMED_RIVER_NIGER',	'CIVILIZATION_CVS_SONGHAI'),
('NAMED_RIVER_SANKARANI',	'CIVILIZATION_CVS_SONGHAI'),
('NAMED_RIVER_BANI',	'CIVILIZATION_CVS_SONGHAI'),
('NAMED_RIVER_SOKOTO',	'CIVILIZATION_CVS_SONGHAI');

insert or ignore into NamedRivers (NamedRiverType, Name) values
('NAMED_RIVER_NIGER',	'LOC_NAMED_RIVER_NIGER_NAME'),
('NAMED_RIVER_SANKARANI',	'LOC_NAMED_RIVER_SANKARANI_NAME'),
('NAMED_RIVER_BANI',	'LOC_NAMED_RIVER_BANI_NAME'),
('NAMED_RIVER_SOKOTO',	'LOC_NAMED_RIVER_SOKOTO_NAME');

--海洋
delete from NamedSeaCivilizations where CivilizationType = 'CIVILIZATION_CVS_SONGHAI';

insert or replace into NamedSeaCivilizations (NamedSeaType, CivilizationType) values
('NAMED_SEA_BENIN',	'CIVILIZATION_CVS_SONGHAI'),
('NAMED_SEA_GUINEA',	'CIVILIZATION_CVS_SONGHAI');

insert or ignore into NamedSeas (NamedSeaType, Name) values
('NAMED_SEA_BENIN',	'LOC_NAMED_SEA_BENIN_NAME'),
('NAMED_SEA_GUINEA',	'LOC_NAMED_SEA_GUINEA_NAME');

--湖泊
delete from NamedLakeCivilizations where CivilizationType = 'CIVILIZATION_CVS_SONGHAI';

insert or replace into NamedLakeCivilizations (NamedLakeType, CivilizationType) values
('NAMED_LAKE_GOSSI_HD',	'CIVILIZATION_CVS_SONGHAI');

insert or ignore into NamedLakes (NamedLakeType, Name) values
('NAMED_LAKE_GOSSI_HD',	'LOC_NAMED_LAKE_GOSSI_HD_NAME');

--火山
delete from NamedVolcanoCivilizations where CivilizationType = 'CIVILIZATION_CVS_SONGHAI';

insert or replace into NamedVolcanoCivilizations (NamedVolcanoType, CivilizationType) values
('NAMED_VOLCANO_TINTAEALLE',	'CIVILIZATION_CVS_SONGHAI');

insert or ignore into NamedVolcanoes (NamedVolcanoType, Name) values
('NAMED_VOLCANO_TINTAEALLE',	'LOC_NAMED_VOLCANO_TINTAEALLE_NAME');

--沙漠
delete from NamedDesertCivilizations where CivilizationType = 'CIVILIZATION_CVS_SONGHAI';

insert or replace into NamedDesertCivilizations (NamedDesertType, CivilizationType) values
('NAMED_DESERT_ARABIAN',	'CIVILIZATION_SUMERIA');

insert or ignore into NamedDeserts (NamedDesertType, Name) values
('NAMED_DESERT_ARABIAN',	'LOC_NAMED_DESERT_ARABIAN_NAME');