
--复制suk代码撞死suk改动避免suk更新导致bug
														-- GOVERNORS --
--==========================================================================================================================
	-- Types
	-------------------------------------
		INSERT or ignore INTO Types
				(Type,														Kind)
		VALUES	('GOVERNOR_SUK_DAMRONG',									'KIND_GOVERNOR'),
				-- Tier 0
				('GOVERNOR_PROMOTION_SUK_DAMRONG_ROYAL_SURVEY',				'KIND_GOVERNOR_PROMOTION'),
				-- Tier 1
				('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',		'KIND_GOVERNOR_PROMOTION'),
				('GOVERNOR_PROMOTION_SUK_DAMRONG_SUANKULARB_COLLEGE',		'KIND_GOVERNOR_PROMOTION'),
				-- Tier 2
				('GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS',			'KIND_GOVERNOR_PROMOTION'),
				('GOVERNOR_PROMOTION_SUK_DAMRONG_SIAM_SOCIETY',				'KIND_GOVERNOR_PROMOTION'),
				-- Tier 3
				('GOVERNOR_PROMOTION_SUK_DAMRONG_KHWAM_SIWILAI',			'KIND_GOVERNOR_PROMOTION');
	-------------------------------------
	-- Governors
	-------------------------------------
		INSERT or ignore INTO Governors
			(
				GovernorType,

				Name,
				Title,
				ShortTitle,
				Description,

				IdentityPressure,
				TransitionStrength,

				Image,
				PortraitImage,
				PortraitImageSelected,

				TraitType
			)
		VALUES
			(
				'GOVERNOR_SUK_DAMRONG',

				'LOC_GOVERNOR_SUK_DAMRONG_NAME',
				'LOC_GOVERNOR_SUK_DAMRONG_TITLE',
				'LOC_GOVERNOR_SUK_DAMRONG_SHORT_TITLE',
				'LOC_GOVERNOR_SUK_DAMRONG_DESCRIPTION',

				8,
				150,

				'GovernorSelected_Suk_Damrong',	
				'GovernorNormal_Suk_Damrong',
				'GovernorSelected_Suk_Damrong',

				'TRAIT_LEADER_SUK_MONTHON_SYSTEM'
			);
	-------------------------------------
	-- GovernorPromotionSets
	-------------------------------------
		INSERT or ignore INTO GovernorPromotionSets
				(GovernorType,					GovernorPromotion)
				-- Tier 0
		VALUES	('GOVERNOR_SUK_DAMRONG',		'GOVERNOR_PROMOTION_SUK_DAMRONG_ROYAL_SURVEY'),
				-- Tier 1
				('GOVERNOR_SUK_DAMRONG',		'GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS'),
				('GOVERNOR_SUK_DAMRONG',		'GOVERNOR_PROMOTION_SUK_DAMRONG_SUANKULARB_COLLEGE'),
				-- Tier 2
				('GOVERNOR_SUK_DAMRONG',		'GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS'),
				('GOVERNOR_SUK_DAMRONG',		'GOVERNOR_PROMOTION_SUK_DAMRONG_SIAM_SOCIETY'),
				-- Tier 3
				('GOVERNOR_SUK_DAMRONG',		'GOVERNOR_PROMOTION_SUK_DAMRONG_KHWAM_SIWILAI');
	-------------------------------------
	-- GovernorPromotions
	-------------------------------------
		INSERT or ignore INTO GovernorPromotions
				(GovernorPromotionType,										Level,	Column,		BaseAbility,	Name,			Description)
		VALUES	('GOVERNOR_PROMOTION_SUK_DAMRONG_ROYAL_SURVEY',				0,		1,			1,				'LOC_NAME',		'LOC_DESC'),
				-- Tier 1
				('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',		1,		0,			0,				'LOC_NAME',		'LOC_DESC'),
				('GOVERNOR_PROMOTION_SUK_DAMRONG_SUANKULARB_COLLEGE',		1,		2,			0,				'LOC_NAME',		'LOC_DESC'),
				-- Tier 2
				('GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS',			2,		0,			0,				'LOC_NAME',		'LOC_DESC'),
				('GOVERNOR_PROMOTION_SUK_DAMRONG_SIAM_SOCIETY',				2,		2,			0,				'LOC_NAME',		'LOC_DESC'),
				-- Tier 3
				('GOVERNOR_PROMOTION_SUK_DAMRONG_KHWAM_SIWILAI',			3,		1,			0,				'LOC_NAME',		'LOC_DESC');

		UPDATE GovernorPromotions
		SET Name = 'LOC_' || GovernorPromotions.GovernorPromotionType || '_NAME',
			Description = 'LOC_' || GovernorPromotions.GovernorPromotionType || '_DESCRIPTION'
		WHERE GovernorPromotionType IN (SELECT GovernorPromotion FROM GovernorPromotionSets WHERE GovernorType = 'GOVERNOR_SUK_DAMRONG');
	-------------------------------------
	-- GovernorPromotionPrereqs
	-------------------------------------
		INSERT or ignore INTO GovernorPromotionPrereqs
				(GovernorPromotionType,										PrereqGovernorPromotion)
				-- Tier 1
		VALUES	('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS',		'GOVERNOR_PROMOTION_SUK_DAMRONG_ROYAL_SURVEY'),
				('GOVERNOR_PROMOTION_SUK_DAMRONG_SUANKULARB_COLLEGE',		'GOVERNOR_PROMOTION_SUK_DAMRONG_ROYAL_SURVEY'),
				-- Tier 2
				('GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS',			'GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS'),
				('GOVERNOR_PROMOTION_SUK_DAMRONG_SIAM_SOCIETY',				'GOVERNOR_PROMOTION_SUK_DAMRONG_SUANKULARB_COLLEGE'),
				-- Tier 3
				('GOVERNOR_PROMOTION_SUK_DAMRONG_KHWAM_SIWILAI',			'GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS'),
				('GOVERNOR_PROMOTION_SUK_DAMRONG_KHWAM_SIWILAI',			'GOVERNOR_PROMOTION_SUK_DAMRONG_SIAM_SOCIETY');
