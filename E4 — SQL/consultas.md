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
