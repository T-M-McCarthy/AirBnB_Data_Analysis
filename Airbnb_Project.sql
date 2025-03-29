USE airbnb_data;

-- Check the table to identify any errors/null values/incorrect information
SELECT * 
FROM airbnb_info
ORDER BY name;

-- Change column names to be in the same format
ALTER TABLE airbnb_info
CHANGE COLUMN `NAME` `name` TEXT;

ALTER TABLE airbnb_info
CHANGE COLUMN host_identity_verified `host identity verified` VARCHAR(255);

ALTER TABLE airbnb_info
CHANGE COLUMN instant_bookable `instant bookable` VARCHAR(255);

ALTER TABLE airbnb_info
CHANGE COLUMN cancellation_policy `cancellation policy` VARCHAR(255);

ALTER TABLE airbnb_info
CHANGE COLUMN house_rules `house rules` TEXT;

-- Convert 'price' column to DECIMAL for numerical operations
ALTER TABLE airbnb_info 
MODIFY COLUMN price DECIMAL(10,2);

-- Convert 'service fee' column to DECIMAL for numerical operations
ALTER TABLE airbnb_info 
MODIFY COLUMN `service fee` DECIMAL(10,2);

-- Clean 'price' column: Remove '$' and ',' to ensure numerical format
UPDATE airbnb_info 
SET price = CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2))
WHERE price REGEXP '[0-9]';

-- Clean 'service fee' column: Remove '$' and ',' to ensure numerical format
UPDATE airbnb_info 
SET `service fee` = CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2))
WHERE `service fee` REGEXP '[0-9]';

-- Identify how many null/blank space values there are for each column
SELECT 
    COUNT(CASE WHEN `id` IS NULL OR `id` = '' THEN 1 END) AS missing_id,
    COUNT(CASE WHEN `NAME` IS NULL OR `NAME` = '' THEN 1 END) AS missing_name,
    COUNT(CASE WHEN `host id` IS NULL OR `host id` = '' THEN 1 END) AS missing_host_id,
    COUNT(CASE WHEN `host identity verified` IS NULL OR `host identity verified` = '' THEN 1 END) AS missing_verified_identity,
    COUNT(CASE WHEN `host name` IS NULL OR `host name` = '' THEN 1 END) AS missing_host_name,
    COUNT(CASE WHEN `neighbourhood group` IS NULL OR `neighbourhood group` = '' THEN 1 END) AS missing_neighbourhood_group,
    COUNT(CASE WHEN `neighbourhood` IS NULL OR `neighbourhood` = '' THEN 1 END) AS missing_neighbourhood,
    COUNT(CASE WHEN `lat` IS NULL OR `lat` = '' THEN 1 END) AS missing_lat,
    COUNT(CASE WHEN `long` IS NULL OR `long` = '' THEN 1 END) AS missing_long,
    COUNT(CASE WHEN `country` IS NULL OR `country` = '' THEN 1 END) AS missing_country,
    COUNT(CASE WHEN `country code` IS NULL OR `country code` = '' THEN 1 END) AS missing_country_code,
    COUNT(CASE WHEN `instant bookable` IS NULL OR `instant bookable` = '' THEN 1 END) AS missing_instant_bookable,
    COUNT(CASE WHEN `cancellation policy` IS NULL OR `cancellation policy` = '' THEN 1 END) AS missing_cancellation_policy,
    COUNT(CASE WHEN `room type` IS NULL OR `room type` = '' THEN 1 END) AS missing_room_type,
    COUNT(CASE WHEN `Construction year` IS NULL OR `Construction year` = '' THEN 1 END) AS missing_construction_year,
    COUNT(CASE WHEN `price` IS NULL THEN 1 END) AS missing_price,
    COUNT(CASE WHEN `service fee` IS NULL THEN 1 END) AS missing_service_fee,
    COUNT(CASE WHEN `minimum nights` IS NULL OR `minimum nights` = '' THEN 1 END) AS missing_minimum_nights,
    COUNT(CASE WHEN `number of reviews` IS NULL OR `number of reviews` = '' THEN 1 END) AS missing_number_of_reviews,
    COUNT(CASE WHEN `last review` IS NULL OR `last review` = '' THEN 1 END) AS missing_last_review,
    COUNT(CASE WHEN `reviews per month` IS NULL OR `reviews per month` = '' THEN 1 END) AS missing_reviews_per_month,
    COUNT(CASE WHEN `review rate number` IS NULL OR `review rate number` = '' THEN 1 END) AS missing_review_rate_number,
    COUNT(CASE WHEN `calculated host listings count` IS NULL OR `calculated host listings count` = '' THEN 1 END) AS missing_calculated_host_listings_count,
    COUNT(CASE WHEN `availability 365` IS NULL OR `availability 365` = '' THEN 1 END) AS missing_availability_365,
    COUNT(CASE WHEN `house rules` IS NULL OR `house rules` = '' THEN 1 END) AS missing_house_rules
