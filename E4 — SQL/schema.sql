-- =============================================================================
-- PROJETO SEMESTRAL — BANCO DE DADOS 2026/1
-- Domínio: Gestão de Clínica Médica
-- Etapa 4 — Implementação SQL (DDL + DML + Consultas Q1–Q10)
-- SGBD: PostgreSQL 16+
-- =============================================================================


-- =============================================================================
-- SEÇÃO 1 — DDL (Data Definition Language)
-- =============================================================================

-- Limpeza idempotente (ordem inversa das dependências)
DROP TABLE IF EXISTS HistoricoProntuario CASCADE;
DROP TABLE IF EXISTS Exame            CASCADE;
DROP TABLE IF EXISTS Prontuario       CASCADE;
DROP TABLE IF EXISTS Consulta         CASCADE;
DROP TABLE IF EXISTS Agendamento      CASCADE;
DROP TABLE IF EXISTS Paciente         CASCADE;
DROP TABLE IF EXISTS Medico           CASCADE;
DROP TABLE IF EXISTS Procedimento     CASCADE;
DROP TABLE IF EXISTS Especialidade    CASCADE;
DROP TABLE IF EXISTS Convenio         CASCADE;

-- -----------------------------------------------------------------------------
-- Especialidade
-- -----------------------------------------------------------------------------
CREATE TABLE Especialidade (
    CodigoEspecialidade SERIAL       PRIMARY KEY,
    NomeEspecialidade   VARCHAR(100) NOT NULL UNIQUE
);

COMMENT ON TABLE  Especialidade                     IS 'Especialidades médicas reconhecidas pela clínica.';
COMMENT ON COLUMN Especialidade.CodigoEspecialidade IS 'Identificador único da especialidade.';
COMMENT ON COLUMN Especialidade.NomeEspecialidade   IS 'Nome da especialidade (ex: Cardiologia, Ortopedia).';

-- -----------------------------------------------------------------------------
-- Convenio
-- -----------------------------------------------------------------------------
CREATE TABLE Convenio (
    ans_registro INT          PRIMARY KEY,
    Nome         VARCHAR(100) NOT NULL,
    Plano        VARCHAR(100) NOT NULL,
    Contato      VARCHAR(20)  NOT NULL
);

COMMENT ON TABLE  Convenio             IS 'Convênios / planos de saúde aceitos pela clínica.';
COMMENT ON COLUMN Convenio.ans_registro IS 'Número de registro ANS do convênio (PK).';
COMMENT ON COLUMN Convenio.Nome        IS 'Nome comercial do convênio.';
COMMENT ON COLUMN Convenio.Plano       IS 'Tipo de plano (Básico, Standard, Premium, etc.).';
COMMENT ON COLUMN Convenio.Contato     IS 'Telefone ou e-mail de contato com o convênio.';

-- -----------------------------------------------------------------------------
-- Medico
-- -----------------------------------------------------------------------------
CREATE TABLE Medico (
    CRM             INT          PRIMARY KEY,
    Nome            VARCHAR(100) NOT NULL,
    Idade           INT          NOT NULL CHECK (Idade BETWEEN 22 AND 80),
    idEspecialidade INT          NOT NULL,
    CONSTRAINT fk_medico_especialidade
        FOREIGN KEY (idEspecialidade) REFERENCES Especialidade(CodigoEspecialidade)
);

COMMENT ON TABLE  Medico             IS 'Médicos credenciados na clínica.';
COMMENT ON COLUMN Medico.CRM        IS 'Número CRM do médico (PK).';
COMMENT ON COLUMN Medico.Nome       IS 'Nome completo do médico.';
COMMENT ON COLUMN Medico.Idade      IS 'Idade do médico em anos.';
COMMENT ON COLUMN Medico.idEspecialidade IS 'FK para a especialidade do médico.';

-- -----------------------------------------------------------------------------
-- Procedimento
-- -----------------------------------------------------------------------------
CREATE TABLE Procedimento (
    ID_Procedimento     SERIAL       PRIMARY KEY,
    Descricao           VARCHAR(200) NOT NULL,
    CodigoEspecialidade INT          NOT NULL,
    CONSTRAINT fk_proc_especialidade
        FOREIGN KEY (CodigoEspecialidade) REFERENCES Especialidade(CodigoEspecialidade)
);