--==========================================================================================================================
-- MomentIllustrations
--==========================================================================================================================
	INSERT or ignore INTO MomentIllustrations
			(MomentIllustrationType, 					MomentDataType,				GameDataType,					Texture)
	VALUES	('MOMENT_ILLUSTRATION_GOVERNOR', 			'MOMENT_DATA_GOVERNOR',		'GOVERNOR_SUK_DAMRONG',			'Moment_PromoteGovernor_Suk_Damrong');
--==========================================================================================================================
													-- GOVERNORS PROMOTIONS --
--==========================================================================================================================
-- REQUIREMENTS: Within 6 Tiles
-- Common, we'll be using these a lot
--------------------------------------------------------------------
	-- RequirementSets
	-------------------------------------
		INSERT or ignore INTO RequirementSets
				(RequirementSetId,										RequirementSetType)
		VALUES	('SUK_DAMRONG_AOE_INCL_REQUIREMENTS',					'REQUIREMENTSET_TEST_ALL'),
				('SUK_DAMRONG_AOE_EXCL_REQUIREMENTS',					'REQUIREMENTSET_TEST_ALL');
	-------------------------------------
	-- RequirementSetRequirements
	-------------------------------------
		INSERT or ignore INTO RequirementSetRequirements
				(RequirementSetId,									RequirementId)
		VALUES	('SUK_DAMRONG_AOE_INCL_REQUIREMENTS',				'SUK_DAMRONG_REQUIRES_AOE_INCL'),
				('SUK_DAMRONG_AOE_EXCL_REQUIREMENTS',				'SUK_DAMRONG_REQUIRES_AOE_EXCL');
	-------------------------------------
	-- Requirements
	-------------------------------------
		INSERT or ignore INTO Requirements
				(RequirementId, 									RequirementType)
		VALUES	('SUK_DAMRONG_REQUIRES_AOE_INCL',					'REQUIREMENT_PLOT_ADJACENT_TO_OWNER'), -- Includes center tile
				('SUK_DAMRONG_REQUIRES_AOE_EXCL',					'REQUIREMENT_PLOT_ADJACENT_TO_OWNER'); -- Excludes center tile
	-------------------------------------
	-- RequirementArguments
	-------------------------------------
		INSERT or ignore INTO RequirementArguments
				(RequirementId, 									Name,					Value)
		VALUES	('SUK_DAMRONG_REQUIRES_AOE_INCL', 					'MinDistance',			0),
				('SUK_DAMRONG_REQUIRES_AOE_INCL', 					'MaxDistance',			6),

				('SUK_DAMRONG_REQUIRES_AOE_EXCL', 					'MinDistance',			1),
				('SUK_DAMRONG_REQUIRES_AOE_EXCL', 					'MaxDistance',			6);
