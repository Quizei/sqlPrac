--Question Link
https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company/description/


--Creating Statement
    -- Create the Candidates table
    CREATE TABLE Candidates (
        employee_id INT PRIMARY KEY,
        experience ENUM('Senior', 'Junior'),
        salary INT
    );
    
    -- Insert the example data
    INSERT INTO Candidates (employee_id, experience, salary) VALUES
    (1, 'Junior', 10000),
    (9, 'Junior', 10000),
    (2, 'Senior', 20000),
    (11, 'Senior', 20000),
    (13, 'Senior', 50000),
    (4, 'Junior', 40000);


--Solution
      WITH senior_candidates AS (
          SELECT 
              *,
              70000 - SUM(salary) OVER (PARTITION BY experience ORDER BY salary, employee_id) AS remaining_budget
          FROM Candidates 
          WHERE experience = 'Senior'
      ),
      
      junior_candidates AS (
          SELECT 
              *,
              (SELECT MIN(remaining_budget) FROM senior_candidates WHERE remaining_budget >= 0) - 
              SUM(salary) OVER (PARTITION BY experience ORDER BY salary, employee_id) AS remaining_budget
          FROM Candidates 
          WHERE experience = 'Junior'
      ),
      
      selected_candidates AS (
          SELECT * FROM senior_candidates WHERE remaining_budget >= 0
          UNION ALL 
          SELECT * FROM junior_candidates WHERE remaining_budget >= 0
      )
      
      SELECT 
          experience, 
          COUNT(*) AS accepted_candidates
      FROM selected_candidates 
      GROUP BY experience;

