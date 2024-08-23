use yelp;
show tables;
SELECT * FROM yelp_business LIMIT 100;
SELECT * FROM yelp_business_hours LIMIT 100;
SELECT * FROM yelp_checkin LIMIT 100;
SELECT * FROM yelp_review LIMIT 100;
SELECT * FROM yelp_tip LIMIT 100;
SELECT * FROM yelp_user LIMIT 100;


# Data Preparation: Filtering out data that does not make sense in business
-- Select all columns from the 'yelp_business' table
SELECT *
FROM `yelp_business`
-- Filter the results where 'name' is NULL
-- or 'state' is NULL
-- or 'stars' is less than 0 or greater than 5
WHERE
    name IS NULL
    OR state IS NULL
    OR stars < 0
    OR stars > 5;
-- The result is all null, meaning that we dont have any useless values

SELECT *
FROM `yelp_business`
WHERE is_open=1;

SELECT *
FROM `yelp_business`
WHERE is_open=0;

-- Select all columns from the 'yelp_business_hours' table
SELECT *
FROM `yelp_business_hours`
-- Filter the results where business is not operating for the entire week
-- Where the values are not equal to none
WHERE
    monday <> "None"
    OR tuesday <> "None"
    OR wednesday <> "None"
    OR thursday <> "None"
    OR friday <> "None"
    OR saturday <> "None"
    OR sunday <> "None";

-- Select all columns from the 'yelp_checkin' table
SELECT *
FROM `yelp_checkin`
-- Check if any result where 'weekday' is null
-- or 'hour' is null
-- or 'checkins' is null
-- If the table returns null, it means that there is no Nah value in this table
WHERE 
    weekday IS NULL
    OR hour IS NULL
    OR checkins IS NULL;

-- Select all columns from the 'yelp_review' table
SELECT *
FROM yelp_review
-- Filter the results where 'review_id' is NULL
-- or 'business_id' is NULL
-- or 'user_id' is NULL
-- or 'date' is NULL
-- or 'stars' is less than 0 or greater than 5
WHERE
    review_id IS NULL
    OR business_id IS NULL
    OR user_id IS NULL
    OR date IS NULL
    OR stars < 0
    OR stars > 5;

-- Select all columns from the 'yelp_tip' table
SELECT *
FROM yelp_tip
-- Filter the results where 'text' is NULL
-- or 'business_id' is NULL
-- or 'user_id' is NULL
-- or 'date' is NULL
-- or 'likes' is less than 0
WHERE
    text IS NULL
    OR business_id IS NULL
    OR user_id IS NULL
    OR date IS NULL
    OR likes < 0;

-- Select all columns from the 'yelp_user' table
SELECT *
FROM `yelp_user`
-- Filter the results where any of the following conditions are met:
-- 'useful' is less than 0
-- 'funny' is less than 0
-- 'cool' is less than 0
-- 'fans' is less than 0
-- 'average_stars' is less than 0
-- 'average_stars' is greater than 5
WHERE
    useful < 0
    OR funny < 0
    OR cool < 0
    OR fans < 0
    OR average_stars < 0
    OR average_stars > 5;

-- Select all columns from the 'yelp_user' table
-- Where 'name', 'review_count', and 'yelping_since' are not NULL
SELECT *
FROM `yelp_user`
WHERE
    name IS NOT NULL
    AND review_count IS NOT NULL
    AND yelping_since IS NOT NULL;

# 1. From the Customer's Perspective:
## 1)  On average, how many reviews do regular users post per month since creating their account, 
## and how many do elite users post per month? What are the counts and proportions of reviews considered "useful," "funny," and "cool"?

-- Select distinct 'yelping_since' values
-- from the 'yelp_user' table, ordered by descending date
-- and limit the result to 1 row (the most recent date)
-- We therefore get the most recent date "2017-12-11"
SELECT DISTINCT(yelping_since)
FROM `yelp_user`
ORDER BY yelping_since DESC
LIMIT 1;

