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

# Retail Sales Analysis Using SQL

A SQL-based data analytics project focused on exploring retail transactions, analyzing customer purchasing behavior, and identifying sales patterns using PostgreSQL.

## 📌 Project Overview

This project demonstrates how SQL can be used to transform retail transaction data into structured analysis that supports business understanding and decision-making.

The workflow covers database creation, data exploration, data quality checks, and business analysis through SQL queries. The analysis focuses on sales performance, product categories, customer behavior, monthly trends, and purchasing activity throughout the day.

## 🎯 Business Objectives

- Explore retail transaction data and understand its structure.
- Identify missing values and assess data quality.
- Analyze sales performance across product categories.
- Examine customer demographics and purchasing behavior.
- Identify high-value transactions and top-spending customers.
- Compare transaction counts across gender and product categories.
- Analyze monthly average transaction values and identify peak months by year.
- Understand purchasing activity across different times of day.

## 🛠️ Tools & Technologies

- **PostgreSQL** — Database creation and SQL analysis.
- **SQL** — Data exploration, filtering, aggregation, and business analysis.
- **GitHub** — Version control and project documentation.
- **CSV** — Retail transaction dataset.

## 📂 Repository Contents

| File | Description |
|---|---|
| `SQL Project (retail sales).sql` | SQL script containing database setup, data quality checks, and analytical queries |
| `retail_sales.csv` | Retail transaction dataset |
| `README.md` | Project documentation |

## 🔄 Project Workflow

### 1. Database Setup

Created a PostgreSQL database named `p1_retail_db` and a `retail_sales` table to organize the transaction-level data.

The table includes transaction identifiers, sales dates and times, customer attributes, product categories, quantities, unit prices, cost of goods sold, and total sales.

### 2. Data Exploration

Explored the dataset using SQL to understand its structure and identify important characteristics, including:

- Total transaction records.
- Unique customers.
- Available product categories.
- Missing values in important columns.

### 3. Data Quality Checks

Used SQL queries to identify records containing missing values and demonstrate data cleaning techniques.

These checks help assess the reliability of the dataset before performing further analysis.

### 4. Business Analysis

Developed SQL queries to investigate retail business questions using filtering, aggregation, date functions, conditional logic, and window functions.

## 📊 Business Questions Answered

| # | Business Question | SQL Techniques |
|---:|---|---|
| 1 | Retrieve transactions for a specific date | `WHERE` |
| 2 | Find clothing transactions with quantities of at least four during November 2022 | `WHERE`, `AND`, date functions |
| 3 | Calculate total sales and transaction counts by category | `SUM()`, `COUNT()`, `GROUP BY` |
| 4 | Calculate the average customer age for Beauty purchases | `AVG()`, `ROUND()` |
| 5 | Identify high-value transactions exceeding 1,000 | Filtering |
| 6 | Compare transaction counts by gender and category | `COUNT()`, `GROUP BY` |
| 7 | Identify the month with the highest average transaction value in each year | `AVG()`, `EXTRACT()`, `RANK()` |
| 8 | Identify the top five customers by total sales | `SUM()`, `ORDER BY`, `LIMIT` |
| 9 | Count unique customers within each category | `COUNT(DISTINCT ...)` |
| 10 | Classify transactions into Morning, Afternoon, and Evening shifts | `CASE`, `CTE`, date/time functions |

## 🧠 SQL Skills Demonstrated

- **Data Definition:** `CREATE DATABASE`, `CREATE TABLE`
- **Data Exploration:** `SELECT`, `DISTINCT`, `COUNT()`
- **Data Quality:** `IS NULL`, filtering records with missing values
- **Aggregation:** `SUM()`, `AVG()`, `COUNT()`, `ROUND()`
- **Grouping and Filtering:** `GROUP BY`, `WHERE`, `ORDER BY`, `LIMIT`
- **Conditional Logic:** `CASE WHEN`
- **Date and Time Analysis:** `EXTRACT()`, `TO_CHAR()`
- **Common Table Expressions:** `WITH`
- **Window Functions:** `RANK()` with `PARTITION BY`

## 💼 Business Value

This analysis demonstrates how SQL can support retail performance monitoring and customer analysis by helping answer questions such as:

- Which product categories generate the highest sales?
- Which customers contribute the most to total sales?
- How does purchasing behavior vary across customer groups?
- Which months have the highest average transaction values?
- How is transaction activity distributed throughout the day?
- What proportion of the dataset requires data quality attention?

## 🚀 How to Run the Project

1. Download or clone this repository.
2. Open the SQL script in PostgreSQL using pgAdmin or another compatible SQL client.
3. Create the database and table using the provided SQL statements.
4. Import `retail_sales.csv` into the `retail_sales` table, ensuring the column names and data types match the table definition.
5. Execute the queries section by section.
6. Review the query results to investigate the business questions.

**Note:** Run the data quality checks before any deletion statements, and verify the affected rows before modifying the source table.

## 📈 Key Takeaways

The project demonstrates a practical SQL workflow for retail analytics, from database setup and data quality checks to business-oriented analysis.

It provides hands-on experience in querying transactional data, summarizing sales performance, analyzing customers, ranking results, and extracting insights from dates and times.

The business findings should be documented using verified query results rather than assumptions about the dataset.

---

**Project Type:** Retail Data Analytics  
**Database:** PostgreSQL  
**Language:** SQL  
**Core Focus:** Data Exploration | Data Quality | Sales Analysis | Customer Analysis | Window Functions


