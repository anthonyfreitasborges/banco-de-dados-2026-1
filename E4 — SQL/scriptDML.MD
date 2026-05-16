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
