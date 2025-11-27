

------------------------------------------------------------
-- 1. PESSOA E ESPECIALIZACAO DE PESSOA
------------------------------------------------------------

CREATE TABLE pessoa (
    id_pessoa  SERIAL      NOT NULL,
    cpf        CHAR(11)    NOT NULL,
    nome       VARCHAR(50) NOT NULL,

    CONSTRAINT pk_pessoa PRIMARY KEY (id_pessoa),
    CONSTRAINT sk_pessoa_cpf UNIQUE (cpf),
    CONSTRAINT check_pessoa_cpf CHECK (cpf ~ '^[0-9]{11}$')

);

CREATE TABLE tipo_pessoa (
    id_pessoa INTEGER   NOT NULL,
    tipo      CHAR(14)  NOT NULL,  -- 'PACIENTE', 'TRABALHADOR_ES', 'DIRETOR', 'GESTOR'

    CONSTRAINT pk_tipo_pessoa PRIMARY KEY (id_pessoa, tipo),
    CONSTRAINT fk_tipo_pessoa_pessoa
        FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa),
    CONSTRAINT check_tipo_pessoa
        CHECK (tipo IN ('PACIENTE', 'TRABALHADOR_ES', 'DIRETOR', 'GESTOR'))
);

CREATE TABLE paciente (
    id_pessoa INTEGER NOT NULL,

    CONSTRAINT pk_paciente PRIMARY KEY (id_pessoa),
    CONSTRAINT fk_paciente_pessoa
        FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa)
);

CREATE TABLE trabalhador_es (
    id_pessoa            INTEGER    NOT NULL,
    funcao_trabalhador   VARCHAR(10) NOT NULL,          -- 'MEDICO' ou 'ENFERMEIRO' 
    registro_profissional VARCHAR(9) NOT NULL,          -- COREM CRM

    CONSTRAINT pk_trabalhador_es PRIMARY KEY (id_pessoa),
    CONSTRAINT fk_trabalhador_es_pessoa
        FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa),
    CONSTRAINT sk_trabalhador_es_registro_funcao
        UNIQUE (registro_profissional, funcao_trabalhador), -- EXPLICAR ISSO NO RELATORIO
    CONSTRAINT check_trabalhador_es_funcao
        CHECK (funcao_trabalhador IN ('MEDICO', 'ENFERMEIRO')),
    CONSTRAINT check_trabalhador_es_registro
        CHECK (registro_profissional ~ '^[0-9]{4,6}-[A-Z]{2}$') 
);

--- VOU ADICIONAR DIRETOR DEPOIS QUE CRIAR ENTIDADE DE SAUDE

CREATE TABLE gestor_sistema (
    id_pessoa INTEGER NOT NULL,

    CONSTRAINT pk_gestor_sistema PRIMARY KEY (id_pessoa),
    CONSTRAINT fk_gestor_sistema_pessoa
        FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa)
);


------------------------------------------------------------
-- 2. ENTIDADES DE SAÚDE, HOSPITAL, LABORATÓRIO
------------------------------------------------------------
-- DUVIDA : ON DELETE CASCADE ?????


CREATE TABLE entidade_saude (
    cnes                  CHAR(7)      NOT NULL,
    nome                  VARCHAR(100) NOT NULL,
    telefone              VARCHAR(15),
    horario_funcionamento VARCHAR(50),
    cep                   CHAR(8),
    numero_endereco       VARCHAR(10),
    complemento_endereco  VARCHAR(50),
    tipo_entidade         VARCHAR(11),    -- 'HOSPITAL' ou 'LABORATORIO'

    CONSTRAINT pk_entidade_saude PRIMARY KEY (cnes),
    CONSTRAINT check_entidade_saude_telefone
        CHECK (telefone IS NULL OR telefone ~ '^\([0-9]{2}\)[0-9]{4,5}-[0-9]{4}$'),
    CONSTRAINT check_entidade_saude_cep
        CHECK (cep IS NULL OR cep ~ '^[0-9]{8}$'),
    CONSTRAINT check_entidade_saude_tipo
        CHECK (tipo_entidade IN ('HOSPITAL', 'LABORATORIO'))
);

