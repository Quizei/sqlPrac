--Question
https://leetcode.com/problems/report-contiguous-dates/description/?envType=study-plan-v2&envId=premium-sql-50


--Create and Insert Statement 
    -- Create Failed table
    CREATE TABLE Failed (
        fail_date DATE PRIMARY KEY
    );
    
    -- Create Succeeded table
    CREATE TABLE Succeeded (
        success_date DATE PRIMARY KEY
    );
    
    -- Insert sample data into Failed table
    INSERT INTO Failed (fail_date) VALUES
    ('2018-12-28'),
    ('2018-12-29'),
    ('2019-01-04'),
    ('2019-01-05');
    
    -- Insert sample data into Succeeded table
    INSERT INTO Succeeded (success_date) VALUES
    ('2018-12-30'),
    ('2018-12-31'),
    ('2019-01-01'),
    ('2019-01-02'),
    ('2019-01-03'),
    ('2019-01-06');


--Solution 
    with CombinedDates  as 
    (
    	select * , 'Failed' as status from Failed 
    	union all
    	select * , 'Succeded' as status from Succeeded 
    ),
    GroupedDates as 
    (
    	select * , 
    	  extract(day from fail_date) -
    	  row_number() over (partition by status order by fail_date ) as grp from CombinedDates 
    	 where extract( year from fail_date) > 2018 
    	order by fail_date
    )
    
    select status , min(fail_date) as start , max(fail_date) as end from GroupedDates
    group by status , grp

