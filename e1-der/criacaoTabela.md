CREATE TABLE Paciente (
    CPF CHAR(11) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DATE NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    Endereco VARCHAR(150));

CREATE TABLE Medico (
    CRM VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DATE,
    CHECK (LENGTH(CRM) >= 4));

CREATE TABLE Especialidade (
    CodigoEspecialidade INT PRIMARY KEY,
    NomeEspecialidade VARCHAR(100) NOT NULL,
    ProcedimentosRealizados TEXT,
    QuantidadeDeProcedimentos INT CHECK (QuantidadeDeProcedimentos >= 0));

CREATE TABLE Possui1 (
    CRM VARCHAR(20),
    CodigoEspecialidade INT,
    PRIMARY KEY (CRM, CodigoEspecialidade),
    FOREIGN KEY (CRM) REFERENCES Medico(CRM),
    FOREIGN KEY (CodigoEspecialidade) REFERENCES Especialidade(CodigoEspecialidade));

CREATE TABLE Consulta (
    ID INT PRIMARY KEY,
    DataHora TIMESTAMP NOT NULL,
    QueixaPrincipal TEXT NOT NULL,
    Diagnostico TEXT,
    Prescricao TEXT,
    CPF_Paciente CHAR(11) NOT NULL,
    CRM_Medico VARCHAR(20) NOT NULL,
    FOREIGN KEY (CPF_Paciente) REFERENCES Paciente(CPF),
    FOREIGN KEY (CRM_Medico) REFERENCES Medico(CRM));

CREATE TABLE Prontuario (
    ID INT PRIMARY KEY,
    DataAbertura DATE NOT NULL,
    HistoricoMedico TEXT,
    CPF_Paciente CHAR(11) UNIQUE,
    FOREIGN KEY (CPF_Paciente) REFERENCES Paciente(CPF)
);
CREATE TABLE Exame (
    ID INT PRIMARY KEY,
    TipoExame VARCHAR(100) NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Pendente', 'Concluido', 'Cancelado')),
    Resultado TEXT,
    ID_Prontuario INT NOT NULL,
    FOREIGN KEY (ID_Prontuario) REFERENCES Prontuario(ID)
);

CREATE TABLE Agendamento (
    ID INT PRIMARY KEY,
    DataHora TIMESTAMP NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Agendado', 'Cancelado', 'Realizado')),
    Observacoes TEXT,
    CPF_Paciente CHAR(11) NOT NULL,
    CRM_Medico VARCHAR(20) NOT NULL,
    FOREIGN KEY (CPF_Paciente) REFERENCES Paciente(CPF),
    FOREIGN KEY (CRM_Medico) REFERENCES Medico(CRM)
);

CREATE TABLE Convenio (
    ans_registro VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Plano VARCHAR(50),
    Contato VARCHAR(100)
);

CREATE TABLE Cobre (
    ans_registro VARCHAR(20),
    idAgendamento INT,
    PRIMARY KEY (ans_registro, idAgendamento),
    FOREIGN KEY (ans_registro) REFERENCES Convenio(ans_registro),
    FOREIGN KEY (idAgendamento) REFERENCES Agendamento(ID)
);