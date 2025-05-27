-- ============================
-- Datos ficticios para la tabla cubo
-- Envío: VA2505 (mayo 2025)
-- ============================

INSERT INTO cubo (
  cliente, cartera, envio, rut, dv, gestor, deudor, direccion, comuna,
  ciudad, codigo, detalle_codigo, id_clasificacion, clasificacion,
  documentos, monto, abonos, saldo, estado_codigo, tipo_cartera
) VALUES
('Fantabella', 'FANTA1', 'VA2505', 12345678, '9', 'Luna Cobranza', 'José Moroso', 'Av. Las Condes 1234', 'Las Condes', 'Santiago', 'P001', 'Promesa de pago', 1, 'Positiva', 3, 1800000, 800000, 1000000, 'POSITIVO', 'Stock'),
('Fantabella', 'FANTA2', 'VA2505', 23456789, 'K', 'Ragnar Pago', 'Elena Deuda', 'Av. Apoquindo 456', 'Providencia', 'Santiago', 'N005', 'Sin contacto', 4, 'Negativa', 2, 3000000, 0, 3000000, 'NEGATIVO', 'Judicial'),
('Fantabella', 'FANTA3', 'VA2505', 34567890, '1', 'Mona Morosa', 'Carlos Morosini', 'Calle Falsa 123', 'Ñuñoa', 'Santiago', 'P003', 'Pago parcial', 2, 'Positiva', 1, 500000, 250000, 250000, 'POSITIVO', 'Stock'),
('Fantabella', 'FANTA1', 'VA2505', 45678901, '3', 'Neo Teleop', 'Julieta Sinpago', 'Camino del Inca 987', 'La Florida', 'Santiago', 'N001', 'No contesta', 5, 'Negativa', 3, 2200000, 0, 2200000, 'NEGATIVO', 'Flujo'),
('Fantabella', 'FANTA2', 'VA2505', 56789012, '7', 'Ragnar Pago', 'Luis Castigo', 'Av. Vitacura 123', 'Vitacura', 'Santiago', 'P002', 'Pago total', 1, 'Positiva', 4, 3500000, 3500000, 0, 'POSITIVO', 'Judicial'),
('Fantabella', 'FANTA3', 'VA2505', 67890123, '2', 'Mona Morosa', 'Ana Morosa', 'El Roble 456', 'Recoleta', 'Santiago', 'N003', 'No pago', 4, 'Negativa', 2, 1600000, 0, 1600000, 'NEGATIVO', 'Stock'),
('Fantabella', 'FANTA1', 'VA2505', 78901234, '5', 'Luna Cobranza', 'Tito Duro', 'Pasaje Lento 789', 'Peñalolén', 'Santiago', 'P004', 'Abono mínimo', 2, 'Positiva', 2, 1200000, 300000, 900000, 'POSITIVO', 'Stock'),
('Tomapo', 'TOMA1', 'VA2505', 89012345, '1', 'Eva Excel', 'Rosa Sinpaga', 'Av. Grecia 999', 'Macul', 'Santiago', 'N002', 'No contesta', 3, 'Negativa', 3, 1800000, 0, 1800000, 'NEGATIVO', 'Flujo'),
('Tomapo', 'TOMA1', 'VA2505', 90123456, '4', 'Eva Excel', 'Ignacio Tardío', 'Calle Lenta 321', 'San Miguel', 'Santiago', 'P005', 'Pago reciente', 1, 'Positiva', 2, 1400000, 1400000, 0, 'POSITIVO', 'Flujo'),
('Fantabella', 'FANTA2', 'VA2505', 11223344, '8', 'Ragnar Pago', 'Lucía Mora', 'Av. Kennedy 1000', 'Las Condes', 'Santiago', 'N006', 'Rechaza contacto', 5, 'Negativa', 2, 2100000, 0, 2100000, 'NEGATIVO', 'Judicial'),
('Tomapo', 'TOMA1', 'VA2505', 22334455, '6', 'Val Vigía', 'Pedro Perdido', 'El Hualle 456', 'Ñuñoa', 'Santiago', 'N004', 'Sin contacto', 4, 'Negativa', 1, 800000, 0, 800000, 'NEGATIVO', 'Flujo'),
('Fantabella', 'FANTA3', 'VA2505', 33445566, '2', 'Gala Gestión', 'Tamara Lenta', 'Av. España 789', 'Estación Central', 'Santiago', 'P006', 'Compromiso alto', 1, 'Positiva', 3, 2000000, 1200000, 800000, 'POSITIVO', 'Stock'),
('Fantabella', 'FANTA1', 'VA2505', 44556677, '3', 'Neo Teleop', 'Benjamín Paga', 'Pedro de Valdivia 999', 'Providencia', 'Santiago', 'P007', 'Abono mensual', 2, 'Positiva', 3, 2700000, 2000000, 700000, 'POSITIVO', 'Stock'),
('Tomapo', 'TOMA1', 'VA2505', 55667788, '9', 'Tito Ticket', 'Fernanda Nada', 'Irarrázaval 333', 'Ñuñoa', 'Santiago', 'N007', 'Rechaza pago', 5, 'Negativa', 2, 1500000, 0, 1500000, 'NEGATIVO', 'Flujo'),
('Fantabella', 'FANTA2', 'VA2505', 66778899, '0', 'Bruno Backoffice', 'Andrea Dura', 'Av. Los Leones 777', 'Providencia', 'Santiago', 'P008', 'Pago total', 1, 'Positiva', 3, 3200000, 3200000, 0, 'POSITIVO', 'Judicial');