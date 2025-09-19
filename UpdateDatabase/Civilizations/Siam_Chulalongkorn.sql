-- Rename Type to disable lua scripts
update Types set Type = 'TRAIT_LEADER_SUK_MONTHON_SYSTEM_HD' where Type = 'TRAIT_LEADER_SUK_MONTHON_SYSTEM';
insert or replace into GlobalParameters
	(Name,								Value)
values
	('MONTHON_SYSTEM_ENVOY_COST',		1),
	('MONTHON_SYSTEM_GOVERNOR_AWARD',	1);
-- Governor
update Modifiers set SubjectRequirementSetId = 'SUK_DAMRONG_AOE_INCL_REQUIREMENTS' where SubjectRequirementSetId = 'SUK_DAMRONG_AOE_EXCL_REQUIREMENTS';
-- 1
update ModifierArguments set Value = 3 where (ModifierId = 'SUK_DAMRONG_ROYAL_SURVEY_PROD' or ModifierId = 'SUK_DAMRONG_ROYAL_SURVEY_FOOD') and Name = 'Amount';
-- L2
delete from GovernorPromotionModifiers where GovernorPromotionType = 'GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS';
insert or replace into GovernorPromotionModifiers
	(GovernorPromotionType,									ModifierId)
values
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',	'SANITARY_DISTRICTS_AQUEDUCT_PRODUCTION'),
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',	'SANITARY_DISTRICTS_DAM_PRODUCTION'),
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',	'SANITARY_DISTRICTS_CANAL_PRODUCTION'),
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',	'SANITARY_DISTRICTS_AQUEDUCT_BUILDING_PRODUCTION'),
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',	'SANITARY_DISTRICTS_DAM_BUILDING_PRODUCTION'),
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',	'SANITARY_DISTRICTS_CANAL_BUILDING_PRODUCTION'),
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',	'SANITARY_DISTRICTS_AQUEDUCT_FOOD'),
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',	'SANITARY_DISTRICTS_DAM_FOOD_CITY_ATTACH'),
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',	'SANITARY_DISTRICTS_CANAL_FOOD_CITY_ATTACH');
insert or replace into Modifiers
	(ModifierId,											ModifierType,											OwnerRequirementSetId,						SubjectRequirementSetId)
