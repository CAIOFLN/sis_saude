-- ========================================
-- DADOS CONSULTA 2: PEDIDOS COM DEMANDA ABSURDA
-- ========================================
-- Este arquivo contém pedidos com demandas absurdamente altas
-- Todos os pedidos ficam EM ANÁLISE devido à alta demanda
-- ========================================


-- ========================================
-- CASO 1: VACINA COVID-19 - 35.000 DOSES (EM ANÁLISE)
-- ========================================

-- Turno 1: Médico Henrique no Hospital São Paulo - 2025-11-21 08:00
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751503', '2025-11-21 08:00:00-03', '2025-11-21 18:00:00-03'
FROM pessoa WHERE cpf = '23565323453';

WITH ped AS (
    INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
    SELECT 
        t.id_turno,
        '1234567890123',
        '2025-11-21 10:00:00-03',
        9890,
        'EXTREMA',
        'Governo Estadual designou hospital como polo regional de vacinação para 15 municípios. Campanha de imunização em massa contra nova variante do COVID-19. Necessário estoque para atender população estimada de 350 mil pessoas. Prazo: 20 dias.'
    FROM turno t
    JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
    WHERE p.cpf = '23565323453' 
      AND t.cnes_entidade_saude = '2751503' 
      AND t.tstz_entrada = '2025-11-21 08:00:00-03'
    RETURNING id_pedido
)
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '30313233343'),
    '2025-11-21 16:00:00-03',
    'ANALISE',
    'Demanda excepcionalmente alta. Aguardando validação orçamentária estadual e análise de viabilidade logística. Necessário avaliação de infraestrutura de armazenamento.'
FROM ped;


-- ========================================
-- CASO 2: SORO FISIOLÓGICO - 22.000 UNIDADES (EM ANÁLISE)
-- ========================================

-- Turno 2: Médico Guilherme no Hospital UFSCar - 2025-11-22 08:00
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751501', '2025-11-22 08:00:00-03', '2025-11-22 18:00:00-03'
FROM pessoa WHERE cpf = '40420248282';

WITH ped AS (
    INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
    SELECT 
        t.id_turno,
        '8901234567890',
        '2025-11-22 09:30:00-03',
        9999,
        'EXTREMA',
        'Surto de intoxicação alimentar em massa em 5 cidades. Hospital referência para hidratação venosa. Previsão de 4.000 atendimentos em 15 dias. Protocolo da Vigilância Sanitária.'
    FROM turno t
    JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
    WHERE p.cpf = '40420248282' 
      AND t.cnes_entidade_saude = '2751501' 
      AND t.tstz_entrada = '2025-11-22 08:00:00-03'
    RETURNING id_pedido
)
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '10111213141'),
    '2025-11-22 14:00:00-03',
    'ANALISE',
    'Volume muito acima da média. Verificando estoque do sistema e capacidade de fornecedores. Aguardando confirmação epidemiológica da Vigilância Sanitária.'
FROM ped;


-- ========================================
-- CASO 3: PARACETAMOL - 30.000 COMPRIMIDOS (EM ANÁLISE)
-- ========================================

-- Turno 3: Médica Ana Beatriz na Santa Casa - 2025-11-22 14:00
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751502', '2025-11-22 14:00:00-03', '2025-11-23 00:00:00-03'
FROM pessoa WHERE cpf = '12452364335';

WITH ped AS (
    INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
    SELECT 
        t.id_turno,
        '4567890123456',
        '2025-11-22 16:00:00-03',
        8040,
        'MEDIA',
        'Contrato com Secretaria Municipal para centralização de distribuição. Hospital será centro logístico para 45 UBS por 4 meses. Sistema municipal unificado.'
    FROM turno t
    JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
    WHERE p.cpf = '12452364335' 
      AND t.cnes_entidade_saude = '2751502' 
      AND t.tstz_entrada = '2025-11-22 14:00:00-03'
    RETURNING id_pedido
)
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '20212223242'),
    '2025-11-22 20:00:00-03',
    'ANALISE',
    'Quantidade incompatível com urgência MEDIA. Analisando contrato municipal e prazo de validade do medicamento. Risco de perda por vencimento.'
FROM ped;


-- ========================================
-- CASO 4: INSULINA - 12.000 FRASCOS (EM ANÁLISE)
-- ========================================

-- Turno 4: Enfermeira Roberta na Sagrada Família - 2025-11-23 08:00
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751504', '2025-11-23 08:00:00-03', '2025-11-23 18:00:00-03'
FROM pessoa WHERE cpf = '60616263646';

WITH ped AS (
    INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
    SELECT 
        t.id_turno,
        '5678901234567',
        '2025-11-23 10:00:00-03',
        9870,
        'EXTREMA',
        'Programa Estadual de Diabetes - Fase 2. Centro de distribuição para 25 municípios. Cadastro de 12.000 pacientes insulinodependentes. Fornecimento trimestral - Lei 15.789/2025.'
    FROM turno t
    JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
    WHERE p.cpf = '60616263646' 
      AND t.cnes_entidade_saude = '2751504' 
      AND t.tstz_entrada = '2025-11-23 08:00:00-03'
    RETURNING id_pedido
)
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '10111213141'),
    '2025-11-23 15:00:00-03',
    'ANALISE',
    'Programa de grande porte. Validando convênio com laboratórios e verificando capacidade de armazenamento refrigerado. Aguardando parecer jurídico sobre Lei 15.789/2025.'
FROM ped;


-- ========================================
-- CASO 5: DIPIRONA - 40.000 COMPRIMIDOS (EM ANÁLISE)
-- ========================================

-- Turno 5: Médico Henrique no Hospital São Paulo - 2025-11-23 08:00
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751503', '2025-11-23 08:00:00-03', '2025-11-23 18:00:00-03'
FROM pessoa WHERE cpf = '23565323453';

WITH ped AS (
    INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
    SELECT 
        t.id_turno,
        '2345678901234',
        '2025-11-23 11:00:00-03',
        9703,
        'EXTREMA',
        'Epidemia de dengue em 8 municípios. Hospital referência estadual. Projeção de 8.000 casos em 60 dias. Estoque estratégico - protocolo do Ministério da Saúde.'
    FROM turno t
    JOIN pessoa p ON t.id_trabalhador_es = p.id_pessoa
    WHERE p.cpf = '23565323453' 
      AND t.cnes_entidade_saude = '2751503' 
      AND t.tstz_entrada = '2025-11-23 08:00:00-03'
    RETURNING id_pedido
)
INSERT INTO relatorio_recurso (id_pedido_relatorio, id_diretor, tstz_relatorio_recurso, estado_relatorio, justificativa_decisao)
SELECT 
    id_pedido,
    (SELECT id_pessoa FROM pessoa WHERE cpf = '30313233343'),
    '2025-11-23 17:00:00-03',
    'ANALISE',
    'Demanda massiva. Confirmando declaração de epidemia e verificando disponibilidade nacional. Necessário coordenação com Ministério da Saúde para liberação de estoque estratégico.'
FROM ped;

