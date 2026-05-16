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
