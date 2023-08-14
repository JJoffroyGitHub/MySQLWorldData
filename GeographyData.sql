CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `supermarketsales`.`geographydata` AS
    SELECT 
        `wd`.`Country` AS `Country`,
        `wd`.`OfficialLanguage` AS `OfficialLanguage`,
        `wd`.`AgriculturalLandPercentage` AS `AgriculturalLandPercentage`,
        `wd`.`LandAreaInKMSquared` AS `LandAreaInKMSquared`,
        `wd`.`CapitalOrMajorCity` AS `CapitalOrMajorCity`,
        `wd`.`ForestedAreaPercentage` AS `ForestedAreaPercentage`,
        `wd`.`Population` AS `Population`,
        `wd`.`PopulationLaborForceParticipationPercentage` AS `PopulationLaborForceParticipationPercentage`,
        `wd`.`UrbanPopulation` AS `UrbanPopulation`,
        `cc`.`Continent` AS `Continent`
    FROM
        (`supermarketsales`.`worlddata2023` `wd`
        LEFT JOIN `supermarketsales`.`countriescontinents` `cc` ON ((`wd`.`Country` = `cc`.`Country`)))
