------------------------------------------------------------
-- INSERÇÃO DE ESCALAS E TURNOS
------------------------------------------------------------

-- ========================================
-- ESCALAS - Horários de trabalho programados dos trabalhadores
-- ========================================

-- Médico Guilherme (CPF: 40420248282) - Segunda a Sexta
INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'segunda-feira', '2025-11-03 08:00:00-03', '2025-11-03 16:00:00-03'
FROM pessoa WHERE cpf = '40420248282';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'terca-feira', '2025-11-04 08:00:00-03', '2025-11-04 16:00:00-03'
FROM pessoa WHERE cpf = '40420248282';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'quarta-feira', '2025-11-05 08:00:00-03', '2025-11-05 16:00:00-03'
FROM pessoa WHERE cpf = '40420248282';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'quinta-feira', '2025-11-06 08:00:00-03', '2025-11-06 16:00:00-03'
FROM pessoa WHERE cpf = '40420248282';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'sexta-feira', '2025-11-07 08:00:00-03', '2025-11-07 16:00:00-03'
FROM pessoa WHERE cpf = '40420248282';

-- Médica Ana Beatriz (CPF: 12452364335) - Terça a Sábado
INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'terca-feira', '2025-11-04 14:00:00-03', '2025-11-04 22:00:00-03'
FROM pessoa WHERE cpf = '12452364335';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'quarta-feira', '2025-11-05 14:00:00-03', '2025-11-05 22:00:00-03'
FROM pessoa WHERE cpf = '12452364335';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'quinta-feira', '2025-11-06 14:00:00-03', '2025-11-06 22:00:00-03'
FROM pessoa WHERE cpf = '12452364335';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'sexta-feira', '2025-11-07 14:00:00-03', '2025-11-07 22:00:00-03'
FROM pessoa WHERE cpf = '12452364335';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'sabado', '2025-11-08 14:00:00-03', '2025-11-08 22:00:00-03'
FROM pessoa WHERE cpf = '12452364335';

-- Médico Henrique (CPF: 23565323453) - Plantão 24h Sábado e Domingo
INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'sabado', '2025-11-08 08:00:00-03', '2025-11-09 08:00:00-03'
FROM pessoa WHERE cpf = '23565323453';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'domingo', '2025-11-09 08:00:00-03', '2025-11-10 08:00:00-03'
FROM pessoa WHERE cpf = '23565323453';

-- Enfermeira Maria Clara (CPF: 34567891234) - Segunda a Sexta manhã
INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'segunda-feira', '2025-11-03 07:00:00-03', '2025-11-03 13:00:00-03'
FROM pessoa WHERE cpf = '34567891234';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'terca-feira', '2025-11-04 07:00:00-03', '2025-11-04 13:00:00-03'
FROM pessoa WHERE cpf = '34567891234';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'quarta-feira', '2025-11-05 07:00:00-03', '2025-11-05 13:00:00-03'
FROM pessoa WHERE cpf = '34567891234';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'quinta-feira', '2025-11-06 07:00:00-03', '2025-11-06 13:00:00-03'
FROM pessoa WHERE cpf = '34567891234';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'sexta-feira', '2025-11-07 07:00:00-03', '2025-11-07 13:00:00-03'
FROM pessoa WHERE cpf = '34567891234';

-- Enfermeiro João Pedro (CPF: 45678912345) - Segunda a Sexta tarde
INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'segunda-feira', '2025-11-03 13:00:00-03', '2025-11-03 19:00:00-03'
FROM pessoa WHERE cpf = '45678912345';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'terca-feira', '2025-11-04 13:00:00-03', '2025-11-04 19:00:00-03'
FROM pessoa WHERE cpf = '45678912345';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'quarta-feira', '2025-11-05 13:00:00-03', '2025-11-05 19:00:00-03'
FROM pessoa WHERE cpf = '45678912345';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'quinta-feira', '2025-11-06 13:00:00-03', '2025-11-06 19:00:00-03'
FROM pessoa WHERE cpf = '45678912345';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, tstz_entrada, tstz_saida)
SELECT id_pessoa, 'sexta-feira', '2025-11-07 13:00:00-03', '2025-11-07 19:00:00-03'
FROM pessoa WHERE cpf = '45678912345';


-- ========================================
-- TURNOS - Registros de trabalho realizados nas entidades
-- ========================================

