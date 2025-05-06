--Question
--https://leetcode.com/problems/students-report-by-geography/description/

--Create and Insert Statement 
        CREATE TABLE IF NOT EXISTS Student (
            name VARCHAR(50),
            continent VARCHAR(7)
        );

        TRUNCATE TABLE Student;

        INSERT INTO Student (name, continent)
        VALUES
            ('Jane', 'America'),
            ('Pascal', 'Europe'),
            ('Xi', 'Asia'),
            ('Jack', 'America');


--Solution 
        WITH cte AS (
            SELECT
                name,
                continent,
                ROW_NUMBER() OVER(PARTITION BY continent ORDER BY name) AS id
            FROM Student
        ),
        ids AS (
            SELECT DISTINCT id FROM cte
        )

        SELECT 
            a.name AS America,
            e.name AS Europe,
            s.name AS Asia
        FROM ids l
        LEFT JOIN (SELECT name, id FROM cte WHERE continent = 'America') a ON l.id = a.id
        LEFT JOIN (SELECT name, id FROM cte WHERE continent = 'Europe') e ON l.id = e.id
        LEFT JOIN (SELECT name, id FROM cte WHERE continent = 'Asia') s ON l.id = s.id
        ORDER BY l.id;

