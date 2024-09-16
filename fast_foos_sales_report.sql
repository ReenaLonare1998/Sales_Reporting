# Create database
create database sales_and_report;
----------------------------------------------------------------------------------------------------------
use sales_and_report;

SELECT * FROM sales_and_report.cleaned_fast_food_sales;
----------------------------------------------------------------------------------------------------------
# Basic Queries
----------------------------------------------------------------------------------------------------------

-- 1.Total Sales Amount:
-- Purpose: Gives the total revenue generated from all sales, providing a quick overview of overall sales performance.

SELECT SUM(transaction_amount) AS total_sales
FROM cleaned_fast_food_sales;
----------------------------------------------------------------------------------------------------------

-- 2. Count of Transactions by Type
-- Purpose: To determine how many transactions were made in each transaction type (e.g., Cash or Online).

SELECT transaction_type, COUNT(*) AS transaction_count
FROM cleaned_fast_food_sales
GROUP BY transaction_type;
----------------------------------------------------------------------------------------------------------

-- 3. Items Sold on a Specific Date with Total Amount
-- Purpose: To list the items sold, their quantities, and the total amount generated from each item on a specific date.

SELECT item_name, quantity, quantity * item_price AS total_amount
FROM cleaned_fast_food_sales
WHERE date = '2022-07-03';


----------------------------------------------------------------------------------------------------------
# Intermediate Queries
----------------------------------------------------------------------------------------------------------

-- 1.Total Sales per Month
-- Purpose: To calculate the total sales for each month.

SELECT Month_Year, SUM(transaction_amount) AS total_sales
FROM  cleaned_fast_food_sales
GROUP BY Month_Year
ORDER BY Month_Year;
----------------------------------------------------------------------------------------------------------

-- 2. Top 5 Items Sold by Quantity
-- Purpose: To find the top 5 best-selling items based on quantity.

SELECT item_name, SUM(quantity) AS total_quantity
FROM cleaned_fast_food_sales
GROUP BY item_name
ORDER BY total_quantity DESC
LIMIT 5;
----------------------------------------------------------------------------------------------------------

-- 3.Monthly Sales Trend
-- Purpose: TAnalyzes sales trends over months to identify peak and low periods in 2022.

SELECT DATE_FORMAT(date, '%Y-%m') AS month, SUM(transaction_amount) AS total_sales
FROM cleaned_fast_food_sales
WHERE YEAR(date) = 2023
GROUP BY month
ORDER BY month;



----------------------------------------------------------------------------------------------------------
# Advanced Queries
----------------------------------------------------------------------------------------------------------

-- 1.Total Sales by Item Type and Month
-- Purpose: To analyze sales performance by item type across different months.

SELECT item_type, Month_Year, SUM(transaction_amount) AS total_sales
FROM cleaned_fast_food_sales
GROUP BY item_type, Month_Year
ORDER BY item_type, Month_Year;


----------------------------------------------------------------------------------------------------------

-- 2. Most Profitable Time of Day
-- Purpose: To identify the time of day that generates the most sales.

SELECT time_of_sale, SUM(transaction_amount) AS total_sales
FROM cleaned_fast_food_sales
GROUP BY time_of_sale
ORDER BY total_sales DESC;


----------------------------------------------------------------------------------------------------------

-- 3.Monthly Sales Growth Rate
-- Purpose: To calculate the monthly sales growth rate, showing how much sales increased or decreased from one month to the next.

SELECT Month_Year, 
       SUM(transaction_amount) AS monthly_sales,
       LAG(SUM(transaction_amount)) OVER (ORDER BY Month_Year) AS previous_month_sales,
       (SUM(transaction_amount) - LAG(SUM(transaction_amount)) OVER (ORDER BY Month_Year)) / 
       LAG(SUM(transaction_amount)) OVER (ORDER BY Month_Year) * 100 AS growth_rate
FROM cleaned_fast_food_sales
GROUP BY Month_Year
ORDER BY Month_Year;
----------------------------------------------------------------------------------------------------------