-- Turnos do Médico Guilherme no Hospital UFSCar (2751501)
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751501', '2025-11-18 08:00:00-03', '2025-11-18 16:00:00-03'
FROM pessoa WHERE cpf = '40420248282';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751501', '2025-11-19 08:00:00-03', '2025-11-19 16:00:00-03'
FROM pessoa WHERE cpf = '40420248282';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751501', '2025-11-11 08:00:00-03', '2025-11-11 16:00:00-03'
FROM pessoa WHERE cpf = '40420248282';

-- Turnos da Médica Ana Beatriz na Santa Casa (2751502)
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751502', '2025-11-18 14:00:00-03', '2025-11-18 22:00:00-03'
FROM pessoa WHERE cpf = '12452364335';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751502', '2025-11-19 14:00:00-03', '2025-11-19 22:00:00-03'
FROM pessoa WHERE cpf = '12452364335';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751502', '2025-11-12 14:00:00-03', '2025-11-12 22:00:00-03'
FROM pessoa WHERE cpf = '12452364335';

-- Turnos do Médico Henrique no Hospital São Paulo (2751503)
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751503', '2025-11-16 08:00:00-03', '2025-11-17 08:00:00-03'
FROM pessoa WHERE cpf = '23565323453';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751503', '2025-11-09 08:00:00-03', '2025-11-10 08:00:00-03'
FROM pessoa WHERE cpf = '23565323453';

-- Turnos do Médico Ricardo no Hospital Sagrada Família (2751504)
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751504', '2025-11-18 08:00:00-03', '2025-11-18 14:00:00-03'
FROM pessoa WHERE cpf = '60616263646';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751504', '2025-11-19 08:00:00-03', '2025-11-19 14:00:00-03'
FROM pessoa WHERE cpf = '60616263646';

-- Turnos da Médica Sandra no Hospital UFSCar (2751501)
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751501', '2025-11-18 16:00:00-03', '2025-11-19 00:00:00-03'
FROM pessoa WHERE cpf = '70717273747';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751501', '2025-11-12 16:00:00-03', '2025-11-13 00:00:00-03'
FROM pessoa WHERE cpf = '70717273747';

-- Turnos da Enfermeira Maria Clara no Hospital UFSCar (2751501)
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751501', '2025-11-18 07:00:00-03', '2025-11-18 13:00:00-03'
FROM pessoa WHERE cpf = '34567891234';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751501', '2025-11-19 07:00:00-03', '2025-11-19 13:00:00-03'
FROM pessoa WHERE cpf = '34567891234';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751501', '2025-11-11 07:00:00-03', '2025-11-11 13:00:00-03'
FROM pessoa WHERE cpf = '34567891234';

-- Turnos do Enfermeiro João Pedro na Santa Casa (2751502)
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751502', '2025-11-18 13:00:00-03', '2025-11-18 19:00:00-03'
FROM pessoa WHERE cpf = '45678912345';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751502', '2025-11-19 13:00:00-03', '2025-11-19 19:00:00-03'
FROM pessoa WHERE cpf = '45678912345';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751502', '2025-11-12 13:00:00-03', '2025-11-12 19:00:00-03'
FROM pessoa WHERE cpf = '45678912345';

-- Turnos da Enfermeira Juliana no Hospital São Paulo (2751503)
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751503', '2025-11-18 19:00:00-03', '2025-11-19 01:00:00-03'
FROM pessoa WHERE cpf = '56789123456';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751503', '2025-11-19 19:00:00-03', '2025-11-20 01:00:00-03'
FROM pessoa WHERE cpf = '56789123456';

-- Turnos do Enfermeiro Rafael no Hospital Sagrada Família (2751504)
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751504', '2025-11-18 14:00:00-03', '2025-11-18 20:00:00-03'
FROM pessoa WHERE cpf = '67891234567';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751504', '2025-11-19 14:00:00-03', '2025-11-19 20:00:00-03'
FROM pessoa WHERE cpf = '67891234567';

-- Turnos da Enfermeira Camila no Laboratório Bio Análises (2751801)
INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751801', '2025-11-18 08:00:00-03', '2025-11-18 14:00:00-03'
FROM pessoa WHERE cpf = '80818283848';

INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada, tstz_saida)
SELECT id_pessoa, '2751801', '2025-11-19 08:00:00-03', '2025-11-19 14:00:00-03'
FROM pessoa WHERE cpf = '80818283848';
