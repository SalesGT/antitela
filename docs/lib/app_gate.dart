import 'package:flutter/material.dart';

import 'main.dart';
import 'screens/boas_vindas_screen.dart';
import 'services/perfil_local.dart';

/// Decide a primeira tela: boas-vindas (nome + idade) na primeira vez,
/// e o app normal (HomeShell) nas vezes seguintes.
class AppGate extends StatefulWidget {
  const AppGate({super.key});

  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> {
  late Future<bool> _temPerfil = PerfilLocal.existe();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _temPerfil,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            backgroundColor: AppColors.bg,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.purpleLight),
            ),
          );
        }
        if (snapshot.data == true) return const HomeShell();
        return BoasVindasScreen(
          onConcluido: () => setState(() => _temPerfil = Future.value(true)),
        );
      },
    );
  }
}
