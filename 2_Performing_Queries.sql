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
-- CTE always start with WITH
WITH CustomerSalesCTE AS (
	SELECT Customer_ID, SUM(Sales) AS Total_Customer_Sales
    FROM orders
    GROUP BY Customer_ID
    )
SELECT Customer_ID, Total_Customer_Sales 
FROM CustomerSalesCTE ;
    
-- 4. Find customers whose total sales are above average. (CTE + Subquery)    
WITH Customer_SalesCTE AS (
	SELECT Customer_ID, SUM(Sales) AS Total_Customer_Sales 
    FROM orders
    GROUP BY Customer_ID
    )
SELECT Customer_ID, Total_Customer_Sales
FROM Customer_SalesCTE
WHERE Total_Customer_Sales > (
	SELECT  AVG(TOTAL_Customer_Sales) 
    FROM Customer_SalesCTE
    );

-- 5. Rank all customers based on total sales. (Window Function)
SELECT
	Customer_ID,
    SUM(Sales) AS Total_Sales,
    RANK() OVER ( ORDER BY SUM(Sales) DESC ) AS Rank_of_Customers   
FROM orders
GROUP BY Customer_ID
LIMIT 5 ;    -- for short proof

-- 6. Assign row numbers to each order within a customer. (Window Function + PARTITION BY)		
SELECT 
    Customer_ID, 
    Order_ID, 
    Order_Date, 
    Sales,
    ROW_NUMBER() OVER(PARTITION BY Customer_ID ORDER BY Order_Date ASC) AS Order_Sequence_Number
FROM orders;

-- 7. Display top 3 customers based on total sales. (Window Function)
SELECT Customer_ID, Total_Sales, Customer_Rank
FROM (
    SELECT 
        Customer_ID, 
        SUM(Sales) AS Total_Sales,
        DENSE_RANK() OVER (ORDER BY SUM(Sales) DESC) AS Customer_Rank
    FROM orders
    GROUP BY Customer_ID
) AS RankedCustomers
WHERE Customer_Rank <= 3;