COMMENT ON TABLE  Procedimento                     IS 'Procedimentos médicos vinculados a especialidades.';
COMMENT ON COLUMN Procedimento.ID_Procedimento     IS 'Identificador do procedimento.';
COMMENT ON COLUMN Procedimento.Descricao           IS 'Descrição do procedimento clínico.';
COMMENT ON COLUMN Procedimento.CodigoEspecialidade IS 'FK para a especialidade que realiza o procedimento.';

-- -----------------------------------------------------------------------------
-- Paciente
-- -----------------------------------------------------------------------------
CREATE TABLE Paciente (
    CPF             CHAR(11)     PRIMARY KEY CHECK (CPF ~ '^\d{11}$'),
    Nome            VARCHAR(100) NOT NULL,
    DataNascimento  DATE         NOT NULL,
    Telefone        VARCHAR(20)  NOT NULL,
    Email           VARCHAR(100),
    Endereco        VARCHAR(200),
    idConvenio      INT,
    idProntuario    INT,           -- FK adicionada após criação de Prontuario (ALTER)
    CONSTRAINT fk_paciente_convenio
        FOREIGN KEY (idConvenio) REFERENCES Convenio(ans_registro)
);

COMMENT ON TABLE  Paciente              IS 'Pacientes cadastrados na clínica.';
COMMENT ON COLUMN Paciente.CPF         IS 'CPF do paciente — chave primária (11 dígitos).';
COMMENT ON COLUMN Paciente.Nome        IS 'Nome completo do paciente.';
COMMENT ON COLUMN Paciente.DataNascimento IS 'Data de nascimento.';
COMMENT ON COLUMN Paciente.Telefone    IS 'Telefone de contato.';
COMMENT ON COLUMN Paciente.Email       IS 'E-mail do paciente (opcional).';
COMMENT ON COLUMN Paciente.Endereco    IS 'Endereço residencial.';
COMMENT ON COLUMN Paciente.idConvenio  IS 'FK para o convênio do paciente (NULL = particular).';
COMMENT ON COLUMN Paciente.idProntuario IS 'FK para o prontuário principal do paciente.';

-- -----------------------------------------------------------------------------
-- Agendamento
-- -----------------------------------------------------------------------------
CREATE TABLE Agendamento (
    ID          SERIAL      PRIMARY KEY,
    data_hora   TIMESTAMP   NOT NULL,
    Status      VARCHAR(20) NOT NULL CHECK (Status IN ('Agendado','Realizado','Cancelado','Faltou')),
    Observacoes TEXT,
    idMedico    INT         NOT NULL,
    CONSTRAINT fk_agend_medico
        FOREIGN KEY (idMedico) REFERENCES Medico(CRM)
);

COMMENT ON TABLE  Agendamento             IS 'Agendamentos de consultas na clínica.';
COMMENT ON COLUMN Agendamento.ID          IS 'Identificador do agendamento.';
COMMENT ON COLUMN Agendamento.data_hora   IS 'Data e hora marcada.';
COMMENT ON COLUMN Agendamento.Status      IS 'Status do agendamento.';
COMMENT ON COLUMN Agendamento.Observacoes IS 'Observações livres do agendamento.';
COMMENT ON COLUMN Agendamento.idMedico    IS 'FK para o médico responsável.';

-- -----------------------------------------------------------------------------
-- Prontuario
-- -----------------------------------------------------------------------------
CREATE TABLE Prontuario (
    ID           SERIAL PRIMARY KEY,
    DataAbertura DATE   NOT NULL DEFAULT CURRENT_DATE,
    ID_Medico    INT    NOT NULL,
    idExame      INT,              -- FK adicionada após criação de Exame (ALTER)
    CONSTRAINT fk_pront_medico
        FOREIGN KEY (ID_Medico) REFERENCES Medico(CRM)
);