CREATE TABLE laboratorio (
    cnes_laboratorio CHAR(7) NOT NULL,

    CONSTRAINT pk_laboratorio PRIMARY KEY (cnes_laboratorio),
    -- Caso a es do laboratorio seja excluida, nao precisamos armazenar o laboratorio pois ele nao possui
    -- nenhum dado sensivel associado a ele, por isso ON DELETE CASCADE
    CONSTRAINT fk_laboratorio_entidade_saude
        FOREIGN KEY (cnes_laboratorio) REFERENCES entidade_saude(cnes) ON DELETE CASCADE
);

CREATE TABLE hospital (
    cnes_hospital        CHAR(7)   NOT NULL,
    leitos_normais_disp  NUMERIC(4,0)  NOT NULL,
    leitos_uti_disp      NUMERIC(4,0)  NOT NULL,

    CONSTRAINT pk_hospital PRIMARY KEY (cnes_hospital),
    CONSTRAINT fk_hospital_entidade_saude
        FOREIGN KEY (cnes_hospital) REFERENCES entidade_saude(cnes),
    CONSTRAINT check_hospital_leitos_normais
        CHECK (leitos_normais_disp >= 0),
    CONSTRAINT check_hospital_leitos_uti
        CHECK (leitos_uti_disp >= 0)
);

CREATE TABLE especializacoes (
    cnes_hospital CHAR(7)     NOT NULL,
    especialidade VARCHAR(20) NOT NULL,

    CONSTRAINT pk_especializacoes PRIMARY KEY (cnes_hospital, especialidade),
    -- caso o hospital seja excluido podemos excluir suas especialidades pois nao tem 
    -- nenhum dado sensivel associado a isso
    CONSTRAINT fk_especializacoes_hospital
        FOREIGN KEY (cnes_hospital) REFERENCES hospital(cnes_hospital) ON DELETE CASCADE
);

-------------------------------
--- Agora que temos entidade de saude, podemos adicionar DIRETOR
--------------------------------

CREATE TABLE diretor (
    id_pessoa INTEGER NOT NULL,
    cnes_dirigido CHAR(7) NOT NULL,

    CONSTRAINT pk_diretor PRIMARY KEY (id_pessoa),

    CONSTRAINT fk_diretor_pessoa
        FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa),

    -- note que caso a entidade de saida for excluida, teremos uma inconsistencia 
    -- nao podemos deixar set null e nem cascade pois diretor tem dados sensiveis associado a relatorio  de recurso
    CONSTRAINT fk_diretor_entidade_saude
        FOREIGN KEY (cnes_dirigido) REFERENCES entidade_saude(cnes)

);

------------------------------------------------------------
-- RECURSOS, POSSUI E PRODUZ
------------------------------------------------------------

CREATE TABLE recurso (
    registro_ms CHAR(13)     NOT NULL,
    nome        VARCHAR(100) NOT NULL,
    tipo        VARCHAR(30)  NOT NULL,    -- ex.: 'Medicamento', 'Vacina'
    temp_min    NUMERIC(5,2),
    temp_max    NUMERIC(5,2),

    CONSTRAINT pk_recurso PRIMARY KEY (registro_ms),
    CONSTRAINT check_recurso_registro_ms
        CHECK (registro_ms ~ '^[0-9]{13}$'),
    CONSTRAINT check_recurso_temp_min
        CHECK (temp_min IS NULL OR (temp_min >= -200 AND temp_min <= 200)),
    CONSTRAINT check_recurso_temp_max
        CHECK (temp_max IS NULL OR (temp_max >= -200 AND temp_max <= 200)),
    CONSTRAINT check_recurso_intervalo_temp
        CHECK (temp_min IS NULL OR temp_max IS NULL OR temp_min <= temp_max)
);

