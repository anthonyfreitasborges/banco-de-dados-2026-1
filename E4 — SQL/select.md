SELECT
SELECT Nome, CPF, DataNascimento
FROM Paciente
WHERE 
    Nome LIKE 'A%' 
    AND DataNascimento BETWEEN '1985-01-01' AND '2000-12-31'
    AND CPF IN ('22222222222','66666666666','88888888888')
    OR NOT Nome LIKE '%Silva%';

 <img width="515" height="205" alt="{A4557640-DF28-46B7-8FD7-6185D20106BC}" src="https://github.com/user-attachments/assets/a19fe045-531a-4dd8-bcb9-28867c512381" />

INNER JOIN

SELECT 
    p.Nome AS Paciente,
    m.Nome AS Medico,
    c.DataHora,
    c.Diagnostico
FROM Consulta c
INNER JOIN Paciente p ON c.idPaciente = p.CPF
INNER JOIN Medico m ON c.idMedico = m.CRM;

<img width="548" height="211" alt="{F06D7384-A4BD-444D-81A8-2F54A3330053}" src="https://github.com/user-attachments/assets/0b428c2d-dcab-496f-8da5-0e5a032a0d97" />

Recuperar registros sem correspondência no lado direito

SELECT p.Nome, p.CPF
FROM Paciente p
LEFT JOIN Prontuario pr ON p.CPF = pr.cpf
WHERE pr.ID IS NULL;

<img width="354" height="144" alt="{974A7F67-59FC-4678-9B4C-B6023E8D29B3}" src="https://github.com/user-attachments/assets/09a76f4f-78a4-4b02-9e81-42e262352bea" />


GROUP BY + função agregada + HAVING
SELECT 
    m.Nome,
    COUNT(c.ID) AS TotalConsultas
FROM Medico m
JOIN Consulta c ON m.CRM = c.idMedico
GROUP BY m.Nome
HAVING COUNT(c.ID) > 1;
