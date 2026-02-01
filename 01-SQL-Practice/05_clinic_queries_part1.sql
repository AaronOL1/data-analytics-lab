/***
Project: Clinic Management System - Analytics Part 1
Author: Aaron Olmedo
Date: 2026-01-31
Description: Fundamental analysis of the Clinic Database. Moving from basic listings to multi-dimensional reporting using JOINs.
****/

USE Clinica_Final;
GO

/*
STEP 1: THE BASICS (Getting to know my data)
Checking the core entities: Patients and Diseases.
*/
-- 1. List all patients ordered by Age (Youngest to Oldest)
SELECT nombre, apellido, edad 
FROM PACIENTE
ORDER BY edad ASC;

-- 2. List all diseases categorized by Type
SELECT nombre_enfermedad, tipo 
FROM ENFERMEDAD
ORDER BY tipo;

/* 
STEP 2: FILTERING WITH LOGIC (Targeting specific segments)
*/
-- 3. Risk Analysis: Find patients older than 50
SELECT * FROM PACIENTE
WHERE edad > 50;

-- 4. Specific Search: Find all 'Viral' diseases
SELECT * FROM ENFERMEDAD
WHERE tipo = 'Viral';

/* 
STEP 3: CONNECTING DATA (The Level Up from School)
Unlike the School DB (2 tables), here we connect 3 to 4 tables at once.
*/

-- 5. The Full Picture Report (Triple INNER JOIN)
-- Let's see WHO visited, WHICH Doctor, for WHAT Sickness, and WHEN.
SELECT 
    C.id_consulta,
    C.fecha,
    P.nombre + ' ' + P.apellido AS Paciente, -- ' ' Adds space between names   
    M.nombre AS Medico,
    M.especialidad,
    E.nombre_enfermedad
FROM CONSULTA C
INNER JOIN PACIENTE P ON C.id_paciente = P.id_paciente
INNER JOIN MEDICO M ON C.id_medico = M.id_medico
INNER JOIN ENFERMEDAD E ON C.id_enfermedad = E.id_enfermedad;

/*
STEP 4: AGGREGATIONS & INSIGHTS (GROUP BY)
Answering business questions.
*/

-- 6. Demand by Specialty: Which medical area is busiest?
SELECT 
    M.especialidad,
    COUNT(*) AS Total_Consultas
FROM CONSULTA C
JOIN MEDICO M ON C.id_medico = M.id_medico
GROUP BY M.especialidad
ORDER BY Total_Consultas DESC;

-- 7. Patient Frequency: Who are our most frequent visitors?
SELECT 
    P.nombre + ' ' + P.apellido AS Paciente, -- ' ' Adds space between names
    COUNT(*) AS Visitas_Totales
FROM CONSULTA C
JOIN PACIENTE P ON C.id_paciente = P.id_paciente
GROUP BY P.nombre, P.apellido
HAVING COUNT(*) > 1 -- Only show patients who came back
ORDER BY Visitas_Totales DESC;

/** 
FINAL BOSS: COMPLEX FILTERING
   Task: Find patients under 30 who were diagnosed with a 'Viral' infection.
   Requires: JOINs + WHERE condition on multiple tables.
**/
-- 8. Pattern Recognition Query
SELECT 
    P.nombre AS Paciente_Joven,
    P.edad,
    E.nombre_enfermedad,
    M.nombre AS Diagnostico_Por
FROM CONSULTA C
JOIN PACIENTE P ON C.id_paciente = P.id_paciente
JOIN ENFERMEDAD E ON C.id_enfermedad = E.id_enfermedad
JOIN MEDICO M ON C.id_medico = M.id_medico
WHERE P.edad < 30 AND E.tipo = 'Viral';

/* BONUS TRACK: INTRODUCCIÓN A SUBCONSULTAS (Subqueries)
   Thinking inside the box. Logic: Solve the inner query first, then use that value.
*/

-- 9. SCALAR SUBQUERY (Comparación contra un promedio)
-- Pregunta: ¿Qué pacientes son mayores que el promedio de edad de la clínica?
-- Lógica: 
--    Paso 1 (Adentro): Calcular el promedio de edad (un solo número).
--    Paso 2 (Afuera): Filtrar a los que superen ese número.
SELECT 
    nombre, 
    apellido, 
    edad
FROM PACIENTE
WHERE edad > (SELECT AVG(edad) FROM PACIENTE) -- SubQuery para comparar toda la tabla con el promedio (un solo número) 
ORDER BY edad DESC;

-- 10. SUBQUERY CON 'IN' (Filtrado por lista)
-- Pregunta: ¿Qué médicos han atendido alguna vez enfermedades de tipo 'Viral'?
-- Lógica: No queremos hacer JOINS complejos, solo queremos saber los IDs.
--    Paso 1 (Adentro): Consigue la lista de IDs de médicos que aparecen en consultas virales.
--    Paso 2 (Afuera): Muéstrame los nombres de esos IDs.
SELECT 
    nombre, 
    especialidad
FROM MEDICO
WHERE id_medico IN (-- SubQuery para comparar contra una LISTA de valores (varios resultados)
    SELECT DISTINCT C.id_medico
    FROM CONSULTA C
    JOIN ENFERMEDAD E ON C.id_enfermedad = E.id_enfermedad
    WHERE E.tipo = 'Viral'
);