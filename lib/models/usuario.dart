import 'package:cloud_firestore/cloud_firestore.dart';
import 'converters.dart';

/// Tabela `usuarios` (antitelaDB.pdf) + campo `idade`.
/// Guardamos SOMENTE nome e idade: o app nao tem cadastro (sem e-mail/senha/telefone).
class Usuario {
  static const String tipoAdolescente = 'adolescente';

  // Mantenha estes limites iguais aos das regras (firebase/firestore.rules).
  static const int idadeMinima = 12;
  static const int idadeMaxima = 18;
  static const int nomeMaxCaracteres = 30;

  final String id; // = uid anonimo do Firebase Auth
  final String nome;
  final int idade;
  final String tipo;
  final DateTime? criadoEm;

  const Usuario({
    required this.id,
    required this.nome,
    required this.idade,
    this.tipo = tipoAdolescente,
    this.criadoEm,
  });

  factory Usuario.fromMap(String id, Map<String, dynamic> m) => Usuario(
        id: id,
        nome: (m['nome'] as String?) ?? '',
        idade: (m['idade'] as num?)?.toInt() ?? 0,
        tipo: (m['tipo'] as String?) ?? tipoAdolescente,
        criadoEm: dataDe(m['criado_em']),
      );

  Map<String, dynamic> toCreateMap() => {
        'nome': nome,
        'idade': idade,
        'tipo': tipo,
        'criado_em': FieldValue.serverTimestamp(),
      };
}
