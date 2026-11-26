import 'converters.dart';

/// Tabela `registros_diario` (antitelaDB.pdf).
/// A tabela de juncao `registro_tags` (N:N) virou o array [tags] com os ids de `tags_contexto`.
class RegistroDiario {
  // Mesmos valores do enum Mood da tela Diario (suave / cansado / frito).
  static const String bateriaSuave = 'suave';
  static const String bateriaCansado = 'cansado';
  static const String bateriaFrito = 'frito';

  final String id;
  final DateTime timestamp;
  final String bateriaMental;
  final String? desabafoPrivado;
  final List<String> tags;

  const RegistroDiario({
    required this.id,
    required this.timestamp,
    required this.bateriaMental,
    this.desabafoPrivado,
    this.tags = const [],
  });

  factory RegistroDiario.fromMap(String id, Map<String, dynamic> m) =>
      RegistroDiario(
        id: id,
        timestamp: dataDe(m['timestamp']) ?? DateTime.now(),
        bateriaMental: (m['bateria_mental'] as String?) ?? bateriaSuave,
        desabafoPrivado: m['desabafo_privado'] as String?,
        tags: List<String>.from((m['tags'] as List?) ?? const []),
      );
}