CREATE TABLE possui (
    cnes_entidade_saude   CHAR(7)  NOT NULL,
    registro_ms_recurso   CHAR(13) NOT NULL,
    quantidade_disponivel SMALLINT NOT NULL DEFAULT 0, 

    CONSTRAINT pk_possui PRIMARY KEY (cnes_entidade_saude, registro_ms_recurso),
    -- podemos usar on delete cascade pois nao perdemos informacao sensivel
    CONSTRAINT fk_possui_entidade_saude
        FOREIGN KEY (cnes_entidade_saude) REFERENCES entidade_saude(cnes) ON DELETE CASCADE,
    CONSTRAINT fk_possui_recurso
        FOREIGN KEY (registro_ms_recurso) REFERENCES recurso(registro_ms) ON DELETE CASCADE,
    CONSTRAINT check_possui_quantidade
        CHECK (quantidade_disponivel >= 0)
);

CREATE TABLE produz (
    cnes_laboratorio    CHAR(7)  NOT NULL,
    registro_ms_recurso CHAR(13) NOT NULL,

    CONSTRAINT pk_produz PRIMARY KEY (cnes_laboratorio, registro_ms_recurso),

    -- podemos usar on delete cascade pois nao perdemos informacao sensivel
    CONSTRAINT fk_produz_laboratorio
        FOREIGN KEY (cnes_laboratorio) REFERENCES laboratorio(cnes_laboratorio) ON DELETE CASCADE,
    CONSTRAINT fk_produz_recurso
        FOREIGN KEY (registro_ms_recurso) REFERENCES recurso(registro_ms) ON DELETE CASCADE
);

------------------------------------------------------------
-- ESCALAS E TURNOS DE TRABALHO
------------------------------------------------------------

CREATE TABLE escala (
    id_trabalhador_es INTEGER     NOT NULL,
    dia_da_semana     VARCHAR(13) NOT NULL,
    hora_entrada      TIME        NOT NULL,  -- note que nao faz sentido considerar o fuso horario aqui, pois é o trabalhador que deve se adptar ao fuso da es
    hora_saida        TIME        NOT NULL,

    CONSTRAINT pk_escala PRIMARY KEY (id_trabalhador_es, dia_da_semana, hora_entrada),
    CONSTRAINT fk_escala_trabalhador_es
        FOREIGN KEY (id_trabalhador_es) REFERENCES trabalhador_es(id_pessoa) ON DELETE CASCADE,
    CONSTRAINT check_escala_dia_da_semana
        CHECK (dia_da_semana IN (
            'segunda-feira',
            'terca-feira',
            'quarta-feira',
            'quinta-feira',
            'sexta-feira',
            'sabado',
            'domingo'
        )),
    CONSTRAINT check_escala_intervalo_tempo
        CHECK (hora_saida > hora_entrada)
);


CREATE TABLE turno (
    id_turno                UUID            DEFAULT gen_random_uuid() NOT NULL,
    id_trabalhador_es       INTEGER         NOT NULL,
    cnes_entidade_saude     CHAR(7)         NOT NULL,
    tstz_entrada            TIMESTAMPTZ     NOT NULL,
    tstz_saida              TIMESTAMPTZ,

    CONSTRAINT pk_turno PRIMARY KEY (id_turno),
    CONSTRAINT sk_turno_trabalhador_es_entidade_entrada
        UNIQUE (id_trabalhador_es, cnes_entidade_saude, tstz_entrada),
    CONSTRAINT fk_turno_trabalhador_es
        FOREIGN KEY (id_trabalhador_es) REFERENCES trabalhador_es(id_pessoa),
    CONSTRAINT fk_turno_entidade_saude
        FOREIGN KEY (cnes_entidade_saude) REFERENCES entidade_saude(cnes),
    CONSTRAINT check_turno_intervalo_tempo
        CHECK (tstz_saida IS NULL OR tstz_saida > tstz_entrada)
);

------------------------------------------------------------
-- NOTIFICAÇÕES E RELATÓRIOS DE CASO
------------------------------------------------------------