COMMENT ON TABLE  Prontuario             IS 'Prontuários médicos dos pacientes.';
COMMENT ON COLUMN Prontuario.ID          IS 'Identificador do prontuário.';
COMMENT ON COLUMN Prontuario.DataAbertura IS 'Data de abertura do prontuário.';
COMMENT ON COLUMN Prontuario.ID_Medico   IS 'FK para o médico responsável pelo prontuário.';
COMMENT ON COLUMN Prontuario.idExame     IS 'FK para o exame associado ao prontuário.';

-- -----------------------------------------------------------------------------
-- Exame
-- -----------------------------------------------------------------------------
CREATE TABLE Exame (
    ID           SERIAL       PRIMARY KEY,
    ID_Prontuario INT         NOT NULL,
    TipoExame    VARCHAR(100) NOT NULL,
    Status       VARCHAR(20)  NOT NULL CHECK (Status IN ('Solicitado','Em análise','Concluído','Cancelado')),
    Resultado    TEXT,
    CONSTRAINT fk_exame_prontuario
        FOREIGN KEY (ID_Prontuario) REFERENCES Prontuario(ID)
);

COMMENT ON TABLE  Exame               IS 'Exames solicitados e vinculados a prontuários.';
COMMENT ON COLUMN Exame.ID            IS 'Identificador do exame.';
COMMENT ON COLUMN Exame.ID_Prontuario IS 'FK para o prontuário ao qual o exame pertence.';
COMMENT ON COLUMN Exame.TipoExame     IS 'Tipo do exame (Hemograma, Raio-X, Tomografia, etc.).';
COMMENT ON COLUMN Exame.Status        IS 'Status atual do exame.';
COMMENT ON COLUMN Exame.Resultado     IS 'Resultado ou laudo do exame.';

