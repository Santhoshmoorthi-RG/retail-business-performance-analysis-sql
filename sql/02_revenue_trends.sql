SELECT * FROM online_retail_clean_new;

--- revenue trends by month
SELECT Date_format(InvoiceDateTime,'%Y-%m') AS year_month, sum(Quantity * UnitPrice) as total_revenue
 FROM online_retail_clean_new
 GROUP BY Date_format(InvoiceDateTime,'%Y-%m') 
 ORDER BY Date_format(InvoiceDateTime,'%Y-%m');
 
-- Diagnosing the errors 

DESCRIBE online_retail_clean_new;

/* the query which used convert Date_format the output is text and followed by grouping and order by so it fails,
 but the new query the output for month and year is numbers so it easy to group by and order by*/ 

-- new code without error
SELECT
    YEAR(InvoiceDateTime) AS year,
    MONTH(InvoiceDateTime) AS month,
    SUM(Quantity * UnitPrice) AS total_revenue
FROM online_retail_clean_new
GROUP BY
    YEAR(InvoiceDateTime),
    MONTH(InvoiceDateTime)
ORDER BY
    YEAR(InvoiceDateTime),
    MONTH(InvoiceDateTime);
