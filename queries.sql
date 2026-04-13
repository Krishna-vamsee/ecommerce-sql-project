
-- Create Database 

CREATE DATABASE ecommerce;
USE ecommerce;

-- Create Tables

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT
);

-- View All Data 
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_details;

-- 
SELECT SUM(p.price * od.quantity) AS total_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id;

-- Total Revenue
SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Top Selling Products
SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Revenue by Category
SELECT p.category, SUM(p.price * od.quantity) AS revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.category;

-- Customer Orders
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- Monthly Sales 
SELECT MONTH(order_date) AS month, COUNT(order_id) AS total_orders
FROM orders
GROUP BY MONTH(order_date);

-- Top Customers
SELECT c.customer_name,
       SUM(p.price * od.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Rank Customers
SELECT c.customer_name,
       SUM(p.price * od.quantity) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.price * od.quantity) DESC) AS rank_no
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_name;

