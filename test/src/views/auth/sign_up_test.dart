import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odonto/src/views/auth/components/custom_text_field.dart';
import 'package:odonto/src/views/auth/sign_in.dart';
import 'package:odonto/src/views/auth/sign_up.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;

  final signInRoute = MaterialPageRoute(builder: (c) {
    return const SignIn();
  });

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  testWidgets('Testa renderização da página', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: SignUp(), navigatorObservers: [mockObserver]));

    // Verifica se o título da página está sendo renderizado corretamente
    expect(find.text('Cadastro'), findsOneWidget);

    // Verifica se os campos do formulário estão sendo renderizados corretamente
    expect(find.byType(CustomTextField), findsNWidgets(4));
    expect(find.text('Nome'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Código de matricula'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Cadastrar Usuário'), findsOneWidget);

    // Verifica se o botão de voltar está sendo renderizado corretamente
    expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
  });

  testWidgets('Testa navegação para a tela anterior pelo icon',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: SignUp(), navigatorObservers: [mockObserver]));

    // Toca no botão de voltar
    await tester.tap(find.byIcon(Icons.arrow_back_ios));
    await tester.pumpAndSettle();

    // Verifica se a tela anterior foi carregada
    verifyNever(mockObserver.didPop(signInRoute, any));
  });

  testWidgets('Testa navegação para a tela principal pelo botão de cadastro',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: SignUp(), navigatorObservers: [mockObserver]));

    // Toca no botão "Cadastrar Usuário"
    await tester.tap(find.text('Cadastrar Usuário'));
    await tester.pumpAndSettle();

    // Verifica se a tela anterior foi carregada
    verifyNever(mockObserver.didPop(signInRoute, any));
  });
}
