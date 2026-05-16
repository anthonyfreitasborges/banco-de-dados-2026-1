# Decisões de Modelagem — Clínica Médica

## 1. CPF como chave primária de Paciente
O CPF é um identificador real, único e oficial no Brasil, dispensando a criação de uma chave artificial.

## 2. Prontuário depende do Paciente
Prontuário não existe sem paciente associado. Por isso, Paciente referencia seu prontuário principal via FK, e Prontuario registra o médico responsável pela abertura.

## 3. FKs circulares resolvidas com DEFERRABLE
Paciente referencia Prontuario, que referencia Exame, que referencia Prontuario. Para permitir inserções sem violar integridade referencial, essas FKs foram declaradas com `DEFERRABLE INITIALLY DEFERRED`.

## 4. Consulta exige Agendamento prévio
Toda consulta parte de um agendamento. A relação é 1:1 — a FK `idAgendamento` em Consulta é declarada com `UNIQUE` para garantir isso.

## 5. Médico possui uma única especialidade
Cada médico tem exatamente uma especialidade principal. Uma relação M:N foi descartada por estar fora do escopo do sistema.

## 6. ans_registro como chave de Convênio
O número ANS é o identificador oficial de convênios no Brasil, sendo usado diretamente como PK.

## 7. HistoricoProntuario para rastreabilidade
Em vez de sobrescrever dados do prontuário, cada evolução clínica é registrada como uma nova entrada com data própria, preservando o histórico completo.

## 8. Procedimento vinculado à Especialidade
Procedimentos pertencem à especialidade, não ao médico individualmente. Qualquer médico daquela especialidade pode realizá-los.

o relacionamento entre Médico e Consulta é 1:N, já que um médico pode conduzir várias consultas, mas cada consulta é realizada por apenas um médico.
O relacionamento entre Paciente e Prontuário é 1:1, considerando que cada paciente possui um único prontuário. Essa regra foi garantida com o uso de chave estrangeira com restrição UNIQUE.
O relacionamento entre  Prontuário e Exame, é 1:N, pois um prontuário pode conter vários exames, enquanto cada exame pertence a apenas um prontuário.
Os relacionamentos entre Paciente e Agendamento e entre Médico e Agendamento são 1:N, pois ambos podem estar associados a vários agendamentos.
O relacionamento entre Médico e Especialidade é N:N, sendo implementado por uma tabela associativa.
o relacionamento entre Convênio e Agendamento também é N:N, permitindo múltiplas associações entre essas entidades.