--===================================================================
-- Survey Deparment
-- +2 [ICON_Production] Production, +2 [ICON_Food] Food to this city and your other cities within 6 tiles
--------------------------------------------------------------------
	-- MODIFIERS
	--------------------------------------------------------------------
		-- GovernorPromotionModifiers
		-------------------------------------
		INSERT or ignore INTO GovernorPromotionModifiers
				(GovernorPromotionType,									ModifierId)
		VALUES	('GOVERNOR_PROMOTION_SUK_DAMRONG_ROYAL_SURVEY', 		'SUK_DAMRONG_ROYAL_SURVEY_PROD'),
				('GOVERNOR_PROMOTION_SUK_DAMRONG_ROYAL_SURVEY', 		'SUK_DAMRONG_ROYAL_SURVEY_FOOD');
		-------------------------------------
		-- Modifiers
		-------------------------------------
			INSERT or ignore INTO Modifiers
					(
						ModifierId,
						ModifierType,
						SubjectRequirementSetId
					)
			VALUES	(
						'SUK_DAMRONG_ROYAL_SURVEY_PROD',
						'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',
						'SUK_DAMRONG_AOE_EXCL_REQUIREMENTS'
					),
					(
						'SUK_DAMRONG_ROYAL_SURVEY_FOOD',
						'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',
						'SUK_DAMRONG_AOE_EXCL_REQUIREMENTS'
					);
		-------------------------------------
		-- ModifierArguments
		-------------------------------------
			INSERT or ignore INTO ModifierArguments
					(ModifierId,							Name,				Value)
			VALUES	('SUK_DAMRONG_ROYAL_SURVEY_PROD',		'YieldType',		'YIELD_PRODUCTION'),
					('SUK_DAMRONG_ROYAL_SURVEY_PROD',		'Amount',			2),

					('SUK_DAMRONG_ROYAL_SURVEY_FOOD',		'YieldType',		'YIELD_FOOD'),
					('SUK_DAMRONG_ROYAL_SURVEY_FOOD',		'Amount',			2);
--===================================================================
-- Sanitary Districts
-- +1 [ICON_Housing] Housing, +1 [ICON_Amenities] Amenity to your other cities within 6 tiles,
-- increasing to +3 [ICON_Housing] Housing, +2 [ICON_Amenities] Amenities if this city has an Aqueduct district.
--------------------------------------------------------------------
	-- MODIFIERS
	--------------------------------------------------------------------
		-- GovernorPromotionModifiers
		-------------------------------------
			INSERT or ignore INTO GovernorPromotionModifiers
					(GovernorPromotionType,										ModifierId)
			VALUES	('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS', 		'SUK_DAMRONG_SANITARY_DISTRICTS_HOUSING'),
					('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS', 		'SUK_DAMRONG_SANITARY_DISTRICTS_AMENITIES'),

					('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS', 		'SUK_DAMRONG_SANITARY_DISTRICTS_AQUEDUCT_HOUSING'),
					('GOVERNOR_PROMOTION_SUK_DAMRONG_SANITARY_DISTRICTS', 		'SUK_DAMRONG_SANITARY_DISTRICTS_AQUEDUCT_AMENITIES');
		-------------------------------------
		-- Modifiers
		-------------------------------------
		INSERT or ignore INTO Modifiers
				(
					ModifierId,
					ModifierType,
					OwnerRequirementSetId,
					SubjectRequirementSetId
				)
		VALUES	(
					'SUK_DAMRONG_SANITARY_DISTRICTS_HOUSING',
					'MODIFIER_PLAYER_CITIES_ADJUST_WATER_HOUSING',
					NULL,
					'SUK_DAMRONG_AOE_EXCL_REQUIREMENTS'
				),
				(
					'SUK_DAMRONG_SANITARY_DISTRICTS_AMENITIES',
					'MODIFIER_PLAYER_CITIES_ADJUST_AMENITIES_FROM_GOVERNORS',
					NULL,
					'SUK_DAMRONG_AOE_EXCL_REQUIREMENTS'
				),

				(
					'SUK_DAMRONG_SANITARY_DISTRICTS_AQUEDUCT_HOUSING',
					'MODIFIER_PLAYER_CITIES_ADJUST_WATER_HOUSING',
					'SUK_DAMRONG_HAS_AQUEDUCT_REQUIREMENTS',
					'SUK_DAMRONG_AOE_EXCL_REQUIREMENTS'
				),
				(
					'SUK_DAMRONG_SANITARY_DISTRICTS_AQUEDUCT_AMENITIES',
					'MODIFIER_PLAYER_CITIES_ADJUST_AMENITIES_FROM_GOVERNORS',
					'SUK_DAMRONG_HAS_AQUEDUCT_REQUIREMENTS',
					'SUK_DAMRONG_AOE_EXCL_REQUIREMENTS'
				);
		-------------------------------------
		-- ModifierArguments
		-------------------------------------
			INSERT or ignore INTO ModifierArguments
					(ModifierId,												Name,							Value)
			VALUES	('SUK_DAMRONG_SANITARY_DISTRICTS_HOUSING',					'Amount',						1),
					('SUK_DAMRONG_SANITARY_DISTRICTS_AMENITIES',				'Amount',						1),

					('SUK_DAMRONG_SANITARY_DISTRICTS_AQUEDUCT_HOUSING',			'Amount',						2),
					('SUK_DAMRONG_SANITARY_DISTRICTS_AQUEDUCT_AMENITIES',		'Amount',						1);
	--------------------------------------------------------------------
	-- REQUIREMENTS
	--------------------------------------------------------------------
		-- RequirementSets
		-------------------------------------
			INSERT or ignore INTO RequirementSets
					(RequirementSetId,										RequirementSetType)
			VALUES	('SUK_DAMRONG_HAS_AQUEDUCT_REQUIREMENTS',				'REQUIREMENTSET_TEST_ALL');
		-------------------------------------
		-- RequirementSetRequirements
		-------------------------------------
			INSERT or ignore INTO RequirementSetRequirements
					(RequirementSetId,									RequirementId)
			VALUES	('SUK_DAMRONG_HAS_AQUEDUCT_REQUIREMENTS',			'SUK_DAMRONG_HAS_AQUEDUCT');
		-------------------------------------
		-- Requirements
		-------------------------------------
			INSERT or ignore INTO Requirements
					(RequirementId, 									RequirementType)
			VALUES	('SUK_DAMRONG_HAS_AQUEDUCT',						'REQUIREMENT_CITY_HAS_DISTRICT');
		-------------------------------------
		-- RequirementArguments
		-------------------------------------
			INSERT or ignore INTO RequirementArguments
					(RequirementId, 							Name,					Value)
			VALUES	('SUK_DAMRONG_HAS_AQUEDUCT', 				'DistrictType',			'DISTRICT_AQUEDUCT');
