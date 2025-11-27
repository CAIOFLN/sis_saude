------------------------------------------------------------
-- INSERÇÃO DE PESSOAS
------------------------------------------------------------

-- ========================================
-- GESTORES DO SISTEMA (2)
-- ========================================

-- Gestor 1: Carlos Eduardo Ferreira
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('78912345678', 'Carlos Eduardo Ferreira')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'GESTOR'
    FROM tabela_pessoa
)
INSERT INTO gestor_sistema (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;

-- Gestor 2: Patricia Rodrigues Lima (também é paciente)
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('89123456789', 'Patricia Rodrigues Lima')
    RETURNING id_pessoa
),
tabela_tipo_gestor AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'GESTOR'
    FROM tabela_pessoa
),
tabela_tipo_paciente AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'PACIENTE'
    FROM tabela_pessoa
),
tabela_gestor AS (
    INSERT INTO gestor_sistema (id_pessoa)
    SELECT id_pessoa
    FROM tabela_pessoa
)
INSERT INTO paciente (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;


-- ========================================
-- DIRETORES (5)
-- Distribuição: 2751501, 2751502, 2751503 (hospitais) e 2751801, 2751802 (labs)
-- 2751504 e 2751803 ficam sem diretor
-- ========================================

-- Diretor 1: Roberto Carlos Mendes - Hospital UFSCar (2751501)
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('10111213141', 'Roberto Carlos Mendes')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'DIRETOR'
    FROM tabela_pessoa
)
INSERT INTO diretor (id_pessoa, cnes_dirigido)
SELECT id_pessoa, '2751501'
FROM tabela_pessoa;

-- Diretor 2: Cristina Almeida Santos - Santa Casa (2751502) (também é paciente)
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('20212223242', 'Cristina Almeida Santos')
    RETURNING id_pessoa
),
tabela_tipo_diretor AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'DIRETOR'
    FROM tabela_pessoa
),
tabela_tipo_paciente AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'PACIENTE'
    FROM tabela_pessoa
),
tabela_diretor AS (
    INSERT INTO diretor (id_pessoa, cnes_dirigido)
    SELECT id_pessoa, '2751502'
    FROM tabela_pessoa
)
INSERT INTO paciente (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;

-- Diretor 3: Eduardo Martins Pereira - Hospital São Paulo (2751503)
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('30313233343', 'Eduardo Martins Pereira')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'DIRETOR'
    FROM tabela_pessoa
)
INSERT INTO diretor (id_pessoa, cnes_dirigido)
SELECT id_pessoa, '2751503'
FROM tabela_pessoa;

-- Diretor 4: Fernanda Lima Costa - Laboratório Bio Análises (2751801)
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('40414243444', 'Fernanda Lima Costa')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'DIRETOR'
    FROM tabela_pessoa
)
INSERT INTO diretor (id_pessoa, cnes_dirigido)
SELECT id_pessoa, '2751801'
FROM tabela_pessoa;

-- Diretor 5: Gabriel Souza Rodrigues - Laboratório Fleury (2751802)
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('50515253545', 'Gabriel Souza Rodrigues')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'DIRETOR'
    FROM tabela_pessoa
)
INSERT INTO diretor (id_pessoa, cnes_dirigido)
SELECT id_pessoa, '2751802'
FROM tabela_pessoa;


-- ========================================
-- MÉDICOS (5) - 2 também são pacientes
-- ========================================

-- Médico 1: Guilherme Souza da Silva (também é paciente)
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('40420248282', 'Guilherme Souza da Silva')
    RETURNING id_pessoa
),
tabela_tipo_trabalhador AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'TRABALHADOR_ES'
    FROM tabela_pessoa
),
tabela_tipo_paciente AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'PACIENTE'
    FROM tabela_pessoa
),
tabela_trabalhador AS (
    INSERT INTO trabalhador_es (id_pessoa, funcao_trabalhador, registro_profissional)
    SELECT id_pessoa, 'MEDICO', '12345-SP'
    FROM tabela_pessoa
)
INSERT INTO paciente (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;

-- Médico 2: Ana Beatriz Faria Lima
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('12452364335', 'Ana Beatriz Faria Lima')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'TRABALHADOR_ES'
    FROM tabela_pessoa
)
INSERT INTO trabalhador_es (id_pessoa, funcao_trabalhador, registro_profissional)
SELECT id_pessoa, 'MEDICO', '15325-RJ'
FROM tabela_pessoa;

-- Médico 3: Henrique Gouveia (também é paciente)
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('23565323453', 'Henrique Gouveia')
    RETURNING id_pessoa
),
tabela_tipo_trabalhador AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'TRABALHADOR_ES'
    FROM tabela_pessoa
),
tabela_tipo_paciente AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'PACIENTE'
    FROM tabela_pessoa
),
tabela_trabalhador AS (
    INSERT INTO trabalhador_es (id_pessoa, funcao_trabalhador, registro_profissional)
    SELECT id_pessoa, 'MEDICO', '14245-SP'
    FROM tabela_pessoa
)
INSERT INTO paciente (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;

-- Médico 4: Ricardo Alves Martins
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('60616263646', 'Ricardo Alves Martins')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'TRABALHADOR_ES'
    FROM tabela_pessoa
)
INSERT INTO trabalhador_es (id_pessoa, funcao_trabalhador, registro_profissional)
SELECT id_pessoa, 'MEDICO', '98712-MG'
FROM tabela_pessoa;

