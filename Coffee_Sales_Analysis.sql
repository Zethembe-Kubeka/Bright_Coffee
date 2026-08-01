-- Databricks notebook source
SELECT *
FROM bright_coffee_sales.coffee_sales.dataset
LIMIT 100;

SELECT DISTINCT `product_type`
FROM bright_coffee_sales.coffee_sales.dataset;