--===================================================================
-- Suan Kulap College
-- +1 [ICON_Science] Science to your other cities within 6 tiles for each Campus district building in this city.
--------------------------------------------------------------------
	-- MODIFIERS
	--------------------------------------------------------------------
		-- GovernorPromotionModifiers
		-------------------------------------
			INSERT or ignore INTO GovernorPromotionModifiers
					(GovernorPromotionType,										ModifierId)
			VALUES	('GOVERNOR_PROMOTION_SUK_DAMRONG_SUANKULARB_COLLEGE',		'SUK_DAMRONG_SUANKULARB_COLLEGE_DISTRICT_CAMPUS');

			INSERT or ignore INTO GovernorPromotionModifiers
					(GovernorPromotionType,										ModifierId)
			SELECT	'GOVERNOR_PROMOTION_SUK_DAMRONG_SUANKULARB_COLLEGE',		'SUK_DAMRONG_SUANKULARB_COLLEGE_' || BuildingType
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' AND Buildings.TraitType IS NULL;
		-------------------------------------
		-- Modifiers
		-------------------------------------
			INSERT or ignore INTO Modifiers
					(
						ModifierId,
						ModifierType,
						OwnerRequirementSetId,
						SubjectRequirementSetId
					)
			VALUES	(
						'SUK_DAMRONG_SUANKULARB_COLLEGE_DISTRICT_CAMPUS',
						'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',
						'SUK_DAMRONG_DISTRICT_CAMPUS_REQUIREMENTS',
						'SUK_DAMRONG_AOE_EXCL_REQUIREMENTS'
					);

			INSERT or ignore INTO Modifiers
					(ModifierId,												ModifierType,													OwnerRequirementSetId,									SubjectRequirementSetId)
			SELECT	'SUK_DAMRONG_SUANKULARB_COLLEGE_' || BuildingType,			'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',				'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',		'SUK_DAMRONG_AOE_EXCL_REQUIREMENTS'
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' AND Buildings.TraitType IS NULL;
		-------------------------------------
		-- ModifierArguments
		-------------------------------------
			INSERT or ignore INTO ModifierArguments
					(ModifierId,											Name,				Value)
			VALUES	('SUK_DAMRONG_SUANKULARB_COLLEGE_DISTRICT_CAMPUS',		'YieldType',		'YIELD_SCIENCE'),
					('SUK_DAMRONG_SUANKULARB_COLLEGE_DISTRICT_CAMPUS',		'Amount',			1);

			INSERT or ignore INTO ModifierArguments
					(ModifierId,												Name,						Value)
			SELECT	'SUK_DAMRONG_SUANKULARB_COLLEGE_' || BuildingType,			'YieldType',				'YIELD_SCIENCE'
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' AND Buildings.TraitType IS NULL;

			INSERT or ignore INTO ModifierArguments
					(ModifierId,												Name,						Value)
			SELECT	'SUK_DAMRONG_SUANKULARB_COLLEGE_' || BuildingType,			'Amount',					1
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' AND Buildings.TraitType IS NULL;
	--------------------------------------------------------------------
	-- REQUIREMENTS
	--------------------------------------------------------------------
		-- RequirementSets
		-------------------------------------
			INSERT or ignore INTO RequirementSets
					(RequirementSetId,										RequirementSetType)
			VALUES	('SUK_DAMRONG_DISTRICT_CAMPUS_REQUIREMENTS',			'REQUIREMENTSET_TEST_ALL');

			INSERT or ignore INTO RequirementSets
					(RequirementSetId,												RequirementSetType)
			SELECT	'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',				'REQUIREMENTSET_TEST_ALL'
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' AND Buildings.TraitType IS NULL;
		-------------------------------------
		-- RequirementSetRequirements
		-------------------------------------
			INSERT or ignore INTO RequirementSetRequirements
					(RequirementSetId,										RequirementId)
			VALUES	('SUK_DAMRONG_DISTRICT_CAMPUS_REQUIREMENTS',			'REQUIRES_CITY_HAS_CAMPUS');

			INSERT or ignore INTO RequirementSetRequirements
					(RequirementSetId,												RequirementId)
			SELECT	'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',				'SUK_DAMRONG_' || BuildingType
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' AND Buildings.TraitType IS NULL;
		-------------------------------------
		-- Requirements
		-------------------------------------
			INSERT or ignore INTO Requirements
					(RequirementId, 									RequirementType)
			SELECT	'SUK_DAMRONG_' || BuildingType,						'REQUIREMENT_CITY_HAS_BUILDING'
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' AND Buildings.TraitType IS NULL;
		-------------------------------------
		-- RequirementArguments
		-------------------------------------
			INSERT or ignore INTO RequirementArguments
					(RequirementId, 							Name,					Value)
			SELECT	'SUK_DAMRONG_' || BuildingType,	 			'BuildingType',			BuildingType
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_CAMPUS' AND Buildings.TraitType IS NULL;
--===================================================================
-- Monthon Reforms
-- Your other cities within 6 tiles provide +1 [ICON_Production] Production, +1 [ICON_GOLD] Gold to this City.
-- They provide an additonal +1 [ICON_Production] Production, +1 [ICON_GOLD] Gold if they have a Floating Market
--------------------------------------------------------------------
	-- MODIFIERS
	--------------------------------------------------------------------
		-- GovernorPromotionModifiers
		-------------------------------------
			INSERT or ignore INTO GovernorPromotionModifiers
					(GovernorPromotionType,									ModifierId)
			VALUES	('GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS',		'SUK_DAMRONG_MONTHON_REFORMS_PRODUCTION'),
					('GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS',		'SUK_DAMRONG_MONTHON_REFORMS_GOLD'),

					('GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS',		'SUK_DAMRONG_MONTHON_REFORMS_PRODUCTION_2'),
					('GOVERNOR_PROMOTION_SUK_DAMRONG_MONTHON_REFORMS',		'SUK_DAMRONG_MONTHON_REFORMS_GOLD_2');
		-------------------------------------
		-- Modifiers
		-------------------------------------
			INSERT or ignore INTO Modifiers
					(
						ModifierId,
						ModifierType,
						SubjectRequirementSetId
					)
			VALUES	(
						'SUK_DAMRONG_MONTHON_REFORMS_PRODUCTION',
						'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',
						'SUK_DAMRONG_MONTHON_REFORMS_REQUIREMENTS'
					),
					(
						'SUK_DAMRONG_MONTHON_REFORMS_GOLD',
						'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',
						'SUK_DAMRONG_MONTHON_REFORMS_REQUIREMENTS'
					),
					(
						'SUK_DAMRONG_MONTHON_REFORMS_PRODUCTION_2',
						'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',
						'SUK_DAMRONG_MONTHON_REFORMS_FLOATING_MARKET_REQUIREMENTS'
					),
					(
						'SUK_DAMRONG_MONTHON_REFORMS_GOLD_2',
						'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',
						'SUK_DAMRONG_MONTHON_REFORMS_FLOATING_MARKET_REQUIREMENTS'
					),
					-----------------------------------------------
					(
						'SUK_DAMRONG_MONTHON_REFORMS_PRODUCTION_MODIFIER',
						'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',
						'SUK_DAMRONG_MONTHON_REFORMS_DAMRONG_REQUIREMENTS'
					),
					(
						'SUK_DAMRONG_MONTHON_REFORMS_GOLD_MODIFIER',
						'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',
						'SUK_DAMRONG_MONTHON_REFORMS_DAMRONG_REQUIREMENTS'
					);
		-------------------------------------
		-- ModifierArguments
		-------------------------------------
			INSERT or ignore INTO ModifierArguments
					(ModifierId,											Name,				Value)
			VALUES	('SUK_DAMRONG_MONTHON_REFORMS_PRODUCTION',				'ModifierId',		'SUK_DAMRONG_MONTHON_REFORMS_PRODUCTION_MODIFIER'),
					('SUK_DAMRONG_MONTHON_REFORMS_PRODUCTION_2',			'ModifierId',		'SUK_DAMRONG_MONTHON_REFORMS_PRODUCTION_MODIFIER'),
					('SUK_DAMRONG_MONTHON_REFORMS_GOLD',					'ModifierId',		'SUK_DAMRONG_MONTHON_REFORMS_GOLD_MODIFIER'),
					('SUK_DAMRONG_MONTHON_REFORMS_GOLD_2',					'ModifierId',		'SUK_DAMRONG_MONTHON_REFORMS_GOLD_MODIFIER'),

					('SUK_DAMRONG_MONTHON_REFORMS_PRODUCTION_MODIFIER',		'YieldType',		'YIELD_PRODUCTION'),
					('SUK_DAMRONG_MONTHON_REFORMS_PRODUCTION_MODIFIER',		'Amount',			1),
					('SUK_DAMRONG_MONTHON_REFORMS_GOLD_MODIFIER',			'YieldType',		'YIELD_GOLD'),
					('SUK_DAMRONG_MONTHON_REFORMS_GOLD_MODIFIER',			'Amount',			1);
	--------------------------------------------------------------------
	-- REQUIREMENTS
	--------------------------------------------------------------------
		-- RequirementSets
		-------------------------------------
			INSERT or ignore INTO RequirementSets
					(RequirementSetId,												RequirementSetType)
			VALUES	('SUK_DAMRONG_MONTHON_REFORMS_REQUIREMENTS',					'REQUIREMENTSET_TEST_ALL'),
					('SUK_DAMRONG_MONTHON_REFORMS_FLOATING_MARKET_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL'),

					('SUK_DAMRONG_MONTHON_REFORMS_DAMRONG_REQUIREMENTS',			'REQUIREMENTSET_TEST_ALL');
		-------------------------------------
		-- RequirementSetRequirements
		-------------------------------------
			INSERT or ignore INTO RequirementSetRequirements
					(RequirementSetId,												RequirementId)
			VALUES	('SUK_DAMRONG_MONTHON_REFORMS_REQUIREMENTS',					'SUK_DAMRONG_REQUIRES_AOE_EXCL'),

					('SUK_DAMRONG_MONTHON_REFORMS_FLOATING_MARKET_REQUIREMENTS',	'SUK_DAMRONG_REQUIRES_AOE_EXCL'),
					('SUK_DAMRONG_MONTHON_REFORMS_FLOATING_MARKET_REQUIREMENTS',	'REQUIRES_CITY_HAS_COMMERCIAL_HUB'),

					('SUK_DAMRONG_MONTHON_REFORMS_DAMRONG_REQUIREMENTS',			'SUK_DAMRONG_REQUIRES_DAMRONG');
		-------------------------------------
		-- Requirements
		-------------------------------------
			INSERT or ignore INTO Requirements
					(
						RequirementId,
						RequirementType,
						Inverse
					)
			VALUES	(
						'SUK_DAMRONG_REQUIRES_DAMRONG',
						'REQUIREMENT_CITY_HAS_SPECIFIC_GOVERNOR_PROMOTION_TYPE',
						0
					),
					(
						'SUK_DAMRONG_REQUIRES_NOT_DAMRONG',
						'REQUIREMENT_CITY_HAS_SPECIFIC_GOVERNOR_PROMOTION_TYPE',
						1
					);
		-------------------------------------
		-- RequirementArguments
		-------------------------------------
			INSERT or ignore INTO RequirementArguments
					(RequirementId, 							Name,							Value)
			VALUES	('SUK_DAMRONG_REQUIRES_DAMRONG', 			'Established',					1),
					('SUK_DAMRONG_REQUIRES_DAMRONG', 			'GovernorPromotionType',		'GOVERNOR_PROMOTION_SUK_DAMRONG_ROYAL_SURVEY'),

					('SUK_DAMRONG_REQUIRES_NOT_DAMRONG', 		'Established',					1),
					('SUK_DAMRONG_REQUIRES_NOT_DAMRONG', 		'GovernorPromotionType',		'GOVERNOR_PROMOTION_SUK_DAMRONG_ROYAL_SURVEY');