FROM 
    airbnb_info;

-- Remove missing license column from table (no information for any row) * set integer values to ' -1 ' that had no information *
ALTER TABLE airbnb_info
DROP COLUMN `license`;

-- Filling missing values for each column 
UPDATE airbnb_info
SET `name` = 'Not Verified'
WHERE `name` is NULL OR `name` = '';

UPDATE airbnb_info
SET `host identity verified` = 'Not Verified'
WHERE `host identity verified` is NULL OR `host identity verified` = '';

UPDATE airbnb_info
SET `host name` = 'Not Verified'
WHERE `host name` is NULL OR `host name` = '';

UPDATE airbnb_info
SET `neighbourhood group` = 'Not Verified'
WHERE `neighbourhood group` is NULL OR `neighbourhood group` = '';

UPDATE airbnb_info
SET `country` = 'Not Verified'
WHERE `country` IS NULL OR `country` = '';

UPDATE airbnb_info
SET `country code` = 'Not Verified'
WHERE `country code` IS NULL OR `country code` = '';

UPDATE airbnb_info
SET `instant bookable` = 'Not Verified'
WHERE `instant bookable` IS NULL OR `instant bookable` = '';

UPDATE airbnb_info
SET `cancellation policy` = 'Not Verified'
WHERE `cancellation policy` IS NULL OR `cancellation policy` = '';

UPDATE airbnb_info
SET `number of reviews` = -1
WHERE `number of reviews` IS NULL OR `number of reviews` = '';

UPDATE airbnb_info
SET `last review` = 'Not Verified'
WHERE `last review` IS NULL OR `last review` = '';

UPDATE airbnb_info
SET `reviews per month` = 'Not Verified'
WHERE `reviews per month` IS NULL OR `reviews per month` = '';

UPDATE airbnb_info
SET `availability 365` = -1
WHERE `availability 365` IS NULL OR `availability 365` = '';

UPDATE airbnb_info
SET `house rules` = 'Not Verified'
WHERE `house rules` IS NULL OR `house rules` = '';

-- Identify Duplicate Listings by Name, Host Name, Neighborhood
SELECT name, `host name`, neighbourhood, COUNT(*) AS duplicates
FROM airbnb_info
GROUP BY name, `host name`, neighbourhood
HAVING COUNT(*) > 1;

-- Identifies 10 most expensive listings 
SELECT name, `host name`, neighbourhood, price
FROM airbnb_info
ORDER BY price DESC
LIMIT 10;

-- Average price by neighbourhood 
SELECT neighbourhood, 
       AVG(price) AS avg_price
FROM airbnb_info
GROUP BY neighbourhood
ORDER BY avg_price DESC;

-- Identifies number of listings in each price range
SELECT 
    CASE 
        WHEN price < 50 THEN 'Under $50'
        WHEN price BETWEEN 50 AND 100 THEN '$50 - $100'
        WHEN price BETWEEN 101 AND 200 THEN '$101 - $200'
        WHEN price BETWEEN 201 AND 500 THEN '$201 - $500'
        ELSE 'Over $500'
    END AS price_range, 
    COUNT(*) AS listings
FROM airbnb_info
WHERE price IS NOT null
GROUP BY price_range
ORDER BY listings DESC;

-- Top 10 Reviewed Listings
SELECT name, `host name`, neighbourhood, `number of reviews`
FROM airbnb_info
WHERE `number of reviews` > 0
ORDER BY `number of reviews` DESC
LIMIT 10;


