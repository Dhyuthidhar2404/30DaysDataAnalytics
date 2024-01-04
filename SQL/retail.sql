SELECT * FROM features_data_set;
SELECT * FROM sales_data_set;
SELECT * FROM stores_data_set;

-- Store Distribution:
-- Explore the distribution of store types and sizes.

-- Unique Store Types
SELECT DISTINCT Type
FROM stores_data_set;

-- Count of Each Store Type
SELECT Type,COUNT(*)
FROM stores_data_set
GROUP BY Type;

-- Analyze Store Sizes:
SELECT Size,Count(*)
FROM stores_data_set
GROUP BY Size;

-- Holiday Weeks by Store:
-- Calculate the number of holiday weeks for each store.
SELECT
    Store,
    COUNT(DISTINCT WEEK(Date)) AS TotalWeeks,
    COUNT(DISTINCT CASE WHEN IsHoliday = 'TRUE' THEN WEEK(Date) END) AS HolidayWeeksCount
FROM
    features_data_set
GROUP BY
    Store;

-- Average Temperature and Fuel Price:
-- Calculate the average temperature and fuel price for each store over time.
SELECT Store,AVG(Temperature) as avg_temp,
AVG(Fuel_Price) as avg_fuel
FROM features_data_set
GROUP BY Store;

-- Missing Markdowns:
-- Identify the percentage of missing values for each Markdown category.
SELECT
    Store,
    (COUNT(CASE WHEN MarkDown1 = 'NA' THEN 1 END) / COUNT(MarkDown1)) * 100 AS count_null_MarkDown1,
    (COUNT(CASE WHEN MarkDown2 = 'NA' THEN 1 END) / COUNT(MarkDown2)) * 100 AS count_null_MarkDown2,
    (COUNT(CASE WHEN MarkDown3 = 'NA' THEN 1 END) / COUNT(MarkDown3)) * 100 AS count_null_MarkDown3,
    (COUNT(CASE WHEN MarkDown4 = 'NA' THEN 1 END) / COUNT(MarkDown4)) * 100 AS count_null_MarkDown4,
    (COUNT(CASE WHEN MarkDown5 = 'NA' THEN 1 END) / COUNT(MarkDown5)) * 100 AS count_null_MarkDown5
FROM
    features_data_set
GROUP BY
    Store;

-- Overall Sales Trends:
-- Determine the overall trend of weekly sales over the given time period.
SELECT
    Date,
    SUM(Weekly_Sales) AS TotalWeeklySales
FROM
    sales_data_set
GROUP BY
    Date
ORDER BY
    Date;

-- Top Performing Departments:
-- Identify the top-performing departments based on average weekly sales.
SELECT Dept,AVG(Weekly_Sales) as avg_sales
FROM sales_data_set
GROUP BY Dept
ORDER BY avg_sales DESC
LIMIT 5;

SELECT * FROM features_data_set;
SELECT * FROM sales_data_set;
SELECT * FROM stores_data_set;

-- Store Type Impact on Features:
-- Analyze how store types correlate with average temperature, fuel price, and other features.
SELECT sd.Type,AVG(fd.Temperature) AS avg_temperature
FROM stores_data_set sd
JOIN features_data_set fd ON sd.Store = fd.Store
GROUP BY sd.Type;

-- Sales by Store Type:
-- Analyze the average weekly sales for each store type.
SELECT std.Type,AVG(sad.Weekly_Sales) AS avg_sales
FROM stores_data_set std
JOIN sales_data_set sad ON std.Store = sad.Store
GROUP BY std.Type;

-- Impact of Store Features on Sales:
-- Explore how store-specific features (temperature, fuel price) correlate with weekly sales.
SELECT sad.Store, SUM(sad.Weekly_Sales) AS weekly_sales, AVG(fd.Temperature) AS avg_temp
FROM sales_data_set sad
JOIN features_data_set fd ON sad.Store = fd.Store
GROUP BY sad.Store;

-- Sales Performance During Holidays:
-- Analyze the impact of holidays on sales, considering store-specific features and markdowns.
SELECT sad.Store, SUM(sad.Weekly_Sales) AS weekly_sales, fd.IsHoliday
FROM sales_data_set sad
JOIN features_data_set fd ON sad.Store = fd.Store
WHERE fd.IsHoliday = "TRUE"
GROUP BY sad.Store;