CREATE TABLE notificacao (
    cnes_entidade_saude_notificada      CHAR(7)         NOT NULL,
    id_gestor_sistema                   INTEGER         NOT NULL,
    tstz_notificacao                    TIMESTAMPTZ     NOT NULL,
    texto                               TEXT            NOT NULL,

    CONSTRAINT pk_notificacao PRIMARY KEY (
        cnes_entidade_saude_notificada,
        id_gestor_sistema,
        tstz_notificacao
    ),
    CONSTRAINT fk_notificacao_entidade_saude
        FOREIGN KEY (cnes_entidade_saude_notificada) REFERENCES entidade_saude(cnes),
    CONSTRAINT fk_notificacao_gestor_sistema
        FOREIGN KEY (id_gestor_sistema) REFERENCES gestor_sistema(id_pessoa)
);

CREATE TABLE relatorio_caso (
    id_relatorio_caso UUID        DEFAULT gen_random_uuid() NOT NULL,
    id_paciente       INTEGER     NOT NULL,
    tstz_relatorio    TIMESTAMPTZ NOT NULL,
    id_turno          UUID        NOT NULL,
    texto_relatorio   TEXT,
    palavra_chave_1   VARCHAR(30),
    palavra_chave_2   VARCHAR(30),

    CONSTRAINT pk_relatorio_caso PRIMARY KEY (id_relatorio_caso),
    CONSTRAINT sk_relatorio_caso_paciente_tempo_turno
        UNIQUE (id_paciente, tstz_relatorio, id_turno),
    CONSTRAINT fk_relatorio_caso_paciente
        FOREIGN KEY (id_paciente) REFERENCES paciente(id_pessoa),
    CONSTRAINT fk_relatorio_caso_turno
        FOREIGN KEY (id_turno) REFERENCES turno(id_turno),

    CONSTRAINT check_palavras_chaves_relatorio_recurso
        CHECK palavra_chave_1 != palavra_chave_2
);

CREATE TABLE encaminhamento (
    id_relatorio_caso               UUID        NOT NULL,
    cnes_hospital_destino           CHAR(7)     NOT NULL,
    id_gestor_sistema_responsavel   INTEGER     NOT NULL,

    CONSTRAINT pk_encaminhamento PRIMARY KEY (id_relatorio_caso),
    CONSTRAINT fk_encaminhamento_relatorio_caso
        FOREIGN KEY (id_relatorio_caso) REFERENCES relatorio_caso(id_relatorio_caso),
    CONSTRAINT fk_encaminhamento_hospital
        FOREIGN KEY (cnes_hospital_destino) REFERENCES hospital(cnes_hospital),
    CONSTRAINT fk_encaminhamento_gestor_sistema
        FOREIGN KEY (id_gestor_sistema_responsavel) REFERENCES gestor_sistema(id_pessoa)
);

------------------------------------------------------------
--  PEDIDOS DE RECURSOS E RELATÓRIOS DE RECURSO
------------------------------------------------------------

CREATE TABLE pedido (
    id_pedido           UUID        DEFAULT gen_random_uuid() NOT NULL,
    id_turno            UUID        NOT NULL,
    registro_ms_recurso CHAR(13)    NOT NULL,
    tstz_pedido         TIMESTAMPTZ NOT NULL,
    quantidade          SMALLINT    NOT NULL DEFAULT 1,
    urgencia            VARCHAR(7)  NOT NULL DEFAULT 'BAIXA',  -- 'BAIXA', 'MEDIA', 'EXTREMA'
    justificativa       TEXT,

    CONSTRAINT pk_pedido PRIMARY KEY (id_pedido),
    CONSTRAINT sk_pedido_turno_recurso_tempo
        UNIQUE (id_turno, registro_ms_recurso, tstz_pedido),
    CONSTRAINT fk_pedido_turno
        FOREIGN KEY (id_turno) REFERENCES turno(id_turno),
    CONSTRAINT fk_pedido_recurso
        FOREIGN KEY (registro_ms_recurso) REFERENCES recurso(registro_ms),
    CONSTRAINT check_pedido_urgencia
        CHECK (urgencia IN ('BAIXA', 'MEDIA', 'EXTREMA')),
    CONSTRAINT check_pedido_quantidade
        CHECK (quantidade > 0)
);

