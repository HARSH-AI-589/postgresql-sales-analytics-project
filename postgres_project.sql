CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    signup_date DATE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price NUMERIC(10,2)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE
);

INSERT INTO customers (name, city, signup_date)
VALUES
('Rahul', 'Pune', '2024-01-10'),
('Sneha', 'Mumbai', '2024-02-05'),
('Amit', 'Delhi', '2024-02-20'),
('Priya', 'Bangalore', '2024-03-01');

INSERT INTO products (product_name, category, price)
VALUES
('Laptop', 'Electronics', 50000.00),
('Phone', 'Electronics', 20000.00),
('Shoes', 'Fashion', 5000.00),
('Watch', 'Accessories', 8000.00);

INSERT INTO orders (customer_id, product_id, quantity, order_date)
VALUES
(1, 1, 1, '2024-05-10'),
(2, 2, 2, '2024-05-12'),
(3, 3, 1, '2024-05-13'),
(4, 4, 1, '2024-05-14'),
(1, 2, 1, '2024-05-15');

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

SELECT SUM(products.price * orders.quantity) AS total_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id;

SELECT products.category,
SUM(products.price * orders.quantity) AS total_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
GROUP BY products.category
ORDER BY total_revenue DESC;

SELECT products.product_name,
SUM(orders.quantity) AS total_quantity_sold
FROM orders
JOIN products
ON orders.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_quantity_sold DESC;

SELECT customers.name,
SUM(products.price * orders.quantity) AS total_spent
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN products
ON orders.product_id = products.product_id
GROUP BY customers.name
ORDER BY total_spent DESC;

SELECT customers.city,
SUM(products.price * orders.quantity) AS total_revenue
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN products
ON orders.product_id = products.product_id
GROUP BY customers.city
ORDER BY total_revenue DESC;

SELECT order_date,
SUM(products.price * orders.quantity) 
OVER (ORDER BY order_date) AS running_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id;

SELECT customers.name,
SUM(products.price * orders.quantity) AS total_spent,
RANK() OVER (ORDER BY SUM(products.price * orders.quantity) DESC) AS customer_rank
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN products
ON orders.product_id = products.product_id
GROUP BY customers.name;