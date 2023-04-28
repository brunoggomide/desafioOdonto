import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odonto/src/config/app_data.dart' as appData;
import 'package:odonto/src/models/item_model.dart';
import 'package:odonto/src/views/home/components/item_tile.dart';
import 'package:odonto/src/views/home/home.dart';

class MockAppData extends Mock implements ItemModel {}

void main() {
  late MockAppData mockAppData;
  late WidgetTester tester;

  setUp(() {
    mockAppData = MockAppData();
    appData.items = [
      ItemModel(name: 'Item 1', description: 'Description 1'),
      ItemModel(name: 'Item 2', description: 'Description 2'),
    ];
  });

  testWidgets('Teste da tela home, listagem e pesquisa de termos',
      (tester) async {
    // Renderizar a tela
    await tester.pumpWidget(const MaterialApp(
      home: Home(),
    ));

    // Verificar a renderização da tela e dos componentes
    expect(find.text('Glossário de Oclusão'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(ItemTile), findsNWidgets(2));

    // Testar a pesquisa
    await tester.enterText(find.byType(TextFormField), 'item 1');
    await tester.pumpAndSettle();
    expect(find.byType(ItemTile), findsOneWidget);
    expect(find.text('Item 1'), findsOneWidget);

    // Simular outra lista de itens
    appData.items = [
      ItemModel(name: 'Item 3', description: 'Description 3'),
      ItemModel(name: 'Item 4', description: 'Description 4'),
    ];

    // Testar a atualização da lista após a pesquisa
    await tester.enterText(find.byType(TextFormField), 'item 3');
    await tester.pumpAndSettle();
    expect(find.byType(ItemTile), findsOneWidget);
    expect(find.text('Item 3'), findsOneWidget);
    expect(find.text('Item 4'), findsNothing);
  });
}
