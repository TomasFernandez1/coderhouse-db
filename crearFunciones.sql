use coder_sql;

DELIMITER //

CREATE FUNCTION calculate_discounted_price(original_price DECIMAL(10, 2), discount_percentage DECIMAL(5, 2))
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE discounted_price DECIMAL(10, 2);
    SET discounted_price = original_price - (original_price * discount_percentage / 100);
    RETURN discounted_price;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION get_customer_full_name(customer_id INT)
RETURNS VARCHAR(101)
DETERMINISTIC
BEGIN
    DECLARE full_name VARCHAR(101);
    SELECT CONCAT(first_name, ' ', last_name) INTO full_name
    FROM customers
    WHERE customer_id = customer_id;
    RETURN full_name;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION calculate_order_total(order_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(quantity * price) INTO total
    FROM order_details
    WHERE order_id = order_id;
    RETURN total;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION is_product_in_stock(product_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE stock INT;
    SELECT stock_quantity INTO stock
    FROM products
    WHERE product_id = product_id;
    RETURN stock > 0;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION calculate_customer_lifetime_value(customer_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_spent DECIMAL(10, 2);
    SELECT SUM(total_amount) INTO total_spent
    FROM orders
    WHERE customer_id = customer_id;
    RETURN total_spent;
END //

DELIMITER ;



