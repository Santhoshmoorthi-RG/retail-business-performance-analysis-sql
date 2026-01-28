-- revenue and orders by country

WITH country_metrics AS (
    SELECT
        Country,
        COUNT(DISTINCT InvoiceNo) AS total_orders,
        SUM(Quantity * UnitPrice) AS total_revenue
    FROM online_retail_clean_new
    GROUP BY Country
)
SELECT *
FROM country_metrics
ORDER BY total_revenue DESC;

--  top revenue by country

WITH country_revenue AS (
    SELECT
        Country,
        SUM(Quantity * UnitPrice) AS total_revenue
    FROM online_retail_clean_new
    GROUP BY Country
)
SELECT *
FROM country_revenue
ORDER BY total_revenue DESC
LIMIT 10;


-- customers by country

WITH customers_by_country AS (
    SELECT
        Country,
        COUNT(DISTINCT CustomerID) AS total_customers
    FROM online_retail_clean_new
    WHERE CustomerID IS NOT NULL
    GROUP BY Country
)
SELECT *
FROM customers_by_country
ORDER BY total_customers DESC;


-- AOV by country

WITH order_totals AS (
    SELECT
        Country,
        InvoiceNo,
        SUM(Quantity * UnitPrice) AS order_value
    FROM online_retail_clean_new
    GROUP BY Country, InvoiceNo
),
country_aov AS (
    SELECT
        Country,
        AVG(order_value) AS avg_order_value
    FROM order_totals
    GROUP BY Country
)
SELECT *
FROM country_aov
ORDER BY avg_order_value DESC;

-- unique product purchase by country

WITH product_diversity AS (
    SELECT
        Country,
        COUNT(DISTINCT StockCode) AS unique_products_purchased
    FROM online_retail_clean_new
    GROUP BY Country
)
SELECT *
FROM product_diversity
ORDER BY unique_products_purchased DESC;

-- monthly revenue by country

WITH monthly_country_revenue AS (
    SELECT
        DATE_FORMAT(InvoiceDateTime, '%Y-%m-01') AS month,
        Country,
        SUM(Quantity * UnitPrice) AS monthly_revenue
    FROM online_retail_clean_new
    GROUP BY month, Country
)
SELECT *
FROM monthly_country_revenue
ORDER BY month, monthly_revenue DESC;

-- rank countries within each month

WITH monthly_country_revenue AS (
    SELECT
        DATE_FORMAT(InvoiceDateTime, '%Y-%m-01') AS month,
        Country,
        SUM(Quantity * UnitPrice) AS monthly_revenue
    FROM online_retail_clean_new
    GROUP BY month, Country
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY monthly_revenue DESC) AS revenue_rank
    FROM monthly_country_revenue
)
SELECT *
FROM ranked
WHERE revenue_rank <= 5;


-- revenue by percentage 


WITH country_revenue AS (
    SELECT
        Country,
        SUM(Quantity * UnitPrice) AS total_revenue
    FROM online_retail_clean_new
    GROUP BY Country
),
total AS (
    SELECT SUM(total_revenue) AS overall_revenue
    FROM country_revenue
)
SELECT
    c.Country,
    ROUND(c.total_revenue, 2) AS total_revenue,
    ROUND((c.total_revenue / t.overall_revenue) * 100, 2) AS revenue_percentage
FROM country_revenue c
CROSS JOIN total t
ORDER BY total_revenue DESC;

-- order volume context

WITH country_orders AS (
    SELECT
        Country,
        COUNT(DISTINCT InvoiceNo) AS total_orders,
        SUM(Quantity * UnitPrice) AS total_revenue
    FROM online_retail_clean_new
    GROUP BY Country
)
SELECT *
FROM country_orders
ORDER BY total_revenue DESC;


