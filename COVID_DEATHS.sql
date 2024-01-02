-- select data that we are going to be using
Select location, date, total_cases, new_cases, total_deaths, population
From covid.covid_deaths
order by 1,2;

-- Find the location with the highest total deaths.
Select location, date, total_cases, total_deaths, population
From covid.covid_deaths order by total_deaths DESC limit 1;

-- List the locations and dates where new cases exceeded 1000.
SELECT location,date FROM covid_deaths WHERE new_cases > 1000;

-- Calculate the total population for each location.
SELECT location,SUM(population) as total_population FROM covid_deaths
GROUP BY location;

-- Determine the average number of new cases per day for each location.
SELECT location,AVG(new_cases) as avg_newcases FROM covid_deaths
GROUP BY location;

-- Find the location with the highest percentage increase in total cases from the previous day.
WITH DailyIncrease AS (
    SELECT
        location,
        date,
        total_cases,
        LAG(total_cases) OVER (PARTITION BY location ORDER BY date) AS previous_day_total_cases,
        total_cases - LAG(total_cases) OVER (PARTITION BY location ORDER BY date) AS daily_increase
    FROM
        covid_deaths
)
SELECT
    location,
    date,
    daily_increase,
    (daily_increase / NULLIF(previous_day_total_cases, 0)) * 100 AS percentage_increase
FROM
    DailyIncrease
ORDER BY
    percentage_increase DESC
LIMIT 1;

-- Identify the date and location with the highest number of total cases.
SELECT location, date, SUM(total_cases) AS t_cases
FROM covid_deaths
GROUP BY location, date
ORDER BY SUM(total_cases) DESC
LIMIT 1;

-- List the locations with a population greater than 10 million.
SELECT location,SUM(population) as total_population
FROM covid_deaths
GROUP BY location
HAVING SUM(population) > 10000000;

-- Retrieve the location, date, and total cases for the last 7 days.
SELECT  location,date,total_cases
FROM covid_deaths
WHERE date >= CURDATE() - INTERVAL 7 DAY;

-- total_cases vs total_deaths
-- Calculate the mortality rate (total deaths/total cases * 100) for each location.
SELECT
    location,
    date,
    (total_deaths / NULLIF(total_cases, 0)) * 100 AS death_percentage
FROM
    covid_deaths;


-- Based on location death percentage

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From covid_deaths
where location like'%Canada%'
order by 1,2;
