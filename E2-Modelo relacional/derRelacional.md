abaixo a foto do modelo relacional 

<img width="1110" height="617" alt="image" src="https://github.com/user-attachments/assets/c30e331d-612c-44a4-b4d1-577b35b54d4b" />

o relacionamento entre Médico e Consulta é 1:N, já que um médico pode conduzir várias consultas, mas cada consulta é realizada por apenas um médico.
O relacionamento entre Paciente e Prontuário é 1:1, considerando que cada paciente possui um único prontuário. Essa regra foi garantida com o uso de chave estrangeira com restrição UNIQUE.
O relacionamento entre  Prontuário e Exame, é 1:N, pois um prontuário pode conter vários exames, enquanto cada exame pertence a apenas um prontuário.
Os relacionamentos entre Paciente e Agendamento e entre Médico e Agendamento são 1:N, pois ambos podem estar associados a vários agendamentos.
O relacionamento entre Médico e Especialidade é N:N, sendo implementado por uma tabela associativa.
o relacionamento entre Convênio e Agendamento também é N:N, permitindo múltiplas associações entre essas entidades.jsutificativa:
