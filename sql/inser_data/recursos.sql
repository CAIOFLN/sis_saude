------------------------------------------------------------
-- INSERÇÃO DE RECURSOS
------------------------------------------------------------

-- ========================================
-- RECURSOS (10 total)
-- ========================================

-- Recurso 1: Vacina contra COVID-19 (Produzido por laboratório)
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('1234567890123', 'Vacina COVID-19 Pfizer', 'Vacina', -80.00, -60.00);

-- Recurso 2: Dipirona Sódica (Produzido por laboratório)
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('2345678901234', 'Dipirona Sódica 500mg', 'Medicamento', 15.00, 30.00);

-- Recurso 3: Vacina contra Gripe (Produzido por laboratório)
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('3456789012345', 'Vacina Influenza Tetravalente', 'Vacina', 2.00, 8.00);

-- Recurso 4: Paracetamol (Produzido por laboratório)
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('4567890123456', 'Paracetamol 750mg', 'Medicamento', 15.00, 25.00);

-- Recurso 5: Insulina (Produzido por laboratório)
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('5678901234567', 'Insulina NPH 100UI', 'Medicamento', 2.00, 8.00);

-- Recurso 6: Vacina Hepatite B (Produzido por laboratório)
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('6789012345678', 'Vacina Hepatite B', 'Vacina', 2.00, 8.00);

-- Recurso 7: Amoxicilina (Produzido por laboratório)
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('7890123456789', 'Amoxicilina 500mg', 'Medicamento', 15.00, 30.00);

-- Recurso 8: Soro Fisiológico (Produzido por laboratório)
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('8901234567890', 'Soro Fisiológico 0,9% 500ml', 'Solução', 15.00, 25.00);

-- Recurso 9: Ibuprofeno (Produzido por laboratório)
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('9012345678901', 'Ibuprofeno 600mg', 'Medicamento', 15.00, 30.00);

-- Recurso 10: Omeprazol (NÃO produzido por laboratório)
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('0123456789012', 'Omeprazol 20mg', 'Medicamento', 15.00, 25.00);
-- Adicione um medicamento do
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('1122334455667', 'Losartana Potássica 50mg', 'Medicamento', 15.00, 30.00);
COMMIT;

-- ========================================
-- PRODUÇÃO - Laboratórios produzem recursos (8 recursos)
-- ========================================

-- Laboratório Bio Análises (2751801) produz:
INSERT INTO produz (cnes_laboratorio, registro_ms_recurso)
VALUES 
    ('2751801', '1234567890123'),  -- Vacina COVID-19
    ('2751801', '5678901234567'),  -- Insulina
    ('2751801', '6789012345678'),  -- Vacina Hepatite B
    ('2751801', '9012345678901');  -- Ibuprofeno

-- Laboratório Fleury São Carlos (2751802) produz:
INSERT INTO produz (cnes_laboratorio, registro_ms_recurso)
VALUES 
    ('2751802', '2345678901234'),  -- Dipirona
    ('2751802', '4567890123456'),  -- Paracetamol
    ('2751802', '7890123456789');  -- Amoxicilina

-- Laboratório Clínico Central (2751803) produz:
INSERT INTO produz (cnes_laboratorio, registro_ms_recurso)
VALUES 
    ('2751803', '3456789012345'),  -- Vacina Gripe
    ('2751803', '8901234567890');  -- Soro Fisiológico


-- ========================================
-- POSSUI - Entidades de Saúde possuem recursos
-- ========================================

-- Hospital Universitário UFSCar (2751501) possui:
INSERT INTO possui (cnes_entidade_saude, registro_ms_recurso, quantidade_disponivel)
VALUES 
    ('2751501', '1234567890123', 50),   -- Vacina COVID-19 (reduzido para criar deficit)
    ('2751501', '2345678901234', 300),  -- Dipirona
    ('2751501', '4567890123456', 250),  -- Paracetamol
    ('2751501', '5678901234567', 80),   -- Insulina
    ('2751501', '8901234567890', 500),  -- Soro Fisiológico
    ('2751501', '9012345678901', 1000), -- Ibuprofeno
    ('2751501', '0123456789012', 600);  -- Omeprazol

