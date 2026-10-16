-- Project: Swiggy Restaurant Data Analysis Using MySQL
-- Dataset: swiggy (1).csv
-- Note: This dataset contains restaurant listings, not transaction-level sales.

CREATE DATABASE IF NOT EXISTS swiggy_analytics;
USE swiggy_analytics;

-- Create the table before importing the CSV with MySQL Workbench's
-- Table Data Import Wizard. Map the CSV columns to these fields.
CREATE TABLE IF NOT EXISTS swiggy_restaurants (
    ID INT,
    Area VARCHAR(100),
    City VARCHAR(100),
    Restaurant VARCHAR(255),
    Price DECIMAL(10,2),
    `Avg ratings` DECIMAL(3,2),
    `Total ratings` INT,
    `Food type` TEXT,
    Address VARCHAR(500),
    `Delivery time` INT
);

-- Q1. Total number of records
SELECT COUNT(*) AS total_restaurants
FROM swiggy_restaurants;

-- Q2. List unique cities
SELECT DISTINCT City
FROM swiggy_restaurants
ORDER BY City;

-- Q3. Top 5 most expensive restaurant listings
SELECT Restaurant, City, Price
FROM swiggy_restaurants
ORDER BY Price DESC
LIMIT 5;

-- Q4. Restaurants with ratings above 4.0
SELECT Restaurant, `Avg ratings`
FROM swiggy_restaurants
WHERE `Avg ratings` > 4.0
ORDER BY `Avg ratings` DESC;

-- Q5. Average listed price
SELECT ROUND(AVG(Price), 2) AS average_listed_price
FROM swiggy_restaurants;

-- Q6. Number of restaurant listings in each city
SELECT City, COUNT(*) AS total_restaurants
FROM swiggy_restaurants
GROUP BY City
ORDER BY total_restaurants DESC;

-- Q7. Average listed price by city
SELECT City, ROUND(AVG(Price), 2) AS average_listed_price
FROM swiggy_restaurants
GROUP BY City
ORDER BY average_listed_price DESC;

-- Q8. Top 10 restaurants by total ratings
SELECT Restaurant, City, `Total ratings`
FROM swiggy_restaurants
ORDER BY `Total ratings` DESC
LIMIT 10;

-- Q9. Cities with average restaurant ratings above 4.0
SELECT City, ROUND(AVG(`Avg ratings`), 2) AS average_rating
FROM swiggy_restaurants
GROUP BY City
HAVING AVG(`Avg ratings`) > 4.0
ORDER BY average_rating DESC;

-- Q10. Average delivery time by city
SELECT City, ROUND(AVG(`Delivery time`), 2) AS avg_delivery_time
FROM swiggy_restaurants
GROUP BY City
ORDER BY avg_delivery_time ASC;

-- Q11. Rank restaurants by rating within each city
SELECT
    Restaurant,
    City,
    `Avg ratings`,
    DENSE_RANK() OVER (
        PARTITION BY City
        ORDER BY `Avg ratings` DESC
    ) AS rating_rank
FROM swiggy_restaurants;

-- Q12. Most expensive restaurant listing(s) in each city
WITH ranked_restaurants AS (
    SELECT
        Restaurant,
        City,
        Price,
        DENSE_RANK() OVER (
            PARTITION BY City
            ORDER BY Price DESC
        ) AS price_rank
    FROM swiggy_restaurants
)
SELECT City, Restaurant, Price
FROM ranked_restaurants
WHERE price_rank = 1
ORDER BY City;

-- Q13. Listings priced above their city's average
WITH city_prices AS (
    SELECT
        Restaurant,
        City,
        Price,
        AVG(Price) OVER (PARTITION BY City) AS city_avg_price
    FROM swiggy_restaurants
)
SELECT
    Restaurant,
    City,
    Price,
    ROUND(city_avg_price, 2) AS city_avg_price
FROM city_prices
WHERE Price > city_avg_price
ORDER BY City, Price DESC;

-- Q14. Highly rated restaurants with faster-than-city-average delivery
WITH delivery_analysis AS (
    SELECT
        Restaurant,
        City,
        `Avg ratings`,
        `Delivery time`,
        AVG(`Delivery time`) OVER (
            PARTITION BY City
        ) AS city_avg_delivery
    FROM swiggy_restaurants
)
SELECT Restaurant, City, `Avg ratings`, `Delivery time`
FROM delivery_analysis
WHERE `Avg ratings` >= 4.0
  AND `Delivery time` < city_avg_delivery
ORDER BY `Avg ratings` DESC;

-- Q15. Restaurant counts by listed-price category
SELECT
    CASE
        WHEN Price < 200 THEN 'Budget'
        WHEN Price < 500 THEN 'Mid-range'
        ELSE 'Premium'
    END AS price_category,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(`Avg ratings`), 2) AS average_rating
FROM swiggy_restaurants
GROUP BY price_category
ORDER BY restaurant_count DESC;
