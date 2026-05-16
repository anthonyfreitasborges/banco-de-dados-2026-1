DER — Tabela: Especialidade
Viola 1FN

CodigoEspecialidade (PK)
NomeEspecialidade
ProcedimentosRealizados
QuantidadeDeProcedimentos
idMedico (FK)

Dependencia:
CodigoEspecialidade → NomeEspecialidade
CodigoEspecialidade → ProcedimentosRealizados
CodigoEspecialidade → QuantidadeDeProcedimentos
CodigoEspecialidade → idMedico

Problema
ProcedimentosRealizados é multivalorado (um médico realiza vários procedimentos).
QuantidadeDeProcedimentos é atributo derivado.
Existe mistura de:
dados da especialidade
dados do médico
dados de procedimentos
------------------------
DER — Tabela: Paciente

Viola 3FN
CPF (PK)
Nome
DataNascimento
Telefone
Email
Endereco
idConvenio (FK)
idProntuario (FK)
idExame (FK)

Dependencia:
CPF → Nome, DataNascimento, Telefone, Email, Endereco
CPF → idConvenio
CPF → idProntuario
CPF → idExame

Problema
Paciente não determina exame nem prontuário.
Isso gera dependência indevida.
Um paciente pode ter vários exames e um prontuário não nasce com o paciente.
---------------------
DER — Tabela: Prontuário
Viola 1FN
ID (PK)
ID_Medico
DataAbertura
HistoricoMedico

Dependencia:
ID → ID_Medico
ID → DataAbertura
ID → HistoricoMedico

Problema
HistoricoMedico é multivalorado (cada consulta gera histórico).
-----------------
DER — Tabela: Consulta
Viola 3FN
ID (PK)
DataHora
QueixaPrincipal
Diagnostico
Prescricao
idPaciente (FK)
idAgendamento (FK)

Dependencia:
ID → DataHora, QueixaPrincipal, Diagnostico, Prescricao
ID → idPaciente
ID → idAgendamento

Problema
DataHora já está em Agendamento.
