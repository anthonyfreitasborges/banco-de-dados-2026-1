SELECT
<img width="963" height="812" alt="image" src="https://github.com/user-attachments/assets/1155b7d5-95d7-4afe-a5cd-bfd9f81a150e" />


INNER JOIN

<img width="972" height="826" alt="image" src="https://github.com/user-attachments/assets/5d23d8ba-8744-4f66-bf11-bd070eb9b40e" />


<img width="548" height="211" alt="{F06D7384-A4BD-444D-81A8-2F54A3330053}" src="https://github.com/user-attachments/assets/0b428c2d-dcab-496f-8da5-0e5a032a0d97" />

Recuperar registros sem correspondência no lado direito

<img width="747" height="644" alt="image" src="https://github.com/user-attachments/assets/4d26c20e-8292-4dae-9624-01326094cc68" />


GROUP BY + função agregada + HAVING
medico mais de um consulta

<img width="735" height="575" alt="image" src="https://github.com/user-attachments/assets/d1a80a19-5255-465b-9a61-e330fed2c0af" />

Subconsulta 
fizeram com convenio
<img width="718" height="720" alt="image" src="https://github.com/user-attachments/assets/513dfad3-5c19-4c6e-ad65-37ea2a6c2ef1" />

Subconsulta no FROM
Média de idade dos médicos por especialidade

<img width="651" height="873" alt="image" src="https://github.com/user-attachments/assets/976ae37e-7bfe-4ed5-bd9b-6673cbd2df6b" />

Subconsulta correlacionada
Pacientes que possuem pelo menos um exame pendente

<img width="719" height="586" alt="image" src="https://github.com/user-attachments/assets/b89c2640-3e05-4a25-8116-9ed18e088f53" />


CREATE VIEW vw_consultas_completas AS
SELECT 
    p.Nome AS Paciente,
    m.Nome AS Medico,
    c.DataHora,
    c.Diagnostico,
    e.TipoExame,
    e.Status
FROM Consulta c
JOIN Paciente p ON c.idPaciente = p.CPF
JOIN Medico m ON c.idMedico = m.CRM
LEFT JOIN Exame e ON c.ID = e.id_consulta;
<img width="1082" height="841" alt="image" src="https://github.com/user-attachments/assets/9519c3e7-f08f-4830-99d3-94a37bf82814" />

WITH
total de consulta por convenio
<img width="906" height="691" alt="image" src="https://github.com/user-attachments/assets/9eacd78e-bd58-4f95-8bd8-983360896733" />

Qual médico mais atendeu pacientes e quantos exames foram gerados por ele
<img width="845" height="755" alt="image" src="https://github.com/user-attachments/assets/66663ce6-37bb-4df6-9645-43ca40564c74" />