-- Médico 5: Sandra Regina Oliveira
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('70717273747', 'Sandra Regina Oliveira')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'TRABALHADOR_ES'
    FROM tabela_pessoa
)
INSERT INTO trabalhador_es (id_pessoa, funcao_trabalhador, registro_profissional)
SELECT id_pessoa, 'MEDICO', '45632-SP'
FROM tabela_pessoa;


-- ========================================
-- ENFERMEIROS (5) - 2 também são pacientes
-- ========================================

-- Enfermeiro 1: Maria Clara Santos (também é paciente)
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('34567891234', 'Maria Clara Santos')
    RETURNING id_pessoa
),
tabela_tipo_trabalhador AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'TRABALHADOR_ES'
    FROM tabela_pessoa
),
tabela_tipo_paciente AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'PACIENTE'
    FROM tabela_pessoa
),
tabela_trabalhador AS (
    INSERT INTO trabalhador_es (id_pessoa, funcao_trabalhador, registro_profissional)
    SELECT id_pessoa, 'ENFERMEIRO', '98765-SP'
    FROM tabela_pessoa
)
INSERT INTO paciente (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;

-- Enfermeiro 2: João Pedro Oliveira
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('45678912345', 'João Pedro Oliveira')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'TRABALHADOR_ES'
    FROM tabela_pessoa
)
INSERT INTO trabalhador_es (id_pessoa, funcao_trabalhador, registro_profissional)
SELECT id_pessoa, 'ENFERMEIRO', '87654-RJ'
FROM tabela_pessoa;

-- Enfermeiro 3: Juliana Costa Mendes (também é paciente)
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('56789123456', 'Juliana Costa Mendes')
    RETURNING id_pessoa
),
tabela_tipo_trabalhador AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'TRABALHADOR_ES'
    FROM tabela_pessoa
),
tabela_tipo_paciente AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'PACIENTE'
    FROM tabela_pessoa
),
tabela_trabalhador AS (
    INSERT INTO trabalhador_es (id_pessoa, funcao_trabalhador, registro_profissional)
    SELECT id_pessoa, 'ENFERMEIRO', '76543-MG'
    FROM tabela_pessoa
)
INSERT INTO paciente (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;

-- Enfermeiro 4: Rafael Almeida Pereira
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('67891234567', 'Rafael Almeida Pereira')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'TRABALHADOR_ES'
    FROM tabela_pessoa
)
INSERT INTO trabalhador_es (id_pessoa, funcao_trabalhador, registro_profissional)
SELECT id_pessoa, 'ENFERMEIRO', '65432-SP'
FROM tabela_pessoa;

-- Enfermeiro 5: Camila Fernandes Silva
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('80818283848', 'Camila Fernandes Silva')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'TRABALHADOR_ES'
    FROM tabela_pessoa
)
INSERT INTO trabalhador_es (id_pessoa, funcao_trabalhador, registro_profissional)
SELECT id_pessoa, 'ENFERMEIRO', '23456-RJ'
FROM tabela_pessoa;


-- ========================================
-- PACIENTES QUE NÃO SÃO TRABALHADORES (4)
-- ========================================

-- Paciente 1: Mariana Souza Oliveira
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('11223344556', 'Mariana Souza Oliveira')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'PACIENTE'
    FROM tabela_pessoa
)
INSERT INTO paciente (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;

-- Paciente 2: Pedro Henrique Costa
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('22334455667', 'Pedro Henrique Costa')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'PACIENTE'
    FROM tabela_pessoa
)
INSERT INTO paciente (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;

-- Paciente 3: Beatriz Alves Ribeiro
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('33445566778', 'Beatriz Alves Ribeiro')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'PACIENTE'
    FROM tabela_pessoa
)
INSERT INTO paciente (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;

-- Paciente 4: Lucas Fernando Dias
WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('44556677889', 'Lucas Fernando Dias')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'PACIENTE'
    FROM tabela_pessoa
)
INSERT INTO paciente (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;


WITH tabela_pessoa AS (
    INSERT INTO pessoa (cpf, nome)
    VALUES ('55667788990', 'Thiago Moreira Lopes')
    RETURNING id_pessoa
),
tabela_tipo AS (
    INSERT INTO tipo_pessoa (id_pessoa, tipo)
    SELECT id_pessoa, 'PACIENTE'
    FROM tabela_pessoa
)
INSERT INTO paciente (id_pessoa)
SELECT id_pessoa
FROM tabela_pessoa;