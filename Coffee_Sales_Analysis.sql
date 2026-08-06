-- Databricks notebook source
SELECT *
FROM bright_coffee_sales.coffee_sales.dataset
LIMIT 100;


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

-----NUMBER OF TRANSACTION---
SELECT 
  COUNT(transaction_id) AS trans_count
FROM bright_coffee_sales.coffee_sales.dataset;

----PRODUCT SOLD----
SELECT 
  SUM(transaction_qty) AS product_sold
FROM bright_coffee_sales.coffee_sales.dataset;


---QUANTITY SOLD PER PRODUCT CATEGORY---
SELECT
  product_category,
  SUM(transaction_qty) AS total_units_sold,
  SUM(total_amount) AS total_revenue,
  COUNT(*) AS transaction_count
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY product_category
ORDER BY total_units_sold DESC;


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

--TIME BUCKET CANCELLED IT WASNT SHOWING SOME TRANSACTIONS
--SELECT
  --product_category,
  --CASE
    --WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
    --WHEN HOUR(transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
    --WHEN HOUR(transaction_time) BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
    --ELSE 'Night'
  --END AS transaction_time_bucket,
  --ROUND(SUM(`transaction_qty` *  CAST(REPLACE(`unit_price`,',','.') AS DOUBLE)),2) AS Total_Revenue
--FROM bright_coffee_sales.coffee_sales.dataset
--GROUP BY ALL;


---(HH:mm:ss) final because 
SELECT
  product_category,
  DATE_FORMAT(transaction_time,'HH:mm:ss') AS trans_time,
  CASE
    WHEN DATE_FORMAT(transaction_time,'HH:mm:ss') BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
    WHEN DATE_FORMAT(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
    WHEN DATE_FORMAT(transaction_time,'HH:mm:ss') BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
    ELSE 'Night'
  END AS transaction_time_bucket,
  ROUND(SUM(`transaction_qty` *  CAST(REPLACE(`unit_price`,',','.') AS DOUBLE)),2) AS Total_Revenue
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY ALL;

---PEAK TIME SALES---
SELECT
  CASE
    WHEN DATE_FORMAT(transaction_time,'HH:mm:ss') BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
    WHEN DATE_FORMAT(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
    WHEN DATE_FORMAT(transaction_time,'HH:mm:ss') BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
    ELSE 'Night'
  END AS transaction_time_bucket,
  COUNT(*) AS transaction_count,
  SUM(transaction_qty) AS total_units,
  ROUND(SUM(transaction_qty * CAST(REPLACE(unit_price,',','.') AS DOUBLE)), 2) AS total_revenue,
  ROUND(SUM(transaction_qty * CAST(REPLACE(unit_price,',','.') AS DOUBLE)) / COUNT(*), 2) AS avg_order_value
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY transaction_time_bucket
ORDER BY total_revenue DESC;

---6. TOTAL REVENUE PER PRODUCT TYPE
SELECT 
  product_type,
  ROUND(SUM(`transaction_qty` *  CAST(REPLACE(`unit_price`,',','.') AS DOUBLE)),2) AS Total_Revenue
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY 1;

---7. DATE EXTRACTION---
SELECT
  transaction_date,
  MONTHNAME(transaction_date) AS month_name,
  MONTH(transaction_date) AS month_num,
  DATE_FORMAT(transaction_date, 'yyyy-MMM') AS month_id,
  DAYNAME(transaction_date) AS day_name,
  DAYOFWEEK(transaction_date) AS day_number
FROM bright_coffee_sales.coffee_sales.dataset;

SELECT Distinct `product_category`
FROM bright_coffee_sales.coffee_sales.dataset;


--------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
  transaction_date,
  MONTHNAME(transaction_date) AS month_name,
  MONTH(transaction_date) AS month_num,
  DATE_FORMAT(transaction_date, 'yyyy-MMM') AS month_id,
  DAYNAME(transaction_date) AS day_name,
  DAYOFWEEK(transaction_date) AS day_number,
  COUNT(transaction_id) AS trans_count,
  SUM(transaction_qty) AS product_sold,
  product_category,
  product_detail,
  product_type,
  store_location,
CASE
    WHEN DATE_FORMAT(transaction_time,'HH:mm:ss') BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
    WHEN DATE_FORMAT(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
    WHEN DATE_FORMAT(transaction_time,'HH:mm:ss') BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
    ELSE 'Night'
  END AS transaction_time_bucket,
  ROUND(SUM(`transaction_qty` *  CAST(REPLACE(`unit_price`,',','.') AS DOUBLE)),2) AS Total_Revenue
FROM bright_coffee_sales.coffee_sales.dataset
GROUP BY ALL;

























































































































