# 🏥 Banco de Dados — Sistema de Consultas Médicas

---

## 📋 Tabelas

- [Especialidade](#especialidade)
- [Medico](#medico)
- [Paciente](#paciente)
- [Convenio](#convenio)
- [Agendamento](#agendamento)
- [Consulta](#consulta)
- [Prontuario](#prontuario)
- [Exame](#exame)

---

## Especialidade

```sql
CREATE TABLE Especialidade (
    CodigoEspecialidade INT PRIMARY KEY,
    NomeEspecialidade   VARCHAR(100) NOT NULL
);

INSERT INTO Especialidade VALUES
    (1,  'Cardiologia'),
    (2,  'Ortopedia'),
    (3,  'Pediatria'),
    (4,  'Dermatologia'),
    (5,  'Neurologia'),
    (6,  'Oftalmologia'),
    (7,  'Psiquiatria'),
    (8,  'Ginecologia'),
    (9,  'Urologia'),
    (10, 'Endocrinologia');
```

![Especialidade]({D75C7B70-D1CF-4713-B271-B6084DDA9F0A}.png)

---

## Medico

```sql
CREATE TABLE Medico (
    CRM                 INT PRIMARY KEY,
    Nome                VARCHAR(100) NOT NULL,
    Idade               INT,
    CodigoEspecialidade INT,

    CONSTRAINT fk_medico_especialidade
        FOREIGN KEY (CodigoEspecialidade)
        REFERENCES Especialidade(CodigoEspecialidade)
);

INSERT INTO Medico VALUES
    (101, 'Carlos Silva',    45, 1),
    (102, 'Ana Souza',       39, 2),
    (103, 'Pedro Lima',      50, 3),
    (104, 'Julia Alves',     42, 4),
    (105, 'Marcos Paulo',    55, 5),
    (106, 'Fernanda Rocha',  37, 6),
    (107, 'Renato Dias',     48, 7),
    (108, 'Carla Mendes',    41, 8),
    (109, 'Fabio Costa',     46, 9),
    (110, 'Patricia Gomes',  44, 10);
```

<img width="1014" height="466" alt="Medico" src="https://github.com/user-attachments/assets/800f3cea-8d8b-421f-bf1d-e8917f9a6db0" />

---

## Paciente

```sql
CREATE TABLE Paciente (
    CPF             VARCHAR(14) PRIMARY KEY,
    Nome            VARCHAR(100) NOT NULL,
    DataNascimento  DATE,
    Telefone        VARCHAR(20),
    Email           VARCHAR(100),
    Endereco        VARCHAR(200)
);

INSERT INTO Paciente VALUES
    ('11111111111', 'Alice Andrade',    '1990-01-01', '31999990001', 'a@email.com', 'Rua A'),
    ('22222222222', 'Bruno Silva',      '1985-02-10', '31999990002', 'b@email.com', 'Rua B'),
    ('33333333333', 'Carla Souza',      '2000-03-15', '31999990003', 'c@email.com', 'Rua C'),
    ('44444444444', 'Daniel Lima',      '1995-04-20', '31999990004', 'd@email.com', 'Rua D'),
    ('55555555555', 'Eduarda Alves',    '1988-05-05', '31999990005', 'e@email.com', 'Rua E'),
    ('66666666666', 'Felipe Rocha',     '1992-06-06', '31999990006', 'f@email.com', 'Rua F'),
    ('77777777777', 'Gabriela Mendes',  '1999-07-07', '31999990007', 'g@email.com', 'Rua G'),
    ('88888888888', 'Henrique Costa',   '1993-08-08', '31999990008', 'h@email.com', 'Rua H'),
    ('99999999999', 'Isabela Santos',   '1987-09-09', '31999990009', 'i@email.com', 'Rua I'),
    ('00000000000', 'Joao Pereira',     '1991-10-10', '31999990010', 'j@email.com', 'Rua J');
```

<img width="955" height="472" alt="Paciente" src="https://github.com/user-attachments/assets/bde61f7a-68c9-45b9-8169-a000c7e60da5" />

---

## Convenio

```sql
CREATE TABLE Convenio (
    id_convenio INT PRIMARY KEY,
    Nome        VARCHAR(100) NOT NULL,
    Plano       VARCHAR(100),
    Contato     VARCHAR(100)
);

INSERT INTO Convenio VALUES
    (1,  'Unimed',      'Premium',  '3130000001'),
    (2,  'Unimed',      'Basico',   '3130000002'),
    (3,  'SulAmerica',  'Ouro',     '3130000003'),
    (4,  'Bradesco',    'Top',      '3130000004'),
    (5,  'Amil',        'Essencial','3130000005'),
    (6,  'Unimed',      'Plus',     '3130000006'),
    (7,  'SulAmerica',  'Prata',    '3130000007'),
    (8,  'Bradesco',    'Basico',   '3130000008'),
    (9,  'Amil',        'Top',      '3130000009'),
    (10, 'Particular',  'Livre',    '3130000010');
```

<img width="939" height="495" alt="Convenio" src="https://github.com/user-attachments/assets/cdad0c62-262c-45c2-8052-249e8bd6b177" />

---

## Agendamento

```sql
CREATE TABLE Agendamento (
    idAgendamento INT PRIMARY KEY,
    data_hora     TIMESTAMP NOT NULL,
    Status        VARCHAR(50),
    Observacoes   TEXT
);

INSERT INTO Agendamento VALUES
    (1,  '2026-05-01 08:00:00', 'Confirmado', ''),
    (2,  '2026-05-01 09:00:00', 'Confirmado', ''),
    (3,  '2026-05-01 10:00:00', 'Confirmado', ''),
    (4,  '2026-05-01 11:00:00', 'Confirmado', ''),
    (5,  '2026-05-01 12:00:00', 'Confirmado', ''),
    (6,  '2026-05-01 13:00:00', 'Confirmado', ''),
    (7,  '2026-05-01 14:00:00', 'Confirmado', ''),
    (8,  '2026-05-01 15:00:00', 'Confirmado', ''),
    (9,  '2026-05-01 16:00:00', 'Confirmado', ''),
    (10, '2026-05-01 17:00:00', 'Confirmado', '');
```

<img width="895" height="481" alt="Agendamento" src="https://github.com/user-attachments/assets/2c743ba1-e035-4c17-bc93-f44b9f7116c6" />

---

## Consulta

```sql
CREATE TABLE Consulta (
    ID              INT PRIMARY KEY,
    DataHora        TIMESTAMP NOT NULL,
    QueixaPrincipal TEXT,
    Diagnostico     TEXT,
    Prescricao      TEXT,
    id_convenio     INT,
    idMedico        INT,
    idPaciente      VARCHAR(14),
    idAgendamento   INT,

    CONSTRAINT fk_consulta_convenio
        FOREIGN KEY (id_convenio)
        REFERENCES Convenio(id_convenio),

    CONSTRAINT fk_consulta_medico
        FOREIGN KEY (idMedico)
        REFERENCES Medico(CRM),

    CONSTRAINT fk_consulta_paciente
        FOREIGN KEY (idPaciente)
        REFERENCES Paciente(CPF),

    CONSTRAINT fk_consulta_agendamento
        FOREIGN KEY (idAgendamento)
        REFERENCES Agendamento(idAgendamento)
);

INSERT INTO Consulta VALUES
    (1,  '2026-05-01 08:00:00', 'Dor peito', 'Cardíaco',  'Repouso',    1, 101, '11111111111', 1),
    (2,  '2026-05-01 09:00:00', 'Joelho',    'Inflamação', 'Remédio',    2, 101, '22222222222', 2),
    (3,  '2026-05-01 10:00:00', 'Febre',     'Virose',     'Repouso',    6, 101, '33333333333', 3),
    (4,  '2026-05-01 11:00:00', 'Alergia',   'Dermatite',  'Pomada',     1, 102, '44444444444', 4),
    (5,  '2026-05-01 12:00:00', 'Cabeça',    'Enxaqueca',  'Analgésico', 3, 103, '55555555555', 5),
    (6,  '2026-05-01 13:00:00', 'Arritmia',  'Cardíaco',   'Exames',     1, 101, '66666666666', 6),
    (7,  '2026-05-01 14:00:00', 'Fratura',   'Osso',       'Gesso',      2, 107, '77777777777', 7),
    (8,  '2026-05-01 15:00:00', 'Gripe',     'Viral',      'Repouso',    6, 101, '88888888888', 8),
    (9,  '2026-05-01 16:00:00', 'Mancha',    'Fungo',      'Exame',      4, 109, '99999999999', 9),
    (10, '2026-05-01 17:00:00', 'Convulsão', 'Neuro',      'Encaminhar', 5, 110, '00000000000', 10);
```

<img width="977" height="492" alt="Consulta" src="https://github.com/user-attachments/assets/3657979f-b473-4dc7-9bd4-4a16f5e21d72" />

---

## Prontuario

```sql
CREATE TABLE Prontuario (
    ID             INT PRIMARY KEY,
    ID_Medico      INT,
    DataAbertura   DATE,
    HistoricoMedico TEXT,
    cpf            VARCHAR(14),

    CONSTRAINT fk_prontuario_medico
        FOREIGN KEY (ID_Medico)
        REFERENCES Medico(CRM),

    CONSTRAINT fk_prontuario_paciente
        FOREIGN KEY (cpf)
        REFERENCES Paciente(CPF)
);

INSERT INTO Prontuario VALUES
    (1,  101, '2026-05-01', 'Cardíaco',  '11111111111'),
    (2,  101, '2026-05-01', 'Ortopedia', '22222222222'),
    (3,  101, '2026-05-01', 'Pediatria', '33333333333'),
    (4,  102, '2026-05-01', 'Pele',      '44444444444'),
    (5,  103, '2026-05-01', 'Neuro',     '55555555555'),
    (6,  101, '2026-05-01', 'Cardio',    '66666666666'),
    (7,  109, '2026-05-01', 'Dermato',   '99999999999'),
    (8,  110, '2026-05-01', 'Neuro',     '00000000000'),
    (9,  104, '2026-05-01', 'Rotina',    '44444444444'),
    (10, 105, '2026-05-01', 'Rotina',    '55555555555');
```

<img width="856" height="467" alt="Prontuario" src="https://github.com/user-attachments/assets/718ed120-7de0-47f4-a8f7-9b5a9012e3ee" />

---

## Exame

```sql
CREATE TABLE Exame (
    ID_exame     INT PRIMARY KEY,
    ID_Prontuario INT,
    TipoExame    VARCHAR(100),
    Status       VARCHAR(50),
    Resultado    TEXT,
    id_consulta  INT,

    CONSTRAINT fk_exame_prontuario
        FOREIGN KEY (ID_Prontuario)
        REFERENCES Prontuario(ID),

    CONSTRAINT fk_exame_consulta
        FOREIGN KEY (id_consulta)
        REFERENCES Consulta(ID)
);

INSERT INTO Exame VALUES
    (1,  1,  'Eletro',      'Concluído', 'Normal', 1),
    (2,  2,  'Raio-X',      'Concluído', 'OK',     2),
    (3,  3,  'Hemograma',   'Pendente',  '',        3),
    (4,  4,  'Biópsia',     'Concluído', 'OK',     4),
    (5,  5,  'Ressonância', 'Concluído', 'OK',     5),
    (6,  6,  'Eletro',      'Pendente',  '',        6),
    (7,  7,  'Raio-X',      'Concluído', 'OK',     7),
    (8,  8,  'Tomografia',  'Concluído', 'OK',     8),
    (9,  9,  'Micologico',  'Concluído', 'OK',     9),
    (10, 10, 'Tomografia',  'Concluído', 'OK',     10);
```

<img width="1047" height="491" alt="Exame" src="https://github.com/user-attachments/assets/98f3c178-eda4-4b93-bc5b-2d30222b1a70" />
