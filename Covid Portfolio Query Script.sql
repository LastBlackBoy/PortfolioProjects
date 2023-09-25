SELECT *
FROM PortfolioProject..CovidDeaths
--WHERE continent is not NUll
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccinations 
--ORDER BY 3,4

--Data Selection
SELECT location, date, total_cases, new_cases,total_deaths, population
FROM PortfolioProject..covidDeaths
WHERE continent is not NUll
ORDER BY 1,2

--Global Numbers
SELECT MAX(total_cases) AS TotalGlobalCases,
       MAX(total_deaths) AS TotalGlobalDeaths,
       MAX(CAST(total_deaths AS DECIMAL(18, 2))) / NULLIF(MAX(total_cases), 0) * 100 AS DeathPercentage
FROM PortfolioProject..covidDeaths
--GROUP BY date
--ORDER BY 1,2;

--Total cases vs Total Deaths

--Global
Select location, date, total_cases,total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
from PortfolioProject..covidDeaths
order by 1,2


--Africa
Select location, date, total_cases,total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
from PortfolioProject..covidDeaths
WHERE Continent like 'Africa'
order by 1,2

--Nigeria
Select location, date, total_cases,total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
from PortfolioProject..covidDeaths
WHERE location like 'Nigeria'
order by 1,2


--Total cases Vs Population
--Global
SELECT Location, 
       MAX(total_cases) AS TotalCases,
       MAX(population) AS Population,  
       (MAX(total_cases) * 100.0) / NULLIF(MAX(population), 0) AS PopulationPercentage
FROM PortfolioProject..covidDeaths
WHERE continent <> ''
GROUP BY location
ORDER BY location;




--Africa
SELECT Location, 
       MAX(total_cases) AS TotalCases,
       MAX(population) AS Population,  
       (MAX(total_cases) * 100.0) / NULLIF(MAX(population), 0) AS PopulationPercentage
FROM PortfolioProject..covidDeaths
WHERE continent like 'Africa'
GROUP BY location
ORDER BY location;



--Nigeria
--Daily figures
Select location, date,population, total_cases, 
(CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS PopulationPercentage
from PortfolioProject..covidDeaths
WHERE location like 'Nigeria'
order by 1,2

--Total figures
SELECT Location, 
       MAX(total_cases) AS TotalCases,
       MAX(population) AS Population,  
       (MAX(total_cases) * 100.0) / NULLIF(MAX(population), 0) AS PopulationPercentage
FROM PortfolioProject..covidDeaths
WHERE location like 'Nigeria'
GROUP BY location;



--Total deaths Vs Population
--Global
SELECT Location, 
       MAX(total_deaths) AS TotalDeaths,
       MAX(population) AS Population,  
       (MAX(total_deaths) * 100.0) / NULLIF(MAX(population), 0) AS PopulationPercentage
FROM PortfolioProject..covidDeaths
WHERE continent <> ''
GROUP BY location
ORDER BY PopulationPercentage DESC;




--Africa
SELECT Location, 
        MAX(total_deaths) AS TotalDeaths,
       MAX(population) AS Population,  
       (MAX(total_deaths) * 100.0) / NULLIF(MAX(population), 0) AS PopulationPercentage
FROM PortfolioProject..covidDeaths
WHERE continent like 'Africa'
GROUP BY location
ORDER BY PopulationPercentage DESC;



--Nigeria
--Daily figures
Select location, date,population, total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, population), 0)) * 100 AS PopulationPercentage
from PortfolioProject..covidDeaths
WHERE location like 'Nigeria'
order by 1,2

--Total figures
SELECT Location, 
       MAX(total_deaths) AS TotalDeaths,
       MAX(population) AS Population,  
       (MAX(total_deaths) * 100.0) / NULLIF(MAX(population), 0) AS PopulationPercentage
FROM PortfolioProject..covidDeaths
WHERE location like 'Nigeria'
GROUP BY location;



