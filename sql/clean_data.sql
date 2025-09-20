INSERT INTO silver.customers
SELECT DISTINCT
	customer_id
	,COALESCE(name, 'not_informed') as name
	,COALESCE(email, 'not_informed') as email
	,COALESCE(signup_date, '1900-01-01') as signup_date
	,COALESCE(state, 'not_informed') as state
FROM bronze.customers;


INSERT INTO silver.products
SELECT DISTINCT
	product_id
	,COALESCE(name, 'not_informed') as name
	,COALESCE(category, 'not_informed') as category
	,COALESCE(price, 0) as price
FROM bronze.products;


INSERT INTO silver.orders
SELECT DISTINCT
	order_id
	,customer_id
	,product_id
	,COALESCE(order_date, '1900-01-01') as order_date
	,COALESCE(quantity, 0) as quantity
	,COALESCE(total_amount, 0) as total_amount
FROM bronze.orders;



