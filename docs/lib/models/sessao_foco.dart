import 'converters.dart';

/// Tabela `sessoes_foco` (antitelaDB.pdf).
/// Imutavel: o registro e criado quando a sessao TERMINA (concluida ou desistida).
class SessaoFoco {
  static const String cicloPomodoro = 'pomodoro'; // 25 min
  static const String cicloProfundo = 'profundo'; // 45 min
  static const String cicloNoturno = 'noturno'; //   60 min

  final String id;
  final int duracaoMinutos;
  final String tipoCiclo;
  final DateTime horarioInicio;
  final bool concluida;

  const SessaoFoco({
    required this.id,
    required this.duracaoMinutos,
    required this.tipoCiclo,
    required this.horarioInicio,
    required this.concluida,
  });

  factory SessaoFoco.fromMap(String id, Map<String, dynamic> m) => SessaoFoco(
        id: id,
        duracaoMinutos: (m['duracao_minutos'] as num?)?.toInt() ?? 0,
        tipoCiclo: (m['tipo_ciclo'] as String?) ?? cicloPomodoro,
        horarioInicio: dataDe(m['horario_inicio']) ?? DateTime.now(),
        concluida: (m['concluida'] as bool?) ?? false,
      );
}
