use coder_sql;

DELIMITER //

CREATE PROCEDURE add_new_customer(
    IN first_name VARCHAR(50),
    IN last_name VARCHAR(50),
    IN email VARCHAR(100),
    IN password VARCHAR(255),
    IN phone VARCHAR(20),
    IN address VARCHAR(255)
)
BEGIN
    DECLARE email_exists INT;
    
    -- Check if the email already exists
    SELECT COUNT(*) INTO email_exists
    FROM customers
    WHERE email = email;

    IF email_exists > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email already exists.';
    ELSE
        -- Insert new customer
        INSERT INTO customers (first_name, last_name, email, password, phone, address)
        VALUES (first_name, last_name, email, password, phone, address);
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE update_order_status(
    IN order_id INT,
    IN new_status VARCHAR(20)
)
BEGIN
    -- Check if order exists
    IF (SELECT COUNT(*) FROM orders WHERE order_id = order_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order not found.';
    ELSE
        -- Update order status
        UPDATE orders
        SET status = new_status
        WHERE order_id = order_id;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE process_payment(
    IN order_id INT,
    IN payment_method VARCHAR(50),
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE order_total DECIMAL(10,2);
    DECLARE current_status VARCHAR(20);

    -- Check if the order exists and retrieve the order total
    SELECT total_amount, status INTO order_total, current_status
    FROM orders
    WHERE order_id = order_id;

    -- Check if the order is not already completed or cancelled
    IF current_status IN ('Completed', 'Cancelled') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot process payment for a completed or cancelled order.';
    ELSEIF order_total IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order not found.';
    ELSEIF amount < order_total THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment amount is less than the order total.';
    ELSE
        -- Insert payment record
        INSERT INTO payments (order_id, payment_method, amount, status)
        VALUES (order_id, payment_method, amount, 'Completed');
        
        -- Update order status to 'Completed'
        UPDATE orders
        SET status = 'Completed'
        WHERE order_id = order_id;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE update_product_stock(
    IN product_id INT,
    IN quantity_change INT
)
BEGIN
    DECLARE current_stock INT;

    -- Get the current stock
    SELECT stock_quantity INTO current_stock
    FROM products
    WHERE product_id = product_id;

    -- Check if the product exists
    IF current_stock IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product not found.';
    ELSEIF current_stock + quantity_change < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock.';
    ELSE
        -- Update the stock quantity
        UPDATE products
        SET stock_quantity = stock_quantity + quantity_change
        WHERE product_id = product_id;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE get_customer_order_history(
    IN customer_id INT
)
BEGIN
    -- Check if customer exists
    IF (SELECT COUNT(*) FROM customers WHERE customer_id = customer_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Customer not found.';
    ELSE
        -- Retrieve order history
        SELECT 
            o.order_id,
            o.order_date,
            o.status,
            o.total_amount
        FROM orders o
        WHERE o.customer_id = customer_id
        ORDER BY o.order_date DESC;
    END IF;
END //

DELIMITER ;
