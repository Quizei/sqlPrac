--Question 
--https://leetcode.com/problems/popularity-percentage/description/


-- Create and Insert Statement 
-- Create Friends table
        CREATE TABLE Friends (
            user1 INT,
            user2 INT,
            PRIMARY KEY (user1, user2)
        );

        -- Insert sample data
        INSERT INTO Friends (user1, user2) VALUES
        (2, 1),
        (1, 3),
        (4, 1),
        (1, 5),
        (1, 6),
        (2, 6),
        (7, 2),
        (8, 3),
        (3, 9);


--Solution 
        WITH FriendshipPairs AS (
            SELECT user1 AS user, user2 AS friend FROM Friends
            UNION ALL
            SELECT user2 AS user, user1 AS friend FROM Friends
        ),

        TotalUsers AS (
            SELECT COUNT(DISTINCT user) AS total FROM FriendshipPairs
        )

        SELECT 
            user AS user1,  
            ROUND(COUNT(DISTINCT friend) * 100.0 / (SELECT total FROM TotalUsers), 2) AS percentage_popularity
        FROM FriendshipPairs
        GROUP BY user
        ORDER BY user; 