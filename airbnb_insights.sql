create database airbnb;
use airbnb;

select * from airbnb_listings;
select count(*) from airbnb_listings;

-- what does the overall airbnb market look like?
select min(price) as min_price, max(price) as max_price, round(avg(price),2) as avg_price
from airbnb_listings;

-- which area is expensive ?
select neighbourhood_group, round(avg(price),2) as avg_price 
from airbnb_listings
group by neighbourhood_group
order by avg_price desc;

-- room type analysis
select room_type, count(*) as total_listings, round(avg(price), 2) as avg_price
from airbnb_listings
group by room_type;

-- demand analysis, which listings are popular 
select neighbourhood_group, round(avg(number_of_reviews), 2) as avg_reviews
from airbnb_listings
group by neighbourhood_group
order by avg_reviews desc;

-- availibility analysis, which listings are inactive are and active 
select case when availability_365 = 0 then "Inactive"
when availability_365 < 100 then "Low Availability"
when availability_365 < 300 then "Medium Availability"
else "High Availability"
end as availability_status,
count(*) as total_listings
from airbnb_listings
group by availability_status;

-- performance analysis, top performing listing
select name, number_of_reviews
from airbnb_listings
order by number_of_reviews desc
limit 3;

-- time series analysis, demand increasing or decreasing over time
select year(str_to_date(last_review, '%m/%d/%Y')) as review_year, month(str_to_date(last_review, '%m/%d/%Y')) as review_month, count(*) as total_reviews
from airbnb_listings
where str_to_date(last_review, '%m/%d/%Y') is not null
group by review_year, review_month
order by review_year, review_month;

