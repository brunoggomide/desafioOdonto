import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odonto/src/views/auth/components/custom_text_field.dart';
import 'package:odonto/src/views/auth/components/forgot_password.dart';
import 'package:odonto/src/views/auth/sign_in.dart';
import 'package:odonto/src/views/auth/sign_up.dart';
import 'package:odonto/src/views/base/base_screen.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;
  final baseScreenRoute = MaterialPageRoute(builder: (c) {
    return const BaseScreen();
  });

  final signUpRoute = MaterialPageRoute(builder: (c) {
    return SignUp();
  });

  final forgotPasswordRoute = MaterialPageRoute(builder: (c) {
    return ForgotPassword(
      email: 'teste@unaerp.br',
    );
  });

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  testWidgets('Testa se campos são renderizados', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignIn()));

    expect(find.byType(CustomTextField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('Esqueceu a senha?'), findsOneWidget);
    expect(find.text('Ou'), findsOneWidget);
    expect(find.text('Criar conta'), findsOneWidget);
  });

  testWidgets('Testa navegação para a tela de Sign Up',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: const SignIn(), navigatorObservers: [mockObserver]));

    // Toca no botão "Criar conta"
    await tester.tap(find.text('Criar conta'));
    await tester.pumpAndSettle();

    // Verifica se a tela de Sign Up foi carregada
    verifyNever(mockObserver.didPush(baseScreenRoute, any));
    expect(find.byType(SignUp), findsOneWidget);
  });

  testWidgets('Testa navegação para a tela principal',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: const SignIn(), navigatorObservers: [mockObserver]));

    // Toca no botão "Entrar"
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    // Verifica se a tela principal foi carregada
    verifyNever(mockObserver.didPush(signUpRoute, any));
    expect(find.byType(BaseScreen), findsOneWidget);
  });

  testWidgets('Testa navegação para a tela de recuperar senha',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: const SignIn(), navigatorObservers: [mockObserver]));

    // Toca no botão "Entrar"
    await tester.tap(find.text('Esqueceu a senha?'));
    await tester.pumpAndSettle();

    // Verifica se a tela principal foi carregada
    verifyNever(mockObserver.didPush(forgotPasswordRoute, any));
    expect(find.byType(ForgotPassword), findsOneWidget);
  });
}
