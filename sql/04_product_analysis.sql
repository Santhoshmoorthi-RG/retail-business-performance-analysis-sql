-- creating virtual table for product analysis

create view  product_analysis as
SELECT StockCode, Description , sum(Quantity * UnitPrice) as total_revenue 
FROM online_retail_clean_new where Quantity > 0 and UnitPrice > 0
Group by StockCode,Description;

describe online_retail_clean_new;

-- filtering top 20 products based on revenue
Select StockCode,Description ,total_revenue from product_analysis order by total_revenue desc limit 20;


drop view quantity_analysis;

-- created virtual table for quantity analysis

create view quantity_analysis as
Select StockCode, Description,sum(Quantity) as total_qty from online_retail_clean_new where Quantity >0 and UnitPrice > 0
Group By StockCode, Description;

Select StockCode, Description,total_qty from quantity_analysis order by total_qty desc limit 20;

-- combining both view tables
SELECT
    q.StockCode,
    q.Description,
    q.total_qty,
    r.total_revenue
FROM quantity_analysis q
JOIN product_analysis r
  ON q.StockCode = r.StockCode
ORDER BY r.total_revenue DESC 
limit 20;
-- the above query combines the tables ang gives top 20 roducts by revenue,
-- but our goal to find product which is available in both top 20 revenue and top 20 qty sale.
-- so following query will find our product

WITH top_revenue AS (
    SELECT
        StockCode,
        Description,
        SUM(Quantity * UnitPrice) AS total_revenue
    FROM online_retail_clean_new
    WHERE Quantity > 0 AND UnitPrice > 0
    GROUP BY StockCode, Description
    ORDER BY total_revenue DESC
    LIMIT 20
),
top_quantity AS (
    SELECT
        StockCode,
        Description,
        SUM(Quantity) AS total_qty
    FROM online_retail_clean_new
    WHERE Quantity > 0 AND UnitPrice > 0
    GROUP BY StockCode, Description
    ORDER BY total_qty DESC
    LIMIT 20
)
SELECT
    r.StockCode,
    r.Description,
    q.total_qty,
    r.total_revenue
FROM top_revenue r
JOIN top_quantity q
  ON r.StockCode = q.StockCode;
  
  -- product concetration
  
  with product_revenue  as(
  select StockCode, Description, Sum(Quantity * UnitPrice) as total_revenue
  from online_retail_clean_new 
  where Quantity > 0 and UnitPrice > 0
  group by StockCode,Description),
  top_product as(
  select StockCode, Description,total_revenue 
  from product_revenue
  order by total_revenue desc
  limit 20)
  select round
  (sum(total_revenue)/(select sum(total_revenue) from product_revenue) *100,2) as top_20_product_conc
  from  top_product;
