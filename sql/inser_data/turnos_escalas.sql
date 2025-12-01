------------------------------------------------------------
-- INSERÇÃO DE ESCALAS E TURNOS
------------------------------------------------------------

-- ========================================
-- ESCALAS - Horários de trabalho programados dos trabalhadores
-- ========================================

-- Médico Guilherme (CPF: 40420248282) - Segunda a Sexta
INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'segunda-feira', '08:00:00', '16:00:00'
FROM pessoa WHERE cpf = '40420248282';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'terca-feira', '08:00:00', '16:00:00'
FROM pessoa WHERE cpf = '40420248282';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'quarta-feira', '08:00:00', '16:00:00'
FROM pessoa WHERE cpf = '40420248282';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'quinta-feira', '08:00:00', '16:00:00'
FROM pessoa WHERE cpf = '40420248282';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'sexta-feira', '08:00:00', '16:00:00'
FROM pessoa WHERE cpf = '40420248282';

-- Médica Ana Beatriz (CPF: 12452364335) - Terça a Sábado
INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'terca-feira', '14:00:00', '22:00:00'
FROM pessoa WHERE cpf = '12452364335';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'quarta-feira', '14:00:00', '22:00:00'
FROM pessoa WHERE cpf = '12452364335';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'quinta-feira', '14:00:00', '22:00:00'
FROM pessoa WHERE cpf = '12452364335';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'sexta-feira', '14:00:00', '22:00:00'
FROM pessoa WHERE cpf = '12452364335';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'sabado', '14:00:00', '22:00:00'
FROM pessoa WHERE cpf = '12452364335';

-- Médico Henrique (CPF: 23565323453) - Plantão 24h Sábado e Domingo
INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'sabado', '08:00:00', '10:00:00'
FROM pessoa WHERE cpf = '23565323453';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'domingo', '08:00:00', '10:00:00'
FROM pessoa WHERE cpf = '23565323453';

-- Enfermeira Maria Clara (CPF: 34567891234) - Segunda a Sexta manhã
INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'segunda-feira', '07:00:00', '13:00:00'
FROM pessoa WHERE cpf = '34567891234';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'terca-feira', '07:00:00', '13:00:00'
FROM pessoa WHERE cpf = '34567891234';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'quarta-feira', '07:00:00', '13:00:00'
FROM pessoa WHERE cpf = '34567891234';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'quinta-feira', '07:00:00', '13:00:00'
FROM pessoa WHERE cpf = '34567891234';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'sexta-feira', '07:00:00', '13:00:00'
FROM pessoa WHERE cpf = '34567891234';

-- Enfermeiro João Pedro (CPF: 45678912345) - Segunda a Sexta tarde
INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'segunda-feira', '13:00:00', '19:00:00'
FROM pessoa WHERE cpf = '45678912345';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'terca-feira', '13:00:00', '19:00:00'
FROM pessoa WHERE cpf = '45678912345';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'quarta-feira', '13:00:00', '19:00:00'
FROM pessoa WHERE cpf = '45678912345';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'quinta-feira', '13:00:00', '19:00:00'
FROM pessoa WHERE cpf = '45678912345';

INSERT INTO escala (id_trabalhador_es, dia_da_semana, hora_entrada, hora_saida)
SELECT id_pessoa, 'sexta-feira', '13:00:00', '19:00:00'
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
