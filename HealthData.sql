CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `supermarketsales`.`healthdata` AS
    SELECT 
        `supermarketsales`.`worlddata2023`.`Country` AS `Country`,
        `supermarketsales`.`worlddata2023`.`Population` AS `Population`,
        `supermarketsales`.`worlddata2023`.`BirthRate` AS `Birth Rate`,
        `supermarketsales`.`worlddata2023`.`FertilityRate` AS `Fertility Rate`,
        `supermarketsales`.`worlddata2023`.`LifeExpectancy` AS `Life Expectancy`,
        `supermarketsales`.`worlddata2023`.`InfantMortality` AS `Infant Mortality`,
        `supermarketsales`.`worlddata2023`.`OutOfPocketHealthExpenditure` AS `OOP Health Expenditure`
    FROM
        `supermarketsales`.`worlddata2023`
    WHERE
        (`supermarketsales`.`worlddata2023`.`LifeExpectancy` > 0)
    ORDER BY `supermarketsales`.`worlddata2023`.`LifeExpectancy` DESC