create database WalmartSale_Project;

use WalmartSale_Project;

create table Sale
(
Invoice_Id varchar(30) Not Null Primary Key,
Branch Varchar(10) Not Null,
City varchar(10) Not Null,
Customer_Type varchar(30) Not Null,
Gender varchar(10) Not Null,
Product_line varchar(30) Not Null,
Unit_Price decimal(10, 2) Not Null,
Quantity int Not Null,
VAT float(6, 4) Not Null,
Total decimal(10, 2) Not Null,
Date date Not Null,
Time time Not Null,
Payment_Method varchar(15)  Not Null,
COGS decimal(10, 2) Not Null,
Gross_Marginpercentage float(11, 9) Not Null,
Gross_income decimal(10, 2) Not Null,
Rating float(2, 1) Not Null
);

describe sale;

select * from sale;

-- ----------------------------------------------------------------------------------------
-- -------------------------------Adding a new_column -------------------------------------

select time,
(case
When time between "00:00:00" and "12:00:00" then "Morning"
when time between "12:01:00" and "16:00:00" then "Afternoon"
Else "Evening"
End)
as Time_of_Day
from sale;

alter table sale add column Time_of_Day Varchar(15);

update sale
set Time_of_day=(
case
When time between "00:00:00" and "12:00:00" then "Morning"
when time between "12:01:00" and "16:00:00" then "Afternoon"
Else "Evening"
End);

select date,
dayname(date) as Day_Name
from sale;

alter table sale add column Day_Name Varchar(15);

update sale
set Day_Name= dayname(date);

select date,
monthname(date) as Month_name
from sale;

alter table sale add column Month_Name Varchar(12);

Update sale
set Month_Name= monthname(date);

select * from sale;


-- ------------------------------------------------------------------------------------------
-- --------------------------------------------Generic Questions-----------------------------

-- ------1. How many unique product line does the data have?---------------------------------


select distinct Product_line from sale;


-- -----------2. What is the most common payment method?-------------------------------------

select Payment_method,
count(Payment_method) As Cnt
from sale
group by Payment_method
order by Cnt desc;

-- --------------------3. What is the most selling product line?-----------------------------

select Product_line,
count(Product_line) as Product_cnt
from sale
group by Product_line
order by Product_cnt desc;

-- -------------------- 4. What is the total revenue by month?-------------------------------

select Month_name,
sum(Total) as Revenue
from sale
group by Month_name
order by Revenue desc;

-- --------------------------5. What month had the largest COGS?-----------------------------

select Month_name,
sum(COGS) as Total_COGS
from sale
group by Month_name
order by Total_COGS desc;

-- -------------------------6. What product line had the largest revenue?--------------------

select Product_line,
sum(total) as Total_Revenue
from sale
group by Product_line
order by Total_Revenue desc;

-- ---------------------------7. What is the city with the largest revenue?------------------

select City,
sum(Total) as Total_revenue
from sale
group by City
order by Total_revenue desc;

-- -------------------------8. What product line had the largest VAT?------------------------

select Product_line,
sum(VAT) as Total_VAT
from sale
group by Product_line
order by Total_VAT desc;

-- -----------------------------------------------------------------------------------------

select avg(Quantity) as Avg_Qty from sale;

select Product_Line,
case When Avg(Quantity) > 6 Then "Good"
Else "Bad"
End as Remark
from sale
group by Product_Line;

-- -----------------------------------------------------------------------------------------

select Product_Line,
round(Avg(rating), 2) as Avg_Rating
from sale
group by Product_Line
order by Avg_Rating desc;

-- ------------------------------------------------------------------------------------------
-- --------------------- Sale----------------------------------------------------------------
-- -----------------1. Number of sales made in each time of the day per weekday-----------------
select Time_of_Day,
count(*) as Total
from sale
where Day_name = "Monday"
group by Time_of_Day
order by Total desc;

-- --------------------Which of the customer types brings the most revenue? ------------------

select Customer_Type,
sum(Total) as Total_revenue
from sale
group by Customer_Type
Order by Total_revenue desc;

-- ---Which city has the largest tax percent/ VAT (Value Added Tax)?---------------------------------------

select City,
sum(VAT) as Total_VAT
from sale
group by City
Order by Total_Vat Desc;

-- ------------------------Which customer type pays the most in VAT?-------------------------

select Customer_Type,
sum(VAT) as Total_VAT
from sale
group by Customer_Type
Order by Total_VAT desc;

-- ---------How many unique customer types does the data have along with count?--------------

select distinct Customer_Type,
count(Customer_Type) as Cnt
from sale
group by Customer_Type;

-- ------------How many unique payment methods does the data have?---------------------------

select distinct Payment_Method,
count(Payment_Method) as Cnt_Payment
 from sale
group by Payment_Method
order by Cnt_Payment Desc;

-- -----------------What is the most common customer type?----------------------------------

select Customer_Type,
count(Customer_Type) as Cnt_Type
from sale
Group by Customer_Type
Order by Cnt_Type desc;

-- ----------------Which customer type buys the most?------------------------

select Customer_Type,
sum(Quantity) As Total_Qty
 from sale
 group by Customer_Type
 Order by Total_Qty Desc;
 
 -- ------------------What is the gender of most of the customers?---------------------------
 
 select Gender,
 count(Gender) as Total_Cnt
 from sale
 group by Gender
 order by Total_Cnt desc;
 
 -- --------------------------------What is the gender distribution per branch? -------------------
 
 select Branch, Gender,
 count(Gender) as Total_Qty
 from sale
 group by Branch, Gender
 order by Branch Asc;
 
 -- --------------------------------Which time of the day do customers give most ratings?------------
 
 select Time_of_Day,
 count(Rating) as Total_Rtg
 from sale
 group by Time_of_Day;
 
 -- ------------------Which time of the day do customers give most ratings per branch?-------
 
 Select Branch, Time_of_Day,
 count(Rating) as Total_Rtg
 from sale
 group by Branch, Time_of_Day
 order by Total_Rtg Desc;
 
 -- -----------------Which day fo the week has the best avg ratings?-------------------------
 
 Select Day_Name,
 round(avg(Rating), 2) as Avg_Rtg
 from sale
 group by Day_Name
 Order by Avg_Rtg desc;
 
 -- ----------------Which day of the week has the best average ratings per branch?-----------
 
select Branch, Day_Name,
round(avg(Rating), 2) as Avg_Rtg
from sale
group by Branch, Day_Name
order by Avg_Rtg desc;

-- --------------------------------------END-----------------------------------------