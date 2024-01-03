select * from online_retail_csv;

-- Total Revenue
-- Calculate the total revenue generated from the online retail transactions.
SELECT InvoiceNo,SUM(Quantity*UnitPrice) as Total_Price 
FROM online_retail_csv
GROUP BY InvoiceNo;

-- Most Popular Products
-- Identify the top-selling or most popular products based on the quantity sold.
SELECT InvoiceNo,Description,Quantity
FROM online_retail_csv
ORDER BY Quantity DESC
LIMIT 1;

-- Customer Segmentation:
-- Analyze customer behavior by segmenting them based on their transaction patterns,
-- such as high-value customers or frequent shoppers.
SELECT InvoiceNo, CustomerID, SUM(Quantity) as TotalQuantity
FROM online_retail_csv
GROUP BY CustomerID, InvoiceNo;

#Based on high - value customers
SELECT CustomerID, 
SUM(Quantity * UnitPrice) as TotalRevenue,
CASE
	WHEN RANK() OVER (ORDER BY SUM(Quantity * UnitPrice) DESC) > 500 THEN 'High Value'
	ELSE 'Regular'
END as CustomerSegment
FROM online_retail_csv
GROUP BY CustomerID;

-- Monthly Sales Trends:
-- Explore the monthly trends in sales and identify any seasonality patterns.
SELECT
    YEAR(IFNULL(InvoiceDate, '2022-01-01')) as InvoiceYear,
    MONTH(IFNULL(InvoiceDate, '2022-01-01')) as InvoiceMonth,
    SUM(Quantity * UnitPrice) as MonthlySales
FROM
    online_retail_csv
GROUP BY
    InvoiceYear, InvoiceMonth
ORDER BY
    InvoiceYear, InvoiceMonth;

-- Country-wise Analysis:
-- Analyze sales performance and customer behavior based on different countries.
SELECT SUM(Quantity) as TotalQuantity, CustomerID, Country
FROM online_retail_csv
GROUP BY CustomerID, Country
ORDER BY TotalQuantity DESC;

-- Returns Analysis
-- Investigate returns by identifying transactions 
-- where the quantity is negative and analyze their impact on revenue.
SELECT InvoiceNo,InvoiceDate,CustomerID,Country,(Quantity * UnitPrice) as total_cost
FROM online_retail_csv
WHERE Quantity < 0;

-- Average Transaction Value
-- Calculate the average value of each transaction to understand typical spending patterns.
SELECT InvoiceNo,CustomerID,AVG(Quantity * UnitPrice) as avg_transaction
FROM online_retail_csv
GROUP BY CustomerID,InvoiceNo;

-- New Customer Acquisition:
-- Identify and analyze new customers who made their first purchase during a specific time period.
SELECT CustomerID,InvoiceDate 
FROM online_retail_csv
ORDER BY InvoiceDate ASC;

SELECT
    CustomerID,
    MAX(InvoiceDate) AS LatestTransactionDateTime
FROM
    online_retail_csv
GROUP BY
    CustomerID
HAVING
    SUBSTRING(MAX(InvoiceDate), 12, 2) >= '12' AND SUBSTRING(MAX(InvoiceDate), 12, 2) <= '14';

-- Top Customers:
-- Identify the top customers based on their total spending or the number of transactions.
SELECT CustomerID, COUNT(InvoiceNo) as no_of_transaction
FROM online_retail_csv
GROUP BY CustomerID
ORDER BY no_of_transaction DESC
LIMIT 5;

SELECT CustomerID, SUM(Quantity * UnitPrice) as total_cost
FROM online_retail_csv
GROUP BY CustomerID
ORDER BY total_cost DESC
LIMIT 5;

-- Product Categories Analysis:
-- Analyze sales performance across different product categories.
SELECT
    Description AS ProductDescription,
    COUNT(InvoiceNo) AS NumberOfTransactions,
    SUM(Quantity * UnitPrice) AS TotalSales
FROM
    online_retail_csv
GROUP BY
    ProductDescription
ORDER BY
    TotalSales DESC;
    
-- Outliers Detection:
-- Identify and investigate any outliers in the data, such as unusually large or small transactions.
SELECT *
FROM online_retail_csv
WHERE ABS((UnitPrice - AVG(UnitPrice)) / STDDEV(UnitPrice)) > 3;
