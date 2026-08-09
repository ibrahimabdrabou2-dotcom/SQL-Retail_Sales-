select * from retail_sales ;

-- finding null value

select * from retail_sales 
where transactions_id is null 
or sale_date is null 
or sale_time is null
or customer_id is null 
or gender is null 
or age is null
or category is null 
or quantity is null
or price_per_unit is null 
or cogs is null
or total_sale is null ;

-- delete null value 

delete from retail_sales
where transactions_id is null 
or sale_date is null 
or sale_time is null
or customer_id is null 
or gender is null 
or age is null
or category is null 
or quantity is null
or price_per_unit is null 
or cogs is null
or total_sale is null ;

--how many unique customer we have
select count(distinct customer_id )
from retail_sales ;

-- what are the unique categories

select distinct category from retail_sales ;

-- retrieve all colmuns in a specific date 

select * from retail_sales 
 where sale_date = '2022-11-05' ; 

-- retrieve all transactions where category = 'clothing' and the quaintity is sold less than or equal 4 the month of Nov-2022

select * 
from retail_sales
where 
category = 'Clothing'
and  
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
and 
quantity<=4 ;

-- calculate count taransactions and total_sales for each category 

select 
category ,
sum (total_sale) as total_sales ,
count (*) as count_orders 
from retail_sales 
group by category ;

-- find the average age of customers who purchased items from the 'Beauty' category

select
round(avg(age),2) as avg_age 
from retail_sales 
where category = 'Beauty' ;

--find all transactions where the total_sale is greater than 1000

select * from retail_sales 
where total_sale > 1000 ;

--find the top number of transactions (transaction_id) made by each gender in each category

select 
count(transactions_id) as number_of_tarnsaction ,
gender ,
category 
from retail_sales 
group by gender , category 
order by number_of_tarnsaction desc ; 

-- find the top 5 customers based on the highest total sales

select 

customer_id ,
sum (total_sale) as total_sales 
from retail_sales 
group by customer_id
order by total_sales desc 
limit 5 ;

-- find the number of unique customers who purchased items from each category

select 
count(distinct customer_id) ,
category 
from retail_sales 
group by category ;

-- calculate the average sale for each month. Find out best selling month in each year

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
WHERE rank = 1 ;

--create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

with hour_sale as (
select * ,
case 
when extract (hour from sale_time ) < 12 then 'Morning' 
when extract (hour from sale_time ) between 12 and 17 then 'Afternoon' 
else 'Evining' 
end as shifts 
from retail_sales )

select 
shifts ,
count(*) as total_orders
from hour_sale 
group by shifts ;

























































































































