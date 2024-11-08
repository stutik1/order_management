-- Insert data into address table
INSERT INTO address (street, city, state, postal_code, country) VALUES
('123 Main Street', 'New York', 'NY', '10001', 'USA'),
('456 Elm Street', 'Los Angeles', 'CA', '90001', 'USA');

-- Insert data into customer table
INSERT INTO customer (first_name, last_name, email, phone, address_id) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', 1),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', 2);

-- Insert data into products table
INSERT INTO products (name, description, price) VALUES
('Product A', 'Description of Product A', 29.99),
('Product B', 'Description of Product B', 49.99),
('Product C', 'Description of Product C', 19.99);

-- Insert data into orders table
INSERT INTO orders (customer_id, order_date, status, payment_type) VALUES
(1, '2024-11-08 10:00:00', 'PENDING', 'CREDIT_CARD'),
(2, '2024-11-08 11:30:00', 'COMPLETED', 'PAYPAL');

-- Insert data into order_product table
INSERT INTO order_product (order_id, product_id, quantity) VALUES
(1, 1, 2),  -- Order 1 has 2 of Product A
(1, 3, 1),  -- Order 1 has 1 of Product C
(2, 2, 1),  -- Order 2 has 1 of Product B
(2, 3, 3);  -- Order 2 has 3 of Product C
