--阿斯基亚·穆罕默德一世
delete from TraitModifiers where TraitType = 'TRAIT_LEADER_CVS_ASKIYA_UA';
delete from BeliefModifiers where ModifierId like "MODIFIER_CVS_ASKIYA_UA_ATTACH_%";
delete from ModifierArguments where ModifierId like "MODIFIER_CVS_ASKIYA_UA_ATTACH_%";
delete from Modifiers where ModifierId like "MODIFIER_CVS_ASKIYA_UA_ATTACH_%";

