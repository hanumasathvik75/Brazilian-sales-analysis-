-- eda in sql
use brazilian_sales;
select *from orders_table;
-- revenue analysis
-- q1.total revenue on delivered case only
select sum(price+freight_value) as revenue from order_items_table inner join orders_table on orders_table.order_id=order_items_table.order_id where
order_status="Delivered";
-- q2 top 10 product categories by revenue
select product_english,round(sum(price+freight_value),2) as revenue from order_items_table
inner join products_table on products_table.product_id=order_items_table.product_id
inner join english_translation on english_translation.product_category_name=products_table.product_category_name group by product_english order by
sum(price+freight_value) desc limit 10;
-- q3 average order value (total_revenue/total_orders)
select sum(price+freight_value)/count(distinct orders_table.order_id) as aov from order_items_table 
inner join orders_table on orders_table.order_id=order_items_table.order_id 
where order_status="delivered";
-- q4 top 5 cities by revenue
select customer_city,round(sum(price+freight_value),2) as total_revenue from customer_table
inner join orders_table on orders_table.customer_id=customer_table.customer_id
inner join order_items_table on order_items_table.order_id=orders_table.order_id
group by customer_city order by total_revenue desc limit 5;
-- q6 top 10 expensive products (based on individual orders) 
select product_english,price from english_translation inner join products_table
on products_table.product_category_name=english_translation.product_category_name
inner join order_items_table on  order_items_table.product_id=products_table.product_id order by price desc limit 10;
-- q7 top perfroming states based on revenue
select customer_state,round(sum(price+freight_value),2) as revenue from customer_table
inner join orders_table on orders_table.customer_id=customer_table.customer_id
inner join order_items_table on order_items_table.order_id=orders_table.order_id
where order_status="delivered"
group by customer_state order by revenue desc limit 3;
-- q8 how many customers are there in each state
select customer_state,count(distinct customer_unique_id) as counts  from customer_table
group by customer_state order by counts desc limit 5;
-- q9 what percentage of customers are repeated buyers
select round(100*sum(case when total_order>1 then 1 else 0 end)/count(*),2) as total_percentage
from (select customer_unique_id,count(*) as total_order from customer_table inner join
orders_table on orders_table.customer_id=customer_table.customer_id where order_status="delivered" group by customer_unique_id
) t;
-- q10 what percentage of revenue comes from repeated customers
select sum(price+freight_value) as revenue from order_items_table inner join 
orders_table on orders_table.order_id=order_items_table.order_id
inner join customer_table on customer_table.customer_id=orders_table.customer_id
where customer_unique_id in(
select customer_unique_id from customer_table inner join
orders_table on orders_table.customer_id=customer_table.customer_id where order_status="delivered" group by customer_unique_id
having count(*)>1
);
-- creating indexes table
CREATE TABLE customer_clean (
    customer_id VARCHAR(50) PRIMARY KEY,        -- unique for each customer
    customer_unique_id VARCHAR(50),             -- may repeat if same person orders multiple times
    customer_zip_code_prefix BIGINT,
    customer_city VARCHAR(100),
    customer_state CHAR(2),                      -- state code like 'SP', 'RJ'

    -- Indexes to make joins and queries faster
    INDEX idx_customer_unique (customer_unique_id),
    INDEX idx_state (customer_state),
    INDEX idx_zip (customer_zip_code_prefix)
);
CREATE TABLE english_translation_clean (
    product_category_name VARCHAR(100) PRIMARY KEY,  -- unique category name
    product_english VARCHAR(100),                    -- English translation

    -- Optional index if you filter/group by English name
    INDEX idx_product_english (product_english)
);
CREATE TABLE order_items_clean (
    order_id VARCHAR(50),                     -- link to orders table
    order_item_id BIGINT,                      -- unique per order
    product_id VARCHAR(50),                    -- link to products table
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,              -- store as proper datetime
    price DOUBLE,
    freight_value DOUBLE,

    PRIMARY KEY (order_id, order_item_id),    -- ensures unique items per order
    INDEX idx_order_id (order_id),            -- fast joins with orders table
    INDEX idx_product_id (product_id)         -- fast joins with products table
);
CREATE TABLE orders_clean (
    order_id VARCHAR(50) PRIMARY KEY,            -- unique order ID
    customer_id VARCHAR(50),                     -- links to customers table
    order_status VARCHAR(20),                    -- e.g., 'delivered', 'shipped'
    order_purchase_timestamp DATETIME,           -- proper datetime
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,

    -- Indexes to speed up queries
    INDEX idx_customer_id (customer_id),         -- fast joins with customers
    INDEX idx_order_status (order_status),       -- fast filtering by status
    INDEX idx_purchase_timestamp (order_purchase_timestamp)
);
-- inserting rows
INSERT INTO customer_clean
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM customer_table;
INSERT INTO english_translation_clean
SELECT
    product_category_name,
    product_english
FROM english_translation;
INSERT INTO order_items_clean
SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    STR_TO_DATE(shipping_limit_date, '%Y-%m-%d %H:%i:%s'),
    price,
    freight_value
FROM order_items_table;
INSERT INTO orders_clean
SELECT
    order_id,
    customer_id,
    order_status,
    STR_TO_DATE(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(order_approved_at, '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(order_delivered_carrier_date, '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(order_delivered_customer_date, '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s')
FROM orders_table;

-- query now
-- find the revenue contribution by repeated customers
drop table if exists revenue_count;
create temporary table revenue_count
select customer_unique_id from customer_clean
inner join orders_clean on orders_clean.customer_id=customer_clean.customer_id
inner join order_items_clean on order_items_clean.order_id=orders_clean.order_id
where order_status="delivered"
group by customer_unique_id having count(distinct orders_clean.order_id)>1;
select *from revenue_count;
select *from revenue_count;
select sum(price+freight_value) as revenue from order_items_clean
inner join orders_clean on orders_clean.order_id=order_items_clean.order_id
inner join customer_clean on customer_clean.customer_id=orders_clean.customer_id
where order_status="delivered" and customer_unique_id in (select customer_unique_id from revenue_count);
-- q11.whats the average rating for the customers
select avg(review_score) as average_review_rating from order_reviews;
-- q12 count how many payment type methods are used 
select payment_type,count(*) as counts from order_payments group by payment_type;
-- q13 average delivery time(how  fast we will deliver)
select avg(datediff(order_delivered_customer_date, order_purchase_timestamp)) as average_delivery_days
from orders_clean;
-- q14 monthly revenue in brazil
select date_format(order_purchase_timestamp,"%Y-%m") as dates,round(sum(price+freight_value),2)
from orders_clean inner join order_items_table on order_items_table.order_id=orders_clean.order_id
where order_status="delivered" group by dates order by dates;
-- q15 best day to buy the products
select dayname(order_purchase_timestamp) as day_week,round(sum(price+freight_value),2) as revenue
from orders_clean inner join order_items_table on order_items_table.order_id=orders_clean.order_id
where order_status="delivered" group by day_week;
use brazilian_sales;
select count(distinct customer_unique_id) from customer_clean;