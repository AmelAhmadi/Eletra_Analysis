-- Cleaning, combining, and organzing data for use

-- During intial checks we discovered inconsistency in product names

WITH cleaned_product AS (
  SELECT
    orders.customer_id,
    orders.id AS order_id,
    orders.purchase_ts AS purchase_date,
    orders.product_id,
    CASE WHEN LOWER(orders.product_name) LIKE '%gaming monitor%' THEN '27 inch Gaming Monitor' 
    WHEN LOWER(orders.product_name) LIKE '%macbook%' THEN 'Apple Macbook Air Laptop'
    WHEN LOWER(orders.product_name) LIKE '%thinkpad%' THEN 'Lenovo ThinkPad Laptop'
    WHEN LOWER(orders.product_name) LIKE '%bose%' THEN 'Bose Soundsport Headphones' 
    ELSE orders.product_name END AS product_name,
    UPPER(orders.currency) AS currency,
    orders.local_price,
    orders.usd_price,
    orders.purchase_platform
  FROM core.orders
)

-- After cleaning product_name, adding columns for product category and brand name

cleaned_orders AS (
  SELECT *,
    CASE WHEN LOWER(cleaned_product.product_name) LIKE '%apple%' THEN 'Apple'
    WHEN LOWER(cleaned_product.product_name) LIKE '%samsung%' THEN 'Samsung'
    WHEN LOWER(cleaned_product.product_name) LIKE '%lenovo%' THEN 'Lenovo'
    WHEN LOWER(cleaned_product.product_name) LIKE '%bose%' THEN 'Bose'
    ELSE 'Unknown' END AS brand_name,
    CASE WHEN LOWER(cleaned_product.product_name) LIKE '%headphones%' THEN 'Headphones'
    WHEN LOWER(cleaned_product.product_name) LIKE '%laptop%' THEN 'Laptop'
    WHEN LOWER(cleaned_product.product_name) LIKE '%iphone%' THEN 'Cell Phone'
    WHEN LOWER(cleaned_product.product_name) LIKE '%monitor%' THEN 'Monitor'
    ELSE 'Accessories' END AS product_category,
    ROW_NUMBER() OVER (PARTITION BY cleaned_product.customer_id ORDER BY cleaned_product.purchase_date) AS customer_order_number,
    EXTRACT(YEAR FROM cleaned_product.purchase_date) AS year,
    CASE WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 1 THEN 'January'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 2 THEN 'February'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 3 THEN 'March'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 4 THEN 'April'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 5 THEN 'May'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 6 THEN 'June'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 7 THEN 'July'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 8 THEN 'August'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 9 THEN 'September'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 10 THEN 'October'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 11 THEN 'November'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 12 THEN 'December'
    ELSE NULL END AS month
    FROM cleaned_product
)

cleaned_customers AS (
  SELECT
    customers.id AS customer_id,
    customers.marketing_channel,
    customers.account_creation_method,
    UPPER(customers.country_code) AS country_code,
    customers.loyalty_program,
    customers.created_on
  FROM
    core.customers
)

-- Checks showed inconsistencies in two regions

cleaned_geo_lookup AS (
  SELECT
    geo_lookup.country,
    CASE WHEN UPPER(geo_lookup.country) = 'EU' THEN 'EMEA'
    WHEN UPPER(geo_lookup.country) = 'A1' THEN 'Unknown'
    ELSE geo_lookup.region END AS region
  FROM
    core.geo_lookup
)

-- Utilizing dataset for the first time, performing checks for inconsistencies, errors, and general data ranges

-- 1) Duplicate Orders Check

SELECT
    orders.id,
    COUNT(*) AS order_id_count
FROM core.orders
GROUP BY 1
HAVING order_id_count > 1;


-- 2) Null Check

SELECT
    SUM(CASE WHEN orders.customer_id IS NULL THEN 1 ELSE 0 END) AS nullcount_cust_id,
    SUM(CASE WHEN orders.id IS NULL THEN 1 ELSE 0 END) AS nullcount_order_id,
    SUM(CASE WHEN orders.purchase_ts IS NULL THEN 1 ELSE 0 END) AS nullcount_purchase_ts,
    SUM(CASE WHEN orders.product_id IS NULL THEN 1 ELSE 0 END) AS nullcount_product_id,
    SUM(CASE WHEN orders.product_name IS NULL THEN 1 ELSE 0 END) AS nullcount_product_name,
    SUM(CASE WHEN orders.currency IS NULL THEN 1 ELSE 0 END) AS nullcount_currency,
    SUM(CASE WHEN orders.local_price IS NULL THEN 1 ELSE 0 END) AS nullcount_local_price,
    SUM(CASE WHEN orders.usd_price IS NULL THEN 1 ELSE 0 END) AS nullcount_usd_price,
    SUM(CASE WHEN orders.purchase_platform IS NULL THEN 1 ELSE 0 END) AS nullcount_purchase_platform
FROM core.orders;

-- 3) Checking Distinct Product Names, Purchase Platforms, Countries & Regions, Marketing Platforms, and Loyalty Designation For Familiarity And Finding Irregularities 

SELECT
    DISTINCT product_name
FROM core.orders
ORDER BY 1;

SELECT
    DISTINCT purchase_platform
FROM core.orders
ORDER BY 1;

SELECT
    DISTINCT customers.country_code,
    geo_lookup.region
FROM core.customers
LEFT JOIN core.geo_lookup
ON customers.country_code = geo_lookup.country
ORDER BY 1;

SELECT
    DISTINCT customers.country_code,
    COUNT(customers.country_code) AS countnull
FROM core.customers
LEFT JOIN core.geo_lookup
ON customers.country_code = geo_lookup.country 
WHERE geo_lookup.region IS NULL
GROUP BY 1;

SELECT
    DISTINCT marketing_channel,
    COUNT(marketing_channel) AS count_of_marketing
FROM core.customers
GROUP BY 1
ORDER BY 1;

SELECT
    DISTINCT loyalty_program
FROM core.customers
ORDER BY 1;


-- 4) Price Ranges

SELECT
    MIN(usd_price) AS smallest_price,
    MAX(usd_price) AS largest_price
FROM core.orders;

SELECT
    usd_price,
    COUNT(*) AS count_of_orders
FROM core.orders
WHERE usd_price = 0
GROUP BY 1;
