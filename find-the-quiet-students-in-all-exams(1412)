--Question Link 
https://leetcode.com/problems/find-the-quiet-students-in-all-exams/description/

--Create and Insert Code
    -- Create Student table
    CREATE TABLE Student (
        student_id INT PRIMARY KEY,
        student_name VARCHAR(50)
    );
    
    -- Create Exam table
    CREATE TABLE Exam (
        exam_id INT,
        student_id INT,
        score INT,
        PRIMARY KEY (exam_id, student_id)
    );
    
    -- Insert data into Student table
    INSERT INTO Student (student_id, student_name) VALUES
    (1, 'Daniel'),
    (2, 'Jade'),
    (3, 'Stella'),
    (4, 'Jonathan'),
    (5, 'Will');
    
    -- Insert data into Exam table
    INSERT INTO Exam (exam_id, student_id, score) VALUES
    (10, 1, 70),
    (10, 2, 80),
    (10, 3, 90),
    (20, 1, 80),
    (30, 1, 70),
    (30, 3, 80),
    (30, 4, 90),
    (40, 1, 60),
    (40, 2, 70),
    (40, 4, 80);

--Solution 
    WITH ExamExtremes AS (
        SELECT 
            exam_id,
            student_id,
            ROW_NUMBER() OVER (PARTITION BY exam_id ORDER BY score DESC) AS is_max_score,
            ROW_NUMBER() OVER (PARTITION BY exam_id ORDER BY score ASC) AS is_min_score
        FROM Exam
    ),
    
    NonQuietStudents AS (
        SELECT DISTINCT student_id
        FROM ExamExtremes
        WHERE is_max_score = 1 OR is_min_score = 1
    )
    
    SELECT 
        s.student_id,
        s.student_name
    FROM Student s
    JOIN Exam e ON s.student_id = e.student_id
    WHERE s.student_id NOT IN (SELECT student_id FROM NonQuietStudents)
    GROUP BY s.student_id, s.student_name
    ORDER BY s.student_id;
