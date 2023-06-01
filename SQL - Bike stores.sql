/* Glance at Customers table */

SELECT *
  FROM sales.customers

/* we need a table containing: Order ID, 
			       customers first and last name, 
			       customer City and State, 
			       order date, 
			       sales volume, 
			       revenue, 
			       product name, 
			       product category, 
			       brand name, 
			       store name, 
			       sales rep */



-- there are 9 seperate tables 
-- Some of the columns that are going to be needed and their locations:
-- 	1. Order ID, Order Date > sales.orders
--	2. Customer Name,City,State > sales.customers
-- 	3. revenue, sales, quantity > sales.order_items
-- 	4. product_name > production.products
--      5. category_name > production.categories 
--      6. store_name > sales.stores
--      7. sales_rep > sales.staffs


SELECT 
	ord.order_id, 
	CONCAT(cust.first_name, ' ', cust.last_name) AS customers,
	cust.city,
	cust.state,
	ord.order_date
FROM sales.orders AS ord
JOIN sales.customers AS cust
ON ord.customer_id = cust.customer_id        



-- also we want to know sales volume & revenue
-- we will add it to the query above

SELECT 
	ord.order_id, 
	CONCAT(cust.first_name, ' ', cust.last_name) AS customers,
	cust.city,
	cust.state,
	ord.order_date,
	SUM(ite.quantity) AS total_units,								
	SUM(ite.quantity * ite.list_price) AS revenue								
FROM sales.orders AS ord
JOIN sales.customers AS cust
ON ord.customer_id = cust.customer_id  
JOIN sales.order_items AS ite								
ON ord.order_id = ite.order_id									
GROUP BY
	ord.order_id, 
	CONCAT(cust.first_name, ' ', cust.last_name),
	cust.city,
	cust.state,
	ord.order_date



-- we also want to know the name of the products that have been bought

SELECT 
	ord.order_id, 
	CONCAT(cust.first_name, ' ', cust.last_name) AS customers,
	cust.city,
	cust.state,
	ord.order_date,
	SUM(ite.quantity) AS total_units,
	SUM(ite.quantity * ite.list_price) AS revenue,
	prod.product_name									
FROM sales.orders as ord
JOIN sales.customers as cust
ON ord.customer_id = cust.customer_id  
JOIN sales.order_items as ite
ON ord.order_id = ite.order_id
JOIN production.products as prod						
ON ite.product_id = prod.product_id						
GROUP BY
	ord.order_id, 
	CONCAT(cust.first_name, ' ', cust.last_name),
	cust.city,
	cust.state,
	ord.order_date,
	prod.product_name								



-- management will also ant to know the CATEGORY of PRODUCTS purchased

SELECT 
	ord.order_id, 
	CONCAT(cust.first_name, ' ', cust.last_name) AS customers,
	cust.city,
	cust.state,
	ord.order_date,
	SUM(ite.quantity) AS total_units,
	SUM(ite.quantity * ite.list_price) AS revenue,
	prod.product_name,
	cate.category_name								
FROM sales.orders as ord
JOIN sales.customers as cust
ON ord.customer_id = cust.customer_id  
JOIN sales.order_items as ite
ON ord.order_id = ite.order_id
JOIN production.products as prod							
ON ite.product_id = prod.product_id				
JOIN production.categories as cate				
ON prod.category_id = cate.category_id				
GROUP BY
	ord.order_id, 
	CONCAT(cust.first_name, ' ', cust.last_name),
	cust.city,
	cust.state,
	ord.order_date,
	prod.product_name,
	cate.category_name										



-- we also want to know the stores where the sales took place

SELECT 
	ord.order_id, 
	CONCAT(cust.first_name, ' ', cust.last_name) AS customers,
	cust.city,
	cust.state,
	ord.order_date,
	SUM(ite.quantity) AS total_units,
	SUM(ite.quantity * ite.list_price) AS revenue,
	prod.product_name,
	cate.category_name,
	stor.store_name								
FROM sales.orders as ord
JOIN sales.customers as cust
ON ord.customer_id = cust.customer_id  
JOIN sales.order_items as ite
ON ord.order_id = ite.order_id
JOIN production.products as prod							
ON ite.product_id = prod.product_id				
JOIN production.categories as cate								
ON prod.category_id = cate.category_id			
JOIN sales.stores as stor						
ON ord.store_id = stor.store_id									
GROUP BY
	ord.order_id, 
	CONCAT(cust.first_name, ' ', cust.last_name),
	cust.city,
	cust.state,
	ord.order_date,
	prod.product_name,
	cate.category_name,
	stor.store_name						



-- finally, we want to know the name of the sales_rep that made the sale
-- first name and last name are separated so we will need to use the CONCAT function

SELECT 
	ord.order_id, 
	CONCAT(cust.first_name, ' ', cust.last_name) AS customers,
	cust.city,
	cust.state,
	ord.order_date,
	SUM(ite.quantity) AS total_units,
	SUM(ite.quantity * ite.list_price) AS revenue,
	prod.product_name,
	cate.category_name,
	stor.store_name,
	CONCAT(staf.first_name, ' ', staf.last_name) AS sales_rep	
FROM sales.orders as ord
JOIN sales.customers as cust
ON ord.customer_id = cust.customer_id  
JOIN sales.order_items as ite
ON ord.order_id = ite.order_id
JOIN production.products as prod							
ON ite.product_id = prod.product_id				
JOIN production.categories as cate								
ON prod.category_id = cate.category_id			
JOIN sales.stores as stor
ON ord.store_id = stor.store_id
JOIN sales.staffs as staf					
ON ord.staff_id = staf.staff_id 					
GROUP BY
	ord.order_id, 
	CONCAT(cust.first_name, ' ', cust.last_name),
	cust.city,
	cust.state,
	ord.order_date,
	prod.product_name,
	cate.category_name,
	stor.store_name,
	CONCAT(staf.first_name, ' ', staf.last_name) 				
