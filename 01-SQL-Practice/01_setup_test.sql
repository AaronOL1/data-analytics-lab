/*
Data Analysis Lab - Exercise 01
Author: Aaron
Date: 2026-01-27
Description: Basic selection sample to verify GitHub workflow.
*/

-- 1. Create a dummy table for testing
CREATE TABLE #TestTable (
    ID INT,
    Description NVARCHAR(50)
);

-- 2. Insert test data
INSERT INTO #TestTable (ID, Description)
VALUES (1, 'Hello GitHub'),
       (2, 'SQL Server Connected');

-- 3. Select data to verify
SELECT * FROM #TestTable;