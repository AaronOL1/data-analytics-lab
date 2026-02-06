/*
=============================================================================
PROJECT: CLINIC "VIDA NUEVA" - ANALYTICS CASE STUDY
AUTHOR: Aaron Olmedo (Data Analyst)
DATE: February 1st, 2026
FRAMEWORK: Google Data Analytics Professional Certificate (Ask, Prepare, Process, Analyze, Share)

DESCRIPTION: 
Simulation of a real-world business scenario. The Medical Director (Stakeholder) 
needs data-driven answers regarding patient flow, specialty demand, and staff performance.
=============================================================================
*/

USE Clinica_Final;
GO

/* 
PHASE 1: ASK

Context: Meeting with Dr. Roberto (Medical Director).
Problem: The clinic feels "busy" but revenue is flat. There are assumptions about 
patient demographics that need verification.

BUSINESS QUESTIONS (Objectives):
1. What is our most demanded medical specialty? (Is it Cardiology as we think?)
2. What is the real age demographic of our patients? (Dr. Roberto thinks it's mostly elderly).
3. Are "Viral" diseases consuming most of our resources?
4. Performance metrics: Which doctors are handling the highest volume?

-- (Nota personal: El Dr. Roberto se basa mucho en su intuición. 
-- Mi objetivo es validar o desmentir sus creencias con datos duros).
*/

/* 
PHASE 2: PREPARE 
Goal: Verify data availability and integrity before analysis.
*/
-- 1. Checking Patient Demographics (Do we have Age?)
-- Status: OK. 'edad' column is available.
SELECT TOP 5 * FROM PACIENTE;

-- 2. Checking Medical Staff (Do we have Specialties?)
-- Status: OK. 'especialidad' column is available.
SELECT TOP 5 * FROM MEDICO;

-- 3. Checking Transactional Data (Consultations)
-- Status: OK. Primary Keys and Foreign Keys are correctly linked.
SELECT TOP 5 * FROM CONSULTA;

/* 
PHASE 3: PROCESS 
Goal: Clean and structure data for analysis.
* Since this database was architected by me (Aaron), data integrity is guaranteed.
* No duplicates or NULL values in critical Foreign Keys.
-- (En un escenario real, aquí irían consultas de UPDATE o DELETE para limpiar NULLs).
*/

/*
PHASE 4: ANALYZE
Goal: Answer business questions (from Phase 1) with SQL queries.
*/

/** Q1. Most Demanded Medical Specialty **/
SELECT 
	M.especialidad AS Specialty,
	COUNT(C.id_consulta) AS Total_consultations,
	FORMAT((COUNT(C.id_consulta)*1.0)/(SELECT COUNT(*) FROM CONSULTA), 'P') AS Market_Share
FROM CONSULTA C
JOIN MEDICO M ON C.id_medico = M.id_medico
GROUP BY M.especialidad
ORDER BY Total_consultations DESC;

-- INSIGHTS:
-- 1. General Medicine is the leading specialty, driving 25% of total traffic.
-- 2. Diagnostic Specialty follows closely (20.45%).
-- 3. There is an evenly distributed demand (18.18% each) between General Surgery, Neurology, and Pediatrics.

-- STRATEGIC RECOMMENDATION:
-- Given that 1 in 4 patients visits General Medicine, we must ensure capacity is sufficient. 
-- Suggestion: Evaluate hiring an additional General Practitioner or extending shift hours to prevent bottlenecks.

/** Q2. Age Demographics of Patients **/
SELECT 
	CASE 
		WHEN edad < 18 THEN 'Youth (0-17)'
		WHEN edad BETWEEN 18 AND 35 THEN 'Young Adult (18-35)'
		WHEN edad BETWEEN 36 AND 60 THEN 'Adult (36-60)'
		WHEN edad > 60 THEN 'Senior (60+)'
	END AS Age_Group,
	COUNT(id_paciente) AS Total_Patients,
	FORMAT((COUNT(id_paciente)*1.0)/(SELECT COUNT(*) FROM PACIENTE), 'P') AS Market_Share
FROM PACIENTE
GROUP BY 
    CASE 
        WHEN edad < 18 THEN 'Youth (0-17)'
		WHEN edad BETWEEN 18 AND 35 THEN 'Young Adult (18-35)'
		WHEN edad BETWEEN 36 AND 60 THEN 'Adult (36-60)'
		WHEN edad > 60 THEN 'Senior (60+)'
    END
