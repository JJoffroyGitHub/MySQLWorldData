CREATE DEFINER=`root`@`localhost` PROCEDURE `TableEdits`()
BEGIN
ALTER TABLE worlddata2023
RENAME COLUMN `Armed Forces size` to ArmedForcesSize,
RENAME COLUMN `Agricultural Land( %)` to AgriculturalLandPercentage,
RENAME COLUMN `Land Area(Km2)` to LandAreaInKMSquared,
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
UrbanPopulation = REPLACE(UrbanPopulation, ',', ''),
CPI = REPLACE(CPI, ',', '')
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
OR
CPI = ''  
;

UPDATE worlddata2023
SET ArmedForcesSize = 0,
LifeExpectancy = 0,
CPI = 0,
PrimaryEducationEnrollmentPercentage = 0,
TertiaryEducationEnrollmentPercentage = 0,
MinimumWage = 0,
Co2Emissions = 0
WHERE ArmedForcesSize = ''
OR
LifeExpectancy = ''
OR
CPI =''
OR
PrimaryEducationEnrollmentPercentage = ''
OR 
TertiaryEducationEnrollmentPercentage = ''
OR
MinimumWage = ''
OR
Co2Emissions = '';

ALTER TABLE worlddata2023
MODIFY COLUMN ArmedForcesSize INT,
MODIFY COLUMN LandAreaInKMSquared INT,
MODIFY COLUMN Co2Emissions INT,
MODIFY COLUMN CPI DOUBLE,
MODIFY COLUMN GDP BIGINT,
MODIFY COLUMN PrimaryEducationEnrollmentPercentage DOUBLE,
MODIFY COLUMN TertiaryEducationEnrollmentPercentage DOUBLE,
MODIFY COLUMN LifeExpectancy DOUBLE,
MODIFY COLUMN MinimumWage DOUBLE,
MODIFY COLUMN Population INT,
MODIFY COLUMN UrbanPopulation INT
;
END