--Question
--https://leetcode.com/problems/team-dominance-by-pass-success/description/

--Create and Insert Statement 
        CREATE TABLE If not exists Teams (
            player_id INT,
            team_name VARCHAR(100)
        )


        CREATE TABLE if not exists Passes (
            pass_from INT,
            time_stamp VARCHAR(5),
            pass_to INT
        )
       -- Insert into Teams
        INSERT INTO Teams (player_id, team_name) VALUES
        ('1', 'Arsenal'),
        ('2', 'Arsenal'),
        ('3', 'Arsenal'),
        ('4', 'Chelsea'),
        ('5', 'Chelsea'),
        ('6', 'Chelsea');

        -- Insert into Passes
        INSERT INTO Passes (pass_from, time_stamp, pass_to) VALUES
        ('1', '00:15', '2'),
        ('2', '00:45', '3'),
        ('3', '01:15', '1'),
        ('4', '00:30', '1'),
        ('2', '46:00', '3'),
        ('3', '46:15', '4'),
        ('1', '46:45', '2'),
        ('5', '46:30', '6');


--Solution 
        WITH cte AS (
        SELECT 
            p.*, 
            t.team_name AS pass_team,  
            t2.team_name AS receive_team,
            CASE 
            WHEN t.team_name <> t2.team_name THEN -1 
            ELSE 1 
            END AS score,
            CASE 
            WHEN time_stamp <= '45:00' THEN 1 
            ELSE 2 
            END AS half_time
        FROM Passes AS p
        INNER JOIN Teams AS t ON p.pass_from = t.player_id
        INNER JOIN Teams AS t2 ON p.pass_to = t2.player_id
        )

        SELECT 
        pass_team AS team_name, 
        half_time, 
        SUM(score) AS dominance
        FROM cte 
        GROUP BY pass_team, half_time
        ORDER BY team_name, half_time;
