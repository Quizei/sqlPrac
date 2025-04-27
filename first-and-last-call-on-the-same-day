--Question 
https://leetcode.com/problems/first-and-last-call-on-the-same-day/description/


--Create and Insert Query
-- Create Calls table
    CREATE TABLE Calls (
        caller_id INT,
        recipient_id INT,
        call_time DATETIME,
        PRIMARY KEY (caller_id, recipient_id, call_time)
    );
    
    -- Insert sample data
    INSERT INTO Calls (caller_id, recipient_id, call_time) VALUES
    (8, 4, '2021-08-24 17:46:07'),
    (4, 8, '2021-08-24 19:57:13'),
    (5, 1, '2021-08-11 05:28:44'),
    (8, 3, '2021-08-17 04:04:15'),
    (11, 3, '2021-08-17 13:07:00'),
    (8, 11, '2021-08-17 22:22:22');


--Solution Query
    WITH call_bounds_per_day AS (
        SELECT 
            DATE(call_time) AS call_date,
            MIN(call_time) AS first_call_time,
            MAX(call_time) AS last_call_time
        FROM Calls
        GROUP BY DATE(call_time)
    ),
    
    first_and_last_calls AS (
        SELECT * FROM Calls
        WHERE 
            (DATE(call_time), call_time) IN (
                SELECT call_date, first_call_time FROM call_bounds_per_day
            )
            OR 
            (DATE(call_time), call_time) IN (
                SELECT call_date, last_call_time FROM call_bounds_per_day
            )
    ),
    
    opposite_direction_matches AS (
        SELECT l.caller_id
        FROM first_and_last_calls l
        INNER JOIN first_and_last_calls r
            ON l.caller_id = r.recipient_id
            AND r.caller_id = l.recipient_id
            AND DATE(l.call_time) = DATE(r.call_time)
    ),
    
    same_direction_matches AS (
        SELECT l.caller_id
        FROM first_and_last_calls l
        INNER JOIN first_and_last_calls r
            ON l.caller_id = r.caller_id
            AND l.recipient_id = r.recipient_id
            AND DATE(l.call_time) = DATE(r.call_time)
            AND l.call_time <> r.call_time
    ),
    
    single_call_users AS (
        SELECT caller_id
        FROM Calls
        WHERE 
            (DATE(call_time), call_time) IN (
                SELECT call_date, first_call_time FROM call_bounds_per_day
            )
            AND 
            (DATE(call_time), call_time) IN (
                SELECT call_date, last_call_time FROM call_bounds_per_day
            )
        
        UNION ALL
    
        SELECT recipient_id
        FROM Calls
        WHERE 
            (DATE(call_time), call_time) IN (
                SELECT call_date, first_call_time FROM call_bounds_per_day
            )
            AND 
            (DATE(call_time), call_time) IN (
                SELECT call_date, last_call_time FROM call_bounds_per_day
            )
    )
    
    SELECT DISTINCT caller_id AS user_id FROM opposite_direction_matches
    UNION
    SELECT DISTINCT caller_id FROM same_direction_matches
    UNION
    SELECT DISTINCT caller_id FROM single_call_users
    ORDER BY user_id;
