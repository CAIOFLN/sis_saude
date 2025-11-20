-- Active: 1762884835198@@localhost@5432@sis_saude
------------------------------------------------------------
-- INSERÇÃO DE PEDIDOS, RELATÓRIOS DE RECURSO, REQUISIÇÕES E TRANSPORTE
------------------------------------------------------------

-- ========================================
-- TRANSPORTADORAS
-- ========================================

-- Transportadora 1: TransMed Logística
INSERT INTO transportadora (cnpj, nome, telefone, temp_min_suportada, temp_max_suportada)
VALUES ('12345678000190', 'TransMed Logística Hospitalar', '(11)98765-4321', -80.00, 30.00);

-- Transportadora 2: VitaLog Transportes
INSERT INTO transportadora (cnpj, nome, telefone, temp_min_suportada, temp_max_suportada)
VALUES ('98765432000123', 'VitaLog Transportes Médicos', '(16)97654-3210', -20.00, 25.00);


-- ========================================
-- PEDIDOS DE RECURSOS
-- ========================================

-- Pedido 1: Vacina COVID-19 - Urgência EXTREMA (surto)
-- Turno: Médico Guilherme no Hospital UFSCar - 2025-11-18 08:00
INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
SELECT 
    t.id_turno,
    '1234567890123',
    '2025-11-18 11:00:00-03',
    200,
    'EXTREMA',
    'Campanha de vacinação emergencial devido ao aumento de casos na região. Estoque atual insuficiente.'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '40420248282' 
  AND t.cnes_entidade_saude = '2751501' 
  AND t.tstz_entrada = '2025-11-18 08:00:00-03';

-- Pedido 2: Dipirona - Urgência MEDIA (estoque baixo rotineiro)
-- Turno: Médica Ana Beatriz na Santa Casa - 2025-11-18 14:00
INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
SELECT 
    t.id_turno,
    '2345678901234',
    '2025-11-18 15:30:00-03',
    500,
    'MEDIA',
    'Reposição de estoque regular. Consumo aumentado devido a alta temporada de casos febris.'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '12452364335' 
  AND t.cnes_entidade_saude = '2751502' 
  AND t.tstz_entrada = '2025-11-18 14:00:00-03';

-- Pedido 3: Insulina - Urgência EXTREMA (paciente crítico)
-- Turno: Médico Henrique no Hospital São Paulo - 2025-11-16 08:00
INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
SELECT 
    t.id_turno,
    '5678901234567',
    '2025-11-16 10:00:00-03',
    50,
    'EXTREMA',
    'Paciente diabético em cetoacidose. Necessário reposição urgente para evitar descompensação grave.'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '23565323453' 
  AND t.cnes_entidade_saude = '2751503' 
  AND t.tstz_entrada = '2025-11-16 08:00:00-03';

-- Pedido 4: Amoxicilina - Urgência MEDIA (tratamento pneumonia)
-- Turno: Médico Guilherme no Hospital UFSCar - 2025-11-19 08:00
INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
SELECT 
    t.id_turno,
    '7890123456789',
    '2025-11-19 11:30:00-03',
    150,
    'MEDIA',
    'Aumento de casos de pneumonia comunitária. Antibiótico de primeira escolha em falta no estoque.'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '40420248282' 
  AND t.cnes_entidade_saude = '2751501' 
  AND t.tstz_entrada = '2025-11-19 08:00:00-03';

-- Pedido 5: Soro Fisiológico - Urgência BAIXA (reposição preventiva)
-- Turno: Médico Ricardo no Hospital Sagrada Família - 2025-11-18 08:00
INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
SELECT 
    t.id_turno,
    '8901234567890',
    '2025-11-18 09:00:00-03',
    300,
    'BAIXA',
    'Reposição preventiva de estoque. Níveis ainda adequados mas abaixo da média histórica.'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '60616263646' 
  AND t.cnes_entidade_saude = '2751504' 
  AND t.tstz_entrada = '2025-11-18 08:00:00-03';

