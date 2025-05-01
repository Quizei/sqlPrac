--Question 
https://leetcode.com/problems/find-the-subtasks-that-did-not-execute/description/

-- Create and Insert code
-- Create Tasks table
    CREATE TABLE Tasks (
        task_id INT PRIMARY KEY,
        subtasks_count INT,
        CHECK (subtasks_count BETWEEN 2 AND 20)
    );
    
    -- Create Executed table
    CREATE TABLE Executed (
        task_id INT,
        subtask_id INT,
        PRIMARY KEY (task_id, subtask_id),
        FOREIGN KEY (task_id) REFERENCES Tasks(task_id)
    );
    
    -- Insert sample data into Tasks table
    INSERT INTO Tasks (task_id, subtasks_count) VALUES
    (1, 3),  -- Task 1 has 3 subtasks (1, 2, 3)
    (2, 2),  -- Task 2 has 2 subtasks (1, 2)
    (3, 4);  -- Task 3 has 4 subtasks (1, 2, 3, 4)
    
    -- Insert sample data into Executed table
    INSERT INTO Executed (task_id, subtask_id) VALUES
    (1, 1),  -- Task 1's subtask 1 was executed
    (1, 3),  -- Task 1's subtask 3 was executed
    (3, 1),  -- Task 3's subtask 1 was executed
    (3, 2),  -- Task 3's subtask 2 was executed
    (3, 4);  -- Task 3's subtask 4 was executed

--Solution 
    WITH RECURSIVE SubtaskGenerator AS (
        -- Base case: Get all tasks with subtask_id starting at 1
        SELECT 
            task_id, 
            subtasks_count, 
            1 AS subtask_id 
        FROM Tasks
        
        UNION ALL
        
        -- Recursive case: Increment subtask_id until reaching subtasks_count
        SELECT 
            task_id, 
            subtasks_count, 
            subtask_id + 1
        FROM SubtaskGenerator
        WHERE subtask_id < subtasks_count
    )
    
    SELECT 
        task_id, 
        subtask_id
    FROM SubtaskGenerator
    WHERE (task_id, subtask_id) NOT IN (
        SELECT task_id, subtask_id 
        FROM Executed
    )
    ORDER BY task_id, subtask_id;
