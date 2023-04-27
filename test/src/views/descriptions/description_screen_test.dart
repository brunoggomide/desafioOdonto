import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odonto/src/models/item_model.dart';
import 'package:odonto/src/views/descriptions/description_screen.dart';
import 'package:odonto/src/views/home/home.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late ItemModel item;
  late NavigatorObserver navigatorObserver;
  final homeScreenRoute = MaterialPageRoute(builder: (c) {
    return const Home();
  });

  setUp(() {
    item = ItemModel(name: 'Test', description: 'Test description');
    navigatorObserver = MockNavigatorObserver();
  });

  testWidgets('renders page correctly', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DescriptionScreen(item: item),
    ));

    expect(find.text(item.name), findsOneWidget);
    expect(find.text(item.description), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
  });

  testWidgets('navigates back when back button is pressed', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DescriptionScreen(item: item),
      navigatorObservers: [navigatorObserver],
    ));

    await tester.tap(find.byIcon(Icons.arrow_back_ios));
    await tester.pumpAndSettle();

    verifyNever(navigatorObserver.didPop(homeScreenRoute, any));
  });
}
