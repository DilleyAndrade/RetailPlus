--CUSTOMER DIMENSION
CREATE TABLE gold.dim_customer(
	sk_customer SERIAL PRIMARY KEY NOT NULL,
	nk_customer_id INT NOT NULL,
	name VARCHAR(100),
	state VARCHAR(5)
);

INSERT INTO gold.dim_customer(nk_customer_id, name, state)
SELECT
	customer_id
	,name
	,state
FROM silver.customers;

--PRODUCT DIMENSION
CREATE TABLE gold.dim_product(
	sk_product SERIAL PRIMARY KEY NOT NULL,
	nk_product_id INT,
	name VARCHAR(100),
	category VARCHAR(100),
	price REAL
);

INSERT INTO gold.dim_product(nk_product_id, name, category, price)
SELECT
	product_id
	,name
	,category
	,price
FROM silver.products;

TIME DIMENSION
CREATE TABLE gold.dim_time(
	sk_time SERIAL PRIMARY KEY NOT NULL,
	date_id INT,
	"date" DATE,
	day_num INT,
	day_name VARCHAR(15),
	is_weekend VARCHAR(6),
	week_num INT,
	month_num INT,
	month_name VARCHAR(15),
	quarter_num INT,
	year_num INT
);

INSERT INTO gold.dim_time(date_id, "date", day_num, day_name, is_weekend, week_num, month_num, month_name, quarter_num, year_num)
SELECT
	TO_CHAR(dt, 'YYYYMMDD')::INT as date_id
	,TO_CHAR(dt, 'YYYY-MM-DD')::date as "date"
	,EXTRACT(day from dt) as day_num
	,TO_CHAR(dt, 'Day') as day_name
	,CASE
		WHEN TO_char(dt, 'D') IN('1','7') THEN 'True'
		ELSE 'False'
	END as is_weekend
	,EXTRACT(week from dt) as week_num
	,EXTRACT(month from dt) as month_num
	,TO_CHAR(dt, 'Month') as month_name
	,EXTRACT(quarter from dt ) as quarter_num
	,EXTRACT(year from dt) as year_num
FROM GENERATE_SERIES('2020-01-01'::date, '2026-01-01'::date, '1 days') as dt;

--SALES FACT
CREATE TABLE gold.fact_sales(
	sales_id SERIAL PRIMARY KEY NOT NULL UNIQUE,
	order_id INT,
	sk_customer INT,
	sk_product INT,
	sk_time INT,
	quantity INT,
	total_amount REAL,
	CONSTRAINT sk_customer_fk FOREIGN KEY (sk_customer) REFERENCES gold.dim_customer(sk_customer),
	CONSTRAINT sk_product_fk FOREIGN KEY (sk_product) REFERENCES gold.dim_product(sk_product),
	CONSTRAINT sk_time_fk FOREIGN KEY (sk_time) REFERENCES gold.dim_time(sk_time)
);

INSERT INTO gold.fact_sales(order_id, sk_customer, sk_product, sk_time, quantity, total_amount)
SELECT
	o.order_id
	,sk_customer
	,sk_product
	,sk_time
	,o.quantity
	,o.total_amount
FROM silver.orders o
LEFT JOIN gold.dim_customer dc ON o.customer_id = dc.nk_customer_id
LEFT JOIN gold.dim_product dp ON o.product_id = dp.nk_product_id
LEFT JOIN gold.dim_time dt ON o.order_date = dt."date"