--===================================================================
-- The Siam Society
-- +1 [ICON_Culture] Culture to your other cities within 6 tiles for each Theatre Square district building in this city.
--------------------------------------------------------------------
	-- MODIFIERS
	--------------------------------------------------------------------
		-- GovernorPromotionModifiers
		-------------------------------------
			INSERT or ignore INTO GovernorPromotionModifiers
					(GovernorPromotionType,										ModifierId)
			VALUES	('GOVERNOR_PROMOTION_SUK_DAMRONG_SIAM_SOCIETY',				'SUK_DAMRONG_SIAM_SOCIETY_DISTRICT_THEATER');

			INSERT or ignore INTO GovernorPromotionModifiers
					(GovernorPromotionType,										ModifierId)
			SELECT	'GOVERNOR_PROMOTION_SUK_DAMRONG_SIAM_SOCIETY',				'SUK_DAMRONG_SIAM_SOCIETY_' || BuildingType
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_THEATER' AND Buildings.TraitType IS NULL;
		-------------------------------------
		-- Modifiers
		-------------------------------------
			INSERT or ignore INTO Modifiers
					(
						ModifierId,
						ModifierType,
						OwnerRequirementSetId,
						SubjectRequirementSetId
					)
			VALUES	(
						'SUK_DAMRONG_SIAM_SOCIETY_DISTRICT_THEATER',
						'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',
						'SUK_DAMRONG_DISTRICT_THEATER_REQUIREMENTS',
						'SUK_DAMRONG_AOE_EXCL_REQUIREMENTS'
					);

			INSERT or ignore INTO Modifiers
					(ModifierId,												ModifierType,													OwnerRequirementSetId,									SubjectRequirementSetId)
			SELECT	'SUK_DAMRONG_SIAM_SOCIETY_' || BuildingType,				'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',				'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',		'SUK_DAMRONG_AOE_EXCL_REQUIREMENTS'
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_THEATER' AND Buildings.TraitType IS NULL;
		-------------------------------------
		-- ModifierArguments
		-------------------------------------
			INSERT or ignore INTO ModifierArguments
					(ModifierId,											Name,				Value)
			VALUES	('SUK_DAMRONG_SIAM_SOCIETY_DISTRICT_THEATER',			'YieldType',		'YIELD_CULTURE'),
					('SUK_DAMRONG_SIAM_SOCIETY_DISTRICT_THEATER',			'Amount',			1);

			INSERT or ignore INTO ModifierArguments
					(ModifierId,												Name,						Value)
			SELECT	'SUK_DAMRONG_SIAM_SOCIETY_' || BuildingType,				'YieldType',				'YIELD_CULTURE'
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_THEATER' AND Buildings.TraitType IS NULL;

			INSERT or ignore INTO ModifierArguments
					(ModifierId,											Name,						Value)
			SELECT	'SUK_DAMRONG_SIAM_SOCIETY_' || BuildingType,			'Amount',					1
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_THEATER' AND Buildings.TraitType IS NULL;
	--------------------------------------------------------------------
	-- REQUIREMENTS
	--------------------------------------------------------------------
		-- RequirementSets
		-------------------------------------
			INSERT or ignore INTO RequirementSets
					(RequirementSetId,										RequirementSetType)
			VALUES	('SUK_DAMRONG_DISTRICT_THEATER_REQUIREMENTS',			'REQUIREMENTSET_TEST_ALL');

			INSERT or ignore INTO RequirementSets
					(RequirementSetId,												RequirementSetType)
			SELECT	'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',				'REQUIREMENTSET_TEST_ALL'
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_THEATER' AND Buildings.TraitType IS NULL;
		-------------------------------------
		-- RequirementSetRequirements
		-------------------------------------
			INSERT or ignore INTO RequirementSetRequirements
					(RequirementSetId,										RequirementId)
			VALUES	('SUK_DAMRONG_DISTRICT_THEATER_REQUIREMENTS',			'REQUIRES_CITY_HAS_THEATER_DISTRICT');

			INSERT or ignore INTO RequirementSetRequirements
					(RequirementSetId,												RequirementId)
			SELECT	'SUK_DAMRONG_' || BuildingType || '_REQUIREMENTS',				'SUK_DAMRONG_' || BuildingType
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_THEATER' AND Buildings.TraitType IS NULL;
		-------------------------------------
		-- Requirements
		-------------------------------------
			INSERT or ignore INTO Requirements
					(RequirementId, 									RequirementType)
			SELECT	'SUK_DAMRONG_' || BuildingType,						'REQUIREMENT_CITY_HAS_BUILDING'
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_THEATER' AND Buildings.TraitType IS NULL;
		-------------------------------------
		-- RequirementArguments
		-------------------------------------
			INSERT or ignore INTO RequirementArguments
					(RequirementId, 							Name,					Value)
			SELECT	'SUK_DAMRONG_' || BuildingType,	 			'BuildingType',			BuildingType
			FROM Buildings WHERE Buildings.PrereqDistrict = 'DISTRICT_THEATER' AND Buildings.TraitType IS NULL;
