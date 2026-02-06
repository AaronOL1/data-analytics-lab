/*
=============================================================================
PROJECT: GOOGLE CAPSTONE - CYCLISTIC BIKE SHARE
FILE: 01_Create_Database_Structure.sql
AUTHOR: Aaron Olmedo
DATE: Feb 5, 2026
DESCRIPTION: Setup of the database and the main staging table for merging 
             12 months of data.
=============================================================================
*/

-- 1. Create the Database (If it doesn't exist)
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Cyclistic_2025')
BEGIN
    CREATE DATABASE Cyclistic_2025;
END
GO

USE Cyclistic_2025;
GO

-- 2. Create the Main Table 
-- We use NVARCHAR(50) for IDs to be safe, and FLOAT for Lat/Lng precision.
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[All_Trips]') AND type in (N'U'))
BEGIN
    CREATE TABLE All_Trips (
        ride_id NVARCHAR(50) NOT NULL,             -- Unique ID
        rideable_type NVARCHAR(50),                -- Bike type
        started_at DATETIME2,                      -- Start time
        ended_at DATETIME2,                        -- End time
        start_station_name NVARCHAR(MAX),          -- Station Name (MAX for long names)
        start_station_id NVARCHAR(50),             -- Station ID
        end_station_name NVARCHAR(MAX),
        end_station_id NVARCHAR(50),
        start_lat FLOAT,                           -- GPS Latitude
        start_lng FLOAT,                           -- GPS Longitude
        member_casual NVARCHAR(50)                 -- User type
    );
END
GO

-- 3. Verify Table Creation
SELECT * FROM All_Trips;