CREATE DATABASE electronics_db;

USE electronics_db;

SET
    SQL_SAFE_UPDATES = 0;

SELECT
    *
FROM
    electronicsdata;

TRUNCATE TABLE electronicsdata;

USE electronics_db;

SET
    SQL_SAFE_UPDATES = 0;

SELECT
    *
FROM
    electronicsdata;

TRUNCATE TABLE electronicsdata;

LOAD data INFILE "C:/Users/Mudit PC/OneDrive/Desktop/Data analytics projects/Campusx Data Analytics project/EDA Using SQL/ElectronicsData.csv" 
INTO TABLE electronics_db.electronicsdata 
FIELDS TERMINATED by ',' 
ENCLOSED by '"' LINES 
TERMINATED BY '\r\n' 
IGNORE 1 ROWS;

DESCRIBE electronicsdata;

-- Cleaning of data --
SELECT
    DISTINCT LOWER(TRIM(`Sub Category`)) AS sub_category
FROM
    electronicsdata;

-- Price Column --
-- Have to handle "$" and "through" --
SELECT
    price,
    REPLACE (REPLACE (price, "$", ""), ",", "") AS cleaned_price
FROM
    electronicsdata;

UPDATE
    electronicsdata
SET
    price = REPLACE (REPLACE (price, "$", ""), ",", "");

SELECT
    price,
    (
        SUBSTRING_INDEX (REPLACE (price, '-', ''), 'through', 1) + SUBSTRING_INDEX (REPLACE (price, '-', ''), 'through', -1)
    ) / 2 AS val_with_avg
FROM
    electronicsdata;

UPDATE
    electronicsdata
SET
    price = (
        SUBSTRING_INDEX (REPLACE (price, '-', ''), 'through', 1) + SUBSTRING_INDEX (REPLACE (price, '-', ''), 'through', -1)
    ) / 2
WHERE
    price LIKE "%through%";

SELECT
    *
FROM
    electronicsdata;

IGNORE 1 ROWS;

DESCRIBE electronicsdata;

-- Cleaning of data --
SELECT
    DISTINCT LOWER(TRIM(`Sub Category`)) AS sub_category
FROM
    electronicsdata;

-- Price Column --
-- Have to handle "$" and "through" --
SELECT
    price,
    REPLACE (REPLACE (price, "$", ""), ",", "") AS cleaned_price
FROM
    electronicsdata;

UPDATE
    electronicsdata
SET
    price = REPLACE (REPLACE (price, "$", ""), ",", "");

SELECT
    price,
    (
        SUBSTRING_INDEX (REPLACE (price, '-', ''), 'through', 1) + SUBSTRING_INDEX (REPLACE (price, '-', ''), 'through', -1)
    ) / 2 AS val_with_avg
FROM
    electronicsdata;

UPDATE
    electronicsdata
SET
    price = (
        SUBSTRING_INDEX (REPLACE (price, '-', ''), 'through', 1) + SUBSTRING_INDEX (REPLACE (price, '-', ''), 'through', -1)
    ) / 2
WHERE
    price LIKE "%through%";

SELECT
    *
FROM
    electronicsdata;

-- Discount Column --
ALTER TABLE
    electronicsdata
ADD
    COLUMN discount_given varchar(255)
AFTER
    discount;

SELECT
    discount,
    CASE
        WHEN discount LIKE "%No Discount%" THEN "NO"
        ELSE "YES"
    END
FROM
    electronicsdata;

UPDATE
    electronicsdata
SET
    discount_given = CASE
        WHEN discount LIKE "%No Discount%" THEN "NO"
        ELSE "YES"
    END;

SELECT
    *
FROM
    electronicsdata;

ALTER TABLE
    electronicsdata
ADD
    COLUMN MRP DECIMAL(10, 2)
AFTER
    price;

SELECT
    price,
    discount,
    CASE
        WHEN discount LIKE "%No Discount%" THEN price
        WHEN discount LIKE "%After%" THEN ROUND(
            price + CAST(
                REGEXP_REPLACE (discount, '[^0-9.]', '') AS DECIMAL(10, 2)
            ),
            2
        )
        ELSE ROUND(price * 1.27, 2)
    END
FROM
    electronicsdata;

SELECT
    *
FROM
    electronicsdata;

UPDATE
    electronicsdata
SET
    MRP = CASE
        WHEN discount LIKE "%No Discount%" THEN price
        WHEN discount LIKE "%After%" THEN ROUND(
            price + CAST(
                REGEXP_REPLACE (discount, '[^0-9.]', '') AS DECIMAL(10, 2)
            ),
            2
        )
        ELSE ROUND(price * 1.27, 2)
    END
