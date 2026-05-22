-- WEEK 3 : The Dataset of superstore_raw tells us about the details of orders' transactions in each row

-- Tasks:

-- STEP 1: Setting up Data

CREATE DATABASE IF NOT EXISTS `superstore_analysis`;
USE `superstore_analysis`;
-- import the superstore_raw table into this dataset

CREATE TABLE  IF NOT EXISTS customers (
    Customer_ID VARCHAR(50) PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Segment VARCHAR(50) 
    );
INSERT IGNORE INTO customers (Customer_ID, Customer_Name, segment)
SELECT DISTINCT `Customer ID`, `Customer Name`, `Segment`
FROM `superstore_raw`;
SELECT * FROM customers LIMIT 5 ;

CREATE TABLE IF NOT EXISTS orders ( 
`Row_ID` INT PRIMARY KEY,
Order_ID VARCHAR(50),
Order_Date DATE,
Ship_Date DATE,
Ship_Mode VARCHAR(50),
Customer_ID VARCHAR(50),
Country VARCHAR(50),
City VARCHAR(50),
State VARCHAR(50),
Postal_Code VARCHAR(20),
Region VARCHAR(50),
Product_ID VARCHAR(50),
Sales DECIMAL(10, 2),
Quantity INT,
Discount DECIMAL(4, 2),
Profit DECIMAL(10, 2)
) ;
INSERT IGNORE INTO orders (`Row_ID`, Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Country, City, State, Postal_Code, Region, Product_ID, Sales, Quantity, Discount, Profit)
SELECT DISTINCT 
    `Row ID`, 
    `Order ID`, 
    STR_TO_DATE(`Order Date`, '%m/%d/%Y'), 
    STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),  
    `Ship Mode`, 
    `Customer ID`, 
    `Country`, 
    `City`, 
    `State`, 
    `Postal Code`, 
    `Region`, 
    `Product ID`, 
    `Sales`, 
    `Quantity`, 
    `Discount`, 
    `Profit`
FROM `superstore_raw` ;
SELECT * FROM orders LIMIT 10 ;

CREATE TABLE IF NOT EXISTS products (
    Row_ID INT PRIMARY KEY,
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255)
);
INSERT IGNORE INTO products ( Row_ID, Product_ID, Category, Sub_Category, Product_Name )
SELECT DISTINCT
	`Row ID`,
	`Product ID`,
	`Category`,
	`Sub-Category`,
	`Product Name`
FROM superstore_raw ;
SELECT * FROM products LIMIT 5 ;


