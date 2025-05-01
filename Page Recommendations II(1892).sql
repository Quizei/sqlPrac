--Question 
https://leetcode.com/problems/page-recommendations-ii/description/


--Create and Insert Statement 
    -- Create Friendship table
    CREATE TABLE Friendship (
        user1_id INT,
        user2_id INT,
        PRIMARY KEY (user1_id, user2_id)
    );

    -- Create Likes table
    CREATE TABLE Likes (
        user_id INT,
        page_id INT,
        PRIMARY KEY (user_id, page_id)
    );

    -- Insert sample data into Friendship table
    INSERT INTO Friendship (user1_id, user2_id) VALUES
    (1, 2), (1, 3), (1, 4),
    (2, 3), (2, 4), (2, 5),
    (6, 1);

    -- Insert sample data into Likes table
    INSERT INTO Likes (user_id, page_id) VALUES
    (1, 88), (2, 23), (3, 24),
    (4, 56), (5, 11), (6, 33),
    (2, 77), (3, 77), (6, 88);


--Solution 
    WITH cte AS (
        SELECT user1_id AS user, user2_id AS friend FROM Friendship
        UNION 
        SELECT user2_id AS user, user1_id AS friend FROM Friendship
    ),
    cte2 AS (
        SELECT c.user AS user_id, l.page_id
        FROM cte c
        JOIN Likes l
        ON c.friend = l.user_id
        WHERE NOT EXISTS (
            SELECT 1 
            FROM Likes l2 
            WHERE l2.user_id = c.user AND l2.page_id = l.page_id
        )
    )
    SELECT user_id, page_id, COUNT(*) AS friends_likes
    FROM cte2
    GROUP BY user_id, page_id
    ORDER BY user_id, friends_likes DESC;
