import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/avatar.dart';
import '../models/missao_offline.dart';
import '../models/registro_diario.dart';
import '../models/sessao_foco.dart';
import '../models/tag_contexto.dart';
import '../models/usuario.dart';
import '../services/perfil_local.dart';

const List<String> _missoesIniciais = [
  'Arrumar a cama ao acordar',
  'Ler 1 capítulo de um livro',
  'Caminhar com o cão ao ar livre',
  'Jantar sem telemóvel na mesa',
  'Organizar o quarto / secretária',
  'Conversar 15min com alguém da família',
];

/// Id baseado no relogio: ordenar por id = ordenar por criacao (sem campo extra no schema).
String _idCronologico([int deslocamento = 0]) =>
    (DateTime.now().microsecondsSinceEpoch + deslocamento).toString();

/// Unico ponto de acesso ao Firestore. Estrutura (ver firebase/README.md):
///
///   usuarios/{uid}
///     avatar/atual
///     sessoes_foco/{id}
///     missoes_offline/{id}
///     registros_diario/{id}
///   tags_contexto/{slug}
///
/// O {uid} vem do login ANONIMO do Firebase Auth: a pessoa nao cria conta.
/// O Firestore guarda cache local, entao o app continua funcionando offline
/// e sincroniza quando a conexao volta (RNF04).
class AntiTelaRepository {
  AntiTelaRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore? _firestore;
  final FirebaseAuth? _auth;

  // Resolvidos so quando usados, para nao exigir Firebase inicializado ao instanciar.
  FirebaseFirestore get _db => _firestore ?? FirebaseFirestore.instance;
  FirebaseAuth get _firebaseAuth => _auth ?? FirebaseAuth.instance;

