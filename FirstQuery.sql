CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `supermarketsales`.`firstquery` AS
    SELECT 
        `cc`.`Continent` AS `Continent`,
        COUNT(`wd`.`Country`) AS `Country Count`,
        SUM(`wd`.`ArmedForcesSize`) AS `Total Troops`,
        ROUND((SUM(`wd`.`ArmedForcesSize`) / COUNT(`wd`.`Country`)),
                0) AS `Troops Per Country`,
        ROUND(AVG(`wd`.`BirthRate`), 2) AS `Average Birth Rate`,
        MAX(`wd`.`UrbanPopulation`) AS `Highest Urban Population`,
        MIN(`wd`.`UrbanPopulation`) AS `Lowest Urban Population`,
        CONCAT('$', FORMAT(SUM(`wd`.`GDP`), '$00000')) AS `Total GDP`,
        CONCAT('$', FORMAT(AVG(`wd`.`GDP`), '$00000')) AS `Average GDP per Country`,
        CONCAT(ROUND(((SUM(`wd`.`UrbanPopulation`) / SUM(`wd`.`Population`)) * 100),
                        2),
                '%') AS `UrbanPop to Pop Ratio`
    FROM
        (`supermarketsales`.`worlddata2023` `wd`
        JOIN `supermarketsales`.`countriescontinents` `cc` ON ((`wd`.`Country` = `cc`.`Country`)))
    GROUP BY `cc`.`Continent`
    ORDER BY `UrbanPop to Pop Ratio` DESC