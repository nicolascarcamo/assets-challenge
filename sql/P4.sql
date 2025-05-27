/*

Nuevo esquema relacional:
clientes ─1─∞─ carteras ─1─∞─ subcarteras ─1─∞─ metas_mes
                                           └─1─∞─ metas_semanales
gestores ─1─∞─ gestores_subcartera_mes

*/

-- Creamos tabla nueva
CREATE TABLE subcarteras (
  id          serial PRIMARY KEY,
  codigo      varchar(100) NOT NULL,
  alias       varchar(100),
  id_cartera  int NOT NULL REFERENCES carteras(id),
  activo      boolean DEFAULT true,
  UNIQUE (id_cartera, codigo)
);

-- Nuevas reglas:
ALTER TABLE metas_mes
  ADD COLUMN id_subcartera INT;

UPDATE metas_mes mm
SET id_subcartera = sc.id
FROM subcarteras sc
WHERE sc.id_cartera = mm.id_cartera     
  AND sc.codigo    = 'GENERAL';

ALTER TABLE metas_mes
  ALTER COLUMN id_subcartera SET NOT NULL,
  DROP CONSTRAINT metas_mes_id_cartera_fkey,
  DROP COLUMN id_cartera;
-- En lugar de gestores_cartera_mes, creamos gestores_subcartera_mes:

CREATE TABLE gestores_subcartera_mes (
  id_gestor     INT NOT NULL REFERENCES gestores(id),
  id_subcartera INT NOT NULL REFERENCES subcarteras(id),
  id_mes        INT NOT NULL REFERENCES meses(id),
  PRIMARY KEY (id_gestor, id_subcartera, id_mes)
);

/* la PK evita duplicados, y dejamos libre la tabla antigua gestores_cartera_mes
   para que se pueda usar en el futuro sin problemas */

/* Para migrar, poblamos la nueva tabla subcarteras, trasladamos claves, reasignamos Foreign Keys de las metas recientes */
