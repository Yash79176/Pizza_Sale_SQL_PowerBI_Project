SELECT * FROM pizza_sales_excel_file AS pizza

-- 1. Total revenue
SELECT SUM(total_price) as Total_revenue FROM pizza_sales_excel_file ;

-- 2. Average order value
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS avg_order_value FROM pizza_sales_excel_file

-- 3. Total Pizzas sold -
SELECT COUNT(pizza_name_id) as Pizzas_sold FROM pizza_sales_excel_file
SELECT SUM(quantity) as pizzas_sold FROM pizza_sales_excel_file

-- 4. Total Orders

USE PizzaDB
SELECT COUNT(DISTINCT order_id) as Tota_orders FROM pizza_sales_excel_file

-- 5. Average Pizzas per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/CAST(COUNT(DISTINCT order_id)AS DECIMAL(10,2))
AS DECIMAL(10,2)) AS avg_pizza_per_order FROM pizza_sales_excel_file

-- * charts requirement
--1. Daily Trend for Total orders
SELECT * FROM pizza_sales_excel_file
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales_excel_file
GROUP BY DATENAME(DW, order_date)

SELECT DATENAME(MONTH, order_date) AS Month, COUNT(DISTINCT order_id) AS Monthly_orders FROM pizza_sales_excel_file
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Monthly_orders DESC

-- 2. Percentage of sales by pizza category
USE PizzaDB
SELECT DISTINCT pizza_category, SUM(quantity), SUM(total_price) As category_wise_sales, 
SUM(total_price)*100/ (SELECT SUM(total_price) FROM pizza_sales_excel_file WHERE MONTH(order_date) = 1)
AS Percentage_of_sales FROM pizza_sales_excel_file
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

-- 3. Percentage of sales by Pizza size
SELECT DISTINCT pizza_size, SUM(quantity), CAST(SUM(total_price) AS DECIMAL(10,2)) As category_wise_sales, 
CAST(SUM(total_price)*100/ (SELECT SUM(total_price) FROM pizza_sales_excel_file WHERE DATEPART(QUARTER, order_date) = 1)
AS DECIMAL(10,2))
AS Percentage_of_sales FROM pizza_sales_excel_file
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY Percentage_of_sales DESC

-- 4. Top 5 Best sellers by Revenue, Total Quantity and Total Orders
USE PizzaDB
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS Decimal(10,2)) AS total_revenue,
SUM(quantity) AS total_quantity, Count(DISTINCT order_id) as total_orders
FROM pizza_sales_excel_file
GROUP BY pizza_name
ORDER BY total_revenue DESC 