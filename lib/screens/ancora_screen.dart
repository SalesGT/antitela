import 'package:flutter/material.dart';

import '../data/antitela_repository.dart';
import '../main.dart';
import '../models/avatar.dart';
import '../services/perfil_local.dart';

/// Tela inicial (aba Ancora): mostra o avatar, o humor, os escudos e atalhos.
/// [onNavigate] recebe o indice da aba do HomeShell (1 = Foco, 2 = Missoes, 3 = Diario).
class AncoraScreen extends StatefulWidget {
  final ValueChanged<int> onNavigate;

  const AncoraScreen({super.key, required this.onNavigate});

  @override
  State<AncoraScreen> createState() => _AncoraScreenState();
}

class _AncoraScreenState extends State<AncoraScreen> {
  final AntiTelaRepository _repo = AntiTelaRepository();
  Stream<Avatar?>? _avatar;
  String? _nome;

  @override
  void initState() {
    super.initState();
    PerfilLocal.nome().then((n) {
      if (mounted) setState(() => _nome = n);
    });
    try {
      _avatar = _repo.avatar();
    } catch (_) {
      _avatar = null; // Firebase indisponivel: mostra valores padrao
    }
  }

  String _textoHumor(String status) {
    switch (status) {
      case Avatar.statusCansado:
        return 'Cansado: que tal uma missao offline?';
      case Avatar.statusEsgotado:
        return 'Esgotado: precisa de uma pausa das telas.';
      default:
        return 'Saudavel e protegido!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: StreamBuilder<Avatar?>(
          stream: _avatar,
          builder: (context, snapshot) {
            final avatar = snapshot.data ?? const Avatar();
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  AppHeader(streak: '${avatar.diasProtegidos} dias'),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _nome == null ? 'Ola!' : 'Ola, $_nome!',
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const RobotMascot(running: true),
                  const SizedBox(height: 8),
                  Text(
                    avatar.nomeMascote,
                    style: const TextStyle(
                      color: AppColors.purpleDim,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _textoHumor(avatar.statusHumor),
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _stat(Icons.shield_outlined, '${avatar.escudos}',
                              'Escudos'),
                          _stat(Icons.local_fire_department,
                              '${avatar.diasProtegidos}', 'Dias protegidos'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        PurpleButton(
                          label: 'Iniciar Foco',
                          icon: Icons.timer_outlined,
                          onPressed: () => widget.onNavigate(1),
                        ),
                        const SizedBox(height: 10),
                        PurpleButton(
                          label: 'Missoes Offline',
                          icon: Icons.checklist_rounded,
                          color: AppColors.card,
                          onPressed: () => widget.onNavigate(2),
                        ),
                        const SizedBox(height: 10),
                        PurpleButton(
                          label: 'Diario de Humor',
                          icon: Icons.menu_book_rounded,
                          color: AppColors.card,
                          onPressed: () => widget.onNavigate(3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _stat(IconData icon, String valor, String rotulo) {
    return Column(
      children: [
        Icon(icon, color: AppColors.purpleLight, size: 24),
        const SizedBox(height: 4),
        Text(valor,
            style: const TextStyle(
                color: AppColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
        Text(rotulo,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
      ],
    );
  }
}
