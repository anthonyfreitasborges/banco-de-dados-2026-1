
-- =============================================
-- BANCO DE DADOS CLINICA MEDICA - PostgreSQL
-- =============================================

-- =========================
-- TABELAS
-- =========================

CREATE TABLE Especialidade (
    CodigoEspecialidade INT PRIMARY KEY,
    NomeEspecialidade VARCHAR(100) NOT NULL
);

CREATE TABLE Medico (
    CRM INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Idade INT,
    CodigoEspecialidade INT,
    CONSTRAINT fk_medico_especialidade
        FOREIGN KEY (CodigoEspecialidade)
        REFERENCES Especialidade(CodigoEspecialidade)
);

CREATE TABLE Paciente (
    CPF VARCHAR(14) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DATE,
    Telefone VARCHAR(20),
    Email VARCHAR(100),
    Endereco VARCHAR(200)
);

CREATE TABLE Convenio (
    id_convenio INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Plano VARCHAR(100),
    Contato VARCHAR(100)
);

CREATE TABLE Agendamento (
    idAgendamento INT PRIMARY KEY,
    data_hora TIMESTAMP NOT NULL,
    Status VARCHAR(50),
    Observacoes TEXT
);

CREATE TABLE Consulta (
    ID INT PRIMARY KEY,
    DataHora TIMESTAMP NOT NULL,
    QueixaPrincipal TEXT,
    Diagnostico TEXT,
    Prescricao TEXT,
    id_convenio INT,
    idMedico INT,
    idPaciente VARCHAR(14),
    idAgendamento INT,
    FOREIGN KEY (id_convenio) REFERENCES Convenio(id_convenio),
    FOREIGN KEY (idMedico) REFERENCES Medico(CRM),
    FOREIGN KEY (idPaciente) REFERENCES Paciente(CPF),
    FOREIGN KEY (idAgendamento) REFERENCES Agendamento(idAgendamento)
);

CREATE TABLE Prontuario (
    ID INT PRIMARY KEY,
    ID_Medico INT,
    DataAbertura DATE,
    HistoricoMedico TEXT,
    cpf VARCHAR(14),
    FOREIGN KEY (ID_Medico) REFERENCES Medico(CRM),
    FOREIGN KEY (cpf) REFERENCES Paciente(CPF)
);

CREATE TABLE Exame (
    ID_exame INT PRIMARY KEY,
    ID_Prontuario INT,
    TipoExame VARCHAR(100),
    Status VARCHAR(50),
    Resultado TEXT,
    id_consulta INT,
    FOREIGN KEY (ID_Prontuario) REFERENCES Prontuario(ID),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(ID)
);

-- =========================
-- INSERTS BÁSICOS
-- =========================

INSERT INTO Especialidade VALUES
(1,'Cardiologia'),
(2,'Ortopedia'),
(3,'Pediatria'),
(4,'Dermatologia'),
(5,'Neurologia');

INSERT INTO Convenio VALUES
(1,'Unimed','Premium','3130000001'),
(2,'Unimed','Basico','3130000002'),
(3,'SulAmerica','Ouro','3130000003'),
(4,'Bradesco','Top','3130000004'),
(5,'Amil','Essencial','3130000005');

INSERT INTO Agendamento VALUES
(1,'2026-05-01 08:00:00','Confirmado',''),
(2,'2026-05-01 09:00:00','Confirmado',''),
(3,'2026-05-01 10:00:00','Confirmado',''),
(4,'2026-05-01 11:00:00','Confirmado',''),
(5,'2026-05-01 12:00:00','Confirmado',''),
(6,'2026-05-01 13:00:00','Confirmado',''),
(7,'2026-05-01 14:00:00','Confirmado',''),
(8,'2026-05-01 15:00:00','Confirmado',''),
(9,'2026-05-01 16:00:00','Confirmado',''),
(10,'2026-05-01 17:00:00','Confirmado','');

-- (Demais inserts podem ser adicionados conforme necessário)
