/// Tabela `tags_contexto` (antitelaDB.pdf). O id do documento e o slug (ex.: "tiktok").
class TagContexto {
  final String id;
  final String nome;

  const TagContexto({required this.id, required this.nome});

  factory TagContexto.fromMap(String id, Map<String, dynamic> m) =>
      TagContexto(id: id, nome: (m['nome'] as String?) ?? id);
}
