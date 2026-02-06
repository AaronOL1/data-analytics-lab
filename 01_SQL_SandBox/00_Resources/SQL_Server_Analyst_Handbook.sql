/*
==========================================================================
📜 SQL SERVER ANALYST HANDBOOK (T-SQL)
👤 AUTOR: Aaron Olmedo
🎯 USO: Mi referencia rápida para importar, limpiar y analizar datos.
==========================================================================
*/
--ESTRUCTURA PRINCIPAL 
SELECT
FROM
WHERE
GROUP BY
ORDER BY
--------------------------------------------------------------------------
-- 🏗️ FASE 1: CONSTRUCCIÓN (DDL - Data Definition)
-- Antes de analizar, hay que crear el espacio.
--------------------------------------------------------------------------

-- 1. CREAR BASES DE DATOS 
-- Siempre revisa si existe antes de crear para no borrar nada por error.
IF NOT EXIST (SELECT * FROM sys.database WHERE name='Nombre_DB')
BEGIN
    CREATE DATABASE Nombre_DB;
END
GO -- Separa lotes de comando 

USE 'Nombre_DB'; -- SIEMPRE CORRE ESTO PRIMERO - Dice  que DB usar
GO 

-- 2. CREAR TABLAS (El esqueleto)
-- Tipos de datos clave:
-- INT            = Números enteros (IDs, años)
-- FLOAT          = Decimales para cálculos científicos o coordenadas
-- DECIMAL(10,2)  = Dinero exacto (10 dígitos total, 2 son decimales)
-- NVARCHAR(255)  = Texto que acepta tildes y ñ (Recomendado)
-- DATETIME2      = Fecha y hora precisa

CREATE TABLE Tabla_Padre(
    id_tpadre NVARCHAR(50) NOT NULL, --Clave PRIMARIA 
    fecha_inicio DATETIME2,
    precio DECIMAL (10,2)
);
CREATE TABLE Tabla_Hijo(
    id_thijo NVARCHAR(50) NOT NULL,
    fecha_inicio DATETIME2,
    latitud FLOAT,
    id_tpadre_fk  NVARCHAR (50) NOT NULL --Creamos Clave Foranea (de t_padre)
CONSTRAINT FK_TPadre                     -- Creamos la REGLA de asociación
FOREIGN KEY (id_tpadre_fk)               --'Esta es la FK'
REFERENCES Tabla_Padre (id_tpadre)       --'De la tabla se toma este valor'
);
GO
-- 3. ELIMINAR TABLA
DROP TABLE IF EXISTS Tabla_Padre; -- Eliminta al tabla (si existe)

--------------------------------------------------------------------------
-- 🚛 FASE 2: IMPORTACIÓN MASIVA (ETL)
-- Meter datos desde CSV.
--------------------------------------------------------------------------
BULK INSERT Tabla_Padre  --EN DONDE VOY A INSERTAR
FROM 'C:\Ruta\MiArchivo.csv'
WITH (
    FIRSTROW = 2           --Inicia importando desde fila 2 
    FIELDTERMINATOR = ','  --Separa datos por 'comas' (,)
    ROWTERMINATOR = '0X0a' --Salto de Línea (ENTER)
--- Nota: '0x0a'→ Común en archivos generdos en Linux/Unix 
--         '\n' → A veces funciona este (formato texto)
--        '\r\n'→ Carriage Return + Line Feed - El estándar clásico de Windows        
); 
GO

--------------------------------------------------------------------------
-- 🧹 FASE 3: LIMPIEZA Y TRANSFORMACIÓN
--------------------------------------------------------------------------
-- 1. NULOS (NULLS) 

-- A. INSPECCIÓN (Deteccion de los nulos)
-- ¿Cuantos tengo?

SELECT 
    COUNT (*) AS Total_Filas, 
    COUNT (var1) AS Total_Válidos,     -- var1= ID.(Número único de transacción)
    COUNT(*)-COUNT(var1) AS Nulos_var1 -- Resta a ver cuantos faltan
FROM Tabla_Padre    

-- Ver las filas culpables para entender POR QUÉ faltan
-- SELECT * FROM Tabla_Maestra WHERE end_lat IS NULL;

-- B.1. OPCIÓN BORRAR (DELETE) 
-- SOLAMENTE Si la fila es inservible sin ese dato

DELETE FROM Tabla_Padre
WHERE var1 IS NULL
    OR var2 IS NULL;

-- **NOTA: BORRAR ES PARA SIEMPRE (no hay Ctrl+Z)**
-- ** Se recomienda tener 

-- B.2 OPCIÓN RELLENAR (IMPUT)
-- **Nota: Si falta un dato numérico, usamos cero o el promedio (depnde)
-- **Nota: Si falta un dato de texo (string), ponemos 'Desconocido'