-- Select 'user_id', calculate the registration time as the difference
-- between "2017-12-11" and 'yelping_since', and calculate the average
-- review per day for non-elite users (elite="None").
SELECT
    user_id,
    DATEDIFF("2017-12-11", yelping_since) as register_time,
    (review_count / DATEDIFF("2017-12-11", yelping_since)) as avg_review_day
FROM `yelp_user`
WHERE elite = "None";

-- Calculate the average of 'avg_review_day' values for non-elite users.
SELECT AVG(sub.avg_review_day) as avg_review_day_nelite
FROM (
    -- Subquery to calculate 'avg_review_day' for non-elite users
    SELECT
        user_id,
        DATEDIFF("2017-12-11", yelping_since) as register_time,
        (review_count / DATEDIFF("2017-12-11", yelping_since)) as avg_review_day
    FROM `yelp_user`
    WHERE elite = "None"
) as sub;

-- Calculate the total review count for non-elite users,
-- as well as the rates of 'useful,' 'funny,' and 'cool' votes per review.
SELECT
    SUM(review_count) as total_review_count,
    SUM(useful) / SUM(review_count) as useful_rate_ne,
    SUM(funny) / SUM(review_count) as funny_rate_ne,
    SUM(cool) / SUM(review_count) as cool_rate_ne
FROM `yelp_user`
WHERE elite = "None";

-- Calculate the average of 'avg_review_day' values for elite users.
SELECT AVG(sub.avg_review_day) as avg_review_day_elite
FROM (
	-- Subquery to calculate 'avg_review_day' for elite users
    SELECT
    user_id,
    datediff("2017-12-11", yelping_since) as register_time,
    (review_count / datediff("2017-12-11", yelping_since)) as avg_review_day
    FROM `yelp_user`
    WHERE elite <> "None"
) as sub;

-- Calculate the total review count for elite users,
-- as well as the rates of 'useful,' 'funny,' and 'cool' votes per review.
SELECT
    SUM(review_count) as total_review_count,
    SUM(useful) / SUM(review_count) as useful_rate_ne,
    SUM(funny) / SUM(review_count) as funny_rate_ne,
    SUM(cool) / SUM(review_count) as cool_rate_ne
FROM `yelp_user`
WHERE elite <> "None";

## 2)

-- Calculate the count of reviews with 'useful' values greater than 1000,
-- the average star rating rounded to one decimal place,
-- and the average length of reviews rounded to the nearest whole number.
SELECT
    COUNT(sub.text) as review_count,
    ROUND(AVG(sub.stars), 1) as avg_stars,
    ROUND(AVG(sub.len), 0) as avg_length
FROM (
    -- Subquery to select relevant data from yelp_review
    SELECT stars, text, LENGTH(text) as len, useful
    FROM yelp_review
    WHERE useful > 1000
) as sub;


-- Calculate the count of reviews with 'useful' values greater than 500,
-- the average star rating rounded to one decimal place,
-- and the average length of reviews rounded to the nearest whole number.
SELECT
    COUNT(sub.text) as review_count,
    ROUND(AVG(sub.stars), 1) as avg_stars,
    ROUND(AVG(sub.len), 0) as avg_length
FROM (
    -- Subquery to select relevant data from yelp_review
    SELECT stars, text, LENGTH(text) as len, useful
    FROM yelp_review
    WHERE useful > 500 AND useful <= 1000
) as sub;

-- Calculate the count of reviews with 'useful' values greater than 200,
-- the average star rating rounded to one decimal place,
-- and the average length of reviews rounded to the nearest whole number.
SELECT
    COUNT(sub.text) as review_count,
    ROUND(AVG(sub.stars), 1) as avg_stars,
    ROUND(AVG(sub.len), 0) as avg_length
FROM (
    -- Subquery to select relevant data from yelp_review
    SELECT stars, text, LENGTH(text) as len, useful
    FROM yelp_review
    WHERE useful > 200 AND useful <= 500
) as sub;

-- Calculate the count of reviews with 'useful' values greater than 100，
-- the average star rating rounded to one decimal place,
-- and the average length of reviews rounded to the nearest whole number.
SELECT
    COUNT(sub.text) as review_count,
    ROUND(AVG(sub.stars), 1) as avg_stars,
    ROUND(AVG(sub.len), 0) as avg_length
