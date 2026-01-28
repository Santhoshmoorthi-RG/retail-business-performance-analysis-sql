# Retail Business Performance Analysis Using SQL

## Project Overview
This project analyzes an online retail transactional dataset using SQL to extract actionable business insights related to revenue performance, customer behavior, product trends, geographic distribution, and time-based patterns.

The project is designed as an end-to-end SQL portfolio demonstrating data cleaning, modular query design, analytical thinking, and business interpretation.

---

## Dataset Description
The dataset contains transactional records from an online retail business, including:

- InvoiceNo - Unique invoice identifier
- StockCode - Product identifier
- Description - Product description
- Quantity - Units purchased per transaction
- UnitPrice - Price per unit
- InvoiceDateTime - Date and time of transaction
- CustomerID - Unique customer identifier
- Country - Customer country

---

## Data Cleaning and Modeling Rules

- Revenue was never removed, including negative or zero values
- Records with missing CustomerID were excluded only for customer-focused analysis
- All queries are written using Common Table Expressions (CTEs)
- Date fields were standardized into a proper DATETIME column (InvoiceDateTime) before time-based analysis

---

## Tools and Technologies

- MySQL
- SQL (CTEs, Window Functions, Aggregations)
- GitHub

---

## Project Structure

01_kpi_overview.sql  
02_revenue_trends.sql  
03_customer_analysis.sql  
04_product_analysis.sql  
05_geographical_analysis.sql  
06_time_based_analysis.sql  

---

## Analysis Summary

### KPI Overview
- Total revenue
- Total orders
- Total customers
- Average order value

### Revenue Analysis
- Revenue distribution
- High-value invoices
- Revenue concentration

### Customer Analysis
- Unique customers
- Top customers by revenue
- Purchase frequency
- Customer lifetime value

### Product Analysis
- Top products by revenue
- Top products by quantity sold
- Product contribution to overall revenue
- Product diversity

### Geographical Analysis
- Revenue by country
- Orders by country
- Customers by country
- Average order value by country
- Monthly revenue by country

### Time-Based Analysis
- Monthly revenue trends
- Monthly order volume
- Monthly active customers
- Month-over-month revenue growth
- Best and worst performing months
- Seasonal revenue patterns

---

## Key Business Insights

- The United Kingdom is the primary revenue-generating market
- Several European countries form a strong secondary revenue group
- Revenue shows clear seasonality with peaks toward the end of the year
- A small percentage of customers contribute a large portion of total revenue
- A limited set of products consistently drives the majority of sales

---

## Skills Demonstrated

- Advanced SQL querying
- CTE-based modular query design
- Window functions and ranking
- Time-series analysis
- Business-oriented data interpretation
- Clean and maintainable SQL structure

---

## Future Enhancements

- RFM customer segmentation
- Cohort retention analysis
- Market basket analysis
- Data visualization dashboard (Power BI or Tableau)

---


