------------------------------------------------------------
-- INSERÇÃO RELACIONADAS A ENTIDADES DE SAÚDE
------------------------------------------------------------

-- Inserindo 3 Laboratórios
INSERT INTO entidade_saude (cnes, nome, telefone, horario_funcionamento, cep, numero_endereco, complemento_endereco, tipo_entidade)
VALUES 
    ('2751801', 'Laboratório Bio Análises', '(16)99876-5432', '07:00 - 18:00 Segunda a Sexta', '13560250', '450', 'Sala 12', 'LABORATORIO'),
    ('2751802', 'Laboratório Fleury São Carlos', '(16)3371-2345', '06:00 - 20:00 Segunda a Sábado', '13566590', '1250', 'Térreo', 'LABORATORIO'),
    ('2751803', 'Laboratório Clínico Central', '(16)3372-8899', '08:00 - 17:00 Segunda a Sexta', '13560460', '789', NULL, 'LABORATORIO');

-- Inserindo os laboratórios na tabela especializada
INSERT INTO laboratorio (cnes_laboratorio)
VALUES 
    ('2751801'),
    ('2751802'),
    ('2751803');

-- Inserindo 4 Hospitais
INSERT INTO entidade_saude (cnes, nome, telefone, horario_funcionamento, cep, numero_endereco, complemento_endereco, tipo_entidade)
VALUES 
    ('2751501', 'Hospital Universitário UFSCar', '(16)3351-8111', '24 horas', '13565905', '300', NULL, 'HOSPITAL'),
    ('2751502', 'Santa Casa de São Carlos', '(16)3362-1000', '24 horas', '13560460', '1177', 'Pronto Socorro', 'HOSPITAL'),
    ('2751503', 'Hospital São Paulo', '(16)3376-4500', '24 horas', '13561320', '2555', 'Bloco A', 'HOSPITAL'),
    ('2751504', 'Hospital e Maternidade Sagrada Família', '(16)3372-9900', '24 horas', '13560250', '890', NULL, 'HOSPITAL');

-- Inserindo os hospitais na tabela especializada com leitos
INSERT INTO hospital (cnes_hospital, leitos_normais_disp, leitos_uti_disp)
VALUES 
    ('2751501', 120, 15),
    ('2751502', 250, 30),
    ('2751503', 180, 20),
    ('2751504', 95, 12);

-- Inserindo especializações dos hospitais
INSERT INTO especializacoes (cnes_hospital, especialidade)
VALUES 
    ('2751501', 'Cardiologia'),
    ('2751501', 'Pediatria'),
    ('2751501', 'Ortopedia'),
    ('2751502', 'Cardiologia'),
    ('2751502', 'Neurologia'),
    ('2751502', 'Oncologia'),
    ('2751502', 'Traumatologia'),
    ('2751503', 'Ginecologia'),
    ('2751503', 'Obstetrícia'),
    ('2751503', 'Cardiologia'),
    ('2751503', 'Cirurgia Geral'),
    ('2751504', 'Obstetrícia'),
    ('2751504', 'Pediatria'),
    ('2751504', 'Neonatologia');
