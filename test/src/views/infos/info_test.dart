import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odonto/src/views/infos/info.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('Info Widget Test', () {
    testWidgets('should render app bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Info(),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Informações do App'), findsOneWidget);
    });

    testWidgets('should render text', (WidgetTester tester) async {
      final mockContext = MockBuildContext();

      await tester.pumpWidget(
        const MaterialApp(
          home: Info(),
        ),
      );

      expect(
        find.text(
            'O Glossário de Oclusão é um aplicativo desenvolvido para os alunos e professores do curso de Odontologia da instituição UNAERP. O desenvolvimento do aplicativo é parte do Desafio da 6° etapa do curso de Engenharia de Software.'),
        findsOneWidget,
      );
      expect(
        find.text(
            'Desenvolvido por: Bruno Gomide e Nelson Mello\nApoio de: Rodrigo Plotze, Carlos Alves e Fabiano\nE-mail para contato: bruno.gomide@sou.unaerp.edu.br'),
        findsOneWidget,
      );
    });
  });
}
