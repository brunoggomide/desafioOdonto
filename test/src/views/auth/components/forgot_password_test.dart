import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odonto/src/views/auth/components/forgot_password.dart';
import 'package:odonto/src/views/auth/sign_in.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;
  final signInRoute = MaterialPageRoute(builder: (c) {
    return SignIn();
  });

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  testWidgets('A tela de recuperar senha foi renderizada corretamente',
      (WidgetTester tester) async {
    // Build da tela de esqueceu a senha
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ForgotPassword(email: 'teste@unaerp.br'),
        ),
        navigatorObservers: [mockObserver],
      ),
    );

    // verifica os campos de e-mail e botão de recuperar
    expect(find.byType(), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Recuperar'), findsOneWidget);
  });

  testWidgets('Botão de recuperar funciona todas as ações',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: ForgotPassword(
          email: 'teste@unaerp.br',
        ),
        navigatorObservers: [mockObserver]));

    // clica no botão de recuperar
    await tester.tap(find.text('Recuperar'));
    await tester.pumpAndSettle();

    // verifica se o botão realiza a função desejada
    verifyNever(mockObserver.didPop(signInRoute, any));
  });
}
