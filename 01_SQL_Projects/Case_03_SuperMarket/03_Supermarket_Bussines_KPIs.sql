/*
PROJECT: SUPERMARKET RETAIL ANALYSIS
FILE: 03_supermarket_exploratory.sql
AUTHOR: Aaron Olmedo
DATE: Feb 5, 2026
DESCRIPTION: Initial data exploration to understand table structures, 
             volume of data, and data quality (NULL checks).
*/

USE SUPERMERCADO;
GO

-- 1. VIEW ALL TABLES IN TEH DATA BASES
-- Quick overview of all tables in the SUPERMERCADO database available for analysis

SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- 2. CHECKING "PRODUCTOS" (Inventory)
-- Goal: See columns and sample data
SELECT TOP 10 * FROM PRODUCTO;

-- Goal: Check total products count
SELECT COUNT(*) AS Total_Products FROM PRODUCTO;

-- 3. CHECKING FACTURAS 
-- Goal: Identify the date range of our data
SELECT 
    MIN(Fecha) AS First_Sale,
    MAX(Fecha) AS Last_Sale
FROM FACTURA_CABECERA;

-- 4. CHECKING "CLIENTES"
-- Goal: Verify if we have customer demographics
SELECT TOP 10 * FROM CLIENTE;

--5. DATA QUALITY CHECKS (Nulls)
--Goal: Do we have transactions without customers?
SELECT COUNT(*) AS Oprhan_Sales
FROM FACTURA_CABECERA
WHERE Cliente_id IS NULL;

--==============================================
-- Advanced analysis focusing on Revenue, Category performance, 
-- and Customer behavior using Multi-Table JOINS.
-- =============================================
-- 6. TOTAL REVENUE & AVERAGE TICKET
SELECT 
    SUM(d.Cantidad * d.Precio) AS Total_Revenue,
    COUNT(DISTINCT d.Factura_cabecera_id) AS Total_Transactions,
    FORMAT(
        SUM(d.Cantidad * d.Precio) / COUNT(DISTINCT d.Factura_cabecera_id), 
        'C'
    ) AS Avg_Ticket_Value
FROM FACTURA_DETALLE d;

-- 7. BEST SELLING CATEGORIES 
SELECT TOP 5
    c.Nombre AS Category_Name,
    SUM(d.Cantidad) AS Units_Sold,
    SUM(d.Cantidad * d.Precio) AS Total_Revenue,
    FORMAT(
        (SUM(d.Cantidad * d.Precio) * 1.0) / (SELECT SUM(Cantidad * Precio) FROM FACTURA_DETALLE),
        'P'
    ) AS Revenue_Share
FROM FACTURA_DETALLE d
INNER JOIN PRODUCTO p ON d.Producto_id = p.Producto_id
INNER JOIN CATEGORIA c ON p.Categoria_id = c.Categoria_id
GROUP BY c.Nombre
ORDER BY Total_Revenue DESC;

-- 8. CUSTOMER SEGMENTATION BY CITY
SELECT 
    cli.Ciudad AS City,
    COUNT(DISTINCT fc.Factura_cabecera_id) AS Visit_Count,
    SUM(fd.Cantidad * fd.Precio) AS Total_Spent
FROM CLIENTE cli
JOIN FACTURA_CABECERA fc ON cli.Cliente_id = fc.Cliente_id
JOIN FACTURA_DETALLE fd ON fc.Factura_cabecera_id = fd.Factura_cabecera_id
GROUP BY cli.Ciudad
ORDER BY Total_Spent DESC;

-- 9. TOP 5 BRANDS
SELECT TOP 5
    p.Marca AS Brand,
    COUNT(DISTINCT p.Producto_id) AS Unique_Products_Sold,
    SUM(d.Cantidad * d.Precio) AS Revenue_Generated
FROM PRODUCTO p
JOIN FACTURA_DETALLE d ON p.Producto_id = d.Producto_id
GROUP BY p.Marca
ORDER BY Revenue_Generated DESC;

--10. PAYMENT METHOD ANALYSIS
SELECT 
    fp.Nombre AS Payment_Method,
    COUNT(DISTINCT fc.Factura_cabecera_id) AS Transactions_Count,
    SUM(fd.Cantidad * fd.Precio) AS Total_Processed
FROM FACTURA_CABECERA fc
JOIN FORMA_PAGO fp ON fc.Forma_pago_id = fp.Forma_pago_id
JOIN FACTURA_DETALLE fd ON fc.Factura_cabecera_id = fd.Factura_cabecera_id
GROUP BY fp.Nombre
ORDER BY Total_Processed DESC;
