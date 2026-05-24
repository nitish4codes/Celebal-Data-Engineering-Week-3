# Superstore Sales Data Analysis

**Developer:** Nitish Bhardwaj  
**Tech Stack:** MySQL Workbench, VS Code, Git Bash  
**LMS Task:** Use Subqueries, CTEs, and Window Functions to analyze sales data from the Superstore dataset.

## Project Objective
This project implements a modular SQL analytics pipeline using advanced relational database techniques—including **Subqueries, Common Table Expressions (CTEs), and Window Functions**—to transform raw transactional data into structured, business-ready insights.

---

## Repository Architecture

The workspace is organized into distinct logical directories separating source executable scripts from their exported execution outputs:

### 📁 Week_Tasks
Contains the core modular SQL development scripts:
* **`1_Setup_Data.sql`:** Handles initial database ingestion, schema definitions, and table normalization using deduplication techniques.
* **`2_Performing_Queries.sql`:** Implements precise conditional filtering, subqueries, and windowed partitions for target business metric tracking.
* **`3_Final_Combined_Query.sql`:** Consolidates multi-table joins, dynamic common table allocations, and analytical ranking into a single compiled script.
* **`Mini_Project_Customer_Insights.sql`:** Focuses on cohort isolation, calculating performance markers for top/bottom spenders and client loyalty lifecycles.

### 📁 Query_Results
Contains the verified output data grids, query execution captures, and exported results corresponding to each development task:
* **`Setup_Data_Results/`**
* **`Performed_Queries/`**
* **`Combined_Query_Results/`**
* **`Mini_Project_Results/`**

---

## Core Technical Implementation & Sample Insights

### 1. Unified Portfolio Performance (CTE + JOIN + Window Function)
This query computes lifetime expenditures across decoupled tables and applies a competitive leaderboard rank to isolate primary high-value consumer tiers.

```sql
WITH CustomerSalesCTE AS (
    SELECT Customer_ID, SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Customer_ID
)
SELECT 
    c.Customer_Name, 
    t.Total_Sales,
    DENSE_RANK() OVER (ORDER BY t.Total_Sales DESC) AS Customer_Rank
FROM CustomerSalesCTE t
JOIN customers c ON t.Customer_ID = c.Customer_ID;
```

#### **Output Result Pattern:**
| Customer_Name | Total_Sales | Customer_Rank |
| :--- | :--- | :--- |
| Sean Miller | $25,043.05 | 1 |
| Tamara Chand | $19,052.22 | 2 |

* **Business Insight:** A small tier of premium customers drives a highly disproportionate share of total sales volume. Implementing exclusive retention campaigns targeting this specific cohort yields the highest return on marketing spend.

---

### 2. Transaction Sequence Analysis (PARTITION BY)
Tracks consumer lifecycle behavior chronologically by indexing distinct order milestones per client profile.

```sql
SELECT 
    Customer_ID, Order_ID, Order_Date, Sales,
    ROW_NUMBER() OVER(PARTITION BY Customer_ID ORDER BY Order_Date ASC) AS Order_Sequence_Number
FROM orders;
```

#### **Output Result Pattern:**
| Customer_ID | Order_ID | Order_Date | Sales | Order_Sequence_Number |
| :--- | :--- | :--- | :--- | :--- |
| CG-12520 | CA-2016-152156 | 2016-11-08 | $261.96 | 1 |
| CG-12520 | CA-2016-152156 | 2016-11-08 | $731.94 | 2 |

* **Business Insight:** Isolating rows where `Order_Sequence_Number = 1` reveals the exact gateway items that initially convert a cold consumer into an active client.

---

## Execution Environment
* **Database Engine:** MySQL
* **Development Interface:** VS Code / Command Line Terminal Staging
* **Primary Source Data:** `Sample - Superstore.csv`
