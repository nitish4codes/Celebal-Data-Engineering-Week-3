-- Mini Project: Customer Sales Insights

-- To Answer the following using SQL:

-- 1. Who are the top 5 customers? 
WITH RankedCustomers AS (
    SELECT 
        c.Customer_ID, 
        c.Customer_Name, 
        SUM(o.Sales) AS Total_Sales,
        DENSE_RANK() OVER (ORDER BY SUM(o.Sales) DESC) AS Customer_Rank
    FROM orders o
    JOIN customers c ON o.Customer_ID = c.Customer_ID
    GROUP BY c.Customer_ID, c.Customer_Name
)
SELECT Customer_Name, Total_Sales, Customer_Rank
FROM RankedCustomers
WHERE Customer_Rank <= 5;

-- 2. Who are the bottom 5 customers?
WITH RankedCustomers AS (
    SELECT 
        c.Customer_ID, 
        c.Customer_Name, 
        SUM(o.Sales) AS Total_Sales,
        DENSE_RANK() OVER (ORDER BY SUM(o.Sales) ASC) AS Customer_Rank
    FROM orders o
    JOIN customers c ON o.Customer_ID = c.Customer_ID
    GROUP BY c.Customer_ID, c.Customer_Name
)
SELECT Customer_Name, Total_Sales, Customer_Rank
FROM RankedCustomers
WHERE Customer_Rank <= 5;

-- 3. Which customers made only one order?
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    COUNT(DISTINCT o.Order_ID) AS Total_Orders
FROM orders o
JOIN customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
HAVING COUNT(DISTINCT o.Order_ID) = 1;

-- 4. Which customers have above-average sales?
WITH CustomerTotals AS (
    SELECT 
        c.Customer_ID, 
        c.Customer_Name, 
        SUM(o.Sales) AS Total_Sales
    FROM orders o
    JOIN customers c ON o.Customer_ID = c.Customer_ID
    GROUP BY c.Customer_ID, c.Customer_Name
)
SELECT Customer_Name, Total_Sales
FROM CustomerTotals
WHERE Total_Sales > (
    SELECT AVG(Total_Sales) 
    FROM CustomerTotals
);

-- 5. What is the highest order value per customer?
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    MAX(o.Sales) AS Highest_Single_Order
FROM orders o
JOIN customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;