ALTER TABLE
    electronicsdata CHANGE COLUMN Discount Discount_type text;

SELECT
    discount_type,
    CASE
        WHEN discount_type LIKE "%No Discount%" THEN "NO Discount"
        WHEN discount_type LIKE "%After%" THEN "Flat Discount"
        WHEN discount_type LIKE "%Price Valid%" THEN "Price Validity Discount"
        ELSE "Special Discount"
    END
FROM
    electronicsdata;

UPDATE
    electronicsdata
SET
    discount_type = CASE
        WHEN discount_type LIKE "%No Discount%" THEN "NO Discount"
        WHEN discount_type LIKE "%After%" THEN "Flat Discount"
        WHEN discount_type LIKE "%Price Valid%" THEN "Price Validity Discount"
        ELSE "Special Discount"
    END;

SELECT
    *
FROM
    electronicsdata;

-- Droping currency cloumn --
ALTER TABLE
    electronicsdata DROP COLUMN currency;

SELECT
    *
FROM
    electronicsdata;

-- Cleaning of Rating column and extracting rating only --
ALTER TABLE
    electronicsdata
ADD
    COLUMN Average_Rating DECIMAL(10, 2)
AFTER
    rating;

SELECT
    rating,
    REGEXP_SUBSTR (rating, '[0-9]+(\\.[0-9]+)?')
FROM
    electronicsdata;

UPDATE
    electronicsdata
SET
    Average_Rating = REGEXP_SUBSTR (rating, '[0-9]+(\\.[0-9]+)?');

SELECT
    Rating,
    REGEXP_SUBSTR (Rating, '[0-9]+(?= reviews)')
FROM
    electronicsdata;

ALTER TABLE
    electronicsdata
ADD
    COLUMN reviews_count INT
AFTER
    Rating;

SELECT
    *
FROM
    electronicsdata;

UPDATE
    electronicsdata
SET
    reviews_count = REGEXP_SUBSTR (Rating, '[0-9]+(?= reviews)');

ALTER TABLE
    electronicsdata DROP COLUMN rating;

SELECT
    DISTINCT title
FROM
    electronicsdata;

SELECT
    *
FROM
    electronicsdata
ALTER TABLE
    electronicsdata
ADD
    COLUMN brand_name VARCHAR(255)
AFTER
    title;

SELECT
    title,
    SUBSTRING_INDEX (title, ' ', 1) AS brand_name
FROM
    electronicsdata;

UPDATE
    electronicsdata
SET
    brand_name = SUBSTRING_INDEX (title, ' ', 1);

SELECT
    DISTINCT brand_name
FROM
    electronicsdata;

UPDATE
    electronicsdata
SET
    brand_name = "Apple"
WHERE
    brand_name LIKE "%mac%"
    OR brand_name LIKE "%iPad%"
    OR brand_name LIKE "%Airpods%";

SELECT
    title,
    brand_name
FROM
    electronicsdata;

WHERE
    brand_name LIKE "%$%";

UPDATE
    electronicsdata
SET
    brand_name = "Nintendo"
WHERE
    brand_name LIKE "%$%";

SELECT
    DISTINCT brand_name
FROM
    electronicsdata;

SELECT
    *
FROM
    electronicsdata;

SELECT
    *
FROM
    electronicsdata
WHERE
    Price IS NULL;

SELECT
    *
FROM
    electronicsdata
WHERE
    brand_name = "Lorex";

DELETE FROM
    electronicsdata
WHERE
    `Sub Category` = "Home Security Systems & Cameras"
    AND brand_name = "Lorex";

--converting price to decimal --
ALTER TABLE
    electronicsdata
MODIFY
    price DECIMAL(20, 2);

-- Start of EDA --
-- Univariate Analysis (Numerical Columns) --
--1. Price Column (Null values check) --
SELECT
    count(*)
FROM
    electronicsdata
WHERE
    price IS NULL;

--2.finding min, max, avg,std of price column --
SELECT
    min(price) AS min_price,
    max(price) AS max_price,
    avg(price) AS avg_price,
    std (price) AS std_deviation
FROM
    electronicsdata;

-- Calculating Percentile --
SELECT
    price,
    MAX(percentile)
FROM
    (
        SELECT
            price,
            round(
                PERCENT_RANK() over (
                    ORDER BY
                        price
                ),
                2
            ) AS percentile
        FROM
            electronicsdata
    ) k
GROUP BY
    price;

DELIMITER / / CREATE PROCEDURE getpricebypercentile (
    IN percentilevalue DECIMAL(5, 2),
    OUT price_limit DECIMAL(10, 2)
) BEGIN
SELECT
    price INTO price_limit
