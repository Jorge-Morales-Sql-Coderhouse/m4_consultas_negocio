# m4_consultas_negocio
Consultas SQL de negocio
Pre-entrega: Consultas SQL de negocio

Título: Extrayendo métricas clave con SQL

Descripción: Ya tenés la base de datos creada en M3. Ahora vas a escribir las primeras consultas que responden directamente a las preguntas de negocio del brief de M1. Esta pre-entrega es el primer paso de la extracción de datos que después vas a conectar a Power BI en M6.

Contexto

El equipo comercial de RetailPro necesita respuestas rápidas antes de la reunión del lunes. No quieren ver todas las filas de la base de datos: quieren métricas concretas, rankings y comparativas. Tu tarea es escribir las consultas SQL que generen exactamente esa información.

Instrucciones

Sobre la base de datos Ventas_Tech_DB creada en M3, escribí las siguientes consultas en un archivo llamado m4_consultas_negocio.sql. Trabajamos solo sobre la tabla ventas (recordá que tiene id_cliente, id_producto, cantidad, precio_unitario y fecha_venta). Los nombres de productos y clientes los vas a poder traer cruzando tablas con JOIN en el Módulo 5; por ahora trabajamos con los IDs.

Consulta 1 — Resumen ejecutivo mensual Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. Calculá el total como cantidad * precio_unitario. Usá alias descriptivos en español y agrupá por mes con MONTH(fecha_venta) (en PostgreSQL sería EXTRACT(MONTH FROM fecha_venta)). Con los datos que cargaste en M3 todas las ventas son de marzo de 2024, así que el resultado tiene una sola fila: es lo esperado.

Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando las unidades vendidas (SUM(cantidad)) y el total generado. Usá GROUP BY id_producto, ORDER BY y TOP 5.

Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos y el total gastado. Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.

Consulta 4 — Productos por encima/por debajo del promedio Total facturado por id_producto, con una columna adicional que etiquete con CASE WHEN si ese producto quedó 'Por encima' o 'Por debajo' del promedio de facturación por producto. Ojo: es el promedio de los totales por producto, no el promedio de las filas de ventas. Resolvelo con WITH y una subconsulta, como en el ejemplo de meses de la unidad "Ordenar, resumir y agrupar resultados".

Bloque de cierre Al final del archivo agregá un bloque de comentarios -- con 3 hallazgos concretos que encontraste al revisar los resultados. Por ejemplo: "El producto 1 concentra el 40% de la facturación del trimestre."
