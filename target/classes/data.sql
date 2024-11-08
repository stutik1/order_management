-- Inserting sample data into address table
INSERT INTO address (street, city, state, postal_code, country) VALUES
('123 Main St', 'Springfield', 'IL', '62701', 'USA'),
('456 Elm St', 'Metropolis', 'NY', '10001', 'USA');

-- Inserting sample data into customer table
INSERT INTO customers (first_name, last_name, email, phone, address_id) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', 1),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', 2);

-- Inserting sample data into products table
INSERT INTO products (name, description, price) VALUES
('Product 1', 'Description for Product 1', 100.00),
('Product 2', 'Description for Product 2', 200.00),
('Product 3', 'Description for Product 3', 300.00);

-- Inserting sample data into orders table
INSERT INTO orders (customer_id, order_date, status, payment_type) VALUES
(1, CURRENT_TIMESTAMP, 'Pending', 'Credit Card'),
(2, CURRENT_TIMESTAMP, 'Shipped', 'PayPal');

-- Inserting sample data into order_product table
INSERT INTO order_product (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 5);