--Countries with High infection rates vs Population
--Global
Select location,population, MAX(total_cases) AS HighesInfectionCount, 
MAX(CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS PopulationPercentage
from PortfolioProject..covidDeaths
WHERE continent is not NUll
GROUP BY location, population
order by 4 desc

--Africa
Select location,population, MAX(total_cases) AS HighesInfectionCount, 
MAX(CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS PopulationPercentage
from PortfolioProject..covidDeaths
WHERE continent LIKE'Africa'
GROUP BY location, population
order by 4 desc


--Continent with the highest deaths
Select continent, MAX(total_deaths) AS HighestDeathCount 
from PortfolioProject..covidDeaths
WHERE continent <> ''  -- Filter out rows where continent is an empty string
GROUP BY continent
order by 2 desc


--Countries with the highest death per population
Select location, MAX(population) AS Population, MAX(total_deaths) AS HighestDeathCount, 
MAX(CONVERT(float,total_deaths) / NULLIF(CONVERT(float, population), 0)) * 100 AS PopulationPercentage
from PortfolioProject..covidDeaths
WHERE continent <> ''  -- Filter out rows where continent is an empty stringGROUP BY location
GROUP BY location
order by 4 desc



--Total population vs Vaccinations
--Global
SELECT D.continent, D.location, D.date, D.population, V.new_vaccinations,
SUM(V.new_vaccinations) OVER (Partition by D.location ORDER BY D.location, D.date) PeopleVaccinatedRolling 
FROM PortfolioProject..CovidDeaths D
JOIN PortfolioProject..CovidVaccinations V 
	ON D.location = V.Location
	AND D.date = V.date
WHERE D.continent <> ''  -- Filter out rows where continent is an empty string
ORDER BY 2, 3;

--Africa
SELECT D.continent, D.location, D.date, D.population, V.new_vaccinations,
SUM(V.new_vaccinations) OVER (Partition by D.location ORDER BY D.location, D.date) PeopleVaccinatedRolling 
FROM PortfolioProject..CovidDeaths D
JOIN PortfolioProject..CovidVaccinations V 
	ON D.location = V.Location
	AND D.date = V.date
WHERE D.continent LIKE 'Africa'  -- Filter out rows where continent is an empty string
--ORDER BY 2, 3;

--Using CTE to show the vacinnation percentage in Africa

WITH VaccinatedPopulation (continent, location, date, population, new_vaccinations, PeopleVaccinatedRolling)
AS
(
    SELECT D.continent, D.location, D.date, D.population, V.new_vaccinations,
    SUM(V.new_vaccinations) OVER (PARTITION BY D.location ORDER BY D.location, D.date) AS PeopleVaccinatedRolling 
    FROM PortfolioProject..CovidDeaths D
    JOIN PortfolioProject..CovidVaccinations V 
        ON D.location = V.Location
        AND D.date = V.date
   WHERE D.continent LIKE 'Africa'  -- Filter out rows where continent is an empty string
    --ORDER BY D.location, D.date;  -- Optionally, order the data within the CTE
)
SELECT *,
       CAST(PeopleVaccinatedRolling AS FLOAT) / CAST(population AS FLOAT) * 100 AS VaccinationPercentage
FROM VaccinatedPopulation;






--Data Visualizations; using views

-- Drop the view if it exists
--IF OBJECT_ID('PercentPopulationVaccinated', 'V') IS NOT NULL
--    DROP VIEW PercentPopulationVaccinated; needed to drop the view 

-- Create the view
CREATE VIEW PercentPopulationVaccinated AS
SELECT D.continent, D.location, D.date, D.population, V.new_vaccinations,
SUM(V.new_vaccinations) OVER (PARTITION BY D.location ORDER BY D.location, D.date) AS PeopleVaccinatedRolling 
FROM PortfolioProject..CovidDeaths D
JOIN PortfolioProject..CovidVaccinations V 
    ON D.location = V.Location
    AND D.date = V.date
WHERE D.continent <> ''  -- Filter out rows where continent is an empty string
-- ORDER BY 2, 3;  -- Optionally, include ORDER BY if needed



-- Drop the view if it exists
--IF OBJECT_ID('PercentPopulationVaccinatedAfrica', 'V') IS NOT NULL
--    DROP VIEW PercentPopulationVaccinatedAfrica; needed to drop the view 

-- Create the view
CREATE VIEW PercentPopulationVaccinatedAfrica AS
SELECT D.continent, D.location, D.date, D.population, V.new_vaccinations,
SUM(V.new_vaccinations) OVER (PARTITION BY D.location ORDER BY D.location, D.date) AS PeopleVaccinatedRolling 
FROM PortfolioProject..CovidDeaths D
JOIN PortfolioProject..CovidVaccinations V 
    ON D.location = V.Location
    AND D.date = V.date
 WHERE D.continent LIKE 'Africa'  -- Filter out rows where continent is an empty string
-- ORDER BY 2, 3;  -- Optionally, include ORDER BY if needed


--Create View

--Global
-- Drop the view if it exists
--IF OBJECT_ID('GlobalTotalCasesVSPop', 'V') IS NOT NULL
--    DROP VIEW GlobalTotalCasesVSPop; needed to drop the view 

CREATE VIEW GlobalTotalCasesVSPop AS
SELECT Location, 
       MAX(total_cases) AS TotalCases,
       MAX(population) AS Population,  
       (MAX(total_cases) * 100.0) / NULLIF(MAX(population), 0) AS PopulationPercentage
FROM PortfolioProject..covidDeaths
WHERE continent <> ''
GROUP BY location
--ORDER BY location;

--Africa
CREATE VIEW AfricaTotalCasesVSPop AS
SELECT Location, 
       MAX(total_cases) AS TotalCases,
       MAX(population) AS Population,  
       (MAX(total_cases) * 100.0) / NULLIF(MAX(population), 0) AS PopulationPercentage
FROM PortfolioProject..covidDeaths
WHERE continent like 'Africa'
GROUP BY location
--ORDER BY location;

--Nigeria
--Daily figures
CREATE VIEW NigeriaTotalCasesVSPop AS
Select location, date,population, total_cases, 
(CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS PopulationPercentage
from PortfolioProject..covidDeaths
WHERE location like 'Nigeria'
--order by 1,2


--Total deaths Vs Population
--Global
CREATE VIEW GlobalTotalDeathsVSPop AS
SELECT Location, 
       MAX(total_deaths) AS TotalDeaths,
       MAX(population) AS Population,  
       (MAX(total_deaths) * 100.0) / NULLIF(MAX(population), 0) AS PopulationPercentage
FROM PortfolioProject..covidDeaths
WHERE continent <> ''
GROUP BY location
--ORDER BY PopulationPercentage DESC;

--Africa
CREATE VIEW AfricaTotalDeathsVSPop AS
SELECT Location, 
        MAX(total_deaths) AS TotalDeaths,
       MAX(population) AS Population,  
       (MAX(total_deaths) * 100.0) / NULLIF(MAX(population), 0) AS PopulationPercentage
FROM PortfolioProject..covidDeaths
WHERE continent like 'Africa'
GROUP BY location

--Nigeria
--Daily figures
CREATE VIEW NigeriaDailyDeathsVSPop AS
Select location, date,population, total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, population), 0)) * 100 AS PopulationPercentage
from PortfolioProject..covidDeaths
WHERE location like 'Nigeria'
--order by 1,2

