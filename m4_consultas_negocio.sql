-- ============================================================
-- Pre-entrega M4: Consultas SQL de negocio
-- Base de datos: ventas_tech_db
-- Tabla: ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta)
-- ============================================================

USE Ventas_Tech_DB;
GO

-- ------------------------------------------------------------
-- Consulta 1 - Resumen ejecutivo mensual
-- ------------------------------------------------------------
SELECT
    MONTH(fecha_venta)                  AS mes,
    SUM(cantidad * precio_unitario)     AS total_facturado,
    COUNT(*)                            AS cantidad_pedidos,
    AVG(cantidad * precio_unitario)     AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- ------------------------------------------------------------
-- Consulta 2 - Ranking de productos (Top 5 por facturación)
-- ------------------------------------------------------------
SELECT TOP 5
    id_producto,
    SUM(cantidad)                       AS unidades_vendidas,
    SUM(cantidad * precio_unitario)     AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- ------------------------------------------------------------
-- Consulta 3 - Clientes recurrentes (más de un pedido)
-- ------------------------------------------------------------
SELECT
    id_cliente,
    COUNT(*)                            AS cantidad_pedidos,
    SUM(cantidad * precio_unitario)     AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- ------------------------------------------------------------
-- Consulta 4 - Productos por encima / por debajo del promedio
-- ------------------------------------------------------------
WITH totales_por_producto AS (
    SELECT
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
)
SELECT
    id_producto,
    total_facturado,
    CASE
        WHEN total_facturado > (SELECT AVG(total_facturado) FROM totales_por_producto)
            THEN 'Por encima'
        ELSE 'Por debajo'
    END AS posicion_vs_promedio
FROM totales_por_producto
ORDER BY total_facturado DESC;


-- ============================================================
-- HALLAZGOS
-- ============================================================
-- 1. El producto 1 concentra el 55,9% de la facturación de marzo 2024 ($3.600 de $6.444)
--    con solo 3 unidades vendidas; junto con el producto 3 suman el 76,8%.
-- 2. Solo 2 de los 6 productos superan el promedio de facturación por producto ($1.074);
--    los otros 4 facturan entre $360 y $390 cada uno. El producto 2 es el más vendido
--    en volumen (13 unidades) pero aporta apenas el 5,6% ($364) por su precio bajo (~$28).
-- 3. Los 5 clientes son recurrentes (2 pedidos cada uno), pero la facturación está
--    concentrada: el cliente 1 aporta el 41,0% y los clientes 1 y 5 juntos el 73,6%.
-- ============================================================