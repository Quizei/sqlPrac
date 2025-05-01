--Question 
https://leetcode.com/problems/find-overlapping-shifts-ii/description/

--Create and Insert Query
    -- Create EmployeeShifts table
    
    CREATE TABLE EmployeeShifts (
        employee_id INT,
        start_time timestamp,
        end_time timestamp,
        PRIMARY KEY (employee_id, start_time)
    );
    
    -- Insert sample data
    INSERT INTO EmployeeShifts (employee_id, start_time, end_time) VALUES
    -- Employee 1 (3 overlapping shifts)
    (1, '2023-10-01 09:00:00', '2023-10-01 17:00:00'),
    (1, '2023-10-01 15:00:00', '2023-10-01 23:00:00'),
    (1, '2023-10-01 16:00:00', '2023-10-02 00:00:00'),
    
    -- Employee 2 (2 overlapping shifts)
    (2, '2023-10-01 09:00:00', '2023-10-01 17:00:00'),
    (2, '2023-10-01 11:00:00', '2023-10-01 19:00:00'),
    
    -- Employee 3 (no overlaps)
    (3, '2023-10-01 09:00:00', '2023-10-01 17:00:00');


--Solution 
    WITH overlapping_shifts AS (
        SELECT 
            l.employee_id,
            l.end_time - r.start_time AS overlap_duration
        FROM EmployeeShifts l
        INNER JOIN EmployeeShifts r
            ON l.employee_id = r.employee_id
            AND l.start_time < r.start_time
            AND l.end_time > r.start_time
    ),
    
    employee_overlaps AS (
        SELECT 
            employee_id,
            COUNT(*) AS overlapping_shift_count,
            SUM(overlap_duration) AS total_overlap_time
        FROM overlapping_shifts
        GROUP BY employee_id
    )
    
    SELECT 
        e.employee_id,
        COALESCE(o.overlapping_shift_count, 0) AS max_overlapping_shifts,
        EXTRACT(HOUR FROM COALESCE(o.total_overlap_time, '00:00:00'::interval)) AS total_overlap_hours
    FROM 
        (SELECT DISTINCT employee_id FROM EmployeeShifts) e
    LEFT JOIN 
        employee_overlaps o ON e.employee_id = o.employee_id
    ORDER BY 
        e.employee_id;
