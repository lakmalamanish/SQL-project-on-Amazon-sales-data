use capstoneproject 

 select * from amazon;

alter table amazon
drop column dayname ;

select * from amazon;

update amazon
set day_name = dayname(date);

select * from amazon;

alter table amazon
add month_name varchar(15);

update amazon
set month_name = monthname(date);

select * from amazon;

alter table amazon
add column timeofday varchar(10);

update amazon
set timeofday = case
when time(time) between '01:00:00' and '11:59:00' then "morning"
when time(time) between '12:00:00' and '17:59:00' then "afternoon"
when time(time) between '18:00:00 'and '23:59:00' then "evening"
end;

select * from amazon;

 # Q1 What is the count of distinct cities in the dataset?
select count(distinct(city)) from amazon;
# comments It gives the count of 3 distinct city from the table amazon

# Q2 For each branch, what is the corresponding city?
select distinct(branch) , city from amazon
where branch in ("A", "B", "C");
# comments It gives the city names ie yangon, naypyitaw and mandalay for branch A , B and C.

# Q3 What is the count of distinct product lines in the dataset?
select count(distinct(`product line`)) as dist_productline from amazon;
# comments It gives count of 6 distinct product lines.

# Q4 Which payment method occurs most frequently?
select payment, count(payment) from amazon
group by payment
order by count(payment) desc
limit 1;
# comments It firsts counts the payment from amazon then groups with payment and then sorts by descending using order by and limiting to 1.

# Q5 Which product line has the highest sales?
select `product line`, max(cogs) from amazon
group by `product line` 
order by max(cogs) desc;
# comments  For highest sales it uses max function on cost of goods sold and groups based on product line then sorts descending using order by function.

# Q6 How much revenue is generated each month?
select month_name, sum(`gross income`) from amazon
group by month_name;
# comments for each month we use month_name and for revenue generation we use sum fuction and then group by month_name.

# Q7 In which month did the cost of goods sold reach its peak?
select month_name, max(cogs) from amazon
group by month_name
order by max(cogs) desc 
limit 1;
# comments In feb the cogs reach its peak for this we used max function and then grouped it with month_name and sorts in desc with order by and limit to 1.

# Q8 Which product line generated the highest revenue?
select `product line` , max(`gross income`) from amazon
group by `product line`
order by max(`gross income`) desc;
# comments the highest revune generated was fashion accessories with max gross income of 49.55

# Q9 In which city was the highest revenue recorded?
select city, max(`gross income`) from amazon
group by city
order by max(`gross income`) desc;
# comments the highest revenue generated in the city naypyitaw with revenue of 49.65

# Q10 Which product line incurred the highest Value Added Tax?
select `product line` , max(`tax 5%`) from amazon 
group by `product line`
order by max(`tax 5%`) desc ;
# comments product line fashion accessories incured highest vat with 49.65

# Q11 For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
with cte as(
select `product line` , sum(cogs) as total_cogs from amazon
group by `product line` 
)
select `product line` , total_cogs, 
case
when total_cogs > ( select avg(total_cogs) from cte )  
then "good" 
else "bad"  
end as salesstatus
from cte;
# comments using cte we used the sum function and then we used the avg function and based on that we got to know if sale is good or bad.

# Q12 Identify the branch that exceeded the average number of products sold.
select branch , sum(quantity) as total_quantity  from amazon
group by branch
having sum(quantity) > (select avg(quantity) from amazon ); 
# comments using sum we got the total quantity of each branch then after that we used having for the sum quantity which should be greater than average quantity

# Q13 Which product line is most frequently associated with each gender?
select `product line` , gender , count(*) from amazon
group by `product line`, gender
order by count(*) desc;
# comments product line of fashion accessories is frequently associated with female and health and beauty with male.

# Q14 Calculate the average rating for each product line.
select `product line`, avg(rating) from amazon
group by `product line`;
# comments It  gives the avg rating of all product line from amazon table using avg function on rating.

# Q15 Count the sales occurrences for each time of day on every weekday.
select timeofday , day_name , count(cogs) from amazon
group by timeofday , day_name
having day_name in ("saturday", "sunday");
# comments It counts the sales of cogs from amazon and groups by timeofday and dayname using having to get the result only for weekends.

# Q16 Identify the customer type contributing the highest revenue.
select `customer type` , max(cogs) from amazon
group by `customer type` 
order by max(cogs);
# comments customer type normal contributes the highest revenue of 989.8

# Q17 Determine the city with the highest VAT percentage.
select city, max(`tax 5%`) as vat_percent from amazon
group by city 
order by vat_percent desc;
# comments naypyitaw city gives the highest vat percentage of 49.65 using max function.

# Q18 Identify the customer type with the highest VAT payments.
select `customer type` , max(`tax 5%`) from amazon
group by `customer type` 
order by max(`tax 5%`) desc; 
# comments customer type member is with highest vat payment of 49.65

# Q19 What is the count of distinct customer types in the dataset?
select count(distinct(`customer type`)) from amazon;
# comments  the count of distinct customer type is 2. 

# Q20 What is the count of distinct payment methods in the dataset?
select count( distinct(payment)) from amazon;
# comments The count of distinct payment is 3 from amazon table.

# Q21 Which customer type occurs most frequently?
select `customer type` , count(*) from amazon
group by `customer type`
order by count(*) desc;
# comments the customer type member with count value as 501 occurs most frequently.

# Q22 Identify the customer type with the highest purchase frequency.
select `customer type` , max(cogs) from amazon
group by `customer type`
order by max(cogs);
# comments normal customer with max function we got the highest purchase as 989.9


# Q23 Determine the predominant gender among customers.
select gender, count(*) from amazon 
group by gender 
order by count(*) desc;
# comments using count function we got the predominant gender feamle with count value 501

# Q24 Examine the distribution of genders within each branch.
select branch ,gender, count(*) from amazon
group by gender, branch;
# comments for each branch ie a, b, c we will get the count of genders ie male, female using count function.

# Q25 Identify the time of day when customers provide the most ratings.
select  timeofday, count(rating) from amazon 
group by timeofday;
# comments  At afternoon the customers provide 525 ratings.

# Q26 Determine the time of day with the highest customer ratings for each branch.
select timeofday, branch, count(rating)as highest_rating from amazon
group by branch
order by count(rating) desc;
# comments using the count rating we will find highest customer rating and the group by branch and sorts desc on count(rating).

# Q27 Identify the day of the week with the highest average ratings.
select day_name, avg(rating) high_rating from amazon
group by day_name
order by avg(rating) desc;
# comments It gives the highest avg rating for all the days ie from monday to sunday from amazon table. 


# Q28 Determine the day of the week with the highest average ratings for each branch.
select day_name , branch, avg(rating) from amazon
group by branch
order by avg(rating) desc;
# comments highest avg rating is 7.07286 for branch C on friday.
