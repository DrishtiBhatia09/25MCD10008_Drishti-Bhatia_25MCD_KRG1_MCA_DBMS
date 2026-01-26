CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    order_date DATE
);

INSERT INTO customer_orders (order_id,customer_name, product, quantity, price, order_date) VALUES
(101,'Aman', 'Laptop', 1, 55000, '2024-01-10'),
(102,'Ridhi', 'Mobile', 2, 30000, '2024-01-12'),
(103,'Mohan', 'Laptop', 1, 60000, '2024-01-15'),
(104,'Sakshi', 'Tablet', 3, 15000, '2024-01-18'),
(105,'Gaurav', 'Mobile', 1, 25000, '2024-01-20'),
(106,'Pihu', 'Laptop', 2, 52000, '2024-01-22');

SELECT * FROM customer_orders;

-- Display high-priced orders
SELECT * 
FROM customer_orders
WHERE price > 30000;

-- Filter based on product and price
SELECT customer_name, product, price
FROM customer_orders
WHERE product = 'Laptop' AND price > 55000;

-- Sort by price (ascending)
SELECT customer_name, product, price
FROM customer_orders
ORDER BY price ASC;

-- Sort by price (descending)
SELECT customer_name, product, price
FROM customer_orders
ORDER BY price DESC;

-- Sorting by multiple attributes
SELECT customer_name, product, price
FROM customer_orders
ORDER BY product ASC, price DESC;

-- Total sales per product
SELECT product, SUM(quantity * price) AS total_sales
FROM customer_orders
GROUP BY product;

-- Average price per product
SELECT product, AVG(price) AS avg_price
FROM customer_orders
GROUP BY product;

-- Products with total sales greater than 1,00,000
SELECT product, SUM(quantity * price) AS total_sales
FROM customer_orders
GROUP BY product
HAVING SUM(quantity * price) > 100000;

SELECT product, SUM(quantity * price) AS total_sales
FROM customer_orders
WHERE order_date >= '2024-01-15'
GROUP BY product
HAVING SUM(quantity * price) > 50000;

