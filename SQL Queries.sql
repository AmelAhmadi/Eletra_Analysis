-- Total Revenue (USD)
SELECT ROUND(SUM(usd_price), 2) AS total_revenue
FROM core.orders
WHERE purchase_ts >= '2019-01-01' AND purchase_ts < '2023-01-01';

-- Order Volume (distinct orders)
SELECT COUNT(DISTINCT id) AS order_volume
FROM core.orders
WHERE purchase_ts >= '2019-01-01' AND purchase_ts < '2023-01-01';

-- AOV = Revenue / Orders
SELECT ROUND(SUM(usd_price) / NULLIF(COUNT(DISTINCT id), 0), 2) AS aov
FROM core.orders
WHERE purchase_ts >= '2019-01-01' AND purchase_ts < '2023-01-01';

-- YoY % for Revenue, Orders, and AOV
WITH yr AS (
  SELECT
    YEAR(purchase_ts) AS yr,
    SUM(usd_price) AS rev,
    COUNT(DISTINCT id) AS ords,
    SUM(usd_price) / NULLIF(COUNT(DISTINCT id), 0) AS aov
  FROM core.orders
  GROUP BY YEAR(purchase_ts)
)
SELECT
  y.yr,
  ROUND(y.rev, 2) AS rev,
  ROUND(100 * (y.rev  - LAG(y.rev)  OVER (ORDER BY y.yr))
            / NULLIF(LAG(y.rev)  OVER (ORDER BY y.yr), 0), 1) AS rev_yoy_pct,
  y.ords,
  ROUND(100 * (y.ords - LAG(y.ords) OVER (ORDER BY y.yr))
            / NULLIF(LAG(y.ords) OVER (ORDER BY y.yr), 0), 1) AS ords_yoy_pct,
  ROUND(y.aov, 2) AS aov,
  ROUND(100 * (y.aov  - LAG(y.aov)  OVER (ORDER BY y.yr))
            / NULLIF(LAG(y.aov)  OVER (ORDER BY y.yr), 0), 1) AS aov_yoy_pct
FROM yr y
ORDER BY y.yr;

-- Monthly revenue
SELECT
  DATE_FORMAT(purchase_ts, '%Y-%m-01') AS month_start,
  ROUND(SUM(usd_price), 2) AS revenue
FROM core.orders
GROUP BY DATE_FORMAT(purchase_ts, '%Y-%m-01')
ORDER BY month_start;

-- Quarter by year
SELECT
  YEAR(purchase_ts) AS order_year,
  CONCAT('Q', QUARTER(purchase_ts)) AS order_qtr,
  ROUND(SUM(usd_price), 2) AS revenue
FROM core.orders
GROUP BY YEAR(purchase_ts), QUARTER(purchase_ts)
ORDER BY order_year, order_qtr;

-- AOV by month and loyalty bucket
SELECT
  DATE_TRUNC('month', order_date)::date AS month_start,
  loyalty_bucket,
  ROUND(SUM(revenue)::numeric / NULLIF(COUNT(DISTINCT order_id),0), 2) AS aov
FROM core.orders
GROUP BY 1,2
ORDER BY 1,2;


-- 2022 member vs non-member average order gap
WITH base AS (
  SELECT
    loyalty_bucket,
    ROUND(SUM(revenue)::numeric / NULLIF(COUNT(DISTINCT order_id),0), 2) AS aov_2022
  FROM core.orders
  WHERE order_year = 2022
  GROUP BY loyalty_bucket
)
SELECT
  (SELECT aov_2022 FROM base WHERE loyalty_bucket='Member')     AS member_aov,
  (SELECT aov_2022 FROM base WHERE loyalty_bucket='Non-Member') AS non_member_aov,
  (SELECT aov_2022 FROM base WHERE loyalty_bucket='Member')
  - (SELECT aov_2022 FROM base WHERE loyalty_bucket='Non-Member') AS member_minus_nonmember;


-- Within each region, what is the most popular product? 

WITH sales_by_product_by_region AS (
  SELECT
    geo_lookup.region,
    orders.product_name,
    COUNT(orders.id) AS order_count
  FROM core.orders
  LEFT JOIN core.order_status
    ON orders.id = order_status.order_id
  LEFT JOIN core.customers
    ON orders.customer_id = customers.id
  LEFT JOIN core.geo_lookup
    ON customers.country_code = geo_lookup.country
  GROUP BY 1,2
)

SELECT *
FROM sales_by_product_by_region
QUALIFY RANK() OVER(PARTITION BY region ORDER BY order_count DESC) = 1
ORDER BY order_count DESC;
