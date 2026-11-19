import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:antitela/main.dart';

void main() {
  testWidgets('exibe a tela inicial e navega entre abas', (tester) async {
    // Simula quem ja passou pela tela de boas-vindas.
    SharedPreferences.setMockInitialValues({'onboarding_concluido': true});
    await tester.pumpWidget(const AntiTelaApp());
    await tester.pump();
    await tester.pump();

    expect(find.text('Modo Foco'), findsOneWidget);

    await tester.tap(find.text('Iniciar Foco'));
    await tester.pump();

    expect(find.text('TEMPO DE ECRÃ HOJE'), findsOneWidget);

    await tester.tap(find.text('Missões'));
    await tester.pump();

    expect(find.text('Missões Offline'), findsOneWidget);
  });

  testWidgets('primeira vez: mostra boas-vindas e valida nome e idade',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const AntiTelaApp());
    await tester.pump();
    await tester.pump();

    expect(find.text('Bem-vindo ao AntiTela'), findsOneWidget);

    await tester.ensureVisible(find.text('Começar'));
    await tester.tap(find.text('Começar'));
    await tester.pump();

    expect(find.text('Como podemos te chamar?'), findsOneWidget);
    expect(find.text('Informe sua idade'), findsOneWidget);
  });
}