  String get uid {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw StateError('Sem sessao ativa. Conclua a tela de boas-vindas antes.');
    }
    return user.uid;
  }

  DocumentReference<Map<String, dynamic>> get _usuarioRef =>
      _db.collection('usuarios').doc(uid);
  DocumentReference<Map<String, dynamic>> get _avatarRef =>
      _usuarioRef.collection('avatar').doc(Avatar.docId);
  CollectionReference<Map<String, dynamic>> get _sessoesRef =>
      _usuarioRef.collection('sessoes_foco');
  CollectionReference<Map<String, dynamic>> get _missoesRef =>
      _usuarioRef.collection('missoes_offline');
  CollectionReference<Map<String, dynamic>> get _diarioRef =>
      _usuarioRef.collection('registros_diario');
  CollectionReference<Map<String, dynamic>> get _tagsRef =>
      _db.collection('tags_contexto');

  /// Offline, o Future de uma escrita so completa quando o servidor confirma.
  /// Como o dado ja esta salvo no cache local e sera enviado depois, nao
  /// deixamos a interface travada esperando: passou do prazo = segue o fluxo.
  /// Erros reais (ex.: permissao negada) continuam sendo lancados.
  Future<void> _semTravarOffline(Future<void> operacao) async {
    try {
      await operacao.timeout(const Duration(seconds: 8));
    } on TimeoutException {
      // gravado localmente; sincroniza quando voltar a conexao
    }
  }

  // ───────────────────────── Perfil (usuarios + avatares) ─────────────────────

  /// Cria o perfil (nome + idade) e o avatar inicial. Faz login anonimo se preciso.
  /// Precisa de internet apenas no primeiro acesso (para obter o uid anonimo).
  Future<Usuario> criarPerfil({required String nome, required int idade}) async {
    final nomeLimpo = nome.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (nomeLimpo.isEmpty || nomeLimpo.length > Usuario.nomeMaxCaracteres) {
      throw ArgumentError('Nome invalido.');
    }
    if (idade < Usuario.idadeMinima || idade > Usuario.idadeMaxima) {
      throw ArgumentError('Idade fora da faixa permitida.');
    }

    if (_firebaseAuth.currentUser == null) {
      await _firebaseAuth.signInAnonymously();
    }

    final usuario = Usuario(id: uid, nome: nomeLimpo, idade: idade);
    final batch = _db.batch();

    // Se o perfil ja existe (ex.: onboarding interrompido antes), so atualiza nome/idade.
    final existente = await _usuarioRef.get();
    if (existente.exists) {
      batch.update(_usuarioRef, {'nome': nomeLimpo, 'idade': idade});
    } else {
      batch.set(_usuarioRef, usuario.toCreateMap());
      // Sugestoes iniciais de missao (as mesmas do prototipo).
      for (var i = 0; i < _missoesIniciais.length; i++) {
        batch.set(_missoesRef.doc(_idCronologico(i)), {
          'titulo': _missoesIniciais[i],
          'recompensa_bonus': 1,
          'concluida': false,
        });
      }
    }

    final avatarExistente = await _avatarRef.get();
    if (!avatarExistente.exists) {
      batch.set(_avatarRef, const Avatar().toMap());
    }

    await _semTravarOffline(batch.commit());
    return usuario;
  }

  Future<Usuario?> carregarUsuario() async {
    final snap = await _usuarioRef.get();
    final dados = snap.data();
    return dados == null ? null : Usuario.fromMap(snap.id, dados);
  }

  Stream<Avatar?> avatar() => _avatarRef.snapshots().map((s) {
        final dados = s.data();
        return dados == null ? null : Avatar.fromMap(dados);
      });

  /// Atualiza so os campos informados (avatar: criar/ler/atualizar, nunca excluir).
  Future<void> atualizarAvatar({
    String? nomeMascote,
    String? statusHumor,
    int? diasProtegidos,
    int? escudos,
  }) {
    final campos = <String, dynamic>{
      if (nomeMascote != null) 'nome_mascote': nomeMascote,
      if (statusHumor != null) 'status_humor': statusHumor,
      if (diasProtegidos != null) 'dias_protegidos': diasProtegidos,
      if (escudos != null) 'escudos': escudos,
    };
    if (campos.isEmpty) return Future.value();
    return _semTravarOffline(_avatarRef.update(campos));
  }

  // ───────────────────────────── Sessoes de foco ─────────────────────────────

  /// Chame quando a sessao TERMINAR (concluida = true) ou for abandonada (false).
  Future<void> registrarSessao({
    required int duracaoMinutos,
    required String tipoCiclo,
    required DateTime horarioInicio,
    required bool concluida,
  }) {
    return _semTravarOffline(_sessoesRef.doc().set({
      'duracao_minutos': duracaoMinutos,
      'tipo_ciclo': tipoCiclo,
      'horario_inicio': Timestamp.fromDate(horarioInicio),
      'concluida': concluida,
    }));
  }

  Stream<List<SessaoFoco>> sessoes({DateTime? desde}) {
    Query<Map<String, dynamic>> consulta =
        _sessoesRef.orderBy('horario_inicio', descending: true);
    if (desde != null) {
      consulta = consulta.where('horario_inicio',
          isGreaterThanOrEqualTo: Timestamp.fromDate(desde));
    }
    return consulta.snapshots().map((q) =>
        q.docs.map((d) => SessaoFoco.fromMap(d.id, d.data())).toList());
  }

  Future<void> apagarSessao(String id) =>
      _semTravarOffline(_sessoesRef.doc(id).delete());

  // ───────────────────────────── Missoes offline ─────────────────────────────

  Future<void> criarMissao({
    required String titulo,
    required int recompensaBonus,
  }) {
    return _semTravarOffline(_missoesRef.doc(_idCronologico()).set({
      'titulo': titulo.trim(),
      'recompensa_bonus': recompensaBonus,
      'concluida': false,
    }));
  }

  Stream<List<MissaoOffline>> missoes() => _missoesRef
      .orderBy(FieldPath.documentId)
      .snapshots()
      .map((q) =>
          q.docs.map((d) => MissaoOffline.fromMap(d.id, d.data())).toList());

  Future<void> atualizarMissao(
    String id, {
    String? titulo,
    int? recompensaBonus,
  }) {
    final campos = <String, dynamic>{
      if (titulo != null) 'titulo': titulo.trim(),
      if (recompensaBonus != null) 'recompensa_bonus': recompensaBonus,
    };
    if (campos.isEmpty) return Future.value();
    return _semTravarOffline(_missoesRef.doc(id).update(campos));
  }

  /// RF05: marca a missao como concluida e credita os escudos no avatar, juntos.
  Future<void> concluirMissao(MissaoOffline missao) {
    if (missao.concluida) return Future.value(); // evita creditar duas vezes
    final batch = _db.batch();
    batch.update(_missoesRef.doc(missao.id), {'concluida': true});
    batch.update(_avatarRef,
        {'escudos': FieldValue.increment(missao.recompensaBonus)});
    return _semTravarOffline(batch.commit());
  }

  Future<void> apagarMissao(String id) =>
      _semTravarOffline(_missoesRef.doc(id).delete());

  // ───────────────────────────── Diario de bordo ─────────────────────────────

  /// Registros sao imutaveis (sem "atualizar"), como definido no CRUD.
  /// [tagIds] sao ids de `tags_contexto` (substitui a tabela `registro_tags`).
  Future<void> registrarDiario({
    required String bateriaMental,
    String? desabafoPrivado,
    List<String> tagIds = const [],
  }) {
    final texto = desabafoPrivado?.trim();
    return _semTravarOffline(_diarioRef.doc().set({
      'timestamp': Timestamp.now(),
      'bateria_mental': bateriaMental,
      'tags': tagIds,
      if (texto != null && texto.isNotEmpty) 'desabafo_privado': texto,
    }));
  }

  Stream<List<RegistroDiario>> diario() => _diarioRef
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((q) =>
          q.docs.map((d) => RegistroDiario.fromMap(d.id, d.data())).toList());

  Future<void> apagarRegistroDiario(String id) =>
      _semTravarOffline(_diarioRef.doc(id).delete());

  // ──────────────────────────────── Tags ─────────────────────────────────────

  Future<List<TagContexto>> tags() async {
    final q = await _tagsRef.orderBy('nome').get();
    return q.docs.map((d) => TagContexto.fromMap(d.id, d.data())).toList();
  }

  // ───────────────────────── Apagar tudo (RF12 / LGPD) ───────────────────────

  /// Remove TODOS os dados da pessoa (nuvem + aparelho) e encerra a sessao anonima.
  /// Exige conexao: o Firestore nao apaga subcolecoes sozinho.
  Future<void> apagarTodosOsDados() async {
    for (final colecao in [_sessoesRef, _missoesRef, _diarioRef]) {
      final snap = await colecao.get();
      for (var i = 0; i < snap.docs.length; i += 400) {
        final lote = _db.batch();
        for (final doc in snap.docs.skip(i).take(400)) {
          lote.delete(doc.reference);
        }
        await lote.commit();
      }
    }

    // Avatar e usuario saem no mesmo lote (a regra do avatar exige isso).
    final fim = _db.batch();
    fim.delete(_avatarRef);
    fim.delete(_usuarioRef);
    await fim.commit();

    try {
      await _firebaseAuth.currentUser?.delete();
    } on FirebaseAuthException {
      await _firebaseAuth.signOut();
    }
    await PerfilLocal.limpar();
  }
}
