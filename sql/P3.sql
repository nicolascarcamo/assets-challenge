
WITH

meta_gestor AS (
    SELECT
        ms.id_gestor,
        m.id                     AS id_mes,
        SUM(ms.monto)            AS meta_gestor
    FROM metas_semanales ms
    JOIN semanas  s ON s.id = ms.id_semana
    JOIN meses    m ON m.id = s.id_mes
    WHERE m.fecha_inicio >= DATE '2025-05-01'
      AND m.fecha_inicio <  DATE '2025-06-01'
    GROUP BY ms.id_gestor, m.id
),

recupero_gestor AS (
    SELECT
        gcm.id_gestor,
        m.id                     AS id_mes,
        SUM(cu.abonos)           AS recupero
    FROM gestores_cartera_mes gcm
    JOIN carteras ca   ON ca.id      = gcm.id_cartera
    JOIN cubo     cu   ON cu.cartera = ca.codigo
    JOIN meses    m    ON m.id       = gcm.id_mes
    WHERE m.fecha_inicio >= DATE '2025-05-01'
      AND m.fecha_inicio <  DATE '2025-06-01'
      AND cu.envio = m.codigo
    GROUP BY gcm.id_gestor, m.id
),

ruts_gestor AS (
    SELECT
        gcm.id_gestor,
        m.id                               AS id_mes,
        COUNT(DISTINCT cu.rut)             AS total_ruts
    FROM gestores_cartera_mes gcm
    JOIN carteras ca   ON ca.id      = gcm.id_cartera
    JOIN cubo     cu   ON cu.cartera = ca.codigo
    JOIN meses    m    ON m.id       = gcm.id_mes
    WHERE m.fecha_inicio >= DATE '2025-05-01'
      AND m.fecha_inicio <  DATE '2025-06-01'
    GROUP BY gcm.id_gestor, m.id
)


SELECT
    g.nombre                                                    AS nombre_gestor,
    to_char(m.fecha_inicio,'YYYY-MM')                           AS mes,
    ROUND(
        CASE
            WHEN mg.meta_gestor = 0 THEN 0
            ELSE COALESCE(rg.recupero,0) / mg.meta_gestor * 100
        END
    , 2)                                                        AS pct_recuperado,
    CASE
        WHEN mg.meta_gestor = 0                       THEN 'No cumple'
        WHEN COALESCE(rg.recupero,0) >= mg.meta_gestor * 1.10
                                                     THEN 'Excede'
        WHEN COALESCE(rg.recupero,0) >= mg.meta_gestor * 0.90
                                                     THEN 'Cumple'
        ELSE                                            'No cumple'
    END                                                         AS categoria,
    COALESCE(rut.total_ruts, 0)                                 AS total_ruts
FROM gestores         g
JOIN meta_gestor      mg  ON mg.id_gestor  = g.id
JOIN meses            m   ON m.id          = mg.id_mes
LEFT JOIN recupero_gestor rg  ON rg.id_gestor = g.id  AND rg.id_mes = m.id
LEFT JOIN ruts_gestor     rut ON rut.id_gestor= g.id  AND rut.id_mes = m.id
ORDER BY mes, pct_recuperado DESC;
