-- ============================================================
--  Banco de dados: Clínica Médica
--  Banco: PostgreSQL
-- ============================================================

-- =========================
-- CRIAÇÃO DAS TABELAS
-- =========================

CREATE TABLE Especialidade (
    CodigoEspecialidade INT PRIMARY KEY,
    NomeEspecialidade VARCHAR(100) NOT NULL
);

CREATE TABLE Medico (
    CRM INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DATE,
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
    Endereco VARCHAR(200),
    idConvenio INT,

    FOREIGN KEY (idConvenio)
        REFERENCES Convenio(id_convenio)
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
    idMedico INT,
    idPaciente VARCHAR(14),
    idAgendamento INT,
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

-- =========================
-- INSERT: Medico
-- (CRM, Nome, Idade, CodigoEspecialidade)
-- =========================

INSERT INTO Medico VALUES
(10001, 'Dr. Carlos Mendes',   '1978-05-10', 1),
(10002, 'Dra. Ana Souza',      '1991-08-22', 1),
(10003, 'Dr. Roberto Lima',    '1974-03-15', 2),
(10004, 'Dra. Fernanda Costa', '1985-11-30', 2),
(10005, 'Dra. Patricia Nunes', '1988-07-12', 3),
(10006, 'Dr. Marcos Alves',    '1981-09-25', 3),
(10007, 'Dr. Paulo Ramos',     '1976-02-18', 4),
(10008, 'Dra. Juliana Melo',   '1993-12-05', 4),
(10009, 'Dr. Ricardo Barros',  '1969-06-08', 5),
(10010, 'Dra. Camila Torres',  '1987-04-20', 5);

-- =========================
-- INSERT: Paciente
-- (CPF, Nome, DataNascimento, Telefone, Email, Endereco)
-- =========================

INSERT INTO Paciente VALUES
('111.111.111-11', 'Joao da Silva',   '1985-03-15', '(31) 99111-2222', 'joao.silva@email.com',      'Rua das Flores, 100, Belo Horizonte - MG', 1),
('222.222.222-22', 'Maria Oliveira',  '1992-07-22', '(31) 99222-3333', 'maria.oliveira@email.com',  'Av. Afonso Pena, 200, Belo Horizonte - MG', 2),
('333.333.333-33', 'Pedro Santos',    '1978-11-30', '(31) 99333-4444', 'pedro.santos@email.com',    'Rua da Bahia, 300, Belo Horizonte - MG', 3),
('444.444.444-44', 'Lucia Ferreira',  '2010-05-10', '(31) 99444-5555', 'lucia.ferreira@email.com',  'Rua Espirito Santo, 400, Belo Horizonte - MG', 4),
('555.555.555-55', 'Carlos Almeida',  '1965-09-05', '(31) 99555-6666', 'carlos.almeida@email.com',  'Rua Goias, 500, Belo Horizonte - MG', 5),
('666.666.666-66', 'Ana Paula Rocha', '1990-01-18', '(31) 99666-7777', 'anapaula.rocha@email.com',  'Rua Sergipe, 600, Belo Horizonte - MG', 1),
('777.777.777-77', 'Bruno Costa',     '1982-06-25', '(31) 99777-8888', 'bruno.costa@email.com',     'Av. Amazonas, 700, Belo Horizonte - MG', 2),
('888.888.888-88', 'Fernanda Lima',   '1999-12-03', '(31) 99888-9999', 'fernanda.lima@email.com',   'Rua Parana, 800, Belo Horizonte - MG', 3),
('999.999.999-99', 'Rafael Mendonca', '1975-08-14', '(31) 99900-1111', 'rafael.mendonca@email.com', 'Av. do Contorno, 900, Belo Horizonte - MG', 4),
('000.000.000-00', 'Claudia Peixoto', '2005-04-29', '(31) 99000-2222', 'claudia.peixoto@email.com', 'Rua Curitiba, 1000, Belo Horizonte - MG', 5);

-- =========================
-- INSERT: Consulta
-- (ID, DataHora, QueixaPrincipal, Diagnostico, Prescricao,
--  id_convenio, idMedico, idPaciente, idAgendamento)
-- =========================

INSERT INTO Consulta VALUES
(1,  '2026-05-01 08:00:00', 'Dor no peito e falta de ar',       'Angina estavel',             'Atenolol 50mg 1x ao dia',            10001, '111.111.111-11', 1),
(2,  '2026-05-01 09:00:00', 'Palpitacoes frequentes',           'Arritmia supraventricular',  'Verapamil 80mg 2x ao dia',           10002, '222.222.222-22', 2),
(3,  '2026-05-01 10:00:00', 'Dor no joelho esquerdo',           'Condromalacia patelar',      'Ibuprofeno 600mg + fisioterapia',    10003, '333.333.333-33', 3),
(4,  '2026-05-01 11:00:00', 'Dor lombar ha 2 semanas',          'Lombalgia mecanica',         'Relaxante muscular + repouso',       10004, '444.444.444-44', 4),
(5,  '2026-05-01 12:00:00', 'Febre e tosse ha 3 dias',          'Infeccao respiratoria viral','Paracetamol 500mg + repouso',        10005, '555.555.555-55', 5),
(6,  '2026-05-01 13:00:00', 'Crianca com otite recorrente',     'Otite media aguda',          'Amoxicilina 250mg xarope 7 dias',    10006, '666.666.666-66', 6),
(7,  '2026-05-01 14:00:00', 'Manchas vermelhas no rosto',       'Dermatite seborreica',       'Cetoconazol shampoo + hidratante',   10007, '777.777.777-77', 7),
(8,  '2026-05-01 15:00:00', 'Acne severa nas costas',           'Acne grau III',              'Adapaleno gel + Doxiciclina 100mg',  10008, '888.888.888-88', 8),
(9,  '2026-05-01 16:00:00', 'Dores de cabeca diarias intensas', 'Enxaqueca cronica',          'Topiramato 50mg + Sumatriptano',     10009, '999.999.999-99', 9),
(10, '2026-05-01 17:00:00', 'Formigamento nas maos a noite',    'Sindrome do tunel do carpo', 'Ortese noturna + anti-inflamatorio', 10010, '000.000.000-00', 10);

-- =========================
-- INSERT: Prontuario
-- (ID, ID_Medico, DataAbertura, HistoricoMedico, cpf)
-- =========================

INSERT INTO Prontuario VALUES
(1,  10001, '2026-05-01', 'Paciente hipertenso ha 5 anos. Uso continuo de anti-hipertensivos. Primeira consulta cardiologica na clinica.',            '111.111.111-11'),
(2,  10002, '2026-05-01', 'Relata palpitacoes ha 3 meses. Sem historico cardiaco familiar. ECG solicitado na consulta.',                              '222.222.222-22'),
(3,  10003, '2026-05-01', 'Praticante de futebol amador. Dor progressiva no joelho esquerdo. Raio-X sem fratura aparente.',                           '333.333.333-33'),
(4,  10004, '2026-05-01', 'Trabalho sedentario. Lombalgia recorrente. Indicado programa de fisioterapia e fortalecimento muscular.',                  '444.444.444-44'),
(5,  10005, '2026-05-01', 'Crianca com historico de infeccoes respiratorias. Vacinacao em dia. Boa resposta a paracetamol.',                          '555.555.555-55'),
(6,  10006, '2026-05-01', 'Historico de otites de repeticao desde os 2 anos. Avaliacao otorrinolaringologica recomendada.',                           '666.666.666-66'),
(7,  10007, '2026-05-01', 'Pele oleosa com lesoes descamativas. Ja utilizou outros tratamentos sem sucesso. Iniciando novo protocolo dermatologico.', '777.777.777-77'),
(8,  10008, '2026-05-01', 'Acne severa com impacto na autoestima. Historico familiar positivo. Contraceptivo em uso.',                                '888.888.888-88'),
(9,  10009, '2026-05-01', 'Enxaqueca com aura desde a adolescencia. Gatilhos: estresse e privacao de sono. Diario de crises recomendado.',            '999.999.999-99'),
(10, 10010, '2026-05-01', 'Sindrome do tunel do carpo bilateral. Trabalha ha 10 anos digitando. Cirurgia pode ser necessaria sem melhora.',           '000.000.000-00');

-- =========================
-- INSERT: Exame
-- (ID_exame, ID_Prontuario, TipoExame, Status, Resultado, id_consulta)
-- =========================

INSERT INTO Exame VALUES
(1,  1,  'Eletrocardiograma',       'Concluido',  'Ritmo sinusal, sem alteracoes isquemicas. Frequencia cardiaca de 72 bpm.',                      1),
(2,  1,  'Ecocardiograma',          'Pendente',    NULL,                                                                                             1),
(3,  2,  'Holter 24h',              'Concluido',  '3 extrassistoles supraventriculares isoladas registradas. Sem taquicardia sustentada.',           2),
(4,  3,  'Raio-X joelho esquerdo',  'Concluido',  'Leve pincamento do espaco articular medial. Sem fraturas ou luxacoes.',                          3),
(5,  3,  'Ressonancia do joelho',   'Pendente',    NULL,                                                                                             3),
(6,  4,  'Raio-X coluna lombar',    'Concluido',  'Discretas alteracoes degenerativas em L4-L5. Sem compressao radicular evidente.',                4),
(7,  5,  'Hemograma completo',      'Concluido',  'Leucocitose leve (12.000/mm3). Demais parametros dentro da normalidade.',                        5),
(8,  6,  'Timpanometria',           'Concluido',  'Curva tipo B na orelha direita, sugestivo de efusao no ouvido medio.',                           6),
(9,  7,  'Cultura de pele',         'Concluido',  'Crescimento de Malassezia furfur. Sensivel a antifungicos topicos.',                             7),
(10, 8,  'Dosagem hormonal DHEA-S', 'Concluido',  'DHEA-S levemente elevado. Androgenos dentro dos limites aceitaveis para a faixa etaria.',        8),
(11, 9,  'Ressonancia magnetica',   'Concluido',  'Sem lesoes estruturais encefalicas. Achados compativeis com enxaqueca sem substrato organico.',  9),
(12, 10, 'Eletroneuromiografia',    'Concluido',  'Reducao da velocidade de conducao no nervo mediano bilateral, confirmando sindrome do tunel.',   10);