UPDATE Tabla_Maestra                    -- Abre Tabla para HACER CAMBIOS PERMAMENTES
SET var1 = COALESCE(var1,'Desconocido') -- Nuevo valor de esta celda es = 'COALESCE'
                                        -- COALESCE: Si NO tiene nombre pon 'Desconocido'
WHERE var1 IS NULL                      -- FILTRO DE SEGURIDAD

---------------------------------------------------------------------------
-- 2. DUPLICADOS () 
-- A. Detección de Duplicados
SELECT 
     var 1,
     COUNT (var1) AS repeticiones
FROM Tabla_Maestra
GROUP BY var1
HAVING COUNT(var1)>1;  -- Cuando el haya más que 1 valor igual


-- B. TRATAMIENTO DE DUPLICADOS (ELIMINAR DUPLICADOS)  
-- **Nota** - Nivel INTERMEDIO (Técnica CTE)

WITH CTE_Duplicados AS(  -- CTE= Tabla temporal; Pero si modificas CTE, modificas la REAL también
    SELECT var1,
        ROW_NUMBER() OVER(PARTITION BY var1 ORDER BY started_at) AS fila_num -- PARTITION: Agrupa por..(Junta todos los 'a101' en un grupo ('a102' en otro...) y numeralos)
    --  ROW_NUMBER= Etiqueta todas las filas (1,2,3,...)
    --  OVER(PARTITION BY..)= Reinicia el contéo cuando veas un 'var1' diferente: var1=A100→1; var1=A100→2 (DUPLICADO); var1=A101→1;...
    --  ORDER BY started_at= Coloca el #1 a la PRIMERA var1(la más antigua); Si quisieramos quedarnos con la mas reciente: 'DESC'
    FROM Tabla_Maestra
)
DELETE FROM CTE_Duplicados WHERE fila_num > 1; -- Borra las filas que son >1

-- C. CIRUGÍA DE TEXTO (LIMPIEZA)
-- C.1. ESPACIOS ("  Hola " -> "Hola")

UPDATE Tabla_Maestra SET var1 = TRIM(station_name);

-- C.2. UNIFICAR MAYÚSCULAS/MINÚSCULAS ("Member", "member", "MEMBER" -> Todo a "Member")

    UPDATE Tabla_Maestra
    SET var1 = UPPER(var1); -- Todo a MAYÚSCULAS
--  "     "  = LOWER(var1); -- Todo a minusculas        

-- C.3. REEMPLAZAR CARACTERES (Quitar símbolos)

SELECT REPLACE (var1, '-','') FROM Tabla_Maestra; -- '-' se puede cambiar por cualquie símbolo

-- C.4. EXTRAER PARTES 
-- Si tienes un código var1="ABC-123" 

    SELECT LEFT(var1, 3) FROM Productos; -- Seleciona los 3 caracteres de la IZQUIERDA
--  "      RIGTH(var1,4) "       "     ; -- Seleciona los 4 caracteres de la DERECHA
--  SELECT SUBSTRING(Columna, POSICION_INICIAL, LONGITUD)
-- Ejemplo SUBSTRING- 
SELECT SUBSTRING('ABC-123-XYZ', 5, 3); -- Desde la posición 5 selecciona 3 valores.
                                       -- RESULTADO: 123
--**BONUS** 
-- CHARINDEX (Rastreador) - Cuando no sabes la posisión exacta
SELECT CHARINDEX('-', 'ABC-123-XYZ') -- Busca donde esta el '-'
                                     -- RESULTADO 4

---------------------------------------------------------------------------
-- 3. ESTANDARIZACIÓN (Arreglar categorías mal escritas o inconsistentes)

-- Supongamos que en 'var1' tienes: 'm', 'M', 'Member', 'Subscriber'.
-- Queremos estandarizar todo a solo 'Member' y 'Casual'.

UPDATE Tabla_Maestra
SET var1 = CASE 
    WHEN var1 IN ('m', 'M', 'Subscriber') THEN 'Member'
    WHEN var1 IN ('c', 'C', 'Customer') THEN 'Casual'
    ELSE var1 -- Si ya está bien, déjalo igual
END;

---------------------------------------------------------------------------
-- 4. VALIDACIÓN DE DATOS (Revisar que los números tengan sentido)
-- A) LÓGICA NUMÉRICA (Precios, Edades, Cantidades)
-- 1. Negativos Imposibles: ¿Precios, edad o inventario bajo cero?

SELECT * FROM Tabla_Ventas 
WHERE precio < 0 OR cantidad < 0;

-- 2. Ceros Sospechosos: ¿Ventas de $0? (A veces es regalo, a veces error)

SELECT * FROM Tabla_Ventas WHERE monto_total = 0;

-- 3. Outliers (Valores Extremos): ¿Alguien tiene 150 años? ¿Un salario de 1 billón?

