/***
Project: School Management System - Analytics & Reporting
Author: Aaron Olmedo
Date: 2026-01-29
Description: Comprehensive analysis of the School Database ranging from basic student listing to complex multi-table joins for academic performance tracking.
****/

USE Colegio;
GO

/*
STEP 1: THE BASICS (Getting to know my data)
Just checking the lists of students and teachers.
*/
-- 1. List all students
SELECT * 
FROM ALUMNO;

-- 2. List all teachers, showing only Name and Specialty
SELECT nombre, apellido, especialidad 
FROM PROFESOR;

/* STEP 2: FILTERING WITH LOGIC
   Learning how to find specific data points
*/
-- 3. Exact Match: Find the Physics department
SELECT * FROM DEPARTAMENTO
WHERE nombre_departamento = 'Ciencias Exactas';

-- 4. Fuzzy Search (LIKE): Find students with Gmail accounts
SELECT nombres, apellidos, email
FROM ALUMNO
WHERE email LIKE '%gmail.com';

-- 5. Ranges (BETWEEN): Find students born between 2010 and 2012
SELECT nombres, fecha_nacimiento
FROM ALUMNO
WHERE fecha_nacimiento BETWEEN '2010-01-01' AND '2012-12-31';

/* 
STEP 3: DATA MODIFICATION
Simulating a real-world scenario where data needs correction.
*/
-- 6. Scenario: A teacher changed their phone number. Updating the record.
-- (Note: Always use WHERE to avoid updating the whole table)
UPDATE PROFESOR
SET telefono = '0998887777'
WHERE nombre = 'Albert' AND apellido = 'Einstein';

-- Verifying the change
SELECT * FROM PROFESOR WHERE apellido = 'Einstein';

/*
STEP 4: AGGREGATIONS (COUNT, SUM, GROUP BY)
Moving from lists to statistics.
*/
-- 7. How many students do we have in total?
SELECT COUNT(*) AS Total_Students FROM ALUMNO;

-- 8. What is the total budget of all departments combined?
SELECT SUM(presupuesto_anual) AS Total_Budget FROM DEPARTAMENTO;

-- 9. How many payments has each student made? (GROUP BY)
SELECT id_alumno, COUNT(*) AS Number_of_Payments
FROM PAGOS
GROUP BY id_alumno;

/* 
STEP 5: CONNECTING DATA (JOINs)
Relational Database logic.
*/
-- 10. Connecting Students with their Guardians (INNER JOIN)
SELECT 
    A.nombres AS Student, 
    R.nombre_completo AS Guardian,
    R.telefono AS Guardian_Contact
FROM ALUMNO A
INNER JOIN REPRESENTANTE R ON A.id_representante = R.id_representante;

/** 
   FINAL BOSS: THE CAPSTONE QUERY (Combining everything)
   Task: Generate a Financial Report showing Student Name, 
   Guardian Name, and Total Amount Paid, ordered by the highest payer.
**/
-- 11. Complex Report: JOIN + AGGREGATION + SORTING
SELECT 
    A.nombres AS Student_Name,
    R.nombre_completo AS Guardian,
    SUM(P.monto) AS Total_Paid
FROM PAGOS P
INNER JOIN ALUMNO A ON P.id_alumno = A.id_alumno
INNER JOIN REPRESENTANTE R ON A.id_representante = R.id_representante
GROUP BY A.nombres, R.nombre_completo
ORDER BY Total_Paid DESC;