--Question
https://leetcode.com/problems/top-three-wineries/description/

--Create and Insert Statement 
    -- Create Sessions table
    CREATE TABLE Sessions (
        id INT PRIMARY KEY,
        country VARCHAR(50),
        points INT,
        winery VARCHAR(50)
    );
    
    -- Insert sample data
    INSERT INTO Sessions (id, country, points, winery) VALUES
    (103, 'Australia', 84, 'WhisperingPines'),
    (737, 'Australia', 85, 'GrapesGalore'),
    (848, 'Australia', 100, 'HarmonyHill'),
    (222, 'Hungary', 60, 'MoonlitCellars'),
    (116, 'USA', 47, 'RoyalVines'),
    (124, 'USA', 45, 'Eagle''sNest'),
    (648, 'India', 69, 'SunsetVines'),
    (894, 'USA', 39, 'RoyalVines'),
    (677, 'USA', 9, 'PacificCrest');


--Solution 
    WITH ranked_wineries AS (
        SELECT *,
               RANK() OVER (PARTITION BY country ORDER BY points DESC, winery) AS rank
        FROM Sessions
    ),
    
    top1 AS (
        SELECT country, CONCAT(winery, ' (', points::VARCHAR, ')') AS winery_info
        FROM ranked_wineries
        WHERE rank = 1
    ),
    
    top2 AS (
        SELECT country, CONCAT(winery, ' (', points::VARCHAR, ')') AS winery_info
        FROM ranked_wineries
        WHERE rank = 2
    ),
    
    top3 AS (
        SELECT country, CONCAT(winery, ' (', points::VARCHAR, ')') AS winery_info
        FROM ranked_wineries
        WHERE rank = 3
    )
    
    SELECT DISTINCT
        s.country,
        COALESCE(top1.winery_info, 'No first winery') AS top_winery,
        COALESCE(top2.winery_info, 'No second winery') AS second_winery,
        COALESCE(top3.winery_info, 'No third winery') AS third_winery
    FROM Sessions s
    LEFT JOIN top1 ON s.country = top1.country
    LEFT JOIN top2 ON s.country = top2.country
    LEFT JOIN top3 ON s.country = top3.country
    ORDER BY s.country;
