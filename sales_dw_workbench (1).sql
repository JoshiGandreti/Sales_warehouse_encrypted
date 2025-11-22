– =============================================== – SALES DATA WAREHOUSE
(STAR SCHEMA) – ===============================================

DROP TABLE IF EXISTS fact_sales; DROP TABLE IF EXISTS dim_customer; DROP
TABLE IF EXISTS dim_product; DROP TABLE IF EXISTS dim_store; DROP TABLE
IF EXISTS dim_time;

CREATE TABLE dim_customer ( customer_sk INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT, customer_name VARCHAR(150), region VARCHAR(100),
loyalty_tier VARCHAR(50), start_date DATE, end_date DATE, is_current
BOOLEAN, UNIQUE (customer_id, start_date) );

CREATE TABLE dim_product ( product_sk INT AUTO_INCREMENT PRIMARY KEY,
product_id INT, product_name VARCHAR(150), category VARCHAR(100),
sub_category VARCHAR(100), brand VARCHAR(100) );

CREATE TABLE dim_store ( store_sk INT AUTO_INCREMENT PRIMARY KEY,
store_id INT, store_name VARCHAR(150), city VARCHAR(100), state
VARCHAR(100), region VARCHAR(100) );

CREATE TABLE dim_time ( time_sk INT AUTO_INCREMENT PRIMARY KEY,
full_date DATE, day INT, week INT, month INT, quarter INT, year INT );

CREATE TABLE fact_sales ( sales_sk INT AUTO_INCREMENT PRIMARY KEY,
invoice_id INT, customer_sk INT, product_sk INT, store_sk INT, time_sk
INT, quantity INT, unit_price DECIMAL(10,2), discount DECIMAL(10,2),
total_amount DECIMAL(12,2), profit DECIMAL(12,2), FOREIGN KEY
(customer_sk) REFERENCES dim_customer(customer_sk), FOREIGN KEY
(product_sk) REFERENCES dim_product(product_sk), FOREIGN KEY (store_sk)
REFERENCES dim_store(store_sk), FOREIGN KEY (time_sk) REFERENCES
dim_time(time_sk) );

INSERT INTO dim_customer (customer_id, customer_name, region,
loyalty_tier, start_date, end_date, is_current) VALUES (101, ‘John Doe’,
‘South’, ‘Gold’, ‘2024-01-01’, NULL, TRUE), (102, ‘Priya Sharma’,
‘North’, ‘Silver’, ‘2024-01-01’, NULL, TRUE), (103, ‘Rohit Verma’,
‘West’, ‘Bronze’, ‘2024-01-01’, NULL, TRUE);

INSERT INTO dim_product (product_id, product_name, category,
sub_category, brand) VALUES (201, ‘iPhone 14’, ‘Electronics’, ‘Mobile’,
‘Apple’), (202, ‘MacBook Pro’, ‘Electronics’, ‘Laptop’, ‘Apple’), (203,
‘Running Shoes’, ‘Fashion’, ‘Footwear’, ‘Nike’);

INSERT INTO dim_store (store_id, store_name, city, state, region) VALUES
(301, ‘TechStore A’, ‘Chennai’, ‘TN’, ‘South’), (302, ‘TechStore B’,
‘Mumbai’, ‘MH’, ‘West’), (303, ‘TechStore C’, ‘Delhi’, ‘DL’, ‘North’);

INSERT INTO dim_time (full_date, day, week, month, quarter, year) VALUES
(‘2025-01-10’, 10, 2, 1, 1, 2025), (‘2025-01-15’, 15, 3, 1, 1, 2025),
(‘2025-02-05’, 5, 6, 2, 1, 2025);

INSERT INTO fact_sales (invoice_id, customer_sk, product_sk, store_sk,
time_sk, quantity, unit_price, discount, total_amount, profit) VALUES
(5001, 1, 1, 1, 1, 1, 80000, 5000, 75000, 12000), (5002, 2, 2, 2, 2, 1,
150000, 10000, 140000, 20000), (5003, 3, 3, 3, 3, 2, 4000, 500, 3500,
500);

CREATE INDEX idx_customer_region ON dim_customer(region); CREATE INDEX
idx_product_category ON dim_product(category); CREATE INDEX
idx_store_region ON dim_store(region); CREATE INDEX idx_time_year_month
ON dim_time(year, month); CREATE INDEX idx_fact_sales_fk ON
fact_sales(customer_sk, product_sk, store_sk, time_sk);