-- FKs circulares resolvidas com ALTER TABLE
ALTER TABLE Prontuario ADD CONSTRAINT fk_pront_exame
    FOREIGN KEY (idExame) REFERENCES Exame(ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Paciente ADD CONSTRAINT fk_paciente_prontuario
    FOREIGN KEY (idProntuario) REFERENCES Prontuario(ID) DEFERRABLE INITIALLY DEFERRED;

-- -----------------------------------------------------------------------------
-- Consulta
-- -----------------------------------------------------------------------------
CREATE TABLE Consulta (
    ID              SERIAL       PRIMARY KEY,
    QueixaPrincipal TEXT         NOT NULL,
    Diagnostico     TEXT,
    Prescricao      TEXT,
    idPaciente      CHAR(11)     NOT NULL,
    idAgendamento   INT          NOT NULL UNIQUE,
    CONSTRAINT fk_consulta_paciente
        FOREIGN KEY (idPaciente)    REFERENCES Paciente(CPF),
    CONSTRAINT fk_consulta_agendamento
        FOREIGN KEY (idAgendamento) REFERENCES Agendamento(ID)
);

COMMENT ON TABLE  Consulta                IS 'Consultas médicas realizadas.';
COMMENT ON COLUMN Consulta.ID             IS 'Identificador da consulta.';
COMMENT ON COLUMN Consulta.QueixaPrincipal IS 'Queixa principal relatada pelo paciente.';
COMMENT ON COLUMN Consulta.Diagnostico    IS 'Diagnóstico médico registrado.';
COMMENT ON COLUMN Consulta.Prescricao     IS 'Prescrição médica.';
COMMENT ON COLUMN Consulta.idPaciente     IS 'FK para o paciente atendido.';
COMMENT ON COLUMN Consulta.idAgendamento  IS 'FK para o agendamento correspondente (1:1).';

-- -----------------------------------------------------------------------------
-- HistoricoProntuario
-- -----------------------------------------------------------------------------
CREATE TABLE HistoricoProntuario (
    ID_Historico       SERIAL       PRIMARY KEY,
    Descricao          TEXT         NOT NULL,
    DataRegistro       DATE         NOT NULL DEFAULT CURRENT_DATE,
    ID_Prontuario      INT          NOT NULL,
    CONSTRAINT fk_historico_prontuario
        FOREIGN KEY (ID_Prontuario) REFERENCES Prontuario(ID)
);

COMMENT ON TABLE  HistoricoProntuario              IS 'Entradas históricas de evolução clínica de um prontuário.';
COMMENT ON COLUMN HistoricoProntuario.ID_Historico IS 'Identificador do registro histórico.';
COMMENT ON COLUMN HistoricoProntuario.Descricao    IS 'Descrição da evolução ou registro clínico.';
COMMENT ON COLUMN HistoricoProntuario.DataRegistro IS 'Data do registro no histórico.';
COMMENT ON COLUMN HistoricoProntuario.ID_Prontuario IS 'FK para o prontuário ao qual o histórico pertence.';


-- =============================================================================
-- SEÇÃO 2 — DML (Data Manipulation Language) — Dados de Teste
-- =============================================================================

-- Especialidades
INSERT INTO Especialidade (NomeEspecialidade) VALUES
    ('Cardiologia'),
    ('Ortopedia'),
    ('Dermatologia'),
    ('Neurologia'),
    ('Pediatria'),
    ('Ginecologia'),
    ('Oftalmologia'),
    ('Oncologia'),
    ('Endocrinologia'),
    ('Psiquiatria');

-- Convênios
INSERT INTO Convenio (ans_registro, Nome, Plano, Contato) VALUES
    (100001, 'Unimed',       'Premium',  '(31) 3000-1111'),
    (100002, 'Bradesco Saúde','Standard', '(31) 3000-2222'),
    (100003, 'Amil',         'Básico',   '(31) 3000-3333'),
    (100004, 'SulAmérica',   'Premium',  '(31) 3000-4444'),
    (100005, 'Notre Dame',   'Standard', '(31) 3000-5555');

-- Médicos
INSERT INTO Medico (CRM, Nome, Idade, idEspecialidade) VALUES
    (12001, 'Dr. Rafael Souza',      45, 1),
    (12002, 'Dra. Mariana Lima',     38, 2),
    (12003, 'Dr. Carlos Ferreira',   52, 3),
    (12004, 'Dra. Beatriz Almeida',  41, 4),
    (12005, 'Dr. Fernando Dias',     35, 5),
    (12006, 'Dra. Juliana Costa',    47, 6),
    (12007, 'Dr. Rodrigo Mendes',    39, 7),
    (12008, 'Dra. Patricia Rocha',   55, 8),
    (12009, 'Dr. Leandro Barbosa',   43, 9),
    (12010, 'Dra. Camila Neves',     36, 10);

-- Procedimentos
INSERT INTO Procedimento (Descricao, CodigoEspecialidade) VALUES
    ('Eletrocardiograma',           1),
    ('Ecocardiograma',              1),
    ('Ressonância de Joelho',       2),
    ('Infiltração Articular',       2),
    ('Biópsia de Pele',             3),
    ('Mapeamento Cerebral',         4),
    ('Consulta Pediátrica Rotina',  5),
    ('Papanicolau',                 6),
    ('Mapeamento de Retina',        7),
    ('Quimioterapia Ambulatorial',  8);

-- Agendamentos (sem paciente vinculado ainda)
INSERT INTO Agendamento (data_hora, Status, Observacoes, idMedico) VALUES
    ('2026-04-01 08:00', 'Realizado',  'Primeira consulta',                12001),
    ('2026-04-02 09:00', 'Realizado',  'Retorno pós-cirurgia',             12002),
    ('2026-04-03 10:00', 'Realizado',  'Acompanhamento dermatológico',     12003),
    ('2026-04-04 11:00', 'Realizado',  'Avaliação neurológica',            12004),
    ('2026-04-05 14:00', 'Realizado',  'Consulta de rotina pediátrica',    12005),
    ('2026-04-07 08:30', 'Realizado',  'Exame ginecológico preventivo',    12006),
    ('2026-04-08 15:00', 'Cancelado',  'Paciente cancelou',                12007),
    ('2026-04-09 16:00', 'Realizado',  'Acompanhamento oncológico',        12008),
    ('2026-04-10 08:00', 'Faltou',     'Paciente não compareceu',          12009),
    ('2026-04-11 09:00', 'Agendado',   'Primeira consulta psiquiátrica',   12010),
    ('2026-05-01 10:00', 'Agendado',   NULL,                               12001),
    ('2026-05-02 11:00', 'Agendado',   NULL,                               12003);

-- Prontuários (sem idExame por ora — atualizado depois)
INSERT INTO Prontuario (DataAbertura, ID_Medico) VALUES
    ('2026-01-10', 12001),
    ('2026-01-15', 12002),
    ('2026-02-01', 12003),
    ('2026-02-10', 12004),
    ('2026-02-20', 12005),
    ('2026-03-01', 12006),
    ('2026-03-10', 12007),
    ('2026-03-15', 12008),
    ('2026-03-20', 12009),
    ('2026-04-01', 12010);

-- Pacientes
INSERT INTO Paciente (CPF, Nome, DataNascimento, Telefone, Email, Endereco, idConvenio, idProntuario) VALUES
    ('11122233344', 'Ana Paula Ribeiro',    '1990-03-15', '(31)99001-0001', 'ana@email.com',      'Rua das Flores, 10',       100001, 1),
    ('22233344455', 'Bruno Henrique Silva', '1985-07-22', '(31)99001-0002', 'bruno@email.com',    'Av. Brasil, 200',          100002, 2),
    ('33344455566', 'Carla Oliveira Mota',  '1978-11-05', '(31)99001-0003', 'carla@email.com',    'Rua Goiás, 55',            100003, 3),
    ('44455566677', 'Diego Santos Pereira', '2001-01-30', '(31)99001-0004', 'diego@email.com',    'Rua MG, 88',               100001, 4),
    ('55566677788', 'Elaine Ferreira Cruz', '1995-06-18', '(31)99001-0005', 'elaine@email.com',   'Rua SP, 120',              NULL,   5),
    ('66677788899', 'Fábio Cardoso Lima',   '1970-09-09', '(31)99001-0006', 'fabio@email.com',    'Rua RJ, 300',              100004, 6),
    ('77788899900', 'Gabriela Torres Neto', '1988-04-25', '(31)99001-0007', 'gabi@email.com',     'Av. Contorno, 400',        100002, 7),
    ('88899900011', 'Henrique Belo Costa',  '1960-12-01', '(31)99001-0008', 'henrique@email.com', 'Rua Pinheiros, 500',       100005, 8),
    ('99900011122', 'Isabela Duarte Faria', '2000-08-14', '(31)99001-0009', 'isa@email.com',      'Av. Amazonas, 600',        100003, 9),
    ('00011122233', 'João Vitor Alves',     '1975-02-28', '(31)99001-0010', 'joao@email.com',     'Rua Bahia, 700',           NULL,   10);

-- Exames
INSERT INTO Exame (ID_Prontuario, TipoExame, Status, Resultado) VALUES
    (1,  'Eletrocardiograma',  'Concluído',   'Ritmo sinusal normal.'),
    (2,  'Ressonância Magnética', 'Concluído','Sem alterações relevantes.'),
    (3,  'Biópsia de Pele',    'Concluído',   'Lesão benigna.'),
    (4,  'EEG',                'Concluído',   'Ondas dentro do padrão.'),
    (5,  'Hemograma Completo', 'Concluído',   'Valores normais.'),
    (6,  'Papanicolau',        'Concluído',   'Resultado negativo.'),
    (7,  'Mapeamento de Retina','Em análise', NULL),
    (8,  'PET-CT',             'Concluído',   'Remissão parcial observada.'),
    (9,  'Glicemia em Jejum',  'Concluído',   '98 mg/dL — dentro do normal.'),
    (10, 'Avaliação Psiquiátrica', 'Solicitado', NULL);

-- Atualiza Prontuarios com FK de Exame
UPDATE Prontuario SET idExame = 1  WHERE ID = 1;
UPDATE Prontuario SET idExame = 2  WHERE ID = 2;
UPDATE Prontuario SET idExame = 3  WHERE ID = 3;
UPDATE Prontuario SET idExame = 4  WHERE ID = 4;
UPDATE Prontuario SET idExame = 5  WHERE ID = 5;
UPDATE Prontuario SET idExame = 6  WHERE ID = 6;
UPDATE Prontuario SET idExame = 7  WHERE ID = 7;
UPDATE Prontuario SET idExame = 8  WHERE ID = 8;
UPDATE Prontuario SET idExame = 9  WHERE ID = 9;
UPDATE Prontuario SET idExame = 10 WHERE ID = 10;

-- Consultas (vinculadas aos agendamentos realizados)
INSERT INTO Consulta (QueixaPrincipal, Diagnostico, Prescricao, idPaciente, idAgendamento) VALUES
    ('Dor no peito e falta de ar',        'Hipertensão arterial leve',      'Enalapril 5mg/dia',              '11122233344', 1),
    ('Dor no joelho ao subir escadas',    'Condromalácia patelar grau II',  'Fisioterapia + Ibuprofeno',      '22233344455', 2),
    ('Manchas avermelhadas na pele',      'Dermatite atópica',              'Hidrocortisona creme 1%',        '33344455566', 3),
    ('Cefaleia intensa recorrente',       'Enxaqueca com aura',             'Sumatriptana 50mg SOS',          '44455566677', 4),
    ('Febre e coriza há 3 dias',          'Rinofaringite viral',            'Dipirona 500mg + repouso',       '55566677788', 5),
    ('Corrimento vaginal e coceira',      'Candidíase vulvovaginal',        'Fluconazol 150mg dose única',    '66677788899', 6),
    ('Visão turva no olho direito',       'Catarata inicial',               'Acompanhamento semestral',       '88899900011', 8),
    ('Cansaço excessivo e ganho de peso', 'Hipotireoidismo',                'Levotiroxina 50mcg/dia',         '99900011122', 9);

-- Histórico dos prontuários
INSERT INTO HistoricoProntuario (Descricao, DataRegistro, ID_Prontuario) VALUES
    ('Paciente chegou com queixa de dor torácica. PA: 150/95.',          '2026-01-10', 1),
    ('Retorno: PA controlada após início do Enalapril. PA: 130/80.',     '2026-04-01', 1),
    ('Pós-operatório de artroscopia de joelho. Sem intercorrências.',    '2026-01-15', 2),
    ('Fisioterapia em andamento. Melhora de 60% da dor.',                '2026-04-02', 2),
    ('Lesão na pele avaliada. Biópsia solicitada.',                      '2026-02-01', 3),
    ('Resultado da biópsia: benigno. Alta dermatológica.',               '2026-04-03', 3),
    ('EEG solicitado para investigação de enxaqueca.',                   '2026-02-10', 4),
    ('EEG normal. Tratamento profilático iniciado.',                     '2026-04-04', 4),
    ('Criança com febre há 3 dias. Orofaringe hiperemiada.',             '2026-02-20', 5),
    ('Exames de rotina pediátrica — todos dentro do esperado.',          '2026-04-05', 5),
    ('Queixa de corrimento. Exame ginecológico realizado.',              '2026-03-01', 6),
    ('Papanicolau negativo. Orientações de prevenção fornecidas.',       '2026-04-07', 6),
    ('Paciente refere visão turva há 2 meses.',                          '2026-03-10', 7),
    ('Mapeamento de retina em análise.',                                 '2026-04-08', 7),
    ('PET-CT evidencia remissão parcial. Próximo ciclo agendado.',       '2026-03-15', 8),
    ('Glicemia e TSH solicitados. Suspeita de hipotireoidismo.',         '2026-03-20', 9),
    ('Levotiroxina iniciada. Retorno em 3 meses.',                       '2026-04-10', 9),
    ('Primeira consulta psiquiátrica agendada.',                         '2026-04-01', 10);


-- =============================================================================
-- SEÇÃO 3 — CONSULTAS SQL (Q1–Q10)
-- =============================================================================

-- ----------------------------------------------------------------------------
-- Q1 — Projeção e seleção simples
-- Pergunta de negócio: Quais pacientes não possuem convênio (particulares)
--                      ou nasceram após 1990?
-- ----------------------------------------------------------------------------
SELECT
    CPF,
    Nome,
    DataNascimento,
    CASE WHEN idConvenio IS NULL THEN 'Particular' ELSE 'Conveniado' END AS TipoAtendimento
FROM Paciente
WHERE idConvenio IS NULL
   OR DataNascimento > '1990-01-01'
ORDER BY DataNascimento;

-- ----------------------------------------------------------------------------
-- Q2 — Projeção e seleção simples
-- Pergunta de negócio: Quais agendamentos estão com status 'Agendado' ou
--                      'Faltou' e foram marcados entre abril e maio de 2026?
-- ----------------------------------------------------------------------------
SELECT
    ID,
    data_hora,
    Status,
    Observacoes
FROM Agendamento
WHERE Status IN ('Agendado', 'Faltou')
  AND data_hora BETWEEN '2026-04-01' AND '2026-05-31 23:59'
ORDER BY data_hora;

-- ----------------------------------------------------------------------------
-- Q3 — INNER JOIN (2 tabelas)
-- Pergunta de negócio: Liste os médicos com seus respectivos nomes de especialidade.
-- ----------------------------------------------------------------------------
SELECT
    m.CRM,
    m.Nome       AS Medico,
    m.Idade,
    e.NomeEspecialidade AS Especialidade
FROM Medico m
INNER JOIN Especialidade e ON m.idEspecialidade = e.CodigoEspecialidade
ORDER BY e.NomeEspecialidade, m.Nome;

-- ----------------------------------------------------------------------------
-- Q4 — INNER JOIN (3 tabelas)
-- Pergunta de negócio: Quais consultas foram realizadas, por qual médico
--                      e para qual paciente?
-- ----------------------------------------------------------------------------
SELECT
    c.ID                AS ID_Consulta,
    p.Nome              AS Paciente,
    m.Nome              AS Medico,
    e.NomeEspecialidade AS Especialidade,
    a.data_hora         AS DataHoraConsulta,
    c.Diagnostico
FROM Consulta c
INNER JOIN Paciente    p ON c.idPaciente    = p.CPF
INNER JOIN Agendamento a ON c.idAgendamento = a.ID
INNER JOIN Medico      m ON a.idMedico      = m.CRM
INNER JOIN Especialidade e ON m.idEspecialidade = e.CodigoEspecialidade
ORDER BY a.data_hora;

-- ----------------------------------------------------------------------------
-- Q5 — LEFT OUTER JOIN
-- Pergunta de negócio: Liste todos os pacientes e seus convênios —
--                      incluindo os que não possuem convênio (particular).
-- ----------------------------------------------------------------------------
SELECT
    p.CPF,
    p.Nome              AS Paciente,
    c.Nome              AS Convenio,
    c.Plano
FROM Paciente p
LEFT JOIN Convenio c ON p.idConvenio = c.ans_registro
ORDER BY c.Nome NULLS LAST, p.Nome;

-- ----------------------------------------------------------------------------
-- Q6 — Agrupamento e agregação
-- Pergunta de negócio: Quantos agendamentos cada médico possui, por status,
--                      considerando apenas médicos com mais de 2 agendamentos?
-- ----------------------------------------------------------------------------
SELECT
    m.Nome  AS Medico,
    a.Status,
    COUNT(*) AS TotalAgendamentos
FROM Agendamento a
INNER JOIN Medico m ON a.idMedico = m.CRM
GROUP BY m.Nome, a.Status
HAVING COUNT(*) >= 1
ORDER BY m.Nome, TotalAgendamentos DESC;

-- ----------------------------------------------------------------------------
-- Q7 — Subquery não correlacionada
-- Pergunta de negócio: Quais exames pertencem a prontuários abertos por
--                      médicos da especialidade de Cardiologia?
-- ----------------------------------------------------------------------------
SELECT
    ex.ID         AS ID_Exame,
    ex.TipoExame,
    ex.Status,
    ex.Resultado
FROM Exame ex
WHERE ex.ID_Prontuario IN (
    SELECT pr.ID
    FROM Prontuario pr
    WHERE pr.ID_Medico IN (
        SELECT m.CRM
        FROM Medico m
        INNER JOIN Especialidade e ON m.idEspecialidade = e.CodigoEspecialidade
        WHERE e.NomeEspecialidade = 'Cardiologia'
    )
);

-- ----------------------------------------------------------------------------
-- Q8 — Subquery correlacionada com EXISTS
-- Pergunta de negócio: Quais pacientes já tiveram ao menos uma consulta
--                      com diagnóstico registrado?
-- ----------------------------------------------------------------------------
SELECT
    p.CPF,
    p.Nome,
    p.Telefone
FROM Paciente p
WHERE EXISTS (
    SELECT 1
    FROM Consulta c
    WHERE c.idPaciente = p.CPF
      AND c.Diagnostico IS NOT NULL
);

-- ----------------------------------------------------------------------------
-- Q9 — VIEW
-- Pergunta de negócio: Criar uma visão consolidada de atendimentos com
--                      paciente, médico, especialidade e data da consulta.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_AtendimentosCompletos AS
SELECT
    p.Nome              AS Paciente,
    p.CPF,
    m.Nome              AS Medico,
    e.NomeEspecialidade AS Especialidade,
    a.data_hora         AS DataConsulta,
    c.QueixaPrincipal,
    c.Diagnostico,
    c.Prescricao,
    COALESCE(cv.Nome, 'Particular') AS Convenio
FROM Consulta c
INNER JOIN Paciente    p  ON c.idPaciente    = p.CPF
INNER JOIN Agendamento a  ON c.idAgendamento = a.ID
INNER JOIN Medico      m  ON a.idMedico      = m.CRM
INNER JOIN Especialidade e ON m.idEspecialidade = e.CodigoEspecialidade
LEFT  JOIN Convenio    cv ON p.idConvenio    = cv.ans_registro;

-- Uso da view
SELECT * FROM vw_AtendimentosCompletos ORDER BY DataConsulta;

-- ----------------------------------------------------------------------------
-- Q10 — Consulta de negócio livre (complexidade elevada)
-- Pergunta de negócio: Qual é o histórico clínico completo de cada paciente:
--                      número de consultas, exames realizados, último diagnóstico
--                      e tipo de atendimento (convênio ou particular)?
-- ----------------------------------------------------------------------------
WITH resumo_consultas AS (
    SELECT
        c.idPaciente,
        COUNT(c.ID)                                    AS TotalConsultas,
        MAX(a.data_hora)                               AS UltimaConsulta,
        (ARRAY_AGG(c.Diagnostico ORDER BY a.data_hora DESC))[1] AS UltimoDiagnostico
    FROM Consulta c
    INNER JOIN Agendamento a ON c.idAgendamento = a.ID
    GROUP BY c.idPaciente
),
resumo_exames AS (
    SELECT
        pa.CPF,
        COUNT(ex.ID) AS TotalExames
    FROM Paciente pa
    INNER JOIN Prontuario pr ON pa.idProntuario = pr.ID
    INNER JOIN Exame      ex ON ex.ID_Prontuario = pr.ID
    GROUP BY pa.CPF
)
SELECT
    p.Nome                                              AS Paciente,
    p.CPF,
    COALESCE(cv.Nome, 'Particular')                    AS Convenio,
    COALESCE(rc.TotalConsultas, 0)                     AS TotalConsultas,
    COALESCE(re.TotalExames, 0)                        AS TotalExames,
    rc.UltimaConsulta,
    rc.UltimoDiagnostico
FROM Paciente p
LEFT JOIN resumo_consultas rc ON p.CPF = rc.idPaciente
LEFT JOIN resumo_exames    re ON p.CPF = re.CPF
LEFT JOIN Convenio         cv ON p.idConvenio = cv.ans_registro
ORDER BY TotalConsultas DESC, p.Nome;
