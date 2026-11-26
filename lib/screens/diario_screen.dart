import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart';
import '../data/antitela_repository.dart';
import '../models/registro_diario.dart';

enum Mood { suave, cansado, frito }

extension MoodExt on Mood {
  IconData get icon => const {
        Mood.suave: Icons.sentiment_satisfied_alt,
        Mood.cansado: Icons.sentiment_neutral,
        Mood.frito: Icons.sick,
      }[this]!;
  String get label =>
      const {'suave': 'Suave', 'cansado': 'Cansado', 'frito': 'Frito'}[name]!;
  String get sub => const {
        'suave': 'Equilibrado',
        'cansado': 'Zona neutra',
        'frito': 'Sobrecarga'
      }[name]!;
}

class DiarioScreen extends StatefulWidget {
  const DiarioScreen({super.key});

  @override
  State<DiarioScreen> createState() => _DiarioScreenState();
}

class _DiarioScreenState extends State<DiarioScreen> {
  Mood _mood = Mood.suave;
  final Set<String> _selectedTags = {};
  final TextEditingController _noteController = TextEditingController();
  bool _saved = false;

  final List<String> _tags = [
    '#TikTok',
    '#Jogos',
    '#Tédio',
    '#Ansiedade',
    '#Estudos',
    '#Série',
    '#FOMO'
  ];

  // Ids das tags no banco (coleção tags_contexto) para cada rótulo da tela.
  static const Map<String, String> _tagIds = {
    '#TikTok': 'tiktok',
    '#Jogos': 'jogos',
    '#Tédio': 'tedio',
    '#Ansiedade': 'ansiedade',
    '#Estudos': 'estudos',
    '#Série': 'serie',
    '#FOMO': 'fomo',
  };

  final AntiTelaRepository _repo = AntiTelaRepository();
  final List<_DiaryEntry> _entries = [];
  StreamSubscription<List<RegistroDiario>>? _sub;

  @override
  void initState() {
    super.initState();
    try {
      _sub = _repo.diario().listen((lista) {
        if (!mounted) return;
        final abertos = {for (final e in _entries) if (e.expanded) e.id};
        final rotulos = {for (final e in _tagIds.entries) e.value: e.key};
        setState(() {
          _entries
            ..clear()
            ..addAll(lista.map((r) => _DiaryEntry(
                  id: r.id,
                  time: _formatarHora(r.timestamp),
                  mood: Mood.values.firstWhere((m) => m.name == r.bateriaMental,
                      orElse: () => Mood.suave),
                  tags: r.tags.map((id) => rotulos[id] ?? '#$id').toList(),
                  note: r.desabafoPrivado,
                )..expanded = abertos.contains(r.id)));
        });
      }, onError: (Object e) => debugPrint('Erro ao ler diário: $e'));
    } catch (e) {
      debugPrint('Banco indisponível: $e');
    }
  }

  String _formatarHora(DateTime d) {
    String dois(int n) => n.toString().padLeft(2, '0');
    final hoje = DateTime.now();
    final hora = '${dois(d.hour)}:${dois(d.minute)}';
    final ehHoje =
        d.year == hoje.year && d.month == hoje.month && d.day == hoje.day;
    return ehHoje ? hora : '${dois(d.day)}/${dois(d.month)} $hora';
  }

  Future<void> _apagar(_DiaryEntry e) async {
    final id = e.id;
    if (id == null) return;
    try {
      await _repo.apagarRegistroDiario(id);
    } catch (err) {
      debugPrint('Erro ao apagar registro: $err');
    }
  }