FROM (
    -- Subquery to select relevant data from yelp_review
    SELECT stars, text, LENGTH(text) as len, useful
    FROM yelp_review
    WHERE useful > 100 AND useful <= 200
) as sub;


-- Caculate the count of reviews with 'funny' values greater than 500
-- the average star rating rounded to one decimal place,
-- and the average length of reviews rounded to the nearest whole number.
Select count(sub.text), round(avg(sub.stars),1), round(avg(sub.len),0)
from (SELECT stars, text, length(text) as len, funny
FROM yelp_review
WHERE funny > 500
) as sub;


-- Caculate the count of reviews with 'funny' values greater than 200
-- the average star rating rounded to one decimal place,
-- and the average length of reviews rounded to the nearest whole number.
Select count(sub.text), round(avg(sub.stars),1), round(avg(sub.len),0)
from (SELECT stars, text, length(text) as len, funny
FROM yelp_review
WHERE funny>200
) as sub;

-- Caculate the count of reviews with 'funny' values greater than 100
-- the average star rating rounded to one decimal place,
-- and the average length of reviews rounded to the nearest whole number.
Select count(sub.text), round(avg(sub.stars), 1), round(avg(sub.len), 0)
From(
	SELECT stars, text, length(text) as len, funny
    FROM yelp_review
    WHERE funny > 100
)as sub;

select count(sub.text), round(avg(sub.stars),1), round(avg(sub.len),0)
from(SELECT stars, text, length(text) as len, cool
FROM yelp_review
WHERE cool>500
) as sub;

select count(sub.text), round(avg(sub.stars),1), round(avg(sub.len),0)
from(SELECT stars, text, length(text) as len, cool
FROM yelp_review
WHERE cool>200
) as sub;

select count(sub.text), round(avg(sub.stars),1), round(avg(sub.len),0)
from(SELECT stars, text, length(text) as len, cool
FROM yelp_review
WHERE cool>100
) as sub;

## 3）
-- Calculate the average business star rating for each unique review star rating,
-- ordering the results by review star rating in descending order.
SELECT
    yelp_review.stars,
    ROUND(AVG(yelp_business.stars), 2) as avg_busi_star
FROM
    yelp_review
LEFT JOIN
    yelp_business
ON
    yelp_review.business_id = yelp_business.business_id
GROUP BY
    yelp_review.stars
ORDER BY
    yelp_review.stars DESC;

-- Calculate the count of businesses, count of reviews with a star rating of 5,
-- and the ratio of businesses to reviews with a star rating of 5.
SELECT
    yelp_business.stars,
    COUNT(yelp_business.business_id) AS count_busi,
    COUNT(review_id) AS count_re,
    ROUND(COUNT(yelp_business.business_id) / COUNT(review_id), 2) AS rate_5
FROM
    yelp_review
LEFT JOIN
    yelp_business
ON
    yelp_review.business_id = yelp_business.business_id
WHERE
    yelp_review.stars = 5
GROUP BY
    yelp_business.stars 
ORDER BY 
yelp_business.stars DESC;

SELECT yelp_business.stars, count(yelp_business.business_id) AS count_busi
FROM yelp_review LEFT JOIN yelp_business
ON yelp_review.business_id=yelp_business.business_id
WHERE yelp_review.stars = 1
GROUP BY yelp_business.stars 
ORDER BY yelp_business.stars DESC;

## 4)
-- Sum the total number of fans, reviews, photo posted and liked by other users
-- Calculate the average of review for each 
SELECT 
	sum(fans), sum(review_count), sum(compliment_photos), sum(review_count)/sum(fans) as fans_re_rate_e, 
    sum(compliment_photos)/sum(fans)as fans_ph_rate_e
FROM `yelp_user`
WHERE elite<>"None";

SELECT
	sum(fans), sum(review_count), sum(compliment_photos), sum(review_count)/sum(fans) as fans_re_rate_e,
    sum(compliment_photos)/sum(fans) as fans_ph_rate_e
