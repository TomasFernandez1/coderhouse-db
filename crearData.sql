use coder_sql;

INSERT INTO customers (first_name, last_name, email, password, phone, address) VALUES
('John', 'Doe', 'john.doe@example.com', 'password1', '123-456-7890', '123 Elm Street'),
('Jane', 'Smith', 'jane.smith@example.com', 'password2', '987-654-3210', '456 Oak Avenue'),
('Alice', 'Johnson', 'alice.johnson@example.com', 'password3', '555-123-4567', '789 Pine Road'),
('Bob', 'Brown', 'bob.brown@example.com', 'password4', '555-987-6543', '321 Maple Drive');

INSERT INTO products (name, description, price, stock_quantity) VALUES
('Laptop', 'A high-performance laptop', 899.99, 50),
('Smartphone', 'Latest model smartphone', 599.99, 100),
('Tablet', 'A powerful tablet with a great screen', 399.99, 75),
('Headphones', 'Noise-canceling headphones', 199.99, 150),
('Smartwatch', 'A smartwatch with various features', 149.99, 200);

INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(1, '2024-09-20 14:30:00', 'Completed', 899.99),
(2, '2024-09-21 10:00:00', 'Pending', 149.99),
(3, '2024-09-22 16:45:00', 'Completed', 599.99),
(4, '2024-09-23 11:20:00', 'Cancelled', 0.00),
(1, '2024-09-24 09:15:00', 'Completed', 399.99);

INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 899.99),
(2, 5, 1, 149.99), 
(3, 2, 1, 599.99), 
(5, 3, 1, 399.99); 

INSERT INTO payments (order_id, payment_method, amount, payment_date, status) VALUES
(1, 'Credit Card', 899.99, '2024-09-20 14:35:00', 'Completed'),
(2, 'PayPal', 149.99, '2024-09-21 10:10:00', 'Pending'),
(3, 'Credit Card', 599.99, '2024-09-22 16:50:00', 'Completed'),
(5, 'Debit Card', 399.99, '2024-09-24 09:20:00', 'Completed');