  Future<void> _register() async {
    final nota = _noteController.text.trim();
    final mood = _mood;
    final tagIds =
        _selectedTags.map((t) => _tagIds[t]).whereType<String>().toList();
    final messenger = ScaffoldMessenger.of(context);
    setState(() {
      _selectedTags.clear();
      _noteController.clear();
      _saved = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _saved = false);
    });
    try {
      await _repo.registrarDiario(
        bateriaMental: mood.name,
        desabafoPrivado: nota.isEmpty ? null : nota,
        tagIds: tagIds,
      );
    } catch (e) {
      debugPrint('Erro ao salvar diário: $e');
      messenger.showSnackBar(const SnackBar(
          content: Text('Não foi possível salvar o registro.')));
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              actions: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: AppColors.border.withOpacity(0.4)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock_outline,
                          color: AppColors.textMuted, size: 12),
                      SizedBox(width: 4),
                      Text('PRIVADO',
                          style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5)),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.settings_outlined,
                    color: AppColors.textMuted, size: 18),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPrivacyBanner(),
                    _buildMoodSelector(),
                    _buildTagsSection(),
                    _buildNoteInput(),
                    _buildRegisterButton(),
                    _buildRecentEntries(),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: const Row(
          children: [
            Icon(Icons.shield_outlined, color: AppColors.purpleLight, size: 14),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Só você vê o seu diário: ele não entra no relatório em PDF dos seus pais.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.purple.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.purpleLight.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('AUTOPERCEPÇÃO',
                style: TextStyle(
                    color: AppColors.purpleLight,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text('Como está sua bateria mental agora?',
                      style: TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.w700,
                          fontSize: 15)),
                ),
                const Icon(Icons.bolt, color: AppColors.purpleLight, size: 16),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: Mood.values.map((m) {
                final active = _mood == m;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _mood = m),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 6),
                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.purple.withOpacity(0.2)
                            : AppColors.card,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: active
                              ? AppColors.purpleLight.withOpacity(0.6)
                              : AppColors.border.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            m.icon,
                            color: active
                                ? AppColors.purpleLight
                                : AppColors.textMuted,
                            size: 28,
                          ),
                          const SizedBox(height: 4),
                          Text(m.label,
                              style: TextStyle(
                                  color: active
                                      ? AppColors.purpleDim
                                      : AppColors.textMuted,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13)),
                          const SizedBox(height: 2),
                          Text(m.sub,
                              style: const TextStyle(
                                  color: Color(0xFF4B5563), fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.label_outline, color: AppColors.purpleLight, size: 14),
              SizedBox(width: 6),
              Text('O que estava rolando?',
                  style: TextStyle(
                      color: AppColors.text,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tags.map((t) {
              final active = _selectedTags.contains(t);
              return GestureDetector(
                onTap: () => setState(() =>
                    active ? _selectedTags.remove(t) : _selectedTags.add(t)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.purple.withOpacity(0.2)
                        : AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: active
                          ? AppColors.purpleLight.withOpacity(0.5)
                          : AppColors.border.withOpacity(0.3),
                    ),
                  ),
                  child: Text(t,
                      style: TextStyle(
                          color: active
                              ? AppColors.purpleDim
                              : AppColors.textMuted,
                          fontSize: 13)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: TextField(
        controller: _noteController,
        style: const TextStyle(color: AppColors.text, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Quer desabafar algo rápido? (opcional e seguro)',
          hintStyle: const TextStyle(color: AppColors.textMuted),
          filled: true,
          fillColor: AppColors.card,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.border.withOpacity(0.4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.border.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: AppColors.purpleLight, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _saved
            ? Container(
                key: const ValueKey('saved'),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF166534),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text('Registrado!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
                  ],
                ),
              )
            : SizedBox(
                key: const ValueKey('register'),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    shadowColor: AppColors.purple.withOpacity(0.3),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline, size: 18),
                      SizedBox(width: 8),
                      Text('Registrar no Diário',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildRecentEntries() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.history, color: AppColors.purpleLight, size: 16),
                  SizedBox(width: 6),
                  Text('Registros Recentes',
                      style: TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                ],
              ),
              const Text('Hoje',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 10),
          ..._entries.map((e) => _EntryTile(
                entry: e,
                onDelete: () => _apagar(e),
              )),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.refresh, color: Color(0xFF4B5563), size: 12),
          SizedBox(width: 6),
          Text(
            'Baseado no protocolo de autorregulação saudável',
            style: TextStyle(color: Color(0xFF4B5563), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _DiaryEntry {
  final String? id;
  final String time;
  final Mood mood;
  final List<String> tags;
  final String? note;
  bool expanded = false;

  _DiaryEntry(
      {this.id,
      required this.time,
      required this.mood,
      required this.tags,
      this.note});
}

class _EntryTile extends StatefulWidget {
  final _DiaryEntry entry;
  final VoidCallback onDelete;

  const _EntryTile({required this.entry, required this.onDelete});

  @override
  State<_EntryTile> createState() => _EntryTileState();
}

class _EntryTileState extends State<_EntryTile> {
  @override
  Widget build(BuildContext context) {
    final e = widget.entry;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(e.mood.icon, color: AppColors.purpleLight, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: e.time,
                                style: const TextStyle(
                                    color: AppColors.text,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: ' · ${e.mood.label}',
                                style: const TextStyle(
                                    color: AppColors.textMuted, fontSize: 14)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(e.tags.join(' '),
                          style: const TextStyle(
                              color: AppColors.purpleLight, fontSize: 12)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => e.expanded = !e.expanded),
                  child: AnimatedRotation(
                    turns: e.expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down,
                        color: AppColors.textMuted, size: 20),
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onDelete,
                  child: const Icon(Icons.delete_outline,
                      color: Color(0xFF4B5563), size: 18),
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: e.expanded
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Color(0x4D3D494C))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        e.note ?? 'Sem nota',
                        style: TextStyle(
                          color: e.note != null
                              ? AppColors.textMuted
                              : AppColors.textMuted.withOpacity(0.5),
                          fontSize: 13,
                          fontStyle: e.note != null
                              ? FontStyle.normal
                              : FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
