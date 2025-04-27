--Question 
https://leetcode.com/problems/customers-with-strictly-increasing-purchases/description/

--Create and Insert Statement 
    CREATE TABLE Orders (
        order_id INT PRIMARY KEY,
        customer_id INT,
        order_date DATE,
        price INT
    );
    INSERT INTO Orders VALUES
    (1, 1, '2019-07-01', 1100),
    (2, 1, '2019-11-01', 1200),
    (3, 1, '2020-05-26', 3000),
    (4, 1, '2021-08-31', 3100),
    (5, 1, '2022-12-07', 4700),
    (6, 2, '2015-01-01', 700),
    (7, 2, '2017-11-07', 1000),
    (8, 2, '2018-01-01', 800),
    (9, 2, '2018-05-01', 900),
    (10, 2, '2019-01-01', 950),
    (11, 2, '2020-01-01', 1000),
    (12, 3, '2017-01-01', 900),
    (13, 3, '2018-11-07', 900),
    (14, 3, '2019-05-01', 800),
    (15, 4, '2020-01-01', 500),
    (16, 4, '2020-06-01', 600),
    (17, 4, '2021-01-01', 700),
    (18, 4, '2022-01-01', 650),
    (19, 5, '2018-01-01', 1000),
    (20, 5, '2019-01-01', 0),
    (21, 5, '2020-01-01', 1100),
    (22, 5, '2021-01-01', 1200),
    (23, 6, '2022-01-01', 500),
    (24, 6, '2022-06-01', 500);

--Solution 
    WITH yearly_totals AS (
        SELECT 
            customer_id, 
            EXTRACT(YEAR FROM order_date) AS year_p, 
            SUM(price) AS yearly_sum
        FROM Orders 
        GROUP BY customer_id, EXTRACT(YEAR FROM order_date)
        ORDER BY customer_id, EXTRACT(YEAR FROM order_date)
    ),
    
    yearly_comparison AS (
        SELECT 
            *,
            yearly_sum - LAG(yearly_sum, 1) OVER (PARTITION BY customer_id ORDER BY year_p) AS diff,
            CASE WHEN 
                yearly_sum - LAG(yearly_sum, 1) OVER (PARTITION BY customer_id ORDER BY year_p) > 0 
                OR LAG(yearly_sum, 1) OVER (PARTITION BY customer_id ORDER BY year_p) IS NULL
            THEN 1 ELSE 0 END AS is_increasing
        FROM yearly_totals
    ),
    
    customers_with_decreases AS (
        SELECT DISTINCT customer_id
        FROM yearly_comparison
        WHERE is_increasing = 0 AND diff IS NOT NULL
    )
    
    SELECT DISTINCT customer_id
    FROM Orders
    WHERE customer_id NOT IN (SELECT customer_id FROM customers_with_decreases)
    ORDER BY customer_id;