values
	('SANITARY_DISTRICTS_AQUEDUCT_PRODUCTION',				'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION',	null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SANITARY_DISTRICTS_DAM_PRODUCTION',					'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION',	null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SANITARY_DISTRICTS_CANAL_PRODUCTION',					'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION',	null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SANITARY_DISTRICTS_AQUEDUCT_BUILDING_PRODUCTION',		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION',	null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SANITARY_DISTRICTS_DAM_BUILDING_PRODUCTION',			'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION',	null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SANITARY_DISTRICTS_CANAL_BUILDING_PRODUCTION',		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION',	null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SANITARY_DISTRICTS_AQUEDUCT_FOOD',					'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',		'CITY_HAS_DISTRICT_AQUEDUCT_REQUIREMENTS',	'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SANITARY_DISTRICTS_DAM_FOOD_CITY_ATTACH',				'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',				null,										'DISTRICT_IS_DISTRICT_DAM_REQUIREMENTS'),
	('SANITARY_DISTRICTS_DAM_FOOD_ATTACH',					'MODIFIER_CITY_OWNER_ATTACH_MODIFIER',					null,										null),
	('SANITARY_DISTRICTS_DAM_FOOD',							'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',		null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SANITARY_DISTRICTS_CANAL_FOOD_CITY_ATTACH',			'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',				null,										'DISTRICT_IS_DISTRICT_CANAL_REQUIREMENTS'),
	('SANITARY_DISTRICTS_CANAL_FOOD_ATTACH',				'MODIFIER_CITY_OWNER_ATTACH_MODIFIER',					null,										null),
	('SANITARY_DISTRICTS_CANAL_FOOD',						'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',		null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,											Name,			Value)
values
	('SANITARY_DISTRICTS_AQUEDUCT_PRODUCTION',				'DistrictType',	'DISTRICT_AQUEDUCT'),
	('SANITARY_DISTRICTS_AQUEDUCT_PRODUCTION',				'Amount',		50),
	('SANITARY_DISTRICTS_DAM_PRODUCTION',					'DistrictType',	'DISTRICT_DAM'),
	('SANITARY_DISTRICTS_DAM_PRODUCTION',					'Amount',		50),
	('SANITARY_DISTRICTS_CANAL_PRODUCTION',					'DistrictType',	'DISTRICT_CANAL'),
	('SANITARY_DISTRICTS_CANAL_PRODUCTION',					'Amount',		50),
	('SANITARY_DISTRICTS_AQUEDUCT_BUILDING_PRODUCTION',		'DistrictType',	'DISTRICT_AQUEDUCT'),
	('SANITARY_DISTRICTS_AQUEDUCT_BUILDING_PRODUCTION',		'Amount',		50),
	('SANITARY_DISTRICTS_DAM_BUILDING_PRODUCTION',			'DistrictType',	'DISTRICT_DAM'),
	('SANITARY_DISTRICTS_DAM_BUILDING_PRODUCTION',			'Amount',		50),
	('SANITARY_DISTRICTS_CANAL_BUILDING_PRODUCTION',		'DistrictType',	'DISTRICT_CANAL'),
	('SANITARY_DISTRICTS_CANAL_BUILDING_PRODUCTION',		'Amount',		50),
	('SANITARY_DISTRICTS_AQUEDUCT_FOOD',					'YieldType',	'YIELD_FOOD'),
	('SANITARY_DISTRICTS_AQUEDUCT_FOOD',					'Amount',		1),
	('SANITARY_DISTRICTS_DAM_FOOD_CITY_ATTACH',				'ModifierId',	'SANITARY_DISTRICTS_DAM_FOOD_ATTACH'),
	('SANITARY_DISTRICTS_DAM_FOOD_ATTACH',					'ModifierId',	'SANITARY_DISTRICTS_DAM_FOOD'),
	('SANITARY_DISTRICTS_DAM_FOOD',							'YieldType',	'YIELD_FOOD'),
	('SANITARY_DISTRICTS_DAM_FOOD',							'Amount',		1),
	('SANITARY_DISTRICTS_CANAL_FOOD_CITY_ATTACH',			'ModifierId',	'SANITARY_DISTRICTS_CANAL_FOOD_ATTACH'),
	('SANITARY_DISTRICTS_CANAL_FOOD_ATTACH',				'ModifierId',	'SANITARY_DISTRICTS_CANAL_FOOD'),
	('SANITARY_DISTRICTS_CANAL_FOOD',						'YieldType',	'YIELD_FOOD'),
	('SANITARY_DISTRICTS_CANAL_FOOD',						'Amount',		1);
insert or replace into GovernorPromotionModifiers
	(GovernorPromotionType,									ModifierId)
select
	'GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',	'SANITARY_DISTRICTS_' || BuildingType || '_FOOD'
from HD_BuildingTiers where PrereqDistrict in ('DISTRICT_AQUEDUCT', 'DISTRICT_DAM', 'DISTRICT_CANAL');
insert or replace into Modifiers
	(ModifierId,											ModifierType,										OwnerRequirementSetId,							SubjectRequirementSetId)
select
	'SANITARY_DISTRICTS_' || BuildingType || '_FOOD',		'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',	'CITY_HAS_' || BuildingType || '_REQUIREMENTS',	'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'
from HD_BuildingTiers where PrereqDistrict in ('DISTRICT_AQUEDUCT', 'DISTRICT_DAM', 'DISTRICT_CANAL');
insert or replace into ModifierArguments
	(ModifierId,											Name,			Value)
select
	'SANITARY_DISTRICTS_' || BuildingType || '_FOOD',		'YieldType',	'YIELD_FOOD'
from HD_BuildingTiers where PrereqDistrict in ('DISTRICT_AQUEDUCT', 'DISTRICT_DAM', 'DISTRICT_CANAL');
insert or replace into ModifierArguments
	(ModifierId,											Name,			Value)
select
	'SANITARY_DISTRICTS_' || BuildingType || '_FOOD',		'Amount',		1
from HD_BuildingTiers where PrereqDistrict in ('DISTRICT_AQUEDUCT', 'DISTRICT_DAM', 'DISTRICT_CANAL');
-- R2
update ModifierArguments set Value = 2 where ModifierId like 'SUK_DAMRONG_SUANKULARB_COLLEGE_%' and Name = 'Amount';
insert or replace into GovernorPromotionModifiers
	(GovernorPromotionType,									ModifierId)
values
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SUANKULARB_COLLEGE',	'SUANKULARB_COLLEGE_CAMPUS_PRODUCTION'),
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SUANKULARB_COLLEGE',	'SUANKULARB_COLLEGE_CAMPUS_BUILDING_PRODUCTION');
	-- ('GOVERNOR_PROMOTION_SUK_DAMRONG_SUANKULARB_COLLEGE',	'SUANKULARB_COLLEGE_CAMPUS_SCIENCE');
insert or replace into Modifiers
	(ModifierId,											ModifierType,											OwnerRequirementSetId,						SubjectRequirementSetId)
values
	('SUANKULARB_COLLEGE_CAMPUS_PRODUCTION',				'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION',	null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SUANKULARB_COLLEGE_CAMPUS_BUILDING_PRODUCTION',		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION',	null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SUANKULARB_COLLEGE_CAMPUS_SCIENCE',					'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',		'CITY_HAS_DISTRICT_CAMPUS_REQUIREMENTS',	'SUK_DAMRONG_AOE_INCL_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,											Name,				Value)
values
	('SUANKULARB_COLLEGE_CAMPUS_PRODUCTION',				'DistrictType',		'DISTRICT_CAMPUS'),
	('SUANKULARB_COLLEGE_CAMPUS_PRODUCTION',				'Amount',			20),
	('SUANKULARB_COLLEGE_CAMPUS_BUILDING_PRODUCTION',		'DistrictType',		'DISTRICT_CAMPUS'),
	('SUANKULARB_COLLEGE_CAMPUS_BUILDING_PRODUCTION',		'Amount',			20),
	('SUANKULARB_COLLEGE_CAMPUS_SCIENCE',					'YieldType',		'YIELD_SCIENCE'),
	('SUANKULARB_COLLEGE_CAMPUS_SCIENCE',					'Amount',			2);
-- L3
delete from GovernorPromotionModifiers where GovernorPromotionType = 'GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS';
insert or replace into GovernorPromotionModifiers
	(GovernorPromotionType,									ModifierId)
values
	('GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS',		'MONTHON_REFORMS_PRODUCTION_ATTACH');
insert or replace into Modifiers
	(ModifierId,							ModifierType,											SubjectRequirementSetId)
values
	('MONTHON_REFORMS_PRODUCTION_ATTACH',	'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER',			'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('MONTHON_REFORMS_PRODUCTION',			'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_CHANGE',			'DISTRICT_IS_SPECIALTY_DISTRICT_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,							Name,			Value)
values
	('MONTHON_REFORMS_PRODUCTION_ATTACH',	'ModifierId',	'MONTHON_REFORMS_PRODUCTION'),
	('MONTHON_REFORMS_PRODUCTION',			'YieldType',	'YIELD_PRODUCTION'),
	('MONTHON_REFORMS_PRODUCTION',			'Amount',		2);
insert or replace into RequirementSets
	(RequirementSetId,				RequirementSetType)
values
	('CITY_HAS_MONTHON_REFORMS',	'REQUIREMENTSET_TEST_ALL');
insert or replace into RequirementSetRequirements
	(RequirementSetId,				RequirementId)
values
	('CITY_HAS_MONTHON_REFORMS',	'REQUIRES_CITY_HAS_MONTHON_REFORMS');
insert or replace into Requirements
	(RequirementId,							RequirementType)
values
	('REQUIRES_CITY_HAS_MONTHON_REFORMS',	'REQUIREMENT_CITY_HAS_SPECIFIC_GOVERNOR_PROMOTION_TYPE');
insert or replace into RequirementArguments
	(RequirementId,							Name,						Value)
values
	('REQUIRES_CITY_HAS_MONTHON_REFORMS',	'GovernorPromotionType',	'GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS');
-- R3
update ModifierArguments set Value = 2 where ModifierId like 'SUK_DAMRONG_SIAM_SOCIETY_%' and Name = 'Amount';
insert or replace into GovernorPromotionModifiers
	(GovernorPromotionType,									ModifierId)
values
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SIAM_SOCIETY',			'SIAM_SOCIETY_THEATER_PRODUCTION'),
	('GOVERNOR_PROMOTION_SUK_DAMRONG_SIAM_SOCIETY',			'SIAM_SOCIETY_THEATER_BUILDING_PRODUCTION');
	-- ('GOVERNOR_PROMOTION_SUK_DAMRONG_SIAM_SOCIETY',			'SIAM_SOCIETY_THEATER_CULTURE');
insert or replace into Modifiers
	(ModifierId,											ModifierType,											OwnerRequirementSetId,						SubjectRequirementSetId)
values
	('SIAM_SOCIETY_THEATER_PRODUCTION',						'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION',	null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SIAM_SOCIETY_THEATER_BUILDING_PRODUCTION',			'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION',	null,										'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'),
	('SIAM_SOCIETY_THEATER_CULTURE',						'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',		'CITY_HAS_DISTRICT_THEATER_REQUIREMENTS',	'SUK_DAMRONG_AOE_INCL_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,											Name,				Value)
values
	('SIAM_SOCIETY_THEATER_PRODUCTION',						'DistrictType',		'DISTRICT_THEATER'),
	('SIAM_SOCIETY_THEATER_PRODUCTION',						'Amount',			20),
	('SIAM_SOCIETY_THEATER_BUILDING_PRODUCTION',			'DistrictType',		'DISTRICT_THEATER'),
	('SIAM_SOCIETY_THEATER_BUILDING_PRODUCTION',			'Amount',			20),
	('SIAM_SOCIETY_THEATER_CULTURE',						'YieldType',		'YIELD_CULTURE'),
	('SIAM_SOCIETY_THEATER_CULTURE',						'Amount',			2);
-- 4
update ModifierArguments set Value = 10 where (ModifierId = 'SUK_DAMRONG_KHWAM_SIWILAI_CULTURE' or ModifierId = 'SUK_DAMRONG_KHWAM_SIWILAI_SCIENCE') and Name = 'Amount';

--补区域扩展
insert or ignore into GovernorPromotionModifiers			
		(GovernorPromotionType,										ModifierId)
select	'GOVERNOR_PROMOTION_SUK_DAMRONG_SIAM_SOCIETY',				'SUK_DAMRONG_SIAM_SOCIETY_' || BuildingType
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_THEATER' and Buildings.TraitType IS NULL;
-------------------------------------
-- Modifiers
-------------------------------------
insert or ignore into Modifiers	
		(ModifierId,												ModifierType,													OwnerRequirementSetId,									SubjectRequirementSetId)
select	'SUK_DAMRONG_SIAM_SOCIETY_' || BuildingType,				'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',				'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',		'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_THEATER' and Buildings.TraitType IS NULL;
-------------------------------------
-- ModifierArguments
-------------------------------------
insert or ignore into ModifierArguments
		(ModifierId,												Name,						Value)
select	'SUK_DAMRONG_SIAM_SOCIETY_' || BuildingType,				'YieldType',				'YIELD_CULTURE'
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_THEATER' and Buildings.TraitType IS NULL;

insert or ignore into ModifierArguments
		(ModifierId,											Name,						Value)
select	'SUK_DAMRONG_SIAM_SOCIETY_' || BuildingType,			'Amount',					2
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_THEATER' and Buildings.TraitType IS NULL;
--------------------------------------------------------------------
-- REQUIREMENTS
--------------------------------------------------------------------
-- RequirementSets
-------------------------------------
insert or ignore into RequirementSets
		(RequirementSetId,												RequirementSetType)
select	'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',				'REQUIREMENTSET_TEST_ALL'
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_THEATER' and Buildings.TraitType IS NULL;
-------------------------------------
-- RequirementSetRequirements
-------------------------------------
insert or ignore into RequirementSetRequirements
		(RequirementSetId,												RequirementId)
select	'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',				'SUK_DAMRONG_' || BuildingType
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_THEATER' and Buildings.TraitType IS NULL;
-------------------------------------
-- Requirements
-------------------------------------
insert or ignore into Requirements
		(RequirementId, 									RequirementType)
select	'SUK_DAMRONG_' || BuildingType,						'REQUIREMENT_CITY_HAS_BUILDING'
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_THEATER' and Buildings.TraitType IS NULL;
-------------------------------------
-- RequirementArguments
-------------------------------------
insert or ignore into RequirementArguments
		(RequirementId, 							Name,					Value)
select	'SUK_DAMRONG_' || BuildingType,	 			'BuildingType',			BuildingType
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_THEATER' and Buildings.TraitType IS NULL;

insert or ignore into GovernorPromotionModifiers			
		(GovernorPromotionType,										ModifierId)
select	'GOVERNOR_PROMOTION_SUK_DAMRONG_SUANKULARB_COLLEGE',		'SUK_DAMRONG_SUANKULARB_COLLEGE_' || BuildingType
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' and Buildings.TraitType IS NULL;
-------------------------------------
-- Modifiers
-------------------------------------
insert or ignore into Modifiers	
		(ModifierId,												ModifierType,													OwnerRequirementSetId,									SubjectRequirementSetId)
select	'SUK_DAMRONG_SUANKULARB_COLLEGE_' || BuildingType,			'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',				'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',		'SUK_DAMRONG_AOE_INCL_REQUIREMENTS'
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' and Buildings.TraitType IS NULL;
-------------------------------------
-- ModifierArguments
-------------------------------------
insert or ignore into ModifierArguments
		(ModifierId,												Name,						Value)
select	'SUK_DAMRONG_SUANKULARB_COLLEGE_' || BuildingType,			'YieldType',				'YIELD_SCIENCE'
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' and Buildings.TraitType IS NULL;

insert or ignore into ModifierArguments
		(ModifierId,												Name,						Value)
select	'SUK_DAMRONG_SUANKULARB_COLLEGE_' || BuildingType,			'Amount',					2
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' and Buildings.TraitType IS NULL;
--------------------------------------------------------------------
-- REQUIREMENTS
--------------------------------------------------------------------
-- RequirementSets
-------------------------------------
insert or ignore into RequirementSets
		(RequirementSetId,												RequirementSetType)
select	'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',				'REQUIREMENTSET_TEST_ALL'
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' and Buildings.TraitType IS NULL;
-------------------------------------
-- RequirementSetRequirements
-------------------------------------
insert or ignore into RequirementSetRequirements
		(RequirementSetId,												RequirementId)
select	'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',				'SUK_DAMRONG_' || BuildingType
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' and Buildings.TraitType IS NULL;
-------------------------------------
-- Requirements
-------------------------------------
insert or ignore into Requirements
		(RequirementId, 									RequirementType)
select	'SUK_DAMRONG_' || BuildingType,						'REQUIREMENT_CITY_HAS_BUILDING'
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' and Buildings.TraitType IS NULL;
-------------------------------------
-- RequirementArguments
-------------------------------------
insert or ignore into RequirementArguments
		(RequirementId, 							Name,					Value)
select	'SUK_DAMRONG_' || BuildingType,	 			'BuildingType',			BuildingType
from Buildings where Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' and Buildings.TraitType IS NULL;