--Total figures
SELECT Location, 
       MAX(total_deaths) AS TotalDeaths,
       MAX(population) AS Population,  
       (MAX(total_deaths) * 100.0) / NULLIF(MAX(population), 0) AS PopulationPercentage
FROM PortfolioProject..covidDeaths
WHERE location like 'Nigeria'
GROUP BY location;


--Total cases vs Total Deaths
CREATE VIEW GlobalCasesVsDeaths AS
Select location, date, total_cases,total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
from PortfolioProject..covidDeaths
WHERE continent <> ''
--order by 1,2

CREATE VIEW AfricaCasesVsDeaths AS
Select location, date, total_cases,total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
from PortfolioProject..covidDeaths
WHERE continent like 'Africa'
--order by 1,2

--Nigeria
CREATE VIEW NigeriaDailyCasesVsDeaths AS
Select location, date, total_cases,total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
from PortfolioProject..covidDeaths
WHERE location like 'Nigeria'
--order by 1,2

--Highest infection rate
CREATE VIEW GlobalInfectionRate AS
Select location,population, MAX(total_cases) AS HighesInfectionCount, 
MAX(CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS PopulationPercentage
from PortfolioProject..covidDeaths
WHERE continent is not NUll
GROUP BY location, population
--order by 4 desc

--Africa
CREATE VIEW AfricaInfectionRate AS
Select location,population, MAX(total_cases) AS HighesInfectionCount, 
MAX(CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS PopulationPercentage
from PortfolioProject..covidDeaths
WHERE continent LIKE'Africa'
GROUP BY location, population
--order by 4 desc

--VaccinationVsPop
--Global
CREATE VIEW VaccinationVsPopGlobal AS
SELECT D.continent, D.location, D.date, D.population, V.new_vaccinations,
SUM(V.new_vaccinations) OVER (Partition by D.location ORDER BY D.location, D.date) PeopleVaccinatedRolling 
FROM PortfolioProject..CovidDeaths D
JOIN PortfolioProject..CovidVaccinations V 
	ON D.location = V.Location
	AND D.date = V.date
WHERE D.continent <> ''  -- Filter out rows where continent is an empty string
--ORDER BY 2, 3;

--Africa
CREATE VIEW VaccinationVsPopAfrica AS
SELECT D.continent, D.location, D.date, D.population, V.new_vaccinations,
SUM(V.new_vaccinations) OVER (Partition by D.location ORDER BY D.location, D.date) PeopleVaccinatedRolling 
FROM PortfolioProject..CovidDeaths D
JOIN PortfolioProject..CovidVaccinations V 
	ON D.location = V.Location
	AND D.date = V.date
WHERE D.continent LIKE 'Africa'  -- Filter out rows where continent is an empty string
--ORDER BY 2, 3;