FROM yelp_user
WHERE elite = "None";

-- Count the number of regular users and their fans in total
-- In this way we can calculate for each regular user how many fans they can have on average
SELECT count(user_id), sum(fans), sum(fans)/count(user_id) as fans_rate_ne
FROM `yelp_user`
WHERE elite="None";

-- Count the number of elite users and their fans in total
-- In this way we can calculate for each regular user how many fans they can have on average
SELECT count(user_id), sum(fans), sum(fans)/count(user_id) as fans_rate_ne
FROM `yelp_user`
WHERE elite<>"None";

## 5)
-- Count the total number of review in each state
-- And output it in descending order
SELECT yelp_business.state, COUNT(yelp_review.review_id) AS count_re_state
FROM yelp_review LEFT JOIN yelp_business
ON yelp_review.business_id = yelp_business.business_id
GROUP BY yelp_business.state
ORDER BY count_re_state DESC;

# 2. From restaurants' perspective
## 1)
-- Calculate the average of ratings for all business
-- Round it to 1 decimal place
SELECT ROUND(AVG(stars), 1) as avg_stars
FROM yelp_business;


SELECT round(avg(stars), 1) as avg_stars
FROM yelp_business
WHERE categories LIKE '%Restaurant%';


-- Count the number of business for each stars level
-- Return by descending order
SELECT stars, count(business_id)
FROM yelp_business
GROUP BY stars
ORDER BY stars DESC;


SELECT b.stars, Round(avg(r.stars), 2) as avg_stars, Count(review_id) as count_re
FROM yelp_business as b
LEFT JOIN yelp_review as r
ON b.business_id = r.business_id
GROUP BY b.stars
ORDER BY b.stars DESC;


## 2）
-- 老师的方法 
SELECT state, count(state)
FROM yelp_business 
GROUP BY state
ORDER BY count(state) DESC;

-- We want to count the number of restaurants in each state
SELECT state, count(business_id) as total_bus
FROM yelp_business
WHERE categories like "%Restaurants%"
GROUP BY state
ORDER BY total_bus DESC;

/* This is the part where I wrote it wrong. I am wrong because I should not include the same alias within the formula for calculating the rate. SQL
SELECT
	state,
    COUNT(state) AS num_state,
    SUM(CASE stars WHEN 5.0 THEN 1 ELSE 0 END) AS sum_5,
    (SUM(sum_5)/num_state) AS rate_5,
    SUM(CASE stars WHEN 4.5 THEN 1 ELSE 0 END) AS sum_4_5,
    (SUM(sum_4_5)/num_state) AS rate_4_5,
    SUM(CASE stars WHEN 4.0 THEN 1 ELSE 0 END) AS sum_4,
    (SUM(sum_4)/num_state) AS rate_4,
    SUM(CASE stars WHEN 3.5 THEN 1 ELSE 0 END) AS sum_3_5,
    (SUM(sum_3_5)/num_state) AS rate_3_5,
    SUM(CASE stars WHEN 3.0 THEN 1 ELSE 0 END) AS sum_3,
    (SUM(sum_3)/num_state) AS rate_3,
    SUM(CASE stars WHEN 2.5 THEN 1 ELSE 0 END) AS sum_2_5,
    (SUM(sum_2_5)/num_state) AS rate_2_5,
    SUM(CASE stars WHEN 2.0 THEN 1 ELSE 0 END) AS sum_2,
    (SUM(sum_2)/num_state) AS rate_2,
    SUM(CASE stars WHEN 1.5 THEN 1 ELSE 0 END) AS sum_1_5,
    (SUM(sum_1_5)/num_state) AS rate_1_5,
    SUM(CASE stars WHEN 1.0 THEN 1 ELSE 0 END) AS sum_1,
    (SUM(sum_1)/num_state) AS rate_1
FROM
	yelp_business
GROUP BY state
ORDER BY num_state DESC;
*/

