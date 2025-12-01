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
-- CASO 3: PARACETAMOL - 30.000 COMPRIMIDOS (EM ANÁLISE) E 
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
-- DADOS CONSULTA 3: RECURSOS EM LABORATÓRIOS E HOSPITAIS
-- ========================================
-- Este arquivo cria um hospital e um laboratório e insere recursos de formas diferentes para testar a resposta
-- ========================================

-- Criamos um hospital e um laboratório 

INSERT INTO entidade_saude (cnes, nome, tipo_entidade, cep, numero_endereco) VALUES
('3950217', 'Hospital Santa Validação', 'HOSPITAL', '12345678', '100'),
('3950218', 'Laboratório Farmacêutico Oficial', 'LABORATORIO', '87654321', '200');

INSERT INTO hospital (cnes_hospital, leitos_normais_disp, leitos_uti_disp) VALUES
('3950217', 50, 10);

INSERT INTO laboratorio (cnes_laboratorio) VALUES
('3950218');

-- Precisamos inserir novos recursos

-- ========================================
-- -- CASO 1: PRODUZIDO PELO LAB, MAS HOSPITAL NÃO TEM REGISTRO
-- -- DEVE APARECER POIS NÃO TEM ESTOQUE
-- ========================================
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('1000000000001', 'Amoxicilina 500mg', 'Medicamento', 15.00, 30.00);

-- ========================================
-- -- CASO 2: PRODUZIDO PELO LAB, HOSPITAL TEM REGISTRO MAS QTD=0
-- -- DEVE APARECER POIS O ESTOQUE ESTÁ ZERADO
-- ========================================
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('1000000000002', 'Omeprazol 20mg', 'Medicamento', 15.00, 30.00);


-- ========================================
-- -- CASO 3: PRODUZIDO PELO LAB E HOSPITAL TEM ESTOQUE
-- -- NÃO DEVE APARECER
-- ========================================
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('1000000000003', 'Simvastatina 20mg', 'Medicamento', 15.00, 30.00);

-- ========================================
-- -- CASO 4: NINGUÉM PRODUZ
-- -- NÃO DEVE APARECER
-- ========================================
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('1000000000004', 'Clonazepam 2.5mg', 'Medicamento', 15.00, 30.00);
-- ========================================
-- -- CASO 5: PRODUZIDO, LAB TEM ESTOQUE, MAS HOSPITAL NÃO
-- -- DEVE APARECER
-- ========================================
INSERT INTO recurso (registro_ms, nome, tipo, temp_min, temp_max)
VALUES ('1000000000005', 'Metformina 850mg', 'Medicamento', 15.00, 30.00);

-- Criamos a tabela produz pros nossos dados, conforme explicado pelos casos acima
-- Laboratório produz todos, menos o Clonazepam (CASO 4)
INSERT INTO produz (cnes_laboratorio, registro_ms_recurso) VALUES
('3950218', '1000000000001'), 
('3950218', '1000000000002'), 
('3950218', '1000000000003'), 
('3950218', '1000000000005'); 

-- Criamos o estoque da entidade de saúde com a tabela possui

-- O Hospital tem Simvastatina em estoque (CASO 3)
INSERT INTO possui (cnes_entidade_saude, registro_ms_recurso, quantidade_disponivel) VALUES
('3950217', '1000000000003', 100),

-- O Hospital tem Omeprazol cadastrado, mas acabou (QTD=0) (CASO 2)
('3950217', '1000000000002', 0),

-- O Laboratório tem estoque de Metformina para fornecer, mas o hospital não tem nada, nem registro na tabela possui(CASO 5)
('3950218', '1000000000005', 500);

-- A Amoxicilina não entra no 'possui, pois o hospital nunca recebeu(CASO 1)













-- ========================================
-- DADOS CONSULTA 4: HOSPITAIS COM AS 3 ESPECIALIDADES MENOS FREQUENTES
-- ========================================
-- As 3 menos frequentes sao Cardiologia, Pediatria,Ortopedia em que apenas os hospitais 2751501, 2751501, 2751501
-- Criei esses hospitais para aumentar a frequencia das especialidades Reumatologia e Geriatria
-- No fim a contegem ficou:
-- Cardiologia, Pediatria, Ortopedia = 3
-- Gereatria = 6
-- Reumatologia = 7


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

INSERT INTO especializacoes (cnes_hospital, especialidade)
VALUES 
    ('2751505', 'Reumatologia');

INSERT INTO especializacoes (cnes_hospital, especialidade)
VALUES 
    ('2751506', 'Reumatologia');

INSERT INTO especializacoes (cnes_hospital, especialidade)
VALUES 
    ('2751507', 'Geriatria');

