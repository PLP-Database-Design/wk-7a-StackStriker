--1NF
SELECT
  OrderID,
  CustomerName,
  TRIM(product) AS Product
FROM
  ProductDetail,
  JSON_TABLE(
    CONCAT('["', REPLACE(Products, ',', '","'), '"]'),
    '$[*]' COLUMNS(product VARCHAR(100) PATH '$')
  ) AS product_split;

--2NF
-- 1. Create Orders table with unique OrderID and CustomerName
CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- 2. Create new OrderDetails table without CustomerName
CREATE TABLE NewOrderDetails AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;
