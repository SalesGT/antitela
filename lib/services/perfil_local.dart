import 'package:shared_preferences/shared_preferences.dart';

/// Guarda no aparelho (so local) que a pessoa ja passou pela tela de boas-vindas,
/// e o nome/idade para exibir sem depender de internet.
class PerfilLocal {
  static const String _kConcluido = 'onboarding_concluido';
  static const String _kNome = 'perfil_nome';
  static const String _kIdade = 'perfil_idade';

  static Future<bool> existe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kConcluido) ?? false;
  }

  static Future<void> salvar({required String nome, required int idade}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kNome, nome);
    await prefs.setInt(_kIdade, idade);
    await prefs.setBool(_kConcluido, true);
  }

  static Future<String?> nome() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kNome);
  }

  static Future<void> limpar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kConcluido);
    await prefs.remove(_kNome);
    await prefs.remove(_kIdade);
  }
}
