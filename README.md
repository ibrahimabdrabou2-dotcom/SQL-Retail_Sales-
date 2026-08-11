##Retail_Sales project 

##Technologies Used
* PostgreSQL
* SQL
* pgAdmin
* GitHub

##This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Project Workflow

**Raw CSV Data → PostgreSQL Database → Data Cleaning → Exploratory Data Analysis → SQL Analysis → Business Insights**

1. Imported the raw retail sales data into PostgreSQL.
2. Created the `retail_sales` table and defined the required columns.
3. Checked the dataset for missing and null values.
4. Cleaned the dataset by removing incomplete records.
5. Performed exploratory data analysis using SQL.
6. Answered business questions using aggregation, filtering, CTEs, and window functions.
7. Extracted key business insights from the analysis.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

Insight :
Electronics generated the highest total sales, followed closely by Clothing.
However, Clothing had the highest number of transactions.
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

Insighs:

The average age of customers purchasing Beauty products was approximately 40 years**.

```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000

Insight:
The analysis identified 306 transactions with sales greater than 1,000.
This can be useful for understanding high-value purchases and premium transactions.
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1
Insight:
This analysis helps understand how purchasing activity differs between male and female customers across product categories.
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
Insight:
The dataset contains sales from 2022,2023
April 2022 had the highest average transaction value at approximately 485.19.
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
Insight:
Customer ID 3 generated the highest total sales with approximately:
38,440
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category
Insight
Clothing had the highest number of unique customers.
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        Else 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
Insight:
The Evening shift recorded the highest number of transactions, representing the busiest period in the dataset.
```

## Key Business Insights

Top Performing Category:** Electronics generated the highest total sales, making it the strongest revenue-generating category.
Transaction Volume:** Clothing recorded the highest number of transactions, indicating strong customer demand.
High-Value Transactions:** The analysis identified **306 transactions** with total sales greater than 1,000.
Customer Spending:** Customer ID **3** was the highest-spending customer, generating approximately **38,440** in total sales.
Customer Reach:** Clothing had the highest number of unique customers among the product categories.
Sales Timing:** The **Evening** shift recorded the highest number of transactions, making it the busiest sales period.
Customer Demographics:** Customers purchasing Beauty products had an average age of approximately **40 years**.
Monthly Performance:** April 2022 recorded the highest average transaction value at approximately **485.19**.


## SQL Skills Demonstrated

* Database and table creation
* Data cleaning and NULL value handling
* Data exploration
* Filtering with `WHERE`
* Aggregations using `SUM`, `AVG`, and `COUNT`
* `GROUP BY` and `ORDER BY`
* `CASE WHEN`
* Common Table Expressions (CTEs)
* Window Functions
* `RANK()`
* `COUNT(DISTINCT)`
* Date and time analysis
* Business-oriented data analysis

