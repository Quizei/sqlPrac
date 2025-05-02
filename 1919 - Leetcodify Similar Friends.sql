--Question 
--http://leetcode.com/problems/leetcodify-similar-friends/description/


--Create and Insert Statement 
-- Create Listens table
        CREATE TABLE Listens (
            user_id INT,
            song_id INT,
            day DATE
        );

        -- Create Friendship table
        CREATE TABLE Friendship (
            user1_id INT,
            user2_id INT,
            PRIMARY KEY (user1_id, user2_id),
            CHECK (user1_id < user2_id)
        );

        -- Insert sample data into Listens table
        INSERT INTO Listens (user_id, song_id, day) VALUES
        (1, 10, '2021-03-15'),
        (1, 11, '2021-03-15'),
        (1, 12, '2021-03-15'),
        (2, 10, '2021-03-15'),
        (2, 11, '2021-03-15'),
        (2, 12, '2021-03-15'),
        (3, 10, '2021-03-15'),
        (3, 11, '2021-03-15'),
        (3, 12, '2021-03-15'),
        (4, 10, '2021-03-15'),
        (4, 11, '2021-03-15'),
        (4, 13, '2021-03-15'),
        (5, 10, '2021-03-16'),
        (5, 11, '2021-03-16'),
        (5, 12, '2021-03-16');

        -- Insert sample data into Friendship table
        INSERT INTO Friendship (user1_id, user2_id) VALUES
        (1, 2),
        (2, 4),
        (2, 5);


--Solution 
        WITH cte AS (
        SELECT 
            l1.user_id AS user_id,
            l2.user_id AS friend,
            l1.song_id,
            l1.day
        FROM Listens l1
        JOIN Listens l2
            ON l1.song_id = l2.song_id
        AND l1.day = l2.day
        AND l1.user_id < l2.user_id
        )
        SELECT user_id, friend
        FROM cte
        JOIN Friendship f
        ON (f.user1_id = user_id AND f.user2_id = friend)
            OR (f.user1_id = friend AND f.user2_id = user_id)
        GROUP BY user_id, friend
        HAVING COUNT(*) >= 3;
