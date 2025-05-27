-- ================================
-- 1) Estructura de tablas (PostgreSQL)
-- ================================

-- Tabla de clientes (simplificada, sin prefijo CLI_)
CREATE TABLE clientes (
  id          SERIAL PRIMARY KEY,
  codigo      VARCHAR(100) NOT NULL,
  nombre      VARCHAR(100) NOT NULL
);

-- Cartera
CREATE TABLE carteras (
  id           SERIAL PRIMARY KEY,
  codigo       VARCHAR(100) NOT NULL,
  alias        VARCHAR(100) NOT NULL,
  id_cliente   INTEGER NOT NULL REFERENCES clientes(id)
);

-- Gestores
CREATE TABLE gestores (
  id           SERIAL PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  apellidos    VARCHAR(100)
);

-- Meses
CREATE TABLE meses (
  id           SERIAL PRIMARY KEY,
  codigo       VARCHAR(20) NOT NULL,
  fecha_inicio DATE        NOT NULL
);

-- Semanas
CREATE TABLE semanas (
  id            SERIAL PRIMARY KEY,
  dias_habiles  INTEGER    NOT NULL,
  id_mes        INTEGER    NOT NULL REFERENCES meses(id),
  fecha_inicio  DATE       NOT NULL,
  fecha_fin     DATE       NOT NULL,
  numero_semana INTEGER    NOT NULL
);

-- Metas mensuales
CREATE TABLE metas_mes (
  id                   SERIAL    PRIMARY KEY,
  porcentaje_meta      DECIMAL(5,2) NOT NULL,
  valor_meta           NUMERIC      NOT NULL,
  id_cartera           INTEGER      NOT NULL REFERENCES carteras(id),
  fecha_envio_mandante TIMESTAMP,
  id_mes               INTEGER      NOT NULL REFERENCES meses(id),
  activa               BOOLEAN      NOT NULL DEFAULT TRUE
);

-- Relación gestor-cartera-mes
CREATE TABLE gestores_cartera_mes (
  id          SERIAL PRIMARY KEY,
  id_gestor   INTEGER NOT NULL REFERENCES gestores(id),
  id_cartera  INTEGER NOT NULL REFERENCES carteras(id),
  id_mes      INTEGER NOT NULL REFERENCES meses(id)
);

-- Metas semanales (ya con id_gestor en lugar de texto “gestor”)
CREATE TABLE metas_semanales (
  id          SERIAL PRIMARY KEY,
  id_semana   INTEGER NOT NULL REFERENCES semanas(id),
  id_cartera  INTEGER NOT NULL REFERENCES carteras(id),
  monto       NUMERIC NOT NULL,
  id_gestor   INTEGER NOT NULL REFERENCES gestores(id)
);

-- Cubo de gestiones (cada fila = un RUT)
CREATE TABLE cubo (
  cliente                         VARCHAR(100),
  cartera                         VARCHAR(100),
  envio                           VARCHAR(100),
  rut                             INTEGER,
  dv                              VARCHAR(2),
  gestor                          VARCHAR(100),
  deudor                          VARCHAR(100),
  direccion                       VARCHAR(100),
  comuna                          VARCHAR(100),
  direccion_laboral               VARCHAR(100),
  comuna_laboral                  VARCHAR(100),
  ciudad                          VARCHAR(100),
  codigo                          VARCHAR(100),
  detalle_codigo                  VARCHAR(100),
  id_clasificacion                INTEGER,
  clasificacion                   VARCHAR(100),
  fecha_compromiso_pago           TIMESTAMP,
  monto_compromiso_pago           INTEGER,
  subcartera                      VARCHAR(100),
  fecha_ultima_codificacion       TIMESTAMP,
  fecha_plazo                     TIMESTAMP,
  documentos                      INTEGER,
  monto                           INTEGER,
  abonos                          INTEGER,
  saldo                           INTEGER,
  fecha_ultimo_pago               TIMESTAMP,
  estado_pago                     VARCHAR(100),
  tipo_cartera                    VARCHAR(100),
  pago_minimo                     INTEGER,
  estado_operacion                VARCHAR(100),
  fonos_vigentes                  INTEGER,
  emails_vigentes                 INTEGER,
  abogado                         VARCHAR(100),
  estado_judicial                 VARCHAR(100),
  estado                          VARCHAR(100),
  fecha_emision                   TIMESTAMP,
  fecha_vencimiento               TIMESTAMP,
  compromisos                     INTEGER,
  fecha_ultimo_compromiso         TIMESTAMP,
  monto_ultimo_compromiso         INTEGER,
  abono_mes_anterior              VARCHAR(100),
  fecha_abono_mes_anterior        TIMESTAMP,
  monto_abono_mes_anterior        INTEGER,
  antiguedad                      INTEGER,
  fecha_ultima_gestion            TIMESTAMP,
  gestiones                       INTEGER,
  fecha_ultima_gestion_persona    TIMESTAMP,
  gestiones_persona               INTEGER,
  fecha_ultima_gestion_titular    TIMESTAMP,
  gestiones_titular               INTEGER,
  fecha_ultima_gestion_maquina    TIMESTAMP,
  gestiones_maquina               INTEGER,
  monto_original                  INTEGER,
  fecha_ultima_gestion_sms        TIMESTAMP,
  gestiones_sms                   INTEGER,
  fecha_ultima_gestion_email      TIMESTAMP,
  gestiones_mail                  INTEGER,
  estado_compromiso_pago          VARCHAR(100),
  zona_final                      VARCHAR(100),
  tramo_monto                     VARCHAR(100),
  tipo_pago                       VARCHAR(100),
  estado_codigo                   VARCHAR(100),
  ultimo_fono_contactado          VARCHAR(100),
  contactabilidad                 VARCHAR(100),
  fecha_ultima_gestion_gestor_asignado TIMESTAMP,
  gestiones_gestor_asignado       INTEGER,
  descuento                       REAL,
  codigo_anterior_pago            VARCHAR(100)
);
