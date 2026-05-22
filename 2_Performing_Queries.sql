-- STEP 2 : Performing required queries

-- 1. Finding all orders where sales are greater than the average sales. (Subquery)
SELECT Row_ID, Order_ID, Sales
FROM orders
WHERE Sales > (
	SELECT AVG(Sales) AS `Average Sales`
    FROM Orders
) ;    

-- 2. Finding the highest sales order for each customer. (Subquery)
SELECT Customer_ID, Order_ID ,Sales
FROM orders
WHERE ( Customer_ID, Sales ) IN (
	SELECT Customer_ID, MAX(Sales)
	FROM orders
	GROUP BY Customer_ID
) ;

-- 3. Calculate total sales for each customer. (CTE)
-- in CTE we basically make a temporary virtual table for our further analysis
SELECT Customer_ID, Sales