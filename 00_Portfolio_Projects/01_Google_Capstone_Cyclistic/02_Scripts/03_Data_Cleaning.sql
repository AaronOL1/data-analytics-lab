/*
=============================================================================
PROJECT: GOOGLE CAPSTONE - CYCLISTIC BIKE SHARE
FILE: 03_Data_Cleaning.sql
AUTHOR: Aaron Olmedo
DATE: Feb 5, 2026
DESCRIPTION: Cleaning raw data.
             1. Removing double quotes ("") from all columns.
             2. Converting data types (Text -> DateTime / Float).
             3. Creating the final analysis table 'Cyclistic_Final'.
=============================================================================
*/

USE Cyclistic_2025;
GO

--1. Creata the FINAL TABLE
-- Let's create the final table, but ready to receive cleaned data.
IF OBJECT_ID('Cyclistic_Final', 'U') IS NOT NULL
    DROP TABLE Cyclistic_Final;
GO

CREATE TABLE Cyclistic_Final (
    ride_id NVARCHAR(50) PRIMARY KEY, -- Clean ID
    rideable_type NVARCHAR(50),
    started_at DATETIME2,             -- Real Date Time
    ended_at DATETIME2,               -- Real Date Time
    start_station_name NVARCHAR(MAX),
    start_station_id NVARCHAR(50),
    end_station_name NVARCHAR(MAX),
    end_station_id NVARCHAR(50),
    start_lat FLOAT,                  
    start_lng FLOAT,
    end_lat FLOAT,      
    end_lng FLOAT,       
    member_casual NVARCHAR(50),
    
    -- Extra Calculation Columns (Required by Case Study)
    ride_length_minutes FLOAT,        -- Duration in minutes
    day_of_week INT                   -- 1=Sunday, 7=Saturday
);
GO

--2. Clean and Insert Data into Cyclistic_Final TABLE
-- We use REPLACE to remove double quotes, and CAST to convert types

INSERT INTO Cyclistic_Final (
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual,
    ride_length_minutes,
    day_of_week
)

SELECT 
    REPLACE(ride_id, '"', ''),
    REPLACE(rideable_type, '"', ''),
    CAST(REPLACE(started_at, '"', '') AS DATETIME2),
    CAST(REPLACE(ended_at, '"', '') AS DATETIME2),
    REPLACE(start_station_name, '"', ''),
    REPLACE(start_station_id, '"', ''),
    REPLACE(end_station_name, '"', ''),
    REPLACE(end_station_id, '"', ''),
    CAST(REPLACE(start_lat, '"', '') AS FLOAT),
    CAST(REPLACE(start_lng, '"', '') AS FLOAT),
    CASE WHEN REPLACE(end_lat, '"', '') = '' THEN NULL ELSE CAST(REPLACE(end_lat, '"', '') AS FLOAT) END,
    CASE WHEN REPLACE(end_lng, '"', '') = '' THEN NULL ELSE CAST(REPLACE(end_lng, '"', '') AS FLOAT) END,
    REPLACE(member_casual, '"', ''),
    DATEDIFF(MINUTE,CAST(REPLACE(started_at, '"', '') AS DATETIME2), 
        CAST(REPLACE(ended_at, '"', '') AS DATETIME2)), -- Calculate Ride Length (minutes) automatically
    DATEPART(WEEKDAY,CAST(REPLACE(started_at,'"','') AS DATETIME2)) ---- Calculate Day of Week automatically 

FROM All_Trips
WHERE start_lat IS NOT NULL AND REPLACE(start_lat, '"', '') <> ''; -- removes gosth rides

GO

-- 3. FINAL VERIFICATION 
-- Check the first 10 rows of the cleaned final table

SELECT TOP 10 * FROM Cyclistic_Final;

-- Check total rows (Should be close to 5.5 million)
SELECT COUNT (*) AS Total_Rows FROM Cyclistic_Final ;
      




