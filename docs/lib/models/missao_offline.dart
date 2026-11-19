/// Tabela `missoes_offline` (antitelaDB.pdf).
class MissaoOffline {
  final String id;
  final String titulo;
  final int recompensaBonus;
  final bool concluida;

  const MissaoOffline({
    required this.id,
    required this.titulo,
    required this.recompensaBonus,
    required this.concluida,
  });

  factory MissaoOffline.fromMap(String id, Map<String, dynamic> m) =>
      MissaoOffline(
        id: id,
        titulo: (m['titulo'] as String?) ?? '',
        recompensaBonus: (m['recompensa_bonus'] as num?)?.toInt() ?? 0,
        concluida: (m['concluida'] as bool?) ?? false,
      );
}
