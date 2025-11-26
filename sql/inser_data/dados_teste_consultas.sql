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
        'Solicitação de 9.890 doses para campanha massiva. Pedido aguarda análise da diretoria devido ao volume excepcionalmente alto e necessidade de validação orçamentária.'
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
        'Requisição de 9.999 unidades para atendimento de emergência. Aguarda análise técnica da disponibilidade no sistema e confirmação epidemiológica.'
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
        'Pedido de 8.040 comprimidos para distribuição municipal. Aguarda validação do contrato e análise de risco de vencimento devido ao volume.'
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
        'Solicitação de 9.870 frascos para programa estadual. Aguarda verificação de capacidade de armazenamento refrigerado e parecer jurídico.'
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
        'Requisição de 9.703 comprimidos para estoque estratégico. Aguarda confirmação de declaração de epidemia e coordenação com o Ministério da Saúde.'
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


WITH ped AS (
    INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
    SELECT 
        t.id_turno,
        '7890123456789',
        '2025-11-19 14:30:00-03',
        9999,
        'MEDIA',
        'Aumento grave de casos de pneumonia comunitária. Antibiótico de primeira escolha em falta no estoque.'
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
    'ANALISE',
    ''
FROM ped;

INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('1625434555667', 'Atorvastatina Cálcica 50mg', 'Medicamento', 15.00, 30.00);

WITH ped AS (
    INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, quantidade, urgencia, justificativa)
    SELECT 
        t.id_turno,
        '1625434555667',
        '2025-11-19 14:35:00-03',
        1240,
        'BAIXA',
        'Aumento de pacientes com hipercolesterolemia.'
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
    'ANALISE',
    ''
FROM ped;


-- ========================================
-- DADOS CONSULTA 4: HOSPITAIS COM AS 3 ESPECIALIDADES MENOS FREQUENTES
-- ========================================
-- Este arquivo cria um cenário para testar a consulta que busca hospitais
-- que atendem TODAS as 3 especialidades menos frequentes

-- Criar 3 hospitais novos para teste
INSERT INTO entidade_saude (cnes, nome, telefone, horario_funcionamento, cep, numero_endereco, tipo_entidade)
VALUES 
    ('2751505', 'Hospital Albert Einstein São Carlos', '(16)3377-0001', '24 horas', '13560250', '100', 'HOSPITAL'),
    ('2751506', 'Hospital Santa Rita de Cássia', '(16)3377-0002', '24 horas', '13560250', '200', 'HOSPITAL'),
    ('2751507', 'Hospital Sírio-Libanês São Carlos', '(16)3377-0003', '24 horas', '13560250', '300', 'HOSPITAL');

INSERT INTO hospital (cnes_hospital, leitos_normais_disp, leitos_uti_disp)
VALUES 
    ('2751505', 80, 10),
    ('2751506', 60, 8),
    ('2751507', 100, 15);

-- Adicionar especialidades RARAS aos hospitais
-- Vamos usar: REUMATOLOGIA, ENDOCRINOLOGIA, GERIATRIA como as 3 menos frequentes

-- Hospital 2751501: Adicionar REUMATOLOGIA (será 1ª ocorrência - MENOS FREQUENTE #1)
INSERT INTO especializacoes (cnes_hospital, especialidade)
VALUES ('2751501', 'Reumatologia');

-- Hospital 2751502: Adicionar ENDOCRINOLOGIA (será 1ª ocorrência - MENOS FREQUENTE #2)
INSERT INTO especializacoes (cnes_hospital, especialidade)
VALUES ('2751502', 'Endocrinologia');

-- Hospital 2751503: Adicionar GERIATRIA (será 1ª ocorrência - MENOS FREQUENTE #3)
INSERT INTO especializacoes (cnes_hospital, especialidade)
VALUES ('2751503', 'Geriatria');

-- Hospital 2751505 (NOVO): TEM todas as 3 especialidades menos frequentes ✓
INSERT INTO especializacoes (cnes_hospital, especialidade)
VALUES 
    ('2751505', 'Reumatologia'),     -- Rara (2ª ocorrência)
    ('2751505', 'Endocrinologia'),   -- Rara (2ª ocorrência)
    ('2751505', 'Geriatria'),        -- Rara (2ª ocorrência)
    ('2751505', 'Cardiologia'),      -- Comum
    ('2751505', 'Pediatria');        -- Comum

-- Hospital 2751506 (NOVO): Tem apenas 2 das 3 especialidades menos frequentes ✗
-- Tem REUMATOLOGIA e ENDOCRINOLOGIA, mas falta GERIATRIA
INSERT INTO especializacoes (cnes_hospital, especialidade)
VALUES 
    ('2751506', 'Reumatologia'),     -- Rara (3ª ocorrência)
    ('2751506', 'Endocrinologia'),   -- Rara (3ª ocorrência)
    ('2751506', 'Cardiologia'),      -- Comum
    ('2751506', 'Ortopedia');        -- Comum

-- Hospital 2751507 (NOVO): TEM todas as 3 especialidades menos frequentes ✓
INSERT INTO especializacoes (cnes_hospital, especialidade)
VALUES 
    ('2751507', 'Reumatologia'),     -- Rara (4ª ocorrência)
    ('2751507', 'Endocrinologia'),   -- Rara (4ª ocorrência)
    ('2751507', 'Geriatria'),        -- Rara (3ª ocorrência)
    ('2751507', 'Neurologia'),       -- Comum
    ('2751507', 'Pediatria');        -- Comum

-- ========================================
-- FREQUÊNCIAS FINAIS:
-- ========================================
-- GERIATRIA: 3 ocorrências (2751503, 2751505, 2751507) - MENOS FREQUENTE #1
-- REUMATOLOGIA: 4 ocorrências (2751501, 2751505, 2751506, 2751507) - MENOS FREQUENTE #2
-- ENDOCRINOLOGIA: 4 ocorrências (2751502, 2751505, 2751506, 2751507) - MENOS FREQUENTE #3
-- Neonatologia: 1 ocorrência (2751504) 
-- Traumatologia: 1 ocorrência (2751502)
-- Cirurgia Geral: 1 ocorrência (2751503)
-- Ginecologia: 1 ocorrência (2751503)
-- Oncologia: 1 ocorrência (2751502)
-- Neurologia: 2 ocorrências (2751502, 2751507)
-- Obstetrícia: 2 ocorrências (2751503, 2751504)
-- Ortopedia: 3 ocorrências (2751501, 2751506)
-- Pediatria: 4 ocorrências (2751501, 2751504, 2751505, 2751507)
-- Cardiologia: 5 ocorrências (2751501, 2751502, 2751503, 2751505, 2751506)
-- ========================================
-- ATENÇÃO: A consulta usa ORDER BY COUNT(*) ASC e LIMIT 3
-- Então as 3 menos frequentes serão as 3 primeiras em ordem crescente
-- =======================================
