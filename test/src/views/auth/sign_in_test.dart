// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:odonto/src/views/auth/components/custom_text_field.dart';
// import 'package:odonto/src/views/auth/components/forgot_password.dart';
// import 'package:odonto/src/views/auth/sign_up.dart';
// import 'package:odonto/src/views/auth/sign_in.dart';
// import 'package:odonto/src/views/base/base_screen.dart';

// class MockNavigatorObserver extends Mock implements NavigatorObserver {}

// void main() {
//   late MockNavigatorObserver mockObserver;

//   setUp(() {
//     mockObserver = MockNavigatorObserver();
//   });

//   group('SignIn widget tests', () {
//     testWidgets('Test if SignIn page is rendered', (WidgetTester tester) async {
//       await tester.pumpWidget(const MaterialApp(
//         home: SignIn(),
//       ));

//       expect(find.text('Glossário de Oclusão'), findsOneWidget);
//       expect(find.byType(CustomTextField), findsNWidgets(2));
//       expect(find.text('Entrar'), findsOneWidget);
//       expect(find.text('Esqueceu a senha?'), findsOneWidget);
//       expect(find.text('Ou'), findsOneWidget);
//       expect(find.text('Criar conta'), findsOneWidget);
//     });

//     testWidgets('Test if SignIn page navigation is correct',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(
//         home: const SignIn(),
//         navigatorObservers: [mockObserver],
//       ));

//       expect(find.byType(ElevatedButton), findsOneWidget);
//       await tester.tap(find.byType(ElevatedButton));
//       await tester.pumpAndSettle();

//       verify(mockObserver.didPush(any!, any));
//       expect(find.byType(BaseScreen), findsOneWidget);

//       await tester.tap(find.text('Esqueceu a senha?'));
//       await tester.pumpAndSettle();

//       expect(find.byType(ForgotPassword), findsOneWidget);

//       await tester.tap(find.text('Criar conta'));
//       await tester.pumpAndSettle();

//       verify(mockObserver.didPush(any!, any));
//       expect(find.byType(SignUp), findsOneWidget);
//     });
//   });
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:odonto/src/views/auth/components/forgot_password.dart';
// import 'package:odonto/src/views/auth/sign_up.dart';
// import 'package:odonto/src/views/auth/sign_in.dart';
// import 'package:odonto/src/views/base/base_screen.dart';

// void main() {
//   testWidgets('Test if SignIn page navigates correctly',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(const MaterialApp(
//       home: SignIn(),
//     ));

//     // Testando se existe um widget com o label 'Email'
//     expect(find.text('Email'), findsOneWidget);

//     // Testando se existe um widget com o label 'Senha'
//     expect(find.text('Senha'), findsOneWidget);

//     // Testando a navegação para a tela de esqueceu a senha
//     await tester.tap(find.text('Esqueceu a senha?'));
//     await tester.pumpAndSettle();
//     expect(find.byType(ForgotPassword), findsOneWidget);

//     // Testando a navegação para a tela de cadastro
//     await tester.tap(find.text('Criar conta'));
//     await tester.pumpAndSettle();
//     expect(find.byType(SignUp), findsOneWidget);

//     // Testando a navegação para a tela principal
//     await tester.tap(find.text('Entrar'));
//     await tester.pumpAndSettle();
//     expect(find.byType(BaseScreen), findsOneWidget);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:odonto/src/views/auth/components/forgot_password.dart';
import 'package:odonto/src/views/auth/sign_in.dart';
import 'package:odonto/src/views/auth/sign_up.dart';
import 'package:odonto/src/views/base/base_screen.dart';

void main() {
  testWidgets('Testa se botões e campos de email e senha estão funcionando',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignIn()));

    // Teste do botão Entrar
    final entrarButton = find.text('Entrar');
    expect(entrarButton, findsOneWidget);
    await tester.tap(entrarButton);
    await tester.pumpAndSettle();
    expect(find.byType(BaseScreen), findsOneWidget);

    // Teste do botão Esqueceu a senha
    final esqueceuSenhaButton = find.text('Esqueceu a senha?');
    expect(esqueceuSenhaButton, findsOneWidget);
    await tester.tap(esqueceuSenhaButton);
    await tester.pumpAndSettle();
    expect(find.byType(ForgotPassword), findsOneWidget);

    // Teste do botão Criar conta
    final criarContaButton = find.text('Criar conta');
    expect(criarContaButton, findsOneWidget);
    await tester.tap(criarContaButton);
    await tester.pumpAndSettle();
    expect(find.byType(SignUp), findsOneWidget);

    // Teste dos campos de email e senha
    final emailTextField = find.byType(TextFormField).at(0);
    expect(emailTextField, findsOneWidget);
    await tester.enterText(emailTextField, 'email@example.com');
    expect(find.text('email@example.com'), findsOneWidget);

    final senhaTextField = find.byType(TextFormField).at(1);
    expect(senhaTextField, findsOneWidget);
    await tester.enterText(senhaTextField, '123456');
    expect(find.text('123456'), findsOneWidget);
  });
}
