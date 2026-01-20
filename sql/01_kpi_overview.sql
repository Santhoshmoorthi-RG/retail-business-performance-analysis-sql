SELECT * FROM online_retail_clean_new;

-- total no of orders
SELECT count(DISTINCT InvoiceNo) as total_orders FROM online_retail_clean_new;

-- total customers
SELECT COUNT(DISTINCT CustomerID) as total_customers FROM online_retail_clean_new;

-- total units sold 
SELECT SUM(Quantity) as total_units FROM online_retail_clean_new;

-- toatal revenue qty* unitprice
SELECT SUM(Quantity * UnitPrice) as total_revenue FROM online_retail_clean_new;

-- average order value (AOV)
SELECT sum(Quantity * UnitPrice)/ count(distinct InvoiceNo) from online_retail_clean_new;


-- All in single query
SELECT
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    COUNT(DISTINCT CustomerID) AS total_customers,
    SUM(Quantity) AS total_units,
    SUM(Quantity * UnitPrice) AS total_revenue,
    SUM(Quantity * UnitPrice) / COUNT(DISTINCT InvoiceNo) AS avg_order_value
FROM online_retail_clean_new;
