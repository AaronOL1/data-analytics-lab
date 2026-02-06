/*
=============================================================================
PROJECT: GOOGLE CAPSTONE - CYCLISTIC BIKE SHARE
FILE: 02_Import_Data.sql
AUTHOR: Aaron Olmedo
DATE: Feb 5, 2026
DESCRIPTION: Bulk inserting 12 CSV files (Jan-Dec 2025) into the All_Trips table.
             
STRATEGY: STAGING TABLE
We define all columns as NVARCHAR (text) initially. 
This prevents "Type Mismatch" errors caused by date formats in the CSVs.
We will convert data types to DATETIME/FLOAT in the next cleaning step.
=============================================================================
*/

USE Cyclistic_2025;
GO

-- ==========================================================================
-- STEP 1: RESET & CREATE STAGING TABLE
-- We drop the table if it exists to ensure we start with a clean slate.
-- All columns are set to NVARCHAR(255) to accept raw data without validation errors.
-- ==========================================================================

IF OBJECT_ID('All_Trips', 'U') IS NOT NULL
    DROP TABLE All_Trips;
GO

CREATE TABLE All_Trips (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at NVARCHAR(255),        -- Stored as text to handle potential format issues
    ended_at NVARCHAR(255),          -- Stored as text
    start_station_name NVARCHAR(MAX),
    start_station_id NVARCHAR(255),
    end_station_name NVARCHAR(MAX),
    end_station_id NVARCHAR(255),
    start_lat NVARCHAR(255),         -- Stored as text
    start_lng NVARCHAR(255),         -- Stored as text
    end_lat NVARCHAR(255),
    end_lng NVARCHAR(255),
    member_casual NVARCHAR(255)
);
GO

-- ==========================================================================
-- STEP 2: BULK INSERT (JANUARY - DECEMBER 2025)
-- Source: C:\DataTemp\ (Local Staging Folder)
-- ==========================================================================

-- JANUARY
BULK INSERT All_Trips
FROM 'C:\DataTemp\202501-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

-- FEBRUARY
BULK INSERT All_Trips
FROM 'C:\DataTemp\202502-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

-- MARCH
BULK INSERT All_Trips
FROM 'C:\DataTemp\202503-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

-- APRIL
BULK INSERT All_Trips
FROM 'C:\DataTemp\202504-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

-- MAY
BULK INSERT All_Trips
FROM 'C:\DataTemp\202505-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

-- JUNE
BULK INSERT All_Trips
FROM 'C:\DataTemp\202506-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

-- JULY
BULK INSERT All_Trips
FROM 'C:\DataTemp\202507-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

-- AUGUST
BULK INSERT All_Trips
FROM 'C:\DataTemp\202508-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

-- SEPTEMBER
BULK INSERT All_Trips
FROM 'C:\DataTemp\202509-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

-- OCTOBER
BULK INSERT All_Trips
FROM 'C:\DataTemp\202510-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

-- NOVEMBER
BULK INSERT All_Trips
FROM 'C:\DataTemp\202511-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

-- DECEMBER
BULK INSERT All_Trips
FROM 'C:\DataTemp\202512-divvy-tripdata.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');


-- ==========================================================================
-- STEP 3: FINAL VERIFICATION
-- ==========================================================================
-- Check total rows loaded (Target: ~5-6 Million rows)
SELECT COUNT(*) AS Total_Trips_Loaded FROM All_Trips;

-- Preview the first 10 rows to ensure data looks correct
SELECT TOP 10 * FROM All_Trips;