CREATE TABLE relatorio_recurso (
    id_pedido_relatorio     UUID        NOT NULL,
    id_diretor              INTEGER     NOT NULL,
    tstz_relatorio_recurso  TIMESTAMPTZ NOT NULL,
    estado_relatorio        VARCHAR(9)  NOT NULL DEFAULT 'ANALISE', -- 'APROVADO', 'RECUSADO', 'ANALISE'
    justificativa_decisao   TEXT,

    CONSTRAINT pk_relatorio_recurso PRIMARY KEY (id_pedido_relatorio),
    CONSTRAINT fk_relatorio_recurso_pedido
        FOREIGN KEY (id_pedido_relatorio) REFERENCES pedido(id_pedido),
    CONSTRAINT fk_relatorio_recurso_diretor
        FOREIGN KEY (id_diretor) REFERENCES diretor(id_pessoa),
    CONSTRAINT check_relatorio_recurso_estado
        CHECK (estado_relatorio IN ('APROVADO', 'RECUSADO', 'ANALISE'))
);

------------------------------------------------------------
--  REQUISIÇÕES, FORNECIMENTO E TRANSPORTE
------------------------------------------------------------

CREATE TABLE requisicao (
    id_requisicao     UUID        NOT NULL,
    id_gestor_sistema INTEGER     NOT NULL,
    tstz_requisicao   TIMESTAMPTZ NOT NULL,

    CONSTRAINT pk_requisicao PRIMARY KEY (id_requisicao),
    CONSTRAINT fk_requisicao_relatorio_recurso
        FOREIGN KEY (id_requisicao) REFERENCES relatorio_recurso(id_pedido_relatorio),
    CONSTRAINT fk_requisicao_gestor_sistema
        FOREIGN KEY (id_gestor_sistema) REFERENCES gestor_sistema(id_pessoa)
);

CREATE TABLE fornecimento (
    id_requisicao        UUID    NOT NULL,
    cnes_entidade_saude  CHAR(7) NOT NULL,

    CONSTRAINT pk_fornecimento PRIMARY KEY (id_requisicao, cnes_entidade_saude),
    CONSTRAINT fk_fornecimento_requisicao
        FOREIGN KEY (id_requisicao) REFERENCES requisicao(id_requisicao),
    CONSTRAINT fk_fornecimento_entidade_saude
        FOREIGN KEY (cnes_entidade_saude) REFERENCES entidade_saude(cnes)
);

CREATE TABLE transportadora (
    cnpj                CHAR(14)     NOT NULL,
    nome                VARCHAR(100) NOT NULL,
    telefone            VARCHAR(15),
    temp_min_suportada  NUMERIC(5,2),
    temp_max_suportada  NUMERIC(5,2),

    CONSTRAINT pk_transportadora PRIMARY KEY (cnpj),
    CONSTRAINT check_transportadora_cnpj CHECK (cnpj ~ '^[0-9]{14}$'),
    CONSTRAINT check_transportadora_telefone
        CHECK (telefone IS NULL OR telefone ~ '^\([0-9]{2}\)[0-9]{5}-[0-9]{4}$'),
    CONSTRAINT chkec_transportadora_intervalo_temp
        CHECK (temp_min_suportada IS NULL OR temp_max_suportada IS NULL OR temp_min_suportada <= temp_max_suportada)
);

CREATE TABLE transporta (
    cnpj_transportadora     CHAR(14)  NOT NULL,
    id_requisicao           UUID      NOT NULL,
    cnes_entidade_saude     CHAR(7)   NOT NULL,
    tempo_rota              INTERVAL,
    quantidade_transportada SMALLINT  NOT NULL,

    CONSTRAINT pk_transporta PRIMARY KEY (cnpj_transportadora, id_requisicao, cnes_entidade_saude),
    CONSTRAINT fk_transporta_transportadora
        FOREIGN KEY (cnpj_transportadora) REFERENCES transportadora(cnpj),
    CONSTRAINT fk_transporta_fornecimento
        FOREIGN KEY (id_requisicao, cnes_entidade_saude) REFERENCES fornecimento(id_requisicao, cnes_entidade_saude),
    CONSTRAINT check_transporta_quantidade
        CHECK (quantidade_transportada > 0)
);