-- Calculate statistics related to star ratings for businesses grouped by state.
-- First count the total number of state
-- Then sum cases when a certain level of rating is satisfied
-- Calculate the ratio of each for each business (the column state has this feature. Each business id has one state so it is fine uing state here) for each rating level within different state)
SELECT
    state,
    COUNT(state) as count_state,
    SUM(CASE stars WHEN 5.0 THEN 1 ELSE 0 END) as sum_5,
    concat((100* SUM(CASE stars WHEN 5.0 THEN 1 ELSE 0 END) / COUNT(state)), '%') as rate_5,
    SUM(CASE stars WHEN 4.5 THEN 1 ELSE 0 END) as sum_4_5,
    (SUM(CASE stars WHEN 4.5 THEN 1 ELSE 0 END) / COUNT(state)) as rate_4_5,
    SUM(CASE stars WHEN 4.0 THEN 1 ELSE 0 END) as sum_4,
    (SUM(CASE stars WHEN 4.0 THEN 1 ELSE 0 END) / COUNT(state)) as rate_4,
    SUM(CASE stars WHEN 3.5 THEN 1 ELSE 0 END) as sum_3_5,
    (SUM(CASE stars WHEN 3.5 THEN 1 ELSE 0 END) / COUNT(state)) as rate_3_5,
    SUM(CASE stars WHEN 3.0 THEN 1 ELSE 0 END) as sum_3,
    (SUM(CASE stars WHEN 3.0 THEN 1 ELSE 0 END) / COUNT(state)) as rate_3,
    SUM(CASE stars WHEN 2.5 THEN 1 ELSE 0 END) as sum_2_5,
    (SUM(CASE stars WHEN 2.5 THEN 1 ELSE 0 END) / COUNT(state)) as rate_2_5,
    SUM(CASE stars WHEN 2.0 THEN 1 ELSE 0 END) as sum_2,
    (SUM(CASE stars WHEN 2.0 THEN 1 ELSE 0 END) / COUNT(state)) as rate_2,
    SUM(CASE stars WHEN 1.5 THEN 1 ELSE 0 END) as sum_1_5,
    (SUM(CASE stars WHEN 1.5 THEN 1 ELSE 0 END) / COUNT(state)) as rate_1_5,
    SUM(CASE stars WHEN 1.0 THEN 1 ELSE 0 END) as sum_1,
    (SUM(CASE stars WHEN 1.0 THEN 1 ELSE 0 END) / COUNT(state)) as rate_1
FROM
    yelp_business
GROUP BY
    state
ORDER BY
    count_state DESC;

## 3)
-- Calculate the number of open days for each business.
with open_days as 
(SELECT
    business_id,
    (
        (CASE WHEN monday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN tuesday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN wednesday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN thursday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN friday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN saturday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN sunday = 'None' THEN 0 ELSE 1 END)
    ) AS open_days
FROM
    yelp_business_hours)
SELECT * FROM open_days;

-- Calculate the count of businesses with different star ratings
-- based on the number of open days.
with open_days as 
(SELECT
    business_id,
    (
        (CASE WHEN monday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN tuesday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN wednesday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN thursday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN friday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN saturday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN sunday = 'None' THEN 0 ELSE 1 END)
    ) AS open_days
FROM
    yelp_business_hours)
SELECT
    open_days.open_days,
    SUM(CASE yelp_business.stars WHEN 5.0 THEN 1 ELSE 0 END) as sum_5,
    SUM(CASE yelp_business.stars WHEN 4.5 THEN 1 ELSE 0 END) as sum_4_5,
    SUM(CASE yelp_business.stars WHEN 4.0 THEN 1 ELSE 0 END) as sum_4,
    SUM(CASE yelp_business.stars WHEN 3.5 THEN 1 ELSE 0 END) as sum_3_5,
    SUM(CASE yelp_business.stars WHEN 3.0 THEN 1 ELSE 0 END) as sum_3,
    SUM(CASE yelp_business.stars WHEN 2.5 THEN 1 ELSE 0 END) as sum_2_5,
    SUM(CASE yelp_business.stars WHEN 2.0 THEN 1 ELSE 0 END) as sum_2,
    SUM(CASE yelp_business.stars WHEN 1.5 THEN 1 ELSE 0 END) as sum_1_5,
    SUM(CASE yelp_business.stars WHEN 1.0 THEN 1 ELSE 0 END) as sum_1
