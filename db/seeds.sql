-- ============================
-- SEED DATA: Assets - mayo 2025
-- ============================

-- 1. Clientes
INSERT INTO clientes (codigo, nombre) VALUES 
('FANT01', 'Fantabella'),
('TOMA01', 'Tomapo');

-- 2. Carteras
INSERT INTO carteras (codigo, alias, id_cliente) VALUES 
('FANTA1', 'masiva', 1),
('FANTA2', 'judicial', 1),
('FANTA3', 'prejudicial', 1),
('TOMA1', 'flujo', 2);

-- 3. Gestores con nombres ingeniosos
INSERT INTO gestores (nombre, apellidos) VALUES
('Luna', 'Cobranza'),
('Ragnar', 'Pago'),
('Mona', 'Morosa'),
('Neo', 'Teleop'),
('Gala', 'Gestión'),
('Bruno', 'Backoffice'),
('Val', 'Vigía'),
('Tito', 'Ticket'),
('Eva', 'Excel'),
('Nico', 'Notion');

-- 4. Mes: mayo 2025
INSERT INTO meses (codigo, fecha_inicio) VALUES
('VA2505', '2025-05-01');

-- 5. Semanas (id_mes = 1)
INSERT INTO semanas (dias_habiles, id_mes, fecha_inicio, fecha_fin, numero_semana) VALUES
(8, 1, '2025-05-01', '2025-05-11', 1),
(5, 1, '2025-05-11', '2025-05-18', 2),
(5, 1, '2025-05-18', '2025-05-25', 3),
(5, 1, '2025-05-25', '2025-06-01', 4);

-- 6. Metas mensuales (para cada cartera)
INSERT INTO metas_mes (porcentaje_meta, valor_meta, id_cartera, fecha_envio_mandante, id_mes, activa) VALUES
(100, 5000000, 1, '2025-05-01', 1, true),
(100, 8000000, 2, '2025-05-01', 1, true),
(100, 6000000, 3, '2025-05-01', 1, true),
(100, 4000000, 4, '2025-05-01', 1, true);

-- 7. Relación gestores-carteras (por simplicidad, primeros 4 gestores con cada cartera)
INSERT INTO gestores_cartera_mes (id_gestor, id_cartera, id_mes) VALUES
(1, 1, 1), (2, 2, 1), (3, 3, 1), (4, 4, 1);

-- 8. Metas semanales (por cartera y gestor — total 16 filas)
-- Semana 1
INSERT INTO metas_semanales (id_semana, id_cartera, monto, id_gestor) VALUES
(1, 1, 1250000, 1),
(1, 2, 2000000, 2),
(1, 3, 1500000, 3),
(1, 4, 1000000, 4);
-- Semana 2
INSERT INTO metas_semanales (id_semana, id_cartera, monto, id_gestor) VALUES
(2, 1, 1250000, 1),
(2, 2, 2000000, 2),
(2, 3, 1500000, 3),
(2, 4, 1000000, 4);
-- Semana 3
INSERT INTO metas_semanales (id_semana, id_cartera, monto, id_gestor) VALUES
(3, 1, 1250000, 1),
(3, 2, 2000000, 2),
(3, 3, 1500000, 3),
(3, 4, 1000000, 4);
-- Semana 4
INSERT INTO metas_semanales (id_semana, id_cartera, monto, id_gestor) VALUES
(4, 1, 1250000, 1),
(4, 2, 2000000, 2),
(4, 3, 1500000, 3),
(4, 4, 1000000, 4);
