-- WEEK 3 :
-- Tasks:
CREATE DATABASE IF NOT EXISTS `superstore_analysis`;
USE `superstore_analysis`;
-- hello
 CREATE TABLE customers (
    'Customer ID' VARCHAR(50) PRIMARY KEY,
    'Customer Name' VARCHAR(50),
    'Segment' VARCHAR(50),
   )

 INSERT INTO customers ( 'Customer ID', 'Customer Name', 'Segment')
 SELECT DISTINCT `Customer 