-- Pedido 6: Paracetamol - Urgência MEDIA (surto de gripe)
-- Turno: Médica Ana Beatriz na Santa Casa - 2025-11-19 14:00
INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
SELECT 
    t.id_turno,
    '4567890123456',
    '2025-11-19 16:00:00-03',
    400,
    'MEDIA',
    'Surto de gripe H3N2 na região. Demanda triplicou em relação ao mês anterior.'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '12452364335' 
  AND t.cnes_entidade_saude = '2751502' 
  AND t.tstz_entrada = '2025-11-19 14:00:00-03';

-- Pedido 7: Vacina Hepatite B - Urgência BAIXA (campanha programada)
-- Turno: Enfermeira Maria Clara no Hospital UFSCar - 2025-11-18 07:00
INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
SELECT 
    t.id_turno,
    '6789012345678',
    '2025-11-18 08:30:00-03',
    100,
    'BAIXA',
    'Campanha de vacinação programada para funcionários. Solicitação com antecedência de 15 dias.'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '34567891234' 
  AND t.cnes_entidade_saude = '2751501' 
  AND t.tstz_entrada = '2025-11-18 07:00:00-03';

-- Pedido 8: Ibuprofeno - Urgência EXTREMA (pós-operatório)
-- Turno: Médico Henrique no Hospital São Paulo - 2025-11-09 08:00
INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
SELECT 
    t.id_turno,
    '9012345678901',
    '2025-11-09 14:00:00-03',
    200,
    'EXTREMA',
    'Alta demanda cirúrgica. Pacientes em pós-operatório necessitando controle de dor e inflamação urgente.'
FROM turno t
JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
WHERE p.cpf = '23565323453' 
  AND t.cnes_entidade_saude = '2751503' 
  AND t.tstz_entrada = '2025-11-09 08:00:00-03';


-- ========================================
-- RELATÓRIOS DE RECURSO (Análise pelos Diretores)
-- ========================================

-- Relatório 1: Pedido de Vacina COVID-19 - APROVADO
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    p.id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '10111213141'),  -- Diretor Roberto (Hospital UFSCar)
    '2025-11-18 13:00:00-03',
    'APROVADO',
    'Pedido justificado pela campanha emergencial. Aprovado fornecimento integral.'
FROM pedido p
JOIN turno t ON p.id_turno = t.id_turno
JOIN pessoa pes ON t.id_trabalhador_es = pes.id_pessoa
WHERE pes.cpf = '40420248282' 
  AND p.registro_ms_recurso = '1234567890123'
  AND p.tstz_pedido = '2025-11-18 11:00:00-03';

-- Relatório 2: Pedido de Dipirona - APROVADO
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    p.id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '20212223242'),  -- Diretora Cristina (Santa Casa)
    '2025-11-18 17:00:00-03',
    'APROVADO',
    'Reposição necessária. Aprovado 80% da quantidade solicitada (400 unidades).'
FROM pedido p
JOIN turno t ON p.id_turno = t.id_turno
JOIN pessoa pes ON t.id_trabalhador_es = pes.id_pessoa
WHERE pes.cpf = '12452364335' 
  AND p.registro_ms_recurso = '2345678901234'
  AND p.tstz_pedido = '2025-11-18 15:30:00-03';

-- Relatório 3: Pedido de Insulina - APROVADO
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    p.id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '30313233343'),  -- Diretor Eduardo (Hospital São Paulo)
    '2025-11-16 11:30:00-03',
    'APROVADO',
    'Emergência médica. Aprovado fornecimento prioritário e integral.'
FROM pedido p
JOIN turno t ON p.id_turno = t.id_turno
JOIN pessoa pes ON t.id_trabalhador_es = pes.id_pessoa
WHERE pes.cpf = '23565323453' 
  AND p.registro_ms_recurso = '5678901234567'
  AND p.tstz_pedido = '2025-11-16 10:00:00-03';

-- Relatório 4: Pedido de Amoxicilina - RECUSADO
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    p.id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '10111213141'),  -- Diretor Roberto (Hospital UFSCar)
    '2025-11-19 14:00:00-03',
    'RECUSADO',
    'Estoque atual suficiente para 10 dias. Reavaliação em caso de piora do cenário epidemiológico.'
