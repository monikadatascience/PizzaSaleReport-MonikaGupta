
----  Data Analysis

Select * from pizza_Sales

---  # KPIs
-----------------------------------------

-- 1) Total Revenue generated 

Select round(sum(quantity * unit_price),2) as Total_Revenue from pizza_sales ;

-- 2) Average Order Value
-- total order value/order count

select round(sum(total_price)/count(Distinct order_id),2) as [Average Order Value] from pizza_sales ;

-- 3) Total Pizza Sold

select sum(quantity) as [total pizza sold] from pizza_sales ;

-- 4) Total Orders Placed

select count(DISTINCT order_id) as [Total Order] from pizza_sales ;

-- 5) Average Pizza per order 
-- pizzas sold / number of pizzas

select sum(quantity)/count(Distinct order_id) as [Average pizzas per order] from pizza_sales ;

---  # Question To Answer
--------------------------------------------

-- # Question 1) Find the daily Trends for Total Orders .

select format(order_date,'dddd') as pizza_orderday ,count(DISTINCT order_id) as total_orders from pizza_sales 
group by format(order_date,'dddd')
order by total_orders Desc ;

-- # Question 2) Find the hourly trend for total orders .

select DATEPART(HOUR,order_time) as Hour,count(DISTINCT order_id) as total_orders from pizza_sales 
group by DATEPART(HOUR,order_time)
order by [Hour] ;

-- # Question 3) Find the peak hour or time :

-- (a) when sales are particularly high -

select top(1)  DATEPART(HOUR,order_time) as Hour,count(DISTINCT order_id) as total_High_Sales from pizza_sales 
group by DATEPART(HOUR,order_time)
order by [total_High_Sales] desc ;

-- (b) when sales are particularly low -

select top(1)  DATEPART(HOUR,order_time) as Hour,count(DISTINCT order_id) as total_low_Sales from pizza_sales 
group by DATEPART(HOUR,order_time)
order by [total_low_Sales]  ;

-- # Question 4) Find the monthly trend for total orders .

select format(order_date,'MMM') as pizzaorder_monthname,count(DISTINCT order_id) as total_orders from pizza_sales 
group by format(order_date,'MMM')
order by total_orders desc ;

-- # Question 5) Find the peak month :

-- (a) when sales are particularly high -

select top (1) format(order_date,'MMMM') as pizzaorder_monthname,
count(DISTINCT order_id) as total_orders from pizza_sales 
group by format(order_date,'MMMM')
order by total_orders desc ;

-- (b) when sales are particularly low -

select top (1) format(order_date,'MMMM') as pizzaorder_monthname,count(DISTINCT order_id) as total_orders from pizza_sales 
group by format(order_date,'MMMM')
order by total_orders asc ;

-- # Question 6) Which pizza_category has the most number of pizza varieties .

select pizza_category , count(quantity) as number_of_pizza_varities from pizza_sales
group by pizza_category ;

-- # Question 7) Identified the most common pizza size ordered .

Select pizza_size ,count(pizza_id) as order_count from pizza_sales
group by pizza_size
order by order_count desc ;

-- # Question 8) Find the total pizzas sold by pizza category .

select pizza_category , sum(quantity) as quantity_sold from pizza_sales
group by pizza_category 
order by sum(quantity) ;

-- # Question 9) Determine the top 4 most ordered pizza type based on revenue .

select top (4) pizza_name as top_4_prefer_pizza , sum(total_price) as revenue from pizza_sales
group by pizza_name
order by revenue desc ;

-- # Question 10) Determine the bottom 4 pizza type based on revenue .

select top (4) pizza_name , sum(total_price) as revenue from pizza_sales
group by pizza_name
order by revenue  ;

-- # Question 11) Find the percentage of Sales by pizza Category .
--            A: firstly , we calculate total revenue per category
--            %  sales calculated as (A:/ total revenue) * 100

select pizza_category , CAST(sum(total_price) as decimal (10,2)) as revenue ,
CAST(sum(total_price) * 100 /(select sum(total_price)from pizza_sales) as DECIMAL(10,2)) as percentage_sales from pizza_sales
group by pizza_category ;

-- # Question 12) Find the percentage of sales by Pizza Size

select pizza_size , CAST(SUM (total_price) as DECIMAL (10,2)) as revenue ,
CAST(sum(total_price) * 100 / ( Select sum(total_price) from pizza_sales) as DECIMAL(10,2)) as percentage_sales from pizza_sales
group by pizza_size ;

-- # Question 13) Identify the highest - priced pizza .

select top (1) pizza_name ,unit_price as pizza_Highest_prize  from pizza_sales  
order by unit_price desc ;

-- # Question 14) Top 5 best selling  pizzas by Quantity .

select top(5) pizza_name ,sum(Quantity) as number_of_pizza_quantity from pizza_sales
group by pizza_name
order by number_of_pizza_quantity desc ;

-- # Question 15) Bottom 5 worst selling  pizzas by Quantity .

select top(5) pizza_name ,sum(Quantity) as number_of_pizza_quantity from pizza_sales
group by pizza_name
order by number_of_pizza_quantity  ;

-- # Question 16) Top 5 best selling  pizzas by Total Orders .

select top(5) pizza_name ,count(DISTINCT order_id) as total_orders from pizza_sales
group by pizza_name
order by total_Orders desc  ;

-- # Question 17) Bottom 5 worst selling  pizzas by Total Orders .

select top(5) pizza_name ,count(DISTINCT order_id) as total_orders from pizza_sales
group by pizza_name
order by total_Orders asc  ;

