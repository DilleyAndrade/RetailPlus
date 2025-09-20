--1-Quantos clientes únicos fizeram pedidos?
WITH MY_CTE AS (
	SELECT
		COUNT(sk_customer) AS unique_order_customers
	FROM gold.fact_sales
	GROUP BY sk_customer
	HAVING COUNT(sk_customer) = 1
)
SELECT COUNT(customers) FROM MY_CTE
;

--2-Qual foi a receita total da empresa? 
SELECT
	SUM(total_amount) AS total_amount
FROM gold.fact_sales;

--3-Qual foi o ticket médio (média do valor total por pedido)?
SELECT
	AVG(total_amount)::REAL AS avg_per_order
FROM gold.fact_sales;

--4-Quais são os 3 estados com mais pedidos?
SELECT
	dc.state
	,COUNT(order_id) AS total_orders
FROM gold.fact_sales fs
INNER JOIN gold.dim_customer dc ON fs.sk_customer = dc.sk_customer 
GROUP BY dc.state
ORDER BY total_orders DESC
LIMIT 3;

--5-Quais são os 5 produtos mais vendidos (em quantidade)?
SELECT
	dp.name
	,COUNT(quantity) AS qtd_sale_per_product
FROM gold.fact_sales fs
INNER JOIN gold.dim_product dp ON fs.sk_product = dp.sk_product
GROUP BY dp.name
ORDER BY qtd_sale_per_product DESC
LIMIT 5;