import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odonto/src/views/auth/components/custom_text_field.dart';
import 'package:odonto/src/views/auth/components/forgot_password.dart';
import 'package:odonto/src/views/auth/sign_in.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;
  final signInRoute = MaterialPageRoute(builder: (c) {
    return const SignIn();
  });

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  testWidgets('ForgotPassword page renders correctly',
      (WidgetTester tester) async {
    // Build the ForgotPassword page
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ForgotPassword(email: 'user@example.com'),
        ),
        navigatorObservers: [mockObserver],
      ),
    );

    // Verify that the page contains the email field and the recover button
    expect(find.byType(CustomTextField), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Recuperar'), findsOneWidget);
  });

  testWidgets('ForgotPassword recover button navigates to previous page',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: ForgotPassword(
          email: 'teste@unaerp.br',
        ),
        navigatorObservers: [mockObserver]));

    // Tap the recover button
    await tester.tap(find.text('Recuperar'));
    await tester.pumpAndSettle();

    // Verify that the previous page is now visible
    verifyNever(mockObserver.didPop(signInRoute, any));
  });
}
