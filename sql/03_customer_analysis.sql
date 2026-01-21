SELECT * FROM online_retail_clean_new;

-- total customers
SELECT count(distinct CustomerID) as total_customers FROM online_retail_clean_new;

-- total orders
SELECT COUNT(distinct InvoiceNo) as total_orders FROM online_retail_clean_new;

-- Average orders per customer tot_order/tot_customer

SELECT COUNT(distinct InvoiceNo)/ count(distinct CustomerID) as avg_ord_as_customer FROM online_retail_clean_new;

-- customer level revenue generation

SELECT CustomerID, count(distinct InvoiceNO)as total_orders, sum(Quantity * UnitPrice) as total_revenue,
sum(Quantity*UnitPrice)/ count(distinct InvoiceNo) as Avg_order_value
FROM online_retail_clean_new
GROUP BY CustomerID;

-- checking for null values in the table 
 
SELECT * FROM online_retail_clean_new where CustomerID is NULL;

-- checking for datatype of the table 

describe online_retail_clean_new;

-- now we have assumption that our cuctomer id have empty strings

  SELECT
    COUNT(*) AS rows_without_customerid
FROM online_retail_clean_new
WHERE CustomerID IS NULL
   OR TRIM(CustomerID) = '';
   
   
-- now checking for individual cutomer revenue generation
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    SUM(Quantity * UnitPrice) AS total_revenue,
    ROUND(
        SUM(Quantity * UnitPrice) / COUNT(DISTINCT InvoiceNo),
        2
    ) AS avg_order_value
FROM online_retail_clean_new
WHERE CustomerID IS NOT NULL
  AND TRIM(CustomerID) <> ''
  GROUP BY CustomerID;
  
-- checking for howmany orders dont have customer id
SELECT
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    SUM(Quantity * UnitPrice) AS total_revenue
FROM online_retail_clean_new
WHERE CustomerID IS NOT NULL
  AND TRIM(CustomerID) = '';
 
 -- checking for customer brings more revenue
 
 SELECT ROUND(sum(t.total_revenue),2) as total_revenue_20_customers
 from (
 SELECT CustomerID, sum(Quantity*UnitPrice) as total_revenue
 FROM online_retail_clean_new where CustomerID is not null and trim(CustomerID)<>'' group by  CustomerID order by total_revenue desc limit 20
 )t;
 
 -- checking for percentage occupation of hese 20 customers
  with top_20_customer as(
  select CustomerID, sum(Quantity * UnitPrice) as total_revenue
  from online_retail_clean_new 
  where CustomerID is not null and trim(CustomerID) <> ''  group by CustomerID 
  order by total_revenue desc limit 20 ),
  top_20_revenue as (
  select sum(total_revenue) as customer_revenue 
  from top_20_customer),
  overall_revenue as(
  select sum(Quantity * UnitPrice) as tot_revenue
  from online_retail_clean_new)
  SELECT ROUND(100.0* t.customer_revenue/ o.tot_revenue,2) as percentage_occupation
  from top_20_revenue t
  cross join overall_revenue o;


