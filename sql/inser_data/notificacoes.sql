------------------------------------------------------------
-- INSERÇÃO DE NOTIFICAÇÕES
------------------------------------------------------------

-- Notificação 1: Alerta de surto de dengue no Hospital UFSCar
INSERT INTO notificacao (cnes_entidade_saude_notificada, id_gestor_sistema, tstz_notificacao, texto)
VALUES (
    '2751501',
    (SELECT id_pessoa FROM pessoa WHERE cpf = '78912345678'),
    '2025-11-15 10:30:00-03',
    'Alerta: Aumento de 60% nos casos confirmados de dengue na última semana. Reforçar triagem e hidratação.'
);

-- Notificação 2: Surto de vírus respiratório sincicial na Santa Casa
INSERT INTO notificacao (cnes_entidade_saude_notificada, id_gestor_sistema, tstz_notificacao, texto)
VALUES (
    '2751502',
    (SELECT id_pessoa FROM pessoa WHERE cpf = '89123456789'),
    '2025-11-16 09:00:00-03',
    'Surto de VSR em crianças menores de 2 anos. 15 casos confirmados esta semana. Isolar pacientes e reforçar higienização.'
);

-- Notificação 3: Caso suspeito de meningite no Hospital São Paulo
INSERT INTO notificacao (cnes_entidade_saude_notificada, id_gestor_sistema, tstz_notificacao, texto)
VALUES (
    '2751503',
    (SELECT id_pessoa FROM pessoa WHERE cpf = '78912345678'),
    '2025-11-17 14:00:00-03',
    'Notificação compulsória: Caso suspeito de meningite bacteriana internado na UTI. Iniciar protocolo de isolamento e profilaxia de contatos.'
);

-- Notificação 4: Surto de gripe no Hospital Sagrada Família
INSERT INTO notificacao (cnes_entidade_saude_notificada, id_gestor_sistema, tstz_notificacao, texto)
VALUES (
    '2751504',
    (SELECT id_pessoa FROM pessoa WHERE cpf = '89123456789'),
    '2025-11-18 08:30:00-03',
    'Surto de Influenza H3N2. Aumento de 40% nos casos de síndrome gripal. Priorizar vacinação de grupos de risco.'
);

-- Notificação 5: Surto de norovírus no Lab Bio Análises
INSERT INTO notificacao (cnes_entidade_saude_notificada, id_gestor_sistema, tstz_notificacao, texto)
VALUES (
    '2751801',
    (SELECT id_pessoa FROM pessoa WHERE cpf = '78912345678'),
    '2025-11-14 16:45:00-03',
    'Alerta: Surto de gastroenterite viral entre funcionários. 8 casos confirmados de norovírus. Reforçar higiene das mãos e superfícies.'
);