ORDER BY Total_Patients DESC;

-- INSIGHTS:
-- 1. Adults (36-60) dominate the patient base, representing 60% of total traffic.
-- 2. Young Adults (18-35) follow as the second largest segment (25%).
-- 3. Seniors (60+) account for only 10%, effectively disproving the hypothesis that our core demographic is elderly.

-- STRATEGIC RECOMMENDATION:
-- Marketing budget should pivot from "Senior Care" to "Workforce Health".
-- Specific Actions: Launch workplace wellness partnerships for the 36-60 demographic and Family Health Packages to capture the Young Adult segment.

/** Q3. Resource Consumption by Viral Diseases **/

SELECT 
	E.nombre_enfermedad AS Disease_Name,
	E.tipo AS Disease_Type,
	COUNT(C.id_consulta) AS Cases_Reported,
	FORMAT((COUNT(C.id_consulta)*1.0)/(SELECT COUNT(*) FROM CONSULTA), 'P') AS Market_Share
FROM CONSULTA C
INNER JOIN ENFERMEDAD E ON C.id_enfermedad = E.id_enfermedad
WHERE E.tipo = 'Viral'--Filtering specific request
GROUP BY E.nombre_enfermedad, E.tipo --Nota.Toda columna que se coloquen en el SELECT que no sea parte de una función de agregación debe ir en el GROUP BY
ORDER BY Cases_Reported DESC;
-- INSIGHTS:
-- 1. "Seasonal Flu" is the dominant viral case (20%+ of all clinic traffic). This is a High-Volume / Low-Risk operational load.
-- 2. "High-Contagion" cases like COVID-19 and Chickenpox are present but low volume (1 case each).

-- STRATEGIC RECOMMENDATION:
-- Operational Split: 
-- A) For Flu: Ensure stock of standard meds and fast-track triage to avoid waiting room overcrowding.
-- B) For COVID/Varicela: Despite low volume, these require strict "Isolation Protocols".
-- DATA IMPROVEMENT: Suggest adding a 'Contagion_Level' (High/Medium/Low) column to the Disease table to automate these alerts in future dashboards.


/** Q4. Doctor Performance Metrics **/

SELECT 
    M.nombre AS Doctor_Name,
    M.especialidad,
    COUNT(C.id_consulta) AS Patients_Attended
FROM CONSULTA C
JOIN MEDICO M ON C.id_medico = M.id_medico
GROUP BY M.nombre, M.especialidad
ORDER BY Patients_Attended DESC;

-- INSIGHTS:
-- 1. Dra. Michaela Quinn is the Top Performer with 11 consultations, outperforming the average doctor (who sees ~8 patients).
-- 2. CRITICAL FINDING: Comparing Query 1 and Query 4, we see that General Medicine has 11 total cases, and Dra. Quinn handled all 11. 
--    This means she is handling 100% of the department's workload alone.

-- STRATEGIC RECOMMENDATION:
-- We have a Single Point of Failure risk in General Medicine.
-- Immediate Action: Hire a support physician or a Junior Doctor to assist Dra. Quinn. 
-- If she takes sick leave or burns out, the clinic loses 25% of its operational capacity instantly.

/* 
PHASE 5: SHARE & ACT (Executive Conlusions)
SUMMARY REPORT FOR DR. ROBERTO (MEDICAL DIRECTOR):

We have successfully diagnosed the clinic's operational status. The data reveals that 
our "busyness" comes from high-volume, low-complexity cases in General Medicine, 
which are being handled by a single doctor.

KEY TAKEAWAYS:
1.  **The Bottleneck:** Dra. Quinn is at maximum capacity (100% of General Med). 
    We are one sick day away from a service failure.
    -> ACTION: Hire support immediately.

2.  **The Opportunity:** Our "Senior" patient hypothesis was wrong. Our money is in 
    the "Workforce" (Adults 36-60).
    -> ACTION: Pivot marketing to Corporate Wellness packages.

3.  **The Risk:** While low in volume, contagious diseases lack a system alert.
    -> ACTION: Implement the 'Contagion_Level' tag in the database.

NEXT STEPS:
-   Export these query results to Power BI/Tableau.
-   Build a "Daily Operations Dashboard" to monitor Dr. Quinn's load and Viral cases in real-time.
*/