FROM
    yelp_business
LEFT JOIN
    open_days
ON
    yelp_business.business_id = open_days.business_id
GROUP BY
    open_days.open_days;


## 4）
-- Calculate the average number of open days and the average star rating
-- for businesses that are not open (is_open = 0).
CREATE TABLE open_days as 
(SELECT
    business_id,
    (
        (CASE WHEN monday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN tuesday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN wednesday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN thursday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN friday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN saturday = 'None' THEN 0 ELSE 1 END) +
        (CASE WHEN sunday = 'None' THEN 0 ELSE 1 END)
    ) AS open_days
FROM
    yelp_business_hours);
    
SELECT
    ROUND(AVG(open_days.open_days), 1) as avg_open,
    ROUND(AVG(yelp_business.stars), 2) as avg_stars
FROM
    yelp_business
LEFT JOIN
    open_days
ON
    yelp_business.business_id = open_days.business_id
WHERE
    yelp_business.is_open = 0;

# 3.
## 1)

--
SELECT year(yelping_since) as year_since, count(user_id)
FROM yelp_user
GROUP BY year(yelping_since)
ORDER BY year(yelping_since) DESC;

/*
SELECT user_id, YEAR(yelping_since) as year_since, count(user_id)
FROM yelp_user
GROUP BY YEAR(yelping_since)
ORDER BY YEAR(yelping_since) ASC
*/

-- Retrieve the count of users who joined Yelp in each year and month
-- along with their user IDs, the year they joined, and the month they joined.
SELECT
    YEAR(yelping_since) as year_since,
    MONTH(yelping_since) as month_since,
    COUNT(user_id)
FROM
    yelp_user
GROUP BY
    YEAR(yelping_since),
    MONTH(yelping_since);

SELECT YEAR(date) as year_review, count(review_id)
FROM yelp_review
GROUP BY YEAR(date)
ORDER BY YEAR(date) ASC;

## 2)
# DROP TABLE IF EXISTS elite;
CREATE TABLE elite as
SELECT user_id, elite
FROM yelp_user
WHERE elite <> "None";


-- The code is not running if I wrote this way
SELECT
	sum(CASE elite WHEN "%2004%" THEN 1 ELSE 0 END) as 2004_elite,
    sum(CASE elite WHEN "%2005%" THEN 1 ELSE 0 END) as 2005_elite,
    sum(CASE elite WHEN "%2006%" THEN 1 ELSE 0 END) as 2006_elite,
    sum(CASE elite WHEN "%2007%" THEN 1 ELSE 0 END) as 2007_elite,
    sum(CASE elite WHEN "%2008%" THEN 1 ELSE 0 END) as 2008_elite,
    sum(CASE elite WHEN "%2009%" THEN 1 ELSE 0 END) as 2009_elite,
    sum(CASE elite WHEN "%2010%" THEN 1 ELSE 0 END) as 2010_elite,
    sum(CASE elite WHEN "%2011%" THEN 1 ELSE 0 END) as 2011_elite,
    sum(CASE elite WHEN "%2012%" THEN 1 ELSE 0 END) as 2012_elite,
    sum(CASE elite WHEN "%2013%" THEN 1 ELSE 0 END) as 2013_elite,
    sum(CASE elite WHEN "%2014%" THEN 1 ELSE 0 END) as 2014_elite,
    sum(CASE elite WHEN "%2015%" THEN 1 ELSE 0 END) as 2015_elite,
    sum(CASE elite WHEN "%2016%" THEN 1 ELSE 0 END) as 2016_elite,
    sum(CASE elite WHEN "%2017%" THEN 1 ELSE 0 END) as 2017_elite
FROM elite;

