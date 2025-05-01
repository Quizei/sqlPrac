--Question 
  https://leetcode.com/problems/tournament-winners/editorial/


--Insert and Create Statement
-- Create Players table
        CREATE TABLE Players (
            player_id INT PRIMARY KEY,
            group_id INT NOT NULL
        );

        -- Create Matches table
        CREATE TABLE Matches (
            match_id INT PRIMARY KEY,
            first_player INT NOT NULL,
            second_player INT NOT NULL,
            first_score INT NOT NULL,
            second_score INT NOT NULL,
            FOREIGN KEY (first_player) REFERENCES Players(player_id),
            FOREIGN KEY (second_player) REFERENCES Players(player_id)
        );

        -- Insert sample data into Players table
        INSERT INTO Players (player_id, group_id) VALUES
        (15, 1),
        (25, 1),
        (30, 1),
        (45, 1),
        (10, 2),
        (35, 2),
        (50, 2),
        (20, 3),
        (40, 3);

        -- Insert sample data into Matches table
        INSERT INTO Matches (match_id, first_player, second_player, first_score, second_score) VALUES
        (1, 15, 45, 3, 0),
        (2, 30, 25, 1, 2),
        (3, 30, 15, 2, 0),
        (4, 40, 20, 5, 2),
        (5, 35, 50, 1, 1);



--Solution
        WITH PlayerScores AS (
            SELECT first_player AS player_id, first_score AS score
            FROM Matches
            
            UNION ALL
            
            SELECT 
            second_player AS player_id, second_score AS score
            FROM Matches
        ),

        PlayerTotals AS (
            SELECT 
                p.player_id, p.group_id, SUM(ps.score) AS total_score
            FROM PlayerScores ps
            JOIN Players p ON ps.player_id = p.player_id
            GROUP BY p.player_id, p.group_id
        ),

        RankedPlayers AS (
            SELECT 
                group_id, player_id,
                RANK() OVER ( PARTITION BY group_id  ORDER BY total_score DESC, player_id ASC) AS rank
            FROM PlayerTotals
        )

        SELECT 
            group_id, player_id
        FROM RankedPlayers
        WHERE rank = 1
        ORDER BY group_id;z
