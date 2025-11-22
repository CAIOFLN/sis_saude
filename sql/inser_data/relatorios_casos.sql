------------------------------------------------------------
-- INSERÇÃO DE RELATÓRIOS DE CASO E ENCAMINHAMENTOS
------------------------------------------------------------
-- ========================================
-- RELATÓRIOS DE CASO
-- ========================================

-- Relatório 1: Paciente Guilherme (médico-paciente) - Turno do Médico Guilherme no Hospital UFSCar
-- Turno: 2025-11-18 08:00 no Hospital UFSCar (2751501)
INSERT INTO relatorio_caso (id_paciente, tstz_relatorio, id_turno, texto_relatorio, palavra_chave_1, palavra_chave_2)
SELECT 
    (SELECT id_pessoa FROM pessoa WHERE cpf = '40420248282'),
    '2025-11-18 09:30:00-03',
    t.id_turno,
    'Paciente apresenta quadro de hipertensão arterial controlada. Pressão aferida 140/90 mmHg. Mantida medicação habitual.',
    'hipertensao',
    'cardiologia'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '40420248282' 
  AND t.cnes_entidade_saude = '2751501' 
  AND t.tstz_entrada = '2025-11-18 08:00:00-03';

-- Relatório 2: Paciente Henrique (médico-paciente) - Turno da Médica Ana Beatriz na Santa Casa
-- Turno: 2025-11-18 14:00 na Santa Casa (2751502)
-- COM ENCAMINHAMENTO para Hospital São Paulo (2751503)
INSERT INTO relatorio_caso (id_paciente, tstz_relatorio, id_turno, texto_relatorio, palavra_chave_1, palavra_chave_2)
SELECT 
    (SELECT id_pessoa FROM pessoa WHERE cpf = '23565323453'),
    '2025-11-18 16:45:00-03',
    t.id_turno,
    'Paciente com quadro de dor torácica aguda. ECG sugere possível IAM. Necessário transferência urgente para unidade com hemodinâmica.',
    'dor toracica',
    'cardiologia'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '12452364335' 
  AND t.cnes_entidade_saude = '2751502' 
  AND t.tstz_entrada = '2025-11-18 14:00:00-03';

-- Relatório 3: Paciente Patricia (gestora-paciente) - Turno do Médico Henrique no Hospital São Paulo
-- Turno: 2025-11-16 08:00 no Hospital São Paulo (2751503)
INSERT INTO relatorio_caso (id_paciente, tstz_relatorio, id_turno, texto_relatorio, palavra_chave_1, palavra_chave_2)
SELECT 
    (SELECT id_pessoa FROM pessoa WHERE cpf = '89123456789'),
    '2025-11-16 14:20:00-03',
    t.id_turno,
    'Paciente com quadro gripal. Febre de 38.5°C, tosse produtiva. Prescrito sintomáticos e repouso domiciliar.',
    'gripe',
    'infectologia'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '23565323453' 
  AND t.cnes_entidade_saude = '2751503' 
  AND t.tstz_entrada = '2025-11-16 08:00:00-03';

-- Relatório 4: Paciente Maria Clara (enfermeira-paciente) - Turno da Médica Sandra no Hospital UFSCar
-- Turno: 2025-11-18 16:00 no Hospital UFSCar (2751501)
INSERT INTO relatorio_caso (id_paciente, tstz_relatorio, id_turno, texto_relatorio, palavra_chave_1, palavra_chave_2)
SELECT 
    (SELECT id_pessoa FROM pessoa WHERE cpf = '34567891234'),
    '2025-11-18 17:30:00-03',
    t.id_turno,
    'Paciente com cefaleia intensa há 3 dias. Exame neurológico sem alterações. Prescrito analgésicos e solicitada RNM craniana.',
    'cefaleia',
    'neurologia'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '70717273747' 
  AND t.cnes_entidade_saude = '2751501' 
  AND t.tstz_entrada = '2025-11-18 16:00:00-03';

