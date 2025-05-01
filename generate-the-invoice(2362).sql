--Question 
https://leetcode.com/problems/generate-the-invoice/description/

--Create and Insert Statement
    -- Create Products table
    CREATE TABLE Products (
        product_id INT PRIMARY KEY,
        price INT
    );
    
    -- Create Purchases table
    CREATE TABLE Purchases (
        invoice_id INT,
        product_id INT,
        quantity INT,
        PRIMARY KEY (invoice_id, product_id)
    );
    
    -- Insert data into Products table
    INSERT INTO Products (product_id, price) VALUES
    (1, 100),
    (2, 200);
    
    -- Insert data into Purchases table
    INSERT INTO Purchases (invoice_id, product_id, quantity) VALUES
    (1, 1, 2),
    (3, 2, 1),
    (2, 2, 3),
    (2, 1, 4),
    (4, 1, 10);

--Solution 
    WITH invoice_items AS (
        SELECT 
            p.invoice_id,
            p.product_id,
            p.quantity,
            (p.quantity * pr.price) AS price
        FROM Purchases p
        JOIN Products pr ON p.product_id = pr.product_id
    ),
    invoice_ranking AS (
        SELECT 
            invoice_id,
            ROW_NUMBER() OVER (
                ORDER BY SUM(price) DESC, invoice_id ASC
            ) AS rnk
        FROM invoice_items
        GROUP BY invoice_id
    )
    SELECT 
        product_id,
        quantity,
        price
    FROM invoice_items
    WHERE invoice_id = (SELECT invoice_id FROM invoice_ranking WHERE rnk = 1)
    ORDER BY product_id;
