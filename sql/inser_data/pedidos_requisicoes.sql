------------------------------------------------------------
-- INSERÇÃO DE PEDIDOS, RELATÓRIOS DE RECURSO, REQUISIÇÕES E TRANSPORTE
------------------------------------------------------------
-- Cada pedido segue o fluxo completo: pedido -> relatório -> requisição -> fornecimento -> transporte
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
-- PEDIDO 1: VACINA COVID-19  
-- ========================================
WITH ped AS (
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
      AND t.tstz_entrada = '2025-11-18 08:00:00-03'
    RETURNING id_pedido
),
rel AS (
    INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
    SELECT 
        id_pedido,
        (SELECT id_pessoa FROM pessoa WHERE cpf = '10111213141'),
        '2025-11-18 13:00:00-03',
        'APROVADO',
        'Pedido justificado pela campanha emergencial. Aprovado fornecimento integral.'
    FROM ped
    RETURNING id_pedido_relatorio
),
req AS (
    INSERT INTO requisicao (id_requisicao, id_gestor_sistema, tstz_requisicao)
    SELECT 
        id_pedido_relatorio,
        (SELECT id_pessoa FROM pessoa WHERE cpf = '78912345678'),
        '2025-11-18 14:00:00-03'
    FROM rel
    RETURNING id_requisicao
),
forn AS (
    INSERT INTO fornecimento (id_requisicao, cnes_entidade_saude)
    SELECT id_requisicao, '2751801'
    FROM req
    RETURNING id_requisicao, cnes_entidade_saude
)
INSERT INTO transporta (cnpj_transportadora, id_requisicao, cnes_entidade_saude, tempo_rota, quantidade_transportada)
SELECT '12345678000190', id_requisicao, cnes_entidade_saude, '02:00:00', 200
FROM forn;


-- ========================================
-- PEDIDO 2: DIPIRONA  
-- ========================================
WITH ped AS (
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
      AND t.tstz_entrada = '2025-11-18 14:00:00-03'
    RETURNING id_pedido
),
rel AS (
    INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
    SELECT 
        id_pedido,
        (SELECT id_pessoa FROM pessoa WHERE cpf = '20212223242'),
        '2025-11-18 17:00:00-03',
        'APROVADO',
        'Reposição necessária. Aprovado 80% da quantidade solicitada (400 unidades).'
    FROM ped
    RETURNING id_pedido_relatorio
),
req AS (
    INSERT INTO requisicao (id_requisicao, id_gestor_sistema, tstz_requisicao)
    SELECT 
        id_pedido_relatorio,
        (SELECT id_pessoa FROM pessoa WHERE cpf = '89123456789'),
        '2025-11-18 18:00:00-03'
    FROM rel
    RETURNING id_requisicao
),
forn AS (
    INSERT INTO fornecimento (id_requisicao, cnes_entidade_saude)
    SELECT id_requisicao, '2751802'
    FROM req
    RETURNING id_requisicao, cnes_entidade_saude
)
INSERT INTO transporta (cnpj_transportadora, id_requisicao, cnes_entidade_saude, tempo_rota, quantidade_transportada)
SELECT '98765432000123', id_requisicao, cnes_entidade_saude, '03:00:00', 400
FROM forn;


-- ========================================
-- PEDIDO 3: INSULINA  
-- ========================================
WITH ped AS (
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
      AND t.tstz_entrada = '2025-11-16 08:00:00-03'
    RETURNING id_pedido
),
rel AS (
    INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
    SELECT 
        id_pedido,
        (SELECT id_pessoa FROM pessoa WHERE cpf = '30313233343'),
        '2025-11-16 11:30:00-03',
        'APROVADO',
        'Emergência médica. Aprovado fornecimento prioritário e integral.'
    FROM ped
    RETURNING id_pedido_relatorio
),
req AS (
    INSERT INTO requisicao (id_requisicao, id_gestor_sistema, tstz_requisicao)
    SELECT 
        id_pedido_relatorio,
        (SELECT id_pessoa FROM pessoa WHERE cpf = '78912345678'),
        '2025-11-16 12:00:00-03'
    FROM rel
    RETURNING id_requisicao
),
forn AS (
    INSERT INTO fornecimento (id_requisicao, cnes_entidade_saude)
    SELECT id_requisicao, '2751801'
    FROM req
    RETURNING id_requisicao, cnes_entidade_saude
)
INSERT INTO transporta (cnpj_transportadora, id_requisicao, cnes_entidade_saude, tempo_rota, quantidade_transportada)
SELECT '98765432000123', id_requisicao, cnes_entidade_saude, '01:30:00', 50
FROM forn;


-- ========================================
-- PEDIDO 4: AMOXICILINA (RECUSADO)
-- ========================================
WITH ped AS (
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
      AND t.tstz_entrada = '2025-11-19 08:00:00-03'
    RETURNING id_pedido
)
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '10111213141'),
    '2025-11-19 14:00:00-03',
    'RECUSADO',
    'Estoque atual suficiente para 10 dias. Reavaliação em caso de piora do cenário epidemiológico.'
FROM ped;


-- ========================================
-- PEDIDO 5: SORO FISIOLÓGICO (EM ANÁLISE)
-- ========================================
WITH ped AS (
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
      AND t.tstz_entrada = '2025-11-18 08:00:00-03'
    RETURNING id_pedido
)
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '10111213141'),
    '2025-11-18 10:00:00-03',
    'ANALISE',
    'Aguardando análise de viabilidade orçamentária e verificação de fornecedores disponíveis.'
FROM ped;


-- ========================================
-- PEDIDO 6: PARACETAMOL  
-- ========================================
WITH ped AS (
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
      AND t.tstz_entrada = '2025-11-19 14:00:00-03'
    RETURNING id_pedido
),
rel AS (
    INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
    SELECT 
        id_pedido,
        (SELECT id_pessoa FROM pessoa WHERE cpf = '20212223242'),
        '2025-11-19 18:00:00-03',
        'APROVADO',
        'Surto confirmado. Aprovado fornecimento integral com prioridade.'
    FROM ped
    RETURNING id_pedido_relatorio
),
req AS (
    INSERT INTO requisicao (id_requisicao, id_gestor_sistema, tstz_requisicao)
    SELECT 
        id_pedido_relatorio,
        (SELECT id_pessoa FROM pessoa WHERE cpf = '89123456789'),
        '2025-11-19 19:00:00-03'
    FROM rel
    RETURNING id_requisicao
),
forn AS (
    INSERT INTO fornecimento (id_requisicao, cnes_entidade_saude)
    SELECT id_requisicao, '2751802'
    FROM req
    RETURNING id_requisicao, cnes_entidade_saude
)
INSERT INTO transporta (cnpj_transportadora, id_requisicao, cnes_entidade_saude, tempo_rota, quantidade_transportada)
SELECT '98765432000123', id_requisicao, cnes_entidade_saude, '02:45:00', 400
FROM forn;


-- ========================================
-- PEDIDO 7: VACINA HEPATITE B (BAIXA PRIORIDADE - SEM RELATÓRIO)
-- ========================================

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
-- Nota: Pedido com urgência BAIXA ainda não analisado pelo diretor


-- ========================================
-- PEDIDO 8: IBUPROFENO (EXTREMA - SEM RELATÓRIO)
-- ========================================

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
-- Nota: Pedido urgente ainda aguardando análise do diretor 