-- Calculate the count of users with elite status in each year from 2004 to 2017.
SELECT
    SUM(CASE WHEN elite LIKE '%2004%' THEN 1 ELSE 0 END) as 2004_elite,
    SUM(CASE WHEN elite LIKE '%2005%' THEN 1 ELSE 0 END) as 2005_elite,
    SUM(CASE WHEN elite LIKE '%2006%' THEN 1 ELSE 0 END) as 2006_elite,
    SUM(CASE WHEN elite LIKE '%2007%' THEN 1 ELSE 0 END) as 2007_elite,
    SUM(CASE WHEN elite LIKE '%2008%' THEN 1 ELSE 0 END) as 2008_elite,
    SUM(CASE WHEN elite LIKE '%2009%' THEN 1 ELSE 0 END) as 2009_elite,
    SUM(CASE WHEN elite LIKE '%2010%' THEN 1 ELSE 0 END) as 2010_elite,
    SUM(CASE WHEN elite LIKE '%2011%' THEN 1 ELSE 0 END) as 2011_elite,
    SUM(CASE WHEN elite LIKE '%2012%' THEN 1 ELSE 0 END) as 2012_elite,
    SUM(CASE WHEN elite LIKE '%2013%' THEN 1 ELSE 0 END) as 2013_elite,
    SUM(CASE WHEN elite LIKE '%2014%' THEN 1 ELSE 0 END) as 2014_elite,
    SUM(CASE WHEN elite LIKE '%2015%' THEN 1 ELSE 0 END) as 2015_elite,
    SUM(CASE WHEN elite LIKE '%2016%' THEN 1 ELSE 0 END) as 2016_elite,
    SUM(CASE WHEN elite LIKE '%2017%' THEN 1 ELSE 0 END) as 2017_elite
FROM elite;

## 3)
-- Calculate the count of reviews posted by each user in each year from 2008 to 2017.
CREATE TABLE user_keep as
SELECT
    user_id,
    SUM(CASE WHEN YEAR(yelp_review.date) = 2008 THEN 1 ELSE 0 END) as 2008_exist,
    SUM(CASE WHEN YEAR(yelp_review.date) = 2009 THEN 1 ELSE 0 END) as 2009_exist,
    SUM(CASE WHEN YEAR(yelp_review.date) = 2010 THEN 1 ELSE 0 END) as 2010_exist,
    SUM(CASE WHEN YEAR(yelp_review.date) = 2011 THEN 1 ELSE 0 END) as 2011_exist,
    SUM(CASE WHEN YEAR(yelp_review.date) = 2012 THEN 1 ELSE 0 END) as 2012_exist,
    SUM(CASE WHEN YEAR(yelp_review.date) = 2013 THEN 1 ELSE 0 END) as 2013_exist,
    SUM(CASE WHEN YEAR(yelp_review.date) = 2014 THEN 1 ELSE 0 END) as 2014_exist,
    SUM(CASE WHEN YEAR(yelp_review.date) = 2015 THEN 1 ELSE 0 END) as 2015_exist,
    SUM(CASE WHEN YEAR(yelp_review.date) = 2016 THEN 1 ELSE 0 END) as 2016_exist,
    SUM(CASE WHEN YEAR(yelp_review.date) = 2017 THEN 1 ELSE 0 END) as 2017_exist
FROM
    yelp_review
GROUP BY
    user_id;