-- Santa Casa de São Carlos (2751502) possui:
INSERT INTO possui (cnes_entidade_saude, registro_ms_recurso, quantidade_disponivel)
VALUES 
    ('2751502', '1234567890123', 100),  -- Vacina COVID-19 (estoque próprio baixo)
    ('2751502', '3456789012345', 180),  -- Vacina Gripe
    ('2751502', '2345678901234', 450),  -- Dipirona
    ('2751502', '4567890123456', 380),  -- Paracetamol
    ('2751502', '7890123456789', 220),  -- Amoxicilina
    ('2751502', '8901234567890', 700),  -- Soro Fisiológico
    ('2751502', '9012345678901', 1500), -- Ibuprofeno
    ('2751502', '0123456789012', 800);  -- Omeprazol

-- Hospital São Paulo (2751503) possui:
INSERT INTO possui (cnes_entidade_saude, registro_ms_recurso, quantidade_disponivel)
VALUES 
    ('2751503', '1234567890123', 80),   -- Vacina COVID-19 (reduzido para criar deficit)
    ('2751503', '2345678901234', 280),  -- Dipirona
    ('2751503', '4567890123456', 200),  -- Paracetamol
    ('2751503', '5678901234567', 60),   -- Insulina
    ('2751503', '6789012345678', 90),   -- Vacina Hepatite B
    ('2751503', '8901234567890', 400),  -- Soro Fisiológico
    ('2751503', '9012345678901', 800),  -- Ibuprofeno
    ('2751503', '0123456789012', 500);  -- Omeprazol

-- Hospital e Maternidade Sagrada Família (2751504) possui:
INSERT INTO possui (cnes_entidade_saude, registro_ms_recurso, quantidade_disponivel)
VALUES 
    ('2751504', '2345678901234', 180),  -- Dipirona
    ('2751504', '4567890123456', 150),  -- Paracetamol
    ('2751504', '5678901234567', 40),   -- Insulina
    ('2751504', '8901234567890', 300),  -- Soro Fisiológico
    ('2751504', '9012345678901', 600),  -- Ibuprofeno
    ('2751504', '0123456789012', 400);  -- Omeprazol

-- Laboratório Bio Análises (2751801) possui:
INSERT INTO possui (cnes_entidade_saude, registro_ms_recurso, quantidade_disponivel)
VALUES 
    ('2751801', '1234567890123', 70),   -- Vacina COVID-19 (produz, mas estoque baixo)
    ('2751801', '5678901234567', 200),  -- Insulina (produz)
    ('2751801', '6789012345678', 300),  -- Vacina Hepatite B (produz)
    ('2751801', '9012345678901', 250),  -- Ibuprofeno (produz)
    ('2751801', '0123456789012', 200);  -- Omeprazol

-- Laboratório Fleury São Carlos (2751802) possui:
INSERT INTO possui (cnes_entidade_saude, registro_ms_recurso, quantidade_disponivel)
VALUES 
    ('2751802', '2345678901234', 800),  -- Dipirona (produz)
    ('2751802', '4567890123456', 600),  -- Paracetamol (produz)
    ('2751802', '7890123456789', 450),  -- Amoxicilina (produz)
    ('2751802', '9012345678901', 300),  -- Ibuprofeno
    ('2751802', '0123456789012', 250);  -- Omeprazol

-- Laboratório Clínico Central (2751803) possui:
INSERT INTO possui (cnes_entidade_saude, registro_ms_recurso, quantidade_disponivel)
VALUES 
    ('2751803', '3456789012345', 400),  -- Vacina Gripe (produz)
    ('2751803', '8901234567890', 1000), -- Soro Fisiológico (produz)
    ('2751803', '9012345678901', 200),  -- Ibuprofeno
    ('2751803', '0123456789012', 150);  -- Omeprazol
