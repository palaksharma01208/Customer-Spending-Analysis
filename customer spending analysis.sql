CREATE DATABASE customer_;
USE customer_;
CREATE TABLE Customer_ (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  city VARCHAR(50)
);

CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  price INT
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE
);

CREATE TABLE Order_Items (
  order_item_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT
);
INSERT INTO Customer_ VALUES 
(1, 'Palak', 'Shivpuri'),
(2, 'Rahul', 'Gwalior'),
(3, 'Priya', 'Bhopal');

INSERT INTO Products VALUES 
(101, 'Laptop', 50000),
(102, 'Mobile', 20000),
(103, 'Headphone', 2000);

INSERT INTO Orders VALUES 
(1001, 1, '2024-01-05'),
(1002, 2, '2024-01-06'),
(1003, 1, '2024-01-07'),
(1004, 3, '2024-01-08');

INSERT INTO Order_Items VALUES 
(1, 1001, 101, 1),
(2, 1002, 102, 2),
(3, 1003, 103, 3),
(4, 1004, 101, 1); 
SELECT 
  c.customer_name,
  p.product_name,
  oi.quantity,
  p.price,
  oi.quantity * p.price AS total
FROM Customer_ c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;

SELECT 
  c.customer_name,
  SUM(oi.quantity * p.price) AS total_spending
FROM Customer_ c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spending DESC;

WITH customer_total AS (
  SELECT 
    c.customer_name,
    SUM(oi.quantity * p.price) AS total_spending
  FROM Customer_ c
  JOIN Orders o ON c.customer_id = o.customer_id
  JOIN Order_Items oi ON o.order_id = oi.order_id
  JOIN Products p ON oi.product_id = p.product_id
  GROUP BY c.customer_name
)
SELECT * FROM customer_total
WHERE total_spending > 45000
ORDER BY total_spending DESC;

CREATE VIEW customer_spending_view AS
SELECT 
  c.customer_name,
  SUM(oi.quantity * p.price) AS total_spending
FROM Customer_ c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.customer_name;

SELECT * FROM customer_spending_view;