FROM pedido p
JOIN turno t ON p.id_turno = t.id_turno
JOIN pessoa pes ON t.id_trabalhador_es = pes.id_pessoa
WHERE pes.cpf = '40420248282' 
  AND p.registro_ms_recurso = '7890123456789'
  AND p.tstz_pedido = '2025-11-19 11:30:00-03';

-- Relatório 5: Pedido de Soro Fisiológico - ANALISE
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    p.id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '10111213141'),  -- Sem diretor no Hospital Sagrada Família, usando Roberto
    '2025-11-18 10:00:00-03',
    'ANALISE',
    'Aguardando análise de viabilidade orçamentária e verificação de fornecedores disponíveis.'
FROM pedido p
JOIN turno t ON p.id_turno = t.id_turno
JOIN pessoa pes ON t.id_trabalhador_es = pes.id_pessoa
WHERE pes.cpf = '60616263646' 
  AND p.registro_ms_recurso = '8901234567890'
  AND p.tstz_pedido = '2025-11-18 09:00:00-03';

-- Relatório 6: Pedido de Paracetamol - APROVADO
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    p.id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '20212223242'),  -- Diretora Cristina (Santa Casa)
    '2025-11-19 18:00:00-03',
    'APROVADO',
    'Surto confirmado. Aprovado fornecimento integral com prioridade.'
FROM pedido p
JOIN turno t ON p.id_turno = t.id_turno
JOIN pessoa pes ON t.id_trabalhador_es = pes.id_pessoa
WHERE pes.cpf = '12452364335' 
  AND p.registro_ms_recurso = '4567890123456'
  AND p.tstz_pedido = '2025-11-19 16:00:00-03';


-- ========================================
-- REQUISIÇÕES (Gestor solicita aos fornecedores)
-- ========================================

-- Requisição 1: Vacina COVID-19 aprovada
INSERT INTO requisicao (id_requisicao, id_gestor_sistema, tstz_requisicao)
SELECT 
    rr.id_pedido_relatorio,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '78912345678'),  -- Gestor Carlos Eduardo
    '2025-11-18 14:00:00-03'
FROM relatorio_recurso rr
JOIN pedido p ON rr.id_pedido_relatorio = p.id_pedido
WHERE p.registro_ms_recurso = '1234567890123'
  AND p.tstz_pedido = '2025-11-18 11:00:00-03';

-- Requisição 2: Dipirona aprovada
INSERT INTO requisicao (id_requisicao, id_gestor_sistema, tstz_requisicao)
SELECT 
    rr.id_pedido_relatorio,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '89123456789'),  -- Gestora Patricia
    '2025-11-18 18:00:00-03'
FROM relatorio_recurso rr
JOIN pedido p ON rr.id_pedido_relatorio = p.id_pedido
WHERE p.registro_ms_recurso = '2345678901234'
  AND p.tstz_pedido = '2025-11-18 15:30:00-03';

-- Requisição 3: Insulina aprovada
INSERT INTO requisicao (id_requisicao, id_gestor_sistema, tstz_requisicao)
SELECT 
    rr.id_pedido_relatorio,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '78912345678'),  -- Gestor Carlos Eduardo
    '2025-11-16 12:00:00-03'
FROM relatorio_recurso rr
JOIN pedido p ON rr.id_pedido_relatorio = p.id_pedido
WHERE p.registro_ms_recurso = '5678901234567'
  AND p.tstz_pedido = '2025-11-16 10:00:00-03';

-- Requisição 4: Paracetamol aprovado
INSERT INTO requisicao (id_requisicao, id_gestor_sistema, tstz_requisicao)
SELECT 
    rr.id_pedido_relatorio,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '89123456789'),  -- Gestora Patricia
    '2025-11-19 19:00:00-03'
FROM relatorio_recurso rr
JOIN pedido p ON rr.id_pedido_relatorio = p.id_pedido
WHERE p.registro_ms_recurso = '4567890123456'
  AND p.tstz_pedido = '2025-11-19 16:00:00-03';


-- ========================================
-- FORNECIMENTO (Quais laboratórios vão fornecer)
-- ========================================

-- Fornecimento 1: Vacina COVID-19 do Lab Bio Análises
INSERT INTO fornecimento (id_requisicao, cnes_entidade_saude)
SELECT 
    req.id_requisicao,
    '2751801'  -- Lab Bio Análises (produz Vacina COVID)
