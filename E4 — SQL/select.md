SELECT
SELECT Nome, CPF, DataNascimento
FROM Paciente
WHERE 
    Nome LIKE 'A%' 
    AND DataNascimento BETWEEN '1985-01-01' AND '2000-12-31'
    AND CPF IN ('22222222222','66666666666','88888888888')
    OR NOT Nome LIKE '%Silva%';

    ![alt text]({3EC06760-F03C-4D71-B81C-1048D125F920}.png)
    