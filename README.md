# Bright_Coffee_Shop_Sales_Analysis
Overview

This project contains an analysis of Bright Coffee Shop using a dataset of daily transactional sales. Bright Coffee Shop's newly appointed CEO wants to grow revenue and improve product performance, and this project extracts actionable insights from historical sales data to support that decision-making.

Objective

Using SQL, data transformation, and data visualization, this project answers:

Which products generate the most revenue
What time of day the store performs best
Sales trends across products and time intervals
Recommendations for improving sales performance

Approach Planning — A data flow & architecture diagram (source → ETL → storage → analysis → presentation) was designed in Miro, along with a project Gantt chart in Excel outlining each phase of the project.

Data Processing (Databricks) — The raw CSV was loaded into Databricks, where the following transformations were applied using SQL:

Created transaction_time_bucket, grouping transactions into 30-minute 

Cast unit_price from comma-decimal text (e.g. '3,1') to a proper numeric type (3.1)

Computed total_amount = unit_price * transaction_qty

Grouped and aggregated data by product type, category, and time bucket

Data Analysis (Excel) — The processed dataset was exported and analysed using pivot tables and charts to surface:

Total revenue per product type

Peak time intervals for sales

Quantity of items sold by product category

Best-selling product types/details

Presentation — Key insights, methodology, and recommendations were compiled into a PowerPoint presentation for the CEO.

Recommendations

Marketing campaigns during slow time slots

Stock more of the best-selling items

Promote underperforming products

Consider loyalty packages for peak time customers

Next Steps

Automate daily sales reporting

Track sales performance across multiple locations

Implement loyalty programs based on peak customer time slots
