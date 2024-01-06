SELECT * FROM iris.iris;
-- Species Overview:
-- Use a CASE statement to create a summary of the different species in terms of count, average sepal length, and average petal width.
SELECT 
    COUNT(*) AS count,
    AVG(sepallength) AS AvgSepalLength,
    AVG(sepalwidth) AS AvgSepalWidth
FROM
    iris
GROUP BY class;

-- Sepal Size Ratio:
-- Calculate the ratio of sepal length to sepal width for each species. Use a CASE statement to classify them as "High Ratio," "Medium Ratio," or "Low Ratio."
SELECT 
    class,
    AVG(sepallength / sepalwidth) AS SepalRatio,
    CASE
        WHEN AVG(sepallength / sepalwidth) > 2 THEN 'High Ratio'
        WHEN AVG(sepallength / sepalwidth) BETWEEN 1.5 AND 2 THEN 'Medium Ratio'
        ELSE 'Low Ratio'
    END AS RatioClassification
FROM
    iris
GROUP BY class;


-- Petal Size Percentiles:
-- Rank each species based on petal length using percentiles.
WITH Percentiles AS (
	SELECT
		class,
        PetalLength,
        PERCENT_RANK() OVER (PARTITION BY class ORDER BY PetalLength) AS PetalPercentile
	FROM
		iris
)
SELECT
	class,
    PetalLength,
    PetalPercentile
FROM
	Percentiles;
    

-- Average Characteristics by Species:
-- Calculate the average Sepal Length, Sepal Width, Petal Length, and Petal Width for each species separately.
SELECT 
    class,
    AVG(sepallength) AS avg_sepallength,
    AVG(sepalwidth) AS avg_sepalwidth
FROM
    iris
GROUP BY class;

SELECT 
    class,
    AVG(petallength) AS avg_petallength,
    AVG(petalwidth) AS avg_petalwidth
FROM
    iris
GROUP BY class;

-- Petal Size Ratio:
-- Calculate the ratio of petal length to petal width for each species. Use a CASE statement to classify them as "High Ratio," "Medium Ratio," or "Low Ratio."
SELECT class,
	AVG(petallength/petalwidth) as PetalRatio,
    CASE
		WHEN AVG(petallength/petalwidth) > 4 THEN "High Ratio"
        WHEN AVG(petallength/petalwidth)  BETWEEN 3 AND 4 THEN "Medium Ratio"
        ELSE "Low Ratio"
        END as PetalClassification
	FROM iris
GROUP BY class;

-- Comparing Petal and Sepal Sizes:
-- Compare the average sizes of petals and sepals within each species.
SELECT class,AVG(petallength) as avg_petallength,AVG(sepallength) as avg_sepallength
FROM iris
GROUP BY class;

SELECT class,AVG(petalwidth) as avg_petalwidth,AVG(sepalwidth) as avg_sepalwidth
FROM iris
GROUP BY class;
