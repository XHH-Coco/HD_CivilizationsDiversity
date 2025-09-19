-- Rename type to disable lua script
update Types set Type = 'BUILDING_MER_LITERARY_SCHOOL_HD' where Type = 'BUILDING_MER_LITERARY_SCHOOL';
update Types set Hash = Make_Hash(Type) where Type = 'BUILDING_MER_LITERARY_SCHOOL_HD';