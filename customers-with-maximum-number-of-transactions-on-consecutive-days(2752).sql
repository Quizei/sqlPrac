--Question
--https://leetcode.com/problems/customers-with-maximum-number-of-transactions-on-consecutive-days/description/

--Create and Insert Statement
        -- Create Transactions table
        CREATE TABLE Transactions (
            transaction_id INT PRIMARY KEY,
            customer_id INT,
            transaction_date DATE,
            amount INT,
            UNIQUE (customer_id, transaction_date)
        );

        -- Insert sample data
        INSERT INTO Transactions (transaction_id, customer_id, transaction_date, amount) VALUES
        (1, 101, '2023-05-01', 100),
        (2, 101, '2023-05-02', 150),
        (3, 101, '2023-05-03', 200),
        (4, 102, '2023-05-01', 50),
        (5, 102, '2023-05-03', 100),
        (6, 102, '2023-05-04', 200),
        (7, 105, '2023-05-01', 100),
        (8, 105, '2023-05-02', 150),
        (9, 105, '2023-05-03', 200);


--Solution
        WITH cte AS (
            SELECT *,
                transaction_date - 
                INTERVAL '1 day' * RANK() OVER (
                    PARTITION BY customer_id 
                    ORDER BY transaction_date
                ) AS grp
            FROM Transactions
        ),
        cte2 AS (
            SELECT customer_id, grp, COUNT(*) AS total
            FROM cte
            GROUP BY customer_id, grp
        ),
        max_total AS (
            SELECT MAX(total) AS max_total FROM cte2
        )
        SELECT customer_id
        FROM cte2
        WHERE total = (SELECT max_total FROM max_total);