-- Relatório 5: Paciente Juliana (enfermeira-paciente) - Turno do Médico Ricardo no Hospital Sagrada Família
-- Turno: 2025-11-18 08:00 no Hospital Sagrada Família (2751504)
-- COM ENCAMINHAMENTO para Santa Casa (2751502)
INSERT INTO relatorio_caso (id_paciente, tstz_relatorio, id_turno, texto_relatorio, palavra_chave_1, palavra_chave_2)
SELECT 
    (SELECT id_pessoa FROM pessoa WHERE cpf = '56789123456'),
    '2025-11-18 10:15:00-03',
    t.id_turno,
    'Gestante com 38 semanas, trabalho de parto prematuro. Dilatação de 4cm. Hospital não possui UTI neonatal adequada. Necessário transferência.',
    'trabalho parto',
    'obstetricia'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '60616263646' 
  AND t.cnes_entidade_saude = '2751504' 
  AND t.tstz_entrada = '2025-11-18 08:00:00-03';

-- Relatório 6: Paciente Cristina (diretora-paciente) - Turno da Médica Ana Beatriz na Santa Casa
-- Turno: 2025-11-19 14:00 na Santa Casa (2751502)
INSERT INTO relatorio_caso (id_paciente, tstz_relatorio, id_turno, texto_relatorio, palavra_chave_1, palavra_chave_2)
SELECT 
    (SELECT id_pessoa FROM pessoa WHERE cpf = '20212223242'),
    '2025-11-19 15:30:00-03',
    t.id_turno,
    'Paciente com diabetes tipo 2 descompensada. Glicemia capilar 380 mg/dL. Ajustado esquema de insulina.',
    'diabetes',
    'endocrinologia'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '12452364335' 
  AND t.cnes_entidade_saude = '2751502' 
  AND t.tstz_entrada = '2025-11-19 14:00:00-03';

-- Relatório 7: Paciente Mariana - Turno do Médico Guilherme no Hospital UFSCar
-- Turno: 2025-11-19 08:00 no Hospital UFSCar (2751501)
INSERT INTO relatorio_caso (id_paciente, tstz_relatorio, id_turno, texto_relatorio, palavra_chave_1, palavra_chave_2)
SELECT 
    (SELECT id_pessoa FROM pessoa WHERE cpf = '11223344556'),
    '2025-11-19 10:00:00-03',
    t.id_turno,
    'Paciente com pneumonia comunitária. Radiografia com infiltrado em lobo inferior direito. Iniciado antibioticoterapia.',
    'pneumonia',
    'pneumologia'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '40420248282' 
  AND t.cnes_entidade_saude = '2751501' 
  AND t.tstz_entrada = '2025-11-19 08:00:00-03';

-- Relatório 8: Paciente Pedro Henrique - Turno do Médico Henrique no Hospital São Paulo
-- Turno: 2025-11-09 08:00 no Hospital São Paulo (2751503)
-- COM ENCAMINHAMENTO para Hospital UFSCar (2751501)
INSERT INTO relatorio_caso (id_paciente, tstz_relatorio, id_turno, texto_relatorio, palavra_chave_1, palavra_chave_2)
SELECT 
    (SELECT id_pessoa FROM pessoa WHERE cpf = '22334455667'),
    '2025-11-09 12:30:00-03',
    t.id_turno,
    'Paciente vítima de acidente automobilístico. Múltiplas fraturas em membros inferiores. Necessário cirurgia ortopédica complexa em centro especializado.',
    'trauma',
    'ortopedia'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '23565323453' 
  AND t.cnes_entidade_saude = '2751503' 
  AND t.tstz_entrada = '2025-11-09 08:00:00-03';

