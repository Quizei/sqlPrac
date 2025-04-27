--Question 
https://leetcode.com/problems/longest-winning-streak/description/


--Create and Insert Statement 
    CREATE TABLE Matches (
        player_id INT,
        match_day DATE,
        result VARCHAR(10)
    );
    
    INSERT INTO Matches (player_id, match_day, result) VALUES
    (1, '2022-01-01', 'Win'),
    (1, '2022-01-02', 'Win'),
    (1, '2022-01-04', 'Win'),
    (1, '2022-01-05', 'Lose'),
    (1, '2022-01-06', 'Win'),
    (1, '2022-01-07', 'Win'),
    (1, '2022-01-08', 'Win'),
    (1, '2022-01-10', 'Win'),
    
    (2, '2022-01-01', 'Draw'),
    (2, '2022-01-02', 'Win'),
    (2, '2022-01-03', 'Win'),
    (2, '2022-01-05', 'Lose'),
    (2, '2022-01-07', 'Win'),
    (2, '2022-01-08', 'Win'),
    (2, '2022-01-09', 'Draw'),
    
    (3, '2022-01-01', 'Lose'),
    (3, '2022-01-02', 'Lose'),
    (3, '2022-01-03', 'Win'),
    (3, '2022-01-04', 'Win'),
    (3, '2022-01-10', 'Win'),
    (3, '2022-01-11', 'Win'),
    (3, '2022-01-13', 'Win'),
    
    (4, '2022-01-01', 'Win');


--Solution 
    WITH cte1 AS (
        SELECT *,
            LAG(match_day, 1, match_day) OVER (PARTITION BY player_id, result ORDER BY match_day) AS prev_day,
            match_day - LAG(match_day, 1, match_day) OVER (PARTITION BY player_id, result ORDER BY match_day) AS diff
        FROM Matches
    ),
    cte2 AS (
        SELECT *,
            CASE WHEN diff = 0 THEN 1 ELSE 0 END AS cnt
        FROM cte1
    ),
    cte3 AS (
        SELECT *,
            SUM(cnt) OVER (PARTITION BY player_id ORDER BY match_day) AS cnt_2
        FROM cte2
    ),
    cte4 AS (
        SELECT *,
            COUNT(*) OVER (PARTITION BY player_id, result, cnt_2) AS final_cnt
        FROM cte3
        WHERE result = 'Win'
    )
    
    SELECT 
        l.player_id, 
        COALESCE(MAX(r.final_cnt), 0) AS longest_streak
    FROM Matches AS l
    LEFT JOIN cte4 AS r 
        ON l.player_id = r.player_id
    GROUP BY l.player_id
    ORDER BY l.player_id;