--===================================================================
-- Khwam Siwilai
-- This city and your other cities with established [Icon_Governor] Governors within 6 tiles gain +15% [ICON_Culture] Culture, +15% [ICON_Science] Science.
--------------------------------------------------------------------
	-- MODIFIERS
	--------------------------------------------------------------------
		-- GovernorPromotionModifiers
		-------------------------------------
			INSERT or ignore INTO GovernorPromotionModifiers
					(GovernorPromotionType,										ModifierId)
			VALUES	('GOVERNOR_PROMOTION_SUK_DAMRONG_KHWAM_SIWILAI', 			'SUK_DAMRONG_KHWAM_SIWILAI_CULTURE'),
					('GOVERNOR_PROMOTION_SUK_DAMRONG_KHWAM_SIWILAI', 			'SUK_DAMRONG_KHWAM_SIWILAI_SCIENCE');
		-------------------------------------
		-- Modifiers
		-------------------------------------
			INSERT or ignore INTO Modifiers
					(ModifierId,								ModifierType,												SubjectRequirementSetId)
			VALUES	('SUK_DAMRONG_KHWAM_SIWILAI_CULTURE',		'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 		'SUK_DAMRONG_AOE_INCL_WITH_GOVERNOR_REQUIREMENTS'),
					('SUK_DAMRONG_KHWAM_SIWILAI_SCIENCE',		'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 		'SUK_DAMRONG_AOE_INCL_WITH_GOVERNOR_REQUIREMENTS');
		-------------------------------------
		-- ModifierArguments
		-------------------------------------
			INSERT or ignore INTO ModifierArguments
					(ModifierId,												Name,							Value)
			VALUES	('SUK_DAMRONG_KHWAM_SIWILAI_CULTURE',						'YieldType',					'YIELD_CULTURE'),
					('SUK_DAMRONG_KHWAM_SIWILAI_CULTURE',						'Amount',						15),

					('SUK_DAMRONG_KHWAM_SIWILAI_SCIENCE',						'YieldType',					'YIELD_SCIENCE'),
					('SUK_DAMRONG_KHWAM_SIWILAI_SCIENCE',						'Amount',						15);
	--------------------------------------------------------------------
	-- REQUIREMENTS
	--------------------------------------------------------------------
		-- RequirementSets
		-------------------------------------
			INSERT or ignore INTO RequirementSets
					(RequirementSetId,											RequirementSetType)
			VALUES	('SUK_DAMRONG_AOE_INCL_WITH_GOVERNOR_REQUIREMENTS',			'REQUIREMENTSET_TEST_ALL');
		-------------------------------------
		-- RequirementSetRequirements
		-------------------------------------
			INSERT or ignore INTO RequirementSetRequirements
					(RequirementSetId,											RequirementId)
			VALUES	('SUK_DAMRONG_AOE_INCL_WITH_GOVERNOR_REQUIREMENTS',			'SUK_DAMRONG_REQUIRES_AOE_INCL'),
					('SUK_DAMRONG_AOE_INCL_WITH_GOVERNOR_REQUIREMENTS',			'REQUIRES_CITY_HAS_GOVERNOR');
--==========================================================================================================================
--==========================================================================================================================