import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/antitela_repository.dart';
import '../main.dart';
import '../models/usuario.dart';
import '../services/perfil_local.dart';

/// Tela inicial: a pessoa so informa nome (ou apelido) e idade.
/// Nao e cadastro: sem e-mail, senha ou telefone.
class BoasVindasScreen extends StatefulWidget {
  final VoidCallback onConcluido;
  final AntiTelaRepository? repository;

  const BoasVindasScreen({
    super.key,
    required this.onConcluido,
    this.repository,
  });

  @override
  State<BoasVindasScreen> createState() => _BoasVindasScreenState();
}

class _BoasVindasScreenState extends State<BoasVindasScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  bool _carregando = false;
  String? _erro;

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  String? _validarNome(String? valor) {
    final nome = (valor ?? '').trim();
    if (nome.isEmpty) return 'Como podemos te chamar?';
    if (nome.length < 2) return 'Use pelo menos 2 letras';
    return null;
  }

  String? _validarIdade(String? valor) {
    final idade = int.tryParse((valor ?? '').trim());
    if (idade == null) return 'Informe sua idade';
    if (idade < Usuario.idadeMinima || idade > Usuario.idadeMaxima) {
      return 'O AntiTela é para quem tem de '
          '${Usuario.idadeMinima} a ${Usuario.idadeMaxima} anos';
    }
    return null;
  }

  Future<void> _comecar() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _carregando = true;
      _erro = null;
    });

    try {
      final repo = widget.repository ?? AntiTelaRepository();
      final usuario = await repo.criarPerfil(
        nome: _nomeController.text,
        idade: int.parse(_idadeController.text.trim()),
      );
      await PerfilLocal.salvar(nome: usuario.nome, idade: usuario.idade);
      if (!mounted) return;
      widget.onConcluido();
    } catch (e) {
      debugPrint('Erro ao criar perfil: $e');
      if (!mounted) return;
      setState(() {
        _carregando = false;
        _erro = 'Não deu para salvar agora. '
            'Confira sua conexão com a internet e tente de novo.';
      });
    }
  }

  InputDecoration _decoracao({
    required String label,
    required String hint,
    required IconData icone,
  }) {
    OutlineInputBorder borda(Color cor, [double largura = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cor, width: largura),
        );

    return InputDecoration(
      labelText: label,
      hintText: hint,
      counterText: '',
      prefixIcon: Icon(icone, color: AppColors.purpleLight, size: 20),
      labelStyle: const TextStyle(color: AppColors.textMuted),
      hintStyle: const TextStyle(color: AppColors.textMuted),
      filled: true,
      fillColor: AppColors.card,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: borda(AppColors.border.withOpacity(0.4)),
      enabledBorder: borda(AppColors.border.withOpacity(0.4)),
      focusedBorder: borda(AppColors.purpleLight, 1.5),
      errorBorder: borda(AppColors.red),
      focusedErrorBorder: borda(AppColors.red, 1.5),
      errorStyle: const TextStyle(color: AppColors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(child: RobotMascot(running: true, size: 160)),
                    const SizedBox(height: 20),
                    const Text(
                      'Bem-vindo ao AntiTela',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Registre o que você faz longe das telas e, quando '
                      'quiser, salve tudo em um PDF.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const AppCard(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      child: Row(
                        children: [
                          Icon(Icons.shield_outlined,
                              color: AppColors.purpleLight, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Sem cadastro: não pedimos e-mail, telefone '
                              'nem senha. Guardamos só seu nome (pode ser um '
                              'apelido) e sua idade.',
                              style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nomeController,
                      enabled: !_carregando,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      maxLength: Usuario.nomeMaxCaracteres,
                      style:
                          const TextStyle(color: AppColors.text, fontSize: 15),
                      decoration: _decoracao(
                        label: 'Seu nome ou apelido',
                        hint: 'Ex.: Lucas',
                        icone: Icons.person_outline,
                      ),
                      validator: _validarNome,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _idadeController,
                      enabled: !_carregando,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      maxLength: 2,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onFieldSubmitted: (_) => _comecar(),
                      style:
                          const TextStyle(color: AppColors.text, fontSize: 15),
                      decoration: _decoracao(
                        label: 'Sua idade',
                        hint: 'Ex.: 15',
                        icone: Icons.cake_outlined,
                      ),
                      validator: _validarIdade,
                    ),
                    if (_erro != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _erro!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: AppColors.red, fontSize: 13),
                      ),
                    ],
                    const SizedBox(height: 20),
                    if (_carregando)
                      const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.purpleLight),
                      )
                    else
                      PurpleButton(
                        label: 'Começar',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: _comecar,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
