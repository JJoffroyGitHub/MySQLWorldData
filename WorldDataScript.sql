-- DESC worlddata2023;

USE supermarketsales;

ALTER TABLE worlddata2023
RENAME COLUMN `Armed Forces size` to ArmedForcesSize,
RENAME COLUMN `Agricultural Land( %)` to AgriculturalLandPercentage,
RENAME COLUMN `Land Area(Km2)` to LandAreaInKMSquared,
RENAME COLUMN `Density (P/Km2)` TO `Density`,
RENAME COLUMN `Birth Rate` TO BirthRate,
RENAME COLUMN `Calling Code` TO CallingCode,
RENAME COLUMN `Capital/Major City` TO CapitalOrMajorCity,
RENAME COLUMN `Co2-Emissions` to Co2Emissions,
RENAME COLUMN `CPI Change (%)` TO CPIChangePercentage,
RENAME COLUMN `Fertility Rate` TO FertilityRate,
RENAME COLUMN `Forested Area (%)` TO ForestedAreaPercentage,
RENAME COLUMN `Gasoline Price` TO GasolinePrice,
RENAME COLUMN `Gross primary education enrollment (%)` TO PrimaryEducationEnrollmentPercentage,
RENAME COLUMN `Gross tertiary education enrollment (%)` TO TertiaryEducationEnrollmentPercentage,
RENAME COLUMN `Infant mortality` TO InfantMortality,
RENAME COLUMN `Largest city` to LargestCity,
RENAME COLUMN `Life expectancy` TO LifeExpectancy,
RENAME COLUMN `Maternal mortality ratio` to MaternalMortalityRatio,
RENAME COLUMN `Minimum wage` TO MinimumWage,
RENAME COLUMN `Official language` TO OfficialLanguage,
RENAME COLUMN `Out of pocket health expenditure` TO OutOfPocketHealthExpenditure,
RENAME COLUMN `Physicians per thousand` to PhysiciansPerThousand,
RENAME COLUMN `Population: Labor force participation (%)` TO PopulationLaborForceParticipationPercentage,
RENAME COLUMN `Tax revenue (%)` TO TaxRevenuePercentage,
RENAME COLUMN `Total tax rate` TO TotalTaxRate,
RENAME COLUMN `Unemployment rate` TO UnemploymentRate,
RENAME COLUMN Urban_population TO UrbanPopulation
;

SET SQL_SAFE_UPDATES = 0;

UPDATE worlddata2023
SET ArmedForcesSize = REPLACE(ArmedForcesSize, ',', ''),
Co2Emissions = REPLACE(Co2Emissions, ',', ''),
LandAreaInKMSquared = REPLACE(LandAreaInKMSquared, ',', ''),
GDP = REPLACE(GDP, ',', ''),
GDP = REPLACE(GDP, "$", ""),
PrimaryEducationEnrollmentPercentage = REPLACE(PrimaryEducationEnrollmentPercentage, '%', ''),
TertiaryEducationEnrollmentPercentage = REPLACE(TertiaryEducationEnrollmentPercentage, '%', ''),
MinimumWage = REPLACE(MinimumWage, '$', ''),
Population = REPLACE(Population, ',', ''),
UrbanPopulation = REPLACE(UrbanPopulation, ',', '')
WHERE ArmedForcesSize <> ''
OR
LandAreaInKMSquared <> ''
OR
GDP <> ''
OR
PrimaryEducationEnrollmentPercentage <> ''
OR
TertiaryEducationEnrollmentPercentage <> ''
OR
Population <> ''  
;

UPDATE worlddata2023
SET ArmedForcesSize = 0,
LifeExpectancy = 0
WHERE ArmedForcesSize = ''
OR
LifeExpectancy = '';

ALTER TABLE worlddata2023
MODIFY COLUMN ArmedForcesSize INT,
MODIFY COLUMN Density INT,
MODIFY COLUMN LandAreaInKMSquared INT,
MODIFY COLUMN Co2Emissions INT,
MODIFY COLUMN CPI DOUBLE,
MODIFY COLUMN GDP INT,
MODIFY COLUMN PrimaryEducationEnrollmentPercentage DOUBLE,
MODIFY COLUMN TertiaryEducationEnrollmentPercentage DOUBLE,
MODIFY COLUMN LifeExpectancy DOUBLE,
MODIFY COLUMN MinimumWage DOUBLE,
MODIFY COLUMN Population INT,
MODIFY COLUMN UrbanPopulation INT
;

SELECT 
	CC.Continent, 
    COUNT(WD.Country) AS 'Country Count',
    SUM(ArmedForcesSize) AS 'Total Troops',
    ROUND(SUM(ArmedForcesSize) / COUNT(WD.Country), 0) AS 'Troops Per Country',
    ROUND(AVG(BirthRate), 2) AS 'Average Birth Rate',
    MAX(UrbanPopulation) AS 'Highest Urban Population',
    MIN(UrbanPopulation) AS 'Lowest Urban Population',
    CONCAT('$', FORMAT(SUM(GDP), "$00000")) AS 'Total GDP',
    CONCAT('$', FORMAT(AVG(GDP), "$00000")) AS 'Average GDP per Country',
    CONCAT(ROUND(SUM(UrbanPopulation) / SUM(Population) * 100, 2), '%') AS 'UrbanPop to Pop Ratio'
    
FROM worlddata2023 AS WD
INNER JOIN CountriesContinents AS CC
ON WD.Country = CC.Country
Group BY CC.Continent
ORDER BY `UrbanPop to Pop Ratio` DESC; 