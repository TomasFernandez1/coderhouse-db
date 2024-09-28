use coder_sql;

CREATE VIEW customer_order_summary AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM 
    customers c
LEFT JOIN 
    orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name;
    
CREATE VIEW order_details_view AS
SELECT 
    o.order_id,
    o.order_date,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    od.product_id,
    p.name AS product_name,
    od.quantity,
    od.price,
    (od.quantity * od.price) AS total_price,
    o.total_amount AS order_total,
    o.status AS order_status
FROM 
    orders o
JOIN 
    customers c ON o.customer_id = c.customer_id
JOIN 
    order_details od ON o.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id;

CREATE VIEW product_sales_summary AS
SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * od.price) AS total_revenue
FROM 
    products p
JOIN 
    order_details od ON p.product_id = od.product_id
GROUP BY 
    p.product_id, p.name;

CREATE VIEW payment_summary AS
SELECT 
    o.order_id,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.payment_method,
    p.amount AS payment_amount,
    p.payment_date,
    p.status AS payment_status,
    o.total_amount AS order_total
FROM 
    payments p
JOIN 
    orders o ON p.order_id = o.order_id
JOIN 
    customers c ON o.customer_id = c.customer_id;

CREATE VIEW pending_orders AS
SELECT 
    o.order_id,
    o.order_date,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.total_amount
FROM 
    orders o
JOIN 
    customers c ON o.customer_id = c.customer_id
WHERE 
    o.status = 'Pending';

