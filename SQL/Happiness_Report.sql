-- Top 10 Happiest Countries:
-- Identify and rank the top 10 happiest countries based on the "Ladder score" (happiness score).
SELECT Country_name, Ladderscore
FROM whr2023
ORDER BY Ladderscore DESC
LIMIT 10;

-- Factors Influencing Happiness:
-- Explore the correlation between different factors (e.g., GDP per capita, social support, life expectancy) and the overall happiness score
SELECT AVG(Logged_GDP_per_capita) as avg_logged_gdp,
  AVG(`Social support`) as AvgSocialSupport,
  AVG(`Healthy life expectancy`) as AvgHealthLife,
  AVG(`Freedom to make life choices`) as AvgFreedom,
  AVG(`Generosity`) as AvgGenerosity,
  AVG(`Perceptions of corruption`) as AvgCorruption
FROM whr2023;

SELECT Country_name,AVG(Logged_GDP_per_capita) as avg_logged_gdp,
  AVG(`Social support`) as AvgSocialSupport,
  AVG(`Healthy life expectancy`) as AvgHealthLife,
  AVG(`Freedom to make life choices`) as AvgFreedom,
  AVG(`Generosity`) as AvgGenerosity,
  AVG(`Perceptions of corruption`) as AvgCorruption
FROM whr2023
GROUP BY Country_name;


-- Impact of GDP on Happiness:
SELECT
  Country_name,
  Logged_GDP_per_capita,
  Ladderscore
FROM whr2023
ORDER BY Logged_GDP_per_capita DESC;
-- As you can see if the gdp is more than 10 the ladderscore is above 6

 -- Social Support and Happiness:
SELECT
  Country_name,
  Social_support,
  Ladderscore
FROM whr2023
WHERE Ladderscore > 6
ORDER BY Social_support DESC;

-- Freedom to Make Life Choices:
SELECT
  Country_name name,
  Freedom_to_make_life_choices,
  Ladderscore
FROM whr2023
ORDER BY Freedom_to_make_life_choices DESC;

-- Generosity and Happiness:
SELECT Country_name as Country,
	Generosity,
    Ladderscore
FROM whr2023
ORDER BY Generosity DESC;

-- Health and Happiness:
SELECT
  `Country_name`,
  `Healthy_life_expectancy`,
  `Ladderscore`
FROM whr2023
ORDER BY `Healthy_life_expectancy` DESC;
-- As the life expentancy is more ladderscore will be more


-- Corruption Perception and Happiness:
SELECT
  `Country_name`,
  `Perceptions of corruption`,
  `Ladderscore`
FROM whr2023
ORDER BY `Perceptions of corruption` DESC;

