select *
from portfolioproject..CovidDeaths

order by 3,4

select location, DATE, total_cases, new_cases, total_deaths, population 
from CovidDeaths
order by 1,2
 
 --look at total cases vs total deaths
 -- shows likelihood of dying if you contract covid in your country
 select location, DATE, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
from portfolioproject..CovidDeaths
where location like '%states%'
order by 1,2
  
  --looking at total cases vs population
  -- shows percentage of population got Covid

  select location, DATE, total_cases, population, (total_cases/population)*100 as casespercentage
from CovidDeaths
--where location like '%states%'
order by 1,2

--looking at countries with highest infection rate compared to population
 select location, population, max(total_cases) as HighestInfectionCountry ,  max((total_cases/population)*100) as infectionpercentage
from portfolioproject..CovidDeaths
--where location like '%states%'
where continent is not null
group by location, population
--order by population desc
order by population desc

--Countries with the highest death count per population
 select location, max(cast(total_deaths as int)) as TotalDeathCountry
from coviddeaths
--where location like '%states%'
where continent is not null
group by location
order by TotalDeathCountry desc

--Let's break things down by continent


--showing continents with the highest death per population
 select continent, max(cast(total_deaths as int)) as TotalDeathPerCountry
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by continent
order by TotalDeathPerCountry desc

--showing the total cases of continents  
 select continent, max(total_cases) as TotalCasePerContinent
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by continent
order by TotalCasePerContinent desc

--showing global numbers
 select date, SUM(new_cases)
from PortfolioProject..CovidDeaths 
--where location like '%states%'
where new_cases is not null
group by date
order by 1,2

--showing total cases in Vietnam
select continent, location, date, total_cases as totalcasesperday ,new_cases as newcasesperday
from portfolioproject..CovidDeaths
where location ='vietnam'

--showing total cases in Asia
select continent,location, date, total_cases  ,new_cases
from portfolioproject..CovidDeaths

--showing news cases in the world descendently
select continent, date,   max(new_cases) as totalcases
from portfolioproject..CovidDeaths
where continent is not null
group by continent, date
order by date




select continent,location, date,new_vaccinations, total_vaccinations, population_density, (cast(population_density*331000 as int)) as population, max((total_vaccinations/100000000*100))as vaccinationpercentage
from portfolioproject..Covidvaccinations

where continent = 'asia' and location like 'viet%' and total_vaccinations is not null
group by continent, location, date, new_vaccinations, total_vaccinations, population_density
order by date

--global number
select date, sum(new_cases) as newcases ,sum(cast(new_cases as int)) as totalcases , sum(cast(total_deaths as int)) as totaldeaths
from PortfolioProject..CovidDeaths
where new_cases is not null
and total_deaths is not null

group by date
order by date

--total cases in each country around the world 
select continent, location, sum(new_cases) 
from PortfolioProject..CovidDeaths
where continent is not null
group by  continent, location
order by continent


select location, max(total_cases) as  total_cases, sum(cast(new_deaths as int)) as total_deaths
from PortfolioProject..CovidDeaths
where continent is not null and location ='vietnam'

group by location
order by 1,2

--looking at total population and new vacciantions
select dea.continent,dea.location, dea.date,dea.population, vac.new_vaccinations 
from PortfolioProject..CovidDeaths dea
join PortfolioProject..Covidvaccinations vac
on vac.date=dea.date
and dea.location=vac.location
where dea.continent is not null
--and dea.location='vietnam'
order by 2,3

-- total death cases in each continent
select Continent, location as Country, sum(cast(total_deaths as int)) as Total_deaths
from coviddeaths

where total_deaths is not null
and continent is not null
and location is not null
group by continent, location
order by continent

-- join total deaths vs total vac population
select dea.continent, dea.location, dea.total_deaths , vac.total_vaccinations
from coviddeaths dea
join covidvaccinations vac
on dea.location = vac.location
where dea.continent is not null 
--and vac.continent is not null
order by continent

--add new column 
alter table coviddeaths
add day_time nvarchar(25) 

--count total countries in each continent
select continent, count  (distinct location) total_countries
from coviddeaths
where continent is not null
group by continent 

