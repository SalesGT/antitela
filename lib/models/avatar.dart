/// Tabela `avatares` (antitelaDB.pdf). Relacao 1:1 com o usuario:
/// fica em `usuarios/{uid}/avatar/atual`.
class Avatar {
  static const String docId = 'atual';
  static const String nomePadrao = 'Neo Lynx'; // mesmo nome da tela Ancora

  static const String statusSaudavel = 'saudavel';
  static const String statusCansado = 'cansado';
  static const String statusEsgotado = 'esgotado';

  final String nomeMascote;
  final String statusHumor;
  final int diasProtegidos;
  final int escudos;

  const Avatar({
    this.nomeMascote = nomePadrao,
    this.statusHumor = statusSaudavel,
    this.diasProtegidos = 0,
    this.escudos = 0,
  });

  factory Avatar.fromMap(Map<String, dynamic> m) => Avatar(
        nomeMascote: (m['nome_mascote'] as String?) ?? nomePadrao,
        statusHumor: (m['status_humor'] as String?) ?? statusSaudavel,
        diasProtegidos: (m['dias_protegidos'] as num?)?.toInt() ?? 0,
        escudos: (m['escudos'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'nome_mascote': nomeMascote,
        'status_humor': statusHumor,
        'dias_protegidos': diasProtegidos,
        'escudos': escudos,
      };
}
