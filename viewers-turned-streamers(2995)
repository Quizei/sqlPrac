--Question Link 
https://leetcode.com/problems/viewers-turned-streamers/description/

-- Create the Sessions table
CREATE TABLE Sessions (
    user_id INT,
    session_start DATETIME,
    session_end DATETIME,
    session_id INT UNIQUE,
    session_type ENUM('Viewer', 'Streamer')
);

-- Insert the sample data
    INSERT INTO Sessions (user_id, session_start, session_end, session_id, session_type) VALUES
    (101, '2023-11-06 13:53:42', '2023-11-06 14:05:42', 375, 'Viewer'),
    (101, '2023-11-22 16:45:21', '2023-11-22 20:39:21', 594, 'Streamer'),
    (102, '2023-11-16 13:23:09', '2023-11-16 16:10:09', 777, 'Streamer'),
    (102, '2023-11-17 13:23:09', '2023-11-17 16:10:09', 778, 'Streamer'),
    (101, '2023-11-20 07:16:06', '2023-11-20 08:33:06', 315, 'Streamer'),
    (104, '2023-11-27 03:10:49', '2023-11-27 03:30:49', 797, 'Viewer'),
    (103, '2023-11-27 03:10:49', '2023-11-27 03:30:49', 798, 'Streamer');


--Solution
    WITH cte AS (
        SELECT *,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY session_start) AS rnk
        FROM Sessions
    ),
    cte2 AS (
        SELECT * FROM cte
        WHERE user_id IN (SELECT user_id FROM cte WHERE rnk = 1 AND session_type = 'Viewer')
    )
    
    SELECT 
        user_id, 
        COUNT(*) AS session_count 
    FROM cte2
    WHERE session_type = 'Streamer'
    GROUP BY user_id
    ORDER BY session_count DESC, user_id DESC;


