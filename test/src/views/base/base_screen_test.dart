import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odonto/src/views/base/base_screen.dart';
import 'package:odonto/src/views/home/home.dart';
import 'package:odonto/src/views/infos/info.dart';

class MockPageController extends Mock implements PageController {}

void main() {
  late BaseScreen baseScreen;
  late MockPageController mockPageController;

  setUp(() {
    mockPageController = MockPageController();
    baseScreen = const BaseScreen();
  });

  testWidgets('Tela renderizada corretamente', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(MaterialApp(home: baseScreen));

    // Verify the initial page is Home()
    expect(find.byType(Home), findsOneWidget);
    expect(find.byType(Info), findsNothing);

    // Tap the second item of the BottomNavigationBar to navigate to Info()
    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();

    // Verify the second page is Info()
    expect(find.byType(Info), findsOneWidget);
    expect(find.byType(Home), findsNothing);

    // Tap the first item of the BottomNavigationBar to navigate to Home()
    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.pumpAndSettle();

    // Verify the first page is Home()
    expect(find.byType(Home), findsOneWidget);
    expect(find.byType(Info), findsNothing);
  });
}
