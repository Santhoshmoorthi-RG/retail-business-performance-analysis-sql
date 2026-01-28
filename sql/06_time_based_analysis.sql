-- monthly revenue trend

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(InvoiceDateTime, '%Y-%m-01') AS month,
        SUM(Quantity * UnitPrice) AS total_revenue
    FROM online_retail_clean_new
    GROUP BY month
)
SELECT *
FROM monthly_revenue
WHERE month IS NOT NULL
ORDER BY month;

-- monthly order volume

WITH monthly_orders AS (
    SELECT
        DATE_FORMAT(InvoiceDateTime, '%Y-%m-01') AS month,
        COUNT(DISTINCT InvoiceNo) AS total_orders
    FROM online_retail_clean_new
    GROUP BY month
)
SELECT *
FROM monthly_orders
WHERE month IS NOT NULL
ORDER BY month;


-- monthly active customers


WITH monthly_customers AS (
    SELECT
        DATE_FORMAT(InvoiceDateTime, '%Y-%m-01') AS month,
        COUNT(DISTINCT CustomerID) AS active_customers
    FROM online_retail_clean_new
    WHERE CustomerID IS NOT NULL
    GROUP BY month
)
SELECT *
FROM monthly_customers
WHERE month IS NOT NULL
ORDER BY month;

-- month over month revenue growth

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(InvoiceDateTime, '%Y-%m-01') AS month,
        SUM(Quantity * UnitPrice) AS total_revenue
    FROM online_retail_clean_new
    GROUP BY month
),
growth AS (
    SELECT
        month,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY month) AS prev_month_revenue
    FROM monthly_revenue
)
SELECT
    month,
    total_revenue,
    prev_month_revenue,
    ROUND(
        ((total_revenue - prev_month_revenue) / prev_month_revenue) * 100,
        2
    ) AS mom_growth_percentage
FROM growth
ORDER BY month;


-- best and worst months by revenue

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(InvoiceDateTime, '%Y-%m-01') AS month,
        SUM(Quantity * UnitPrice) AS total_revenue
    FROM online_retail_clean_new
    GROUP BY month
)
SELECT *
FROM monthly_revenue
ORDER BY total_revenue DESC;


-- 6. Seasonal Revenue by Month

WITH seasonal_revenue AS (
    SELECT
        MONTH(InvoiceDateTime) AS month_number,
        MONTHNAME(InvoiceDateTime) AS month_name,
        SUM(Quantity * UnitPrice) AS total_revenue
    FROM online_retail_clean_new
    GROUP BY month_number, month_name
)
SELECT *
FROM seasonal_revenue
ORDER BY month_number;