SELECT * FROM Tabla_Empleados 
WHERE edad > 100 
   OR salario > 1000000; -- Ajusta el umbral a tu negocio

-- B) COHERENCIA TEMPORAL (Time Travel Logic)
-- 1. El fin ocurre antes del inicio 

SELECT * FROM Tabla_Logistica
WHERE fecha_entrega < fecha_pedido;

-- 2. Datos mayores a HOY

SELECT * FROM Tabla_Usuarios
WHERE fecha_registro > GETDATE(); -- GETDATE() es 'Ahora mismo'

-- 3. Viajeros del Pasado (Datos demasiado viejos)

SELECT * FROM Tabla_Usuarios
WHERE YEAR(fecha_nacimiento) < 1920;


-- C) PATRONES DE TEXTO Y FORMATO 
-- 1. Longitud Incorrecta (LEN)
-- Ej: Un RUC 13 dígitos.

SELECT * FROM Tabla_Clientes
WHERE LEN(RUC) <> 13;

-- 2. Falta de Caracteres Clave (LIKE)

SELECT * FROM Tabla_Contactos
WHERE email NOT LIKE '%@%';

-- 3. Espacios Invisibles (DATALENGTH vs LEN)

SELECT columna, LEN(columna) as Longitud_Visible, DATALENGTH(columna) as Bytes_Reales
FROM Tabla_Maestra
WHERE LEN(columna) <> DATALENGTH(columna); 
-- **Nota: En NVARCHAR esto varía, usar con cuidado.

-- D) CONSISTENCIA ENTRE COLUMNAS (Cross-Column Logic) 🕵️‍♂️
-- 1. Estado vs. Fecha - Dice 'Entregado' pero la fecha de entrega es NULA. ¡Contradicción!

SELECT * FROM Tabla_Pedidos
WHERE estado = 'Entregado' AND fecha_entrega IS NULL;

-- 2. Categoría vs. Valor
-- Ej: El tipo de cliente es 'VIP' pero sus compras son 0.

SELECT * FROM Tabla_Clientes
WHERE tipo_cliente = 'VIP' AND total_compras < 100;

---------------------------------------------------------------------------
/*
FASE 4: ANÁLISIS, MATEMÁTICAS Y AGREGACIÓN
"El Taller de Operaciones". Aquí transformamos filas en respuestas.

Para que el código funcione en tu cabeza, asume que tenemos esta tabla imaginaria:

Tabla_General: Tu tabla de datos.
col_categ: Una columna de texto/categoría (Ej: País, Producto, Tipo de Cliente).
col_num_A: Una métrica numérica (Ej: Ventas, Ingresos, Distancia).
col_num_B: Otra métrica numérica (Ej: Costos, Gastos, Tiempo).
col_fecha: Una fecha (Ej: Fecha de Transacción).
*/
---------------------------------------------------------------------------
-- A. MATEMÁTICAS DE FILA (peraciones entre columnas de la MISMA fila. No agrupan, solo calculan.)
SELECT
    col_categ,
    (col_num_A + col_num_B) AS resultado_suma,           --SUMA simple
    (col_num_A - col_num_B) AS resultado_resta,          --RESTA simple
    (col_num_A * col_num_B) AS resultado_multiplicacion, 
    (col_num_A * 1.0 / col_num_B) AS resultado_division  --IMPORTANTE: Multiplicar por 1.0 para evitar división entera (que trunca decimales)
FROM Tabla_General;

-- B. AGREGACIONES BÁSICAS (The Big 5)
-- Resumir miles de filas en un solo número. Requiere GROUP BY si hay texto.

SELECT 
    
    -- 1. CONTEO (Frecuencia)
    COUNT(*) AS total_filas,           -- Cuenta todo (*) (incluye nulos)
    COUNT(col_num_A) AS total_validos, -- Cuenta solo valores reales (ignora nulos)
    
    -- 2. SUMA (Totales)
    SUM(col_num_A) AS total_acumulado,
    
    -- 3. PROMEDIO 
    AVG(col_num_A) AS promedio,
    
    -- 4. RANGO (Extremos)
    MIN(col_num_A) AS valor_minimo,
    MAX(col_num_A) AS valor_maximo,

    -- 5. DESVIACIÓN ESTÁNDAR (Para ver qué tan dispersos están los datos)
    STDEV(col_num_A) AS variabilidad

FROM Tabla_General
GROUP BY col_categ;

-- C. FÓRMULAS AVANZADAS Y KIPs

SELECT
    -- A) EL PORCENTAJE DEL TOTAL (Share of Total)
    --Fórmula: (Suma de la Categoría / Suma de TODA la tabla) * 100
    
    ROUND(SUM(col_num_A) * 100.0 / (SELECT SUM(col_num_A)FROM Tabla_General), 2)  
    -- Lógica: Usamos una subconsulta para sacar el denominador global.
    AS porcentaje_del_mercado,