FROM requisicao req
JOIN pedido p ON req.id_requisicao = p.id_pedido
WHERE p.registro_ms_recurso = '1234567890123'
  AND p.tstz_pedido = '2025-11-18 11:00:00-03';

-- Fornecimento 2: Dipirona do Lab Fleury
INSERT INTO fornecimento (id_requisicao, cnes_entidade_saude)
SELECT 
    req.id_requisicao,
    '2751802'  -- Lab Fleury (produz Dipirona)
FROM requisicao req
JOIN pedido p ON req.id_requisicao = p.id_pedido
WHERE p.registro_ms_recurso = '2345678901234'
  AND p.tstz_pedido = '2025-11-18 15:30:00-03';

-- Fornecimento 3: Insulina do Lab Bio Análises
INSERT INTO fornecimento (id_requisicao, cnes_entidade_saude)
SELECT 
    req.id_requisicao,
    '2751801'  -- Lab Bio Análises (produz Insulina)
FROM requisicao req
JOIN pedido p ON req.id_requisicao = p.id_pedido
WHERE p.registro_ms_recurso = '5678901234567'
  AND p.tstz_pedido = '2025-11-16 10:00:00-03';

-- Fornecimento 4: Paracetamol do Lab Fleury
INSERT INTO fornecimento (id_requisicao, cnes_entidade_saude)
SELECT 
    req.id_requisicao,
    '2751802'  -- Lab Fleury (produz Paracetamol)
FROM requisicao req
JOIN pedido p ON req.id_requisicao = p.id_pedido
WHERE p.registro_ms_recurso = '4567890123456'
  AND p.tstz_pedido = '2025-11-19 16:00:00-03';


-- ========================================
-- TRANSPORTA (Transporte dos recursos)
-- ========================================

-- Transporte 1: Vacina COVID-19 para Hospital UFSCar
INSERT INTO transporta (cnpj_transportadora, id_requisicao, cnes_entidade_saude, tempo_rota, quantidade_transportada)
SELECT 
    '12345678000190',  -- TransMed (suporta -80°C)
    req.id_requisicao,
    '2751801',
    INTERVAL '2 hours',
    200
FROM requisicao req
JOIN pedido p ON req.id_requisicao = p.id_pedido
WHERE p.registro_ms_recurso = '1234567890123'
  AND p.tstz_pedido = '2025-11-18 11:00:00-03';

-- Transporte 2: Dipirona para Santa Casa
INSERT INTO transporta (cnpj_transportadora, id_requisicao, cnes_entidade_saude, tempo_rota, quantidade_transportada)
SELECT 
    '98765432000123',  -- VitaLog
    req.id_requisicao,
    '2751802',
    INTERVAL '3 hours',
    400
FROM requisicao req
JOIN pedido p ON req.id_requisicao = p.id_pedido
WHERE p.registro_ms_recurso = '2345678901234'
  AND p.tstz_pedido = '2025-11-18 15:30:00-03';

-- Transporte 3: Insulina para Hospital São Paulo
INSERT INTO transporta (cnpj_transportadora, id_requisicao, cnes_entidade_saude, tempo_rota, quantidade_transportada)
SELECT 
    '98765432000123',  -- VitaLog (suporta refrigeração)
    req.id_requisicao,
    '2751801',
    INTERVAL '1 hour 30 minutes',
    50
FROM requisicao req
JOIN pedido p ON req.id_requisicao = p.id_pedido
WHERE p.registro_ms_recurso = '5678901234567'
  AND p.tstz_pedido = '2025-11-16 10:00:00-03';

-- Transporte 4: Paracetamol para Santa Casa
INSERT INTO transporta (cnpj_transportadora, id_requisicao, cnes_entidade_saude, tempo_rota, quantidade_transportada)
SELECT 
    '98765432000123',  -- VitaLog
    req.id_requisicao,
    '2751802',
    INTERVAL '2 hours 45 minutes',
    400
FROM requisicao req
JOIN pedido p ON req.id_requisicao = p.id_pedido
WHERE p.registro_ms_recurso = '4567890123456'
  AND p.tstz_pedido = '2025-11-19 16:00:00-03';
