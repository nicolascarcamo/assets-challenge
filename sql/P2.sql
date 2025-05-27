

WITH metas_sem AS (           -- ► metas de las semanas 1-4 por cartera
    SELECT
        ms.id_cartera,
        SUM(CASE WHEN s.numero_semana = 1 THEN ms.monto ELSE 0 END) AS meta_semana1,
        SUM(CASE WHEN s.numero_semana = 2 THEN ms.monto ELSE 0 END) AS meta_semana2,
        SUM(CASE WHEN s.numero_semana = 3 THEN ms.monto ELSE 0 END) AS meta_semana3,
        SUM(CASE WHEN s.numero_semana = 4 THEN ms.monto ELSE 0 END) AS meta_semana4
    FROM metas_semanales ms
    JOIN semanas  s  ON s.id = ms.id_semana
    JOIN meses    m  ON m.id = s.id_mes
    WHERE m.codigo = 'VA2505'                 -- mes solicitado
    GROUP BY ms.id_cartera
),
recupero AS (                -- ► recupero total (abonos) por cartera
    SELECT
        ca.id                         AS id_cartera,
        SUM(cu.abonos)                AS recupero_total
    FROM cubo cu
    JOIN carteras ca ON ca.codigo = cu.cartera
    WHERE cu.envio = 'VA2505'                          -- mismo mes en cubo
    GROUP BY ca.id
)
SELECT
    cl.nombre                           AS nombre_cliente,
    ca.alias                            AS alias_cartera,
    mm.valor_meta,
    COALESCE(ms.meta_semana1, 0)        AS meta_semana1,
    COALESCE(ms.meta_semana2, 0)        AS meta_semana2,
    COALESCE(ms.meta_semana3, 0)        AS meta_semana3,
    COALESCE(ms.meta_semana4, 0)        AS meta_semana4,
    COALESCE(r.recupero_total, 0)       AS recupero_total,
    ROUND(
        CASE
            WHEN mm.valor_meta = 0 THEN 0
            ELSE COALESCE(r.recupero_total, 0) / mm.valor_meta * 100
        END,
        2
    ) AS porcentaje_recuperado
FROM metas_mes mm
JOIN meses    m  ON m.id         = mm.id_mes
JOIN carteras ca ON ca.id        = mm.id_cartera
JOIN clientes cl ON cl.id        = ca.id_cliente
LEFT JOIN metas_sem ms ON ms.id_cartera = ca.id
LEFT JOIN recupero  r  ON r.id_cartera  = ca.id
WHERE m.codigo = 'VA2505'
  AND mm.activa = true
ORDER BY cl.nombre, ca.alias;