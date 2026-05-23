-- STEP 3 : 
-- Write one final query that shows: • Customer Name • Total Sales • Rank
-- (Use JOIN + CTE + Window Function together)

WITH CustomerSalesCTE AS (
    SELECT 
        Customer_ID, 
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Customer_ID
)
SELECT 
    c.Customer_Name, 
    t.Total_Sales,
    DENSE_RANK() OVER (ORDER BY t.Total_Sales DESC) AS Customer_Rank
FROM CustomerSalesCTE t
JOIN customers c ON t.Customer_ID = c.Customer_ID;