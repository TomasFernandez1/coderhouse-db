SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS lifetime_value,
    COUNT(o.order_id) AS total_orders
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, customer_name
ORDER BY 
    lifetime_value DESC
LIMIT 10;  

SELECT 
    p.payment_method,
    COUNT(p.payment_id) AS total_transactions,
    SUM(p.amount) AS total_revenue
FROM 
    payments p
GROUP BY 
    p.payment_method
ORDER BY 
    total_revenue DESC;

SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    AVG(total_amount) AS average_order_value
FROM 
    orders
GROUP BY 
    YEAR(order_date), MONTH(order_date)
ORDER BY 
    year, month;

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(od.quantity) AS total_quantity_purchased
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    order_details od ON o.order_id = od.order_id
GROUP BY 
    c.customer_id, customer_name
ORDER BY 
    total_quantity_purchased DESC
LIMIT 10;  

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS purchase_frequency
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, customer_name
ORDER BY 
    purchase_frequency DESC
LIMIT 10;  