-- Relatório 9: Paciente Beatriz - Turno do Médico Ricardo no Hospital Sagrada Família
-- Turno: 2025-11-19 08:00 no Hospital Sagrada Família (2751504)
INSERT INTO relatorio_caso (id_paciente, tstz_relatorio, id_turno, texto_relatorio, palavra_chave_1, palavra_chave_2)
SELECT 
    (SELECT id_pessoa FROM pessoa WHERE cpf = '33445566778'),
    '2025-11-19 09:45:00-03',
    t.id_turno,
    'Paciente com crise asmática moderada. Nebulização realizada com melhora do quadro. Mantido acompanhamento ambulatorial.',
    'asma',
    'pneumologia'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '60616263646' 
  AND t.cnes_entidade_saude = '2751504' 
  AND t.tstz_entrada = '2025-11-19 08:00:00-03';

-- Relatório 10: Paciente Lucas - Turno da Médica Sandra no Hospital UFSCar
-- Turno: 2025-11-12 16:00 no Hospital UFSCar (2751501)
INSERT INTO relatorio_caso (id_paciente, tstz_relatorio, id_turno, texto_relatorio, palavra_chave_1, palavra_chave_2)
SELECT 
    (SELECT id_pessoa FROM pessoa WHERE cpf = '44556677889'),
    '2025-11-12 18:20:00-03',
    t.id_turno,
    'Paciente pediátrico com quadro de gastroenterite aguda. Desidratação moderada. Realizada hidratação venosa com boa resposta.',
    'gastroenterite',
    'pediatria'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '70717273747' 
  AND t.cnes_entidade_saude = '2751501' 
  AND t.tstz_entrada = '2025-11-12 16:00:00-03';

-- ========================================
-- ENCAMINHAMENTOS
-- ========================================
-- Encaminhamento 1: Paciente Henrique (dor torácica)
-- Da Santa Casa (2751502) para Hospital São Paulo (2751503)
-- Gestor responsável: Carlos Eduardo
INSERT INTO encaminhamento (id_relatorio_caso, cnes_hospital_destino, id_gestor_sistema_responsavel)
SELECT 
    rc.id_relatorio_caso,
    '2751503',
    (SELECT id_pessoa FROM pessoa WHERE cpf = '78912345678')
FROM relatorio_caso rc
JOIN paciente pac ON rc.id_paciente = pac.id_pessoa
JOIN pessoa p ON pac.id_pessoa = p.id_pessoa
WHERE p.cpf = '23565323453'
  AND rc.tstz_relatorio = '2025-11-18 16:45:00-03';

-- Encaminhamento 2: Paciente Juliana (trabalho de parto)
-- Do Hospital Sagrada Família (2751504) para Santa Casa (2751502)
-- Gestor responsável: Patricia
INSERT INTO encaminhamento (id_relatorio_caso, cnes_hospital_destino, id_gestor_sistema_responsavel)
SELECT 
    rc.id_relatorio_caso,
    '2751502',
    (SELECT id_pessoa FROM pessoa WHERE cpf = '89123456789')
FROM relatorio_caso rc
JOIN paciente pac ON rc.id_paciente = pac.id_pessoa
JOIN pessoa p ON pac.id_pessoa = p.id_pessoa
WHERE p.cpf = '56789123456'
  AND rc.tstz_relatorio = '2025-11-18 10:15:00-03';

-- Encaminhamento 3: Paciente Pedro Henrique (trauma/fraturas)
-- Do Hospital São Paulo (2751503) para Hospital UFSCar (2751501)
-- Gestor responsável: Carlos Eduardo
INSERT INTO encaminhamento (id_relatorio_caso, cnes_hospital_destino, id_gestor_sistema_responsavel)
SELECT 
    rc.id_relatorio_caso,
    '2751501',
    (SELECT id_pessoa FROM pessoa WHERE cpf = '78912345678')
FROM relatorio_caso rc
JOIN paciente pac ON rc.id_paciente = pac.id_pessoa
JOIN pessoa p ON pac.id_pessoa = p.id_pessoa
WHERE p.cpf = '22334455667'
  AND rc.tstz_relatorio = '2025-11-09 12:30:00-03';
