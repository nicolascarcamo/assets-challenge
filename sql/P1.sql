SELECT
    c.estado_codigo,
    c.detalle_codigo,
    c.clasificacion,
    COUNT(DISTINCT c.rut)         AS cantidad_ruts,   -- clientes únicos
    SUM(c.monto)                  AS monto_total,     -- importe comprometido
    SUM(c.abonos)                 AS recupero_total,  -- pagos/abonos recibidos
    SUM(c.saldo)                  AS saldo_total      -- saldo pendiente
FROM cubo AS c
GROUP BY
    c.estado_codigo,
    c.detalle_codigo,
    c.clasificacion
ORDER BY
    recupero_total DESC;          -- mayor recupero primero