FROM
    (
        SELECT
            price,
            CUME_DIST() OVER (
                ORDER BY
                    price
            ) AS percentile
        FROM
            electronicsdata
    ) t
WHERE
    percentile >= percentilevalue
ORDER BY
    percentile
LIMIT
    1;

END / / DELIMITER;

SHOW PROCEDURE STATUS
WHERE
    Db = 'electronics_db';

CALL getpricebypercentile(0.25, @q1);

CALL getpricebypercentile(0.50, @q2);

CALL getpricebypercentile(0.73, @q3);

SELECT
    @q1 AS "Quarter 1",
    @q2 AS "Median",
    @q3 AS "Quarter 3";

-- Finding Outliers --
SELECT
    *
FROM
    electronicsdata
WHERE
    price <(@q1 -1.5 *(@q3 - @q1))
    OR price > (@q1 + 1.5 *(@q3 - @q1));

-- Histogram --
SELECT
    Buckets,
    count(*)
FROM
    (
        SELECT
            price,
            CASE
                WHEN price BETWEEN 0
                AND 500 THEN '0-0.5k'
                WHEN price BETWEEN 501
                AND 1500 THEN '0.5K-1.5k'
                WHEN price BETWEEN 1501
                AND 3000 THEN '1.5k-3k'
                WHEN price BETWEEN 3001
                AND 6000 THEN '3K-6k'
                ELSE '>6K'
            END AS 'Buckets'
        FROM
            electronicsdata
    ) b
GROUP BY
    Buckets;

-- Categorical Columns --
--1. Null values check in sub category column --
SELECT
    count(*)
FROM
    electronicsdata
WHERE
    `Sub Category` IS NULL;

SELECT
    `Sub Category`,
    count(`Sub Category`) AS counts
FROM
    electronicsdata
GROUP BY
    `Sub Category`;

-- BI-Variate Analysis --
-- Numerical Columns --
SELECT
    *
FROM
    electronicsdata;

-- Scatter plot  --
SELECT
    reviews_count,
    Average_Rating
FROM
    electronicsdata;

-- Covariance --
SELECT
    ROUND(
        SUM(
            (
                Average_Rating -(
                    SELECT
                        AVG(Average_Rating)
                    FROM
                        electronicsdata
                )
            ) * (
                reviews_count - (
                    SELECT
                        AVG(reviews_count)
                    FROM
                        electronicsdata
                )
            )
        ) / (COUNT(*) - 1),
        2
    ) AS covariance
FROM
    electronicsdata;

-- Correlation --
SELECT
    ROUND(
        (
            ROUND(
                SUM(
                    (
                        Average_Rating -(
                            SELECT
                                AVG(Average_Rating)
                            FROM
                                electronicsdata
                        )
                    ) * (
                        reviews_count - (
                            SELECT
                                AVG(reviews_count)
                            FROM
                                electronicsdata
                        )
                    )
                ) / (COUNT(*) - 1),
                2
            )
        ) / (STDDEV(Average_Rating) * STDDEV(reviews_count)),
        2
    ) AS correlation
FROM
    electronicsdata;

-- Slope --
SELECT
    ROUND(
        SUM(
            (
                Average_Rating -(
                    SELECT
                        AVG(Average_Rating)
                    FROM
                        electronicsdata
                )
            ) * (
                reviews_count - (
                    SELECT
                        AVG(reviews_count)
                    FROM
                        electronicsdata
                )
            )
        ) / (
            sum(
                POWER(
                    Average_Rating - (
                        SELECT
                            AVG(Average_Rating)
                        FROM
                            electronicsdata
                    ),
                    2
                )
            )
        ),
        2
    ) AS slope
FROM
    electronicsdata;

-- Categorical - Categorical Columns --
SELECT
    brand_name,
    COUNT(DISTINCT(`Sub Category`)) AS sectors
FROM
    electronicsdata
GROUP BY
    brand_name;

-- Numerical - Categorical Columns --
SELECT
    brand_name,
    ROUND(MIN(price), 2) AS min_price,
    ROUND(MAX(price), 2) AS max_price,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(STDDEV(price), 2) AS std_deviation
FROM
    electronicsdata
GROUP BY
    brand_name;

-- Multivariate Analysis --
SELECT
    `sub category`,
    ROUND(
        SUM(
            (
                price -(
                    SELECT
                        AVG(price)
                    FROM
                        electronicsdata
                )
            ) * (
                MRP - (
                    SELECT
                        AVG(MRP)
                    FROM
                        electronicsdata
                )
            )
        ) / (COUNT(*) - 1),
        2
    ) AS covariance
FROM
    electronicsdata
GROUP BY
    `sub category`;