-- Calculate the proportion of users who posted reviews in consecutive years for each pair of years from 2008 to 2017.
SELECT
    ROUND(SUM(CASE WHEN (2008_exist <> 0 AND 2009_exist <> 0) THEN 1 ELSE 0 END) / SUM(CASE WHEN 2008_exist <> 0 THEN 1 ELSE 0 END), 2) AS exist_2009,
    ROUND(SUM(CASE WHEN (2009_exist <> 0 AND 2010_exist <> 0) THEN 1 ELSE 0 END) / SUM(CASE WHEN 2009_exist <> 0 THEN 1 ELSE 0 END), 2) AS exist_2010,
    ROUND(SUM(CASE WHEN (2010_exist <> 0 AND 2011_exist <> 0) THEN 1 ELSE 0 END) / SUM(CASE WHEN 2010_exist <> 0 THEN 1 ELSE 0 END), 2) AS exist_2011,
    ROUND(SUM(CASE WHEN (2011_exist <> 0 AND 2012_exist <> 0) THEN 1 ELSE 0 END) / SUM(CASE WHEN 2011_exist <> 0 THEN 1 ELSE 0 END), 2) AS exist_2012,
    ROUND(SUM(CASE WHEN (2012_exist <> 0 AND 2013_exist <> 0) THEN 1 ELSE 0 END) / SUM(CASE WHEN 2012_exist <> 0 THEN 1 ELSE 0 END), 2) AS exist_2013,
    ROUND(SUM(CASE WHEN (2013_exist <> 0 AND 2014_exist <> 0) THEN 1 ELSE 0 END) / SUM(CASE WHEN 2013_exist <> 0 THEN 1 ELSE 0 END), 2) AS exist_2014,
    ROUND(SUM(CASE WHEN (2014_exist <> 0 AND 2015_exist <> 0) THEN 1 ELSE 0 END) / SUM(CASE WHEN 2014_exist <> 0 THEN 1 ELSE 0 END), 2) AS exist_2015,
    ROUND(SUM(CASE WHEN (2015_exist <> 0 AND 2016_exist <> 0) THEN 1 ELSE 0 END) / SUM(CASE WHEN 2015_exist <> 0 THEN 1 ELSE 0 END), 2) AS exist_2016,
    ROUND(SUM(CASE WHEN (2016_exist <> 0 AND 2017_exist <> 0) THEN 1 ELSE 0 END) / SUM(CASE WHEN 2016_exist <> 0 THEN 1 ELSE 0 END), 2) AS exist_2017
FROM
    user_keep;

-- Calculate the proportion of users who had elite status in consecutive years for each pair of years from 2005 to 2017.
SELECT
    ROUND(SUM(CASE WHEN (elite LIKE '%2005%' AND elite LIKE '%2006%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2005%' THEN 1 ELSE 0 END), 2) AS exist_2006,
    ROUND(SUM(CASE WHEN (elite LIKE '%2006%' AND elite LIKE '%2007%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2006%' THEN 1 ELSE 0 END), 2) AS exist_2007,
    ROUND(SUM(CASE WHEN (elite LIKE '%2007%' AND elite LIKE '%2008%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2007%' THEN 1 ELSE 0 END), 2) AS exist_2008,
    ROUND(SUM(CASE WHEN (elite LIKE '%2008%' AND elite LIKE '%2009%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2008%' THEN 1 ELSE 0 END), 2) AS exist_2009,
    ROUND(SUM(CASE WHEN (elite LIKE '%2009%' AND elite LIKE '%2010%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2009%' THEN 1 ELSE 0 END), 2) AS exist_2010,
    ROUND(SUM(CASE WHEN (elite LIKE '%2010%' AND elite LIKE '%2011%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2010%' THEN 1 ELSE 0 END), 2) AS exist_2011,
    ROUND(SUM(CASE WHEN (elite LIKE '%2011%' AND elite LIKE '%2012%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2011%' THEN 1 ELSE 0 END), 2) AS exist_2012,
    ROUND(SUM(CASE WHEN (elite LIKE '%2012%' AND elite LIKE '%2013%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2012%' THEN 1 ELSE 0 END), 2) AS exist_2013,
    ROUND(SUM(CASE WHEN (elite LIKE '%2013%' AND elite LIKE '%2014%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2013%' THEN 1 ELSE 0 END), 2) AS exist_2014,
    ROUND(SUM(CASE WHEN (elite LIKE '%2014%' AND elite LIKE '%2015%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2014%' THEN 1 ELSE 0 END), 2) AS exist_2015,
    ROUND(SUM(CASE WHEN (elite LIKE '%2015%' AND elite LIKE '%2016%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2015%' THEN 1 ELSE 0 END), 2) AS exist_2016,
    ROUND(SUM(CASE WHEN (elite LIKE '%2016%' AND elite LIKE '%2017%') THEN 1 ELSE 0 END) / SUM(CASE WHEN elite LIKE '%2016%' THEN 1 ELSE 0 END), 2) AS exist_2017
FROM
    elite;
