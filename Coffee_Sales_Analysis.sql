-- Databricks notebook source
SELECT *
FROM bright_coffee_sales.coffee_sales.dataset
LIMIT 100;

----check all columns in the format
  --Unit price change
SELECT
  CAST(REPLACE(`unit_price`,',','.')AS DOUBLE) AS unit_price
FROM bright_coffee_sales.coffee_sales.dataset;

--Checking for number of records
SELECT COUNT(*)
FROM bright_coffee_sales.coffee_sales.dataset;

--Duplicates checking in rows
SELECT *,
  COUNT(*)
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY ALL
HAVING COUNT(*) >1;
--No duplicates 

---NULL FUNCTIONS 
SELECT *
FROM bright_coffee_sales.coffee_sales.dataset
WHERE `transaction_id` IS NULL OR `transaction_date` IS NULL OR `transaction_time` IS NULL OR `transaction_qty` IS NULL OR `store_id` IS NULL OR `store_location` IS NULL OR `product_id` IS NULL OR `unit_price` IS NULL OR `product_category` IS NULL OR `product_type` IS NULL OR `product_detail` IS NULL; -- NO Null values found

--1.TOTAL REVENUE
SELECT 
  ROUND(SUM(`transaction_qty` *  CAST(REPLACE(`unit_price`,',','.') AS DOUBLE)),2) AS Total_Revenue
FROM bright_coffee_sales.coffee_sales.dataset;

--2.TOTAL REVENUE PER PRODUCT CATEGORY
SELECT 
  product_category,
  ROUND(SUM(`transaction_qty` *  CAST(REPLACE(`unit_price`,',','.') AS DOUBLE)),2) AS Total_Revenue
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY 1;

--3.TOTAL REVENUE PER PRODUCT CATEGORY AND PRODUCT DETAIL
SELECT 
  product_category,
  product_detail,
  ROUND(SUM(`transaction_qty` *  CAST(REPLACE(`unit_price`,',','.') AS DOUBLE)),2) AS Total_Revenue
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY ALL;

--4. TOTAL Revenue per store location
SELECT
  store_location,
  ROUND(SUM(`transaction_qty` *  CAST(REPLACE(`unit_price`,',','.') AS DOUBLE)),2) AS Total_Revenue
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY 1;

SELECT 
  MIN(transaction_time),
  MAX(transaction_time)
FROM bright_coffee_sales.coffee_sales.dataset;

--5. TOTAL REVENUE BASED ON TIME OF DAY AND PRODUCT_CATEGORY
 ---6am - 11:59 > morning
 --12pm - 16:59 > afternoon
 --17:00 - 19:59 > evening
SELECT
  product_category,
  CASE
    WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN HOUR(transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
    WHEN HOUR(transaction_time) BETWEEN 17 AND 19 THEN 'Evening'
    ELSE 'Night'
  END AS transaction_time_bucket,
  ROUND(SUM(`transaction_qty` *  CAST(REPLACE(`unit_price`,',','.') AS DOUBLE)),2) AS Total_Revenue
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY ALL;

---6. TOTAL REVENUE PER PRODUCT TYPE
SELECT 
  product_type,
  ROUND(SUM(`transaction_qty` *  CAST(REPLACE(`unit_price`,',','.') AS DOUBLE)),2) AS Total_Revenue
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY 1;

--7. PEAK TIME INTERVALS FOR SALES
SELECT
  CASE
    WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN HOUR(transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
    WHEN HOUR(transaction_time) BETWEEN 17 AND 19 THEN 'Evening'
    ELSE 'Night'
  END AS transaction_time_bucket,
  COUNT(*) AS transaction_count,
  SUM(transaction_qty) AS total_units,
  ROUND(SUM(`transaction_qty` * CAST(REPLACE(`unit_price`,',','.') AS DOUBLE)),2) AS total_revenue
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY transaction_time_bucket
ORDER BY total_revenue DESC;










































































































-----------------------------------------------------------------------------------------
--SELECT
        --transaction_date, 
        --MONTHNAME(transaction_date) AS month_name,
        --MONTH(transaction_date) AS month_number,
        --DATE_FORMAT(transaction_date, 'yyyy-MMM') AS month_id,
        --DAYNAME(transaction_date) AS day_name,
        --DAYOFWEEK(transaction_date) AS day_number

--FROM bright_coffee_sales.coffee_sales.dataset
--